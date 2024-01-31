/* mblock.c -- aligned memory blocks (cache issues)

   This file is part of the lzop file compressor.

   Copyright (C) 1996-2017 Markus Franz Xaver Johannes Oberhumer
   All Rights Reserved.

   lzop and the LZO library are free software; you can redistribute them
   and/or modify them under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of
   the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING.
   If not, write to the Free Software Foundation, Inc.,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

   Markus F.X.J. Oberhumer
   <markus@oberhumer.com>
   http://www.oberhumer.com/opensource/lzop/
 */


#include "conf.h"


/*************************************************************************
//
**************************************************************************/

static void do_init(mblock_p m, lzo_uint32 size, lzo_uint32 align)
{
    memset(m,0,sizeof(*m));
    m->mb_size = size;
    m->mb_align = (align > 1) ? align : 1;
    assert((m->mb_align & (m->mb_align - 1)) == 0);
}


lzo_bool mb_alloc(mblock_p m, lzo_uint32 size, lzo_uint32 align)
{
    do_init(m,size,align);
    if (m->mb_size == 0)
        return 1;

    m->mb_size_alloc = m->mb_size + m->mb_align - 1;
    m->mb_mem_alloc = (lzo_bytep) acc_halloc(m->mb_size_alloc);
    if (m->mb_mem_alloc == NULL)
        return 0;
    acc_hmemset(m->mb_mem_alloc, 0, m->mb_size_alloc);

    m->mb_mem = LZO_PTR_ALIGN_UP(m->mb_mem_alloc,m->mb_align);
    assert(m->mb_mem >= m->mb_mem_alloc);
    assert(m->mb_mem + m->mb_size <= m->mb_mem_alloc + m->mb_size_alloc);
#if 0
    printf("m_alloc: %p %p %8ld %8ld %8ld\n", m->mb_mem_alloc, m->mb_mem,
           (long) m->mb_size_alloc, (long) m->mb_size, (long) m->mb_align);
#endif
    return 1;
}


void mb_free(mblock_p m)
{
    acc_hfree(m->mb_mem_alloc);
    memset(m,0,sizeof(*m));
}


/* vim:set ts=4 sw=4 et: */
