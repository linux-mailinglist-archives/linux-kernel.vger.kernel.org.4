Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17569EE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBVFFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBVFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:04:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DE2D15C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677042293; x=1708578293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oJ7XMFF2VmyWWBTx/mel03X2Wu+Ybe3nKZ11chhScAM=;
  b=gdxGJ+iyoLPcu/EgJCEQxIgKkLhCM8z+9ElSJ0O081OAjz9fNyeVV/FC
   INq5V6Qgow2pzemNROTO1JZMTHYZsa0eDWjgwN38XkFgmVOGwU68cdt1b
   oG6tFi6ADoBwcqSSsyrbLHm5WKMw++QlHPRpwlCl6qvkIassdZI9RZOdj
   B2RjLywFR0S5Fxz9Zhwzyuwr7dXVPUgv6p+U2mZJyQqyMf1VJy4dnpABP
   Fc/iwhhl1ziSdzcWlIPvyDcrVmrjP6z60eaJK29XG5OaLPN2z4dSUiljh
   8/3/vU1nciqdFqCOsYJuDqTRiZ37k4P51NpOiY0BKkH+YNIucpHe/GCJ1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334201157"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="334201157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 21:04:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="781287416"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="781287416"
Received: from lkp-server01.sh.intel.com (HELO 598f84d49bc7) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2023 21:04:51 -0800
Received: from kbuild by 598f84d49bc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUhJC-00001l-2N;
        Wed, 22 Feb 2023 05:04:50 +0000
Date:   Wed, 22 Feb 2023 13:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/bpf/core.c:1913:3: error: call to undeclared function
 'barrier_nospec'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202302221228.E0rmVamR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
commit: 74e19ef0ff8061ef55957c3abd71614ef0f42f47 uaccess: Add speculation barrier to copy_from_user()
date:   6 hours ago
config: hexagon-buildonly-randconfig-r005-20230222 (https://download.01.org/0day-ci/archive/20230222/202302221228.E0rmVamR-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74e19ef0ff8061ef55957c3abd71614ef0f42f47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 74e19ef0ff8061ef55957c3abd71614ef0f42f47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221228.E0rmVamR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   kernel/bpf/core.c:1630:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1630:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
>> kernel/bpf/core.c:1913:3: error: call to undeclared function 'barrier_nospec'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   barrier_nospec();
                   ^
   7 warnings and 1 error generated.


vim +/barrier_nospec +1913 kernel/bpf/core.c

f5bffecda951b5 Alexei Starovoitov 2014-07-22  1668  
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1669  select_insn:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1670  	goto *jumptable[insn->code];
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1671  
28131e9d933339 Daniel Borkmann    2021-06-16  1672  	/* Explicitly mask the register-based shift amounts with 63 or 31
28131e9d933339 Daniel Borkmann    2021-06-16  1673  	 * to avoid undefined behavior. Normally this won't affect the
28131e9d933339 Daniel Borkmann    2021-06-16  1674  	 * generated code, for example, in case of native 64 bit archs such
28131e9d933339 Daniel Borkmann    2021-06-16  1675  	 * as x86-64 or arm64, the compiler is optimizing the AND away for
28131e9d933339 Daniel Borkmann    2021-06-16  1676  	 * the interpreter. In case of JITs, each of the JIT backends compiles
28131e9d933339 Daniel Borkmann    2021-06-16  1677  	 * the BPF shift operations to machine instructions which produce
28131e9d933339 Daniel Borkmann    2021-06-16  1678  	 * implementation-defined results in such a case; the resulting
28131e9d933339 Daniel Borkmann    2021-06-16  1679  	 * contents of the register may be arbitrary, but program behaviour
28131e9d933339 Daniel Borkmann    2021-06-16  1680  	 * as a whole remains defined. In other words, in case of JIT backends,
28131e9d933339 Daniel Borkmann    2021-06-16  1681  	 * the AND must /not/ be added to the emitted LSH/RSH/ARSH translation.
28131e9d933339 Daniel Borkmann    2021-06-16  1682  	 */
28131e9d933339 Daniel Borkmann    2021-06-16  1683  	/* ALU (shifts) */
28131e9d933339 Daniel Borkmann    2021-06-16  1684  #define SHT(OPCODE, OP)					\
28131e9d933339 Daniel Borkmann    2021-06-16  1685  	ALU64_##OPCODE##_X:				\
28131e9d933339 Daniel Borkmann    2021-06-16  1686  		DST = DST OP (SRC & 63);		\
28131e9d933339 Daniel Borkmann    2021-06-16  1687  		CONT;					\
28131e9d933339 Daniel Borkmann    2021-06-16  1688  	ALU_##OPCODE##_X:				\
28131e9d933339 Daniel Borkmann    2021-06-16  1689  		DST = (u32) DST OP ((u32) SRC & 31);	\
28131e9d933339 Daniel Borkmann    2021-06-16  1690  		CONT;					\
28131e9d933339 Daniel Borkmann    2021-06-16  1691  	ALU64_##OPCODE##_K:				\
28131e9d933339 Daniel Borkmann    2021-06-16  1692  		DST = DST OP IMM;			\
28131e9d933339 Daniel Borkmann    2021-06-16  1693  		CONT;					\
28131e9d933339 Daniel Borkmann    2021-06-16  1694  	ALU_##OPCODE##_K:				\
28131e9d933339 Daniel Borkmann    2021-06-16  1695  		DST = (u32) DST OP (u32) IMM;		\
28131e9d933339 Daniel Borkmann    2021-06-16  1696  		CONT;
28131e9d933339 Daniel Borkmann    2021-06-16  1697  	/* ALU (rest) */
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1698  #define ALU(OPCODE, OP)					\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1699  	ALU64_##OPCODE##_X:				\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1700  		DST = DST OP SRC;			\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1701  		CONT;					\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1702  	ALU_##OPCODE##_X:				\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1703  		DST = (u32) DST OP (u32) SRC;		\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1704  		CONT;					\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1705  	ALU64_##OPCODE##_K:				\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1706  		DST = DST OP IMM;			\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1707  		CONT;					\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1708  	ALU_##OPCODE##_K:				\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1709  		DST = (u32) DST OP (u32) IMM;		\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1710  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1711  	ALU(ADD,  +)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1712  	ALU(SUB,  -)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1713  	ALU(AND,  &)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1714  	ALU(OR,   |)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1715  	ALU(XOR,  ^)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1716  	ALU(MUL,  *)
28131e9d933339 Daniel Borkmann    2021-06-16  1717  	SHT(LSH, <<)
28131e9d933339 Daniel Borkmann    2021-06-16  1718  	SHT(RSH, >>)
28131e9d933339 Daniel Borkmann    2021-06-16  1719  #undef SHT
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1720  #undef ALU
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1721  	ALU_NEG:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1722  		DST = (u32) -DST;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1723  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1724  	ALU64_NEG:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1725  		DST = -DST;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1726  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1727  	ALU_MOV_X:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1728  		DST = (u32) SRC;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1729  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1730  	ALU_MOV_K:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1731  		DST = (u32) IMM;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1732  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1733  	ALU64_MOV_X:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1734  		DST = SRC;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1735  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1736  	ALU64_MOV_K:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1737  		DST = IMM;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1738  		CONT;
02ab695bb37ee9 Alexei Starovoitov 2014-09-04  1739  	LD_IMM_DW:
02ab695bb37ee9 Alexei Starovoitov 2014-09-04  1740  		DST = (u64) (u32) insn[0].imm | ((u64) (u32) insn[1].imm) << 32;
02ab695bb37ee9 Alexei Starovoitov 2014-09-04  1741  		insn++;
02ab695bb37ee9 Alexei Starovoitov 2014-09-04  1742  		CONT;
2dc6b100f928aa Jiong Wang         2018-12-05  1743  	ALU_ARSH_X:
28131e9d933339 Daniel Borkmann    2021-06-16  1744  		DST = (u64) (u32) (((s32) DST) >> (SRC & 31));
2dc6b100f928aa Jiong Wang         2018-12-05  1745  		CONT;
2dc6b100f928aa Jiong Wang         2018-12-05  1746  	ALU_ARSH_K:
75672dda27bd00 Jiong Wang         2019-06-25  1747  		DST = (u64) (u32) (((s32) DST) >> IMM);
2dc6b100f928aa Jiong Wang         2018-12-05  1748  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1749  	ALU64_ARSH_X:
28131e9d933339 Daniel Borkmann    2021-06-16  1750  		(*(s64 *) &DST) >>= (SRC & 63);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1751  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1752  	ALU64_ARSH_K:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1753  		(*(s64 *) &DST) >>= IMM;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1754  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1755  	ALU64_MOD_X:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1756  		div64_u64_rem(DST, SRC, &AX);
144cd91c4c2bce Daniel Borkmann    2019-01-03  1757  		DST = AX;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1758  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1759  	ALU_MOD_X:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1760  		AX = (u32) DST;
144cd91c4c2bce Daniel Borkmann    2019-01-03  1761  		DST = do_div(AX, (u32) SRC);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1762  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1763  	ALU64_MOD_K:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1764  		div64_u64_rem(DST, IMM, &AX);
144cd91c4c2bce Daniel Borkmann    2019-01-03  1765  		DST = AX;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1766  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1767  	ALU_MOD_K:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1768  		AX = (u32) DST;
144cd91c4c2bce Daniel Borkmann    2019-01-03  1769  		DST = do_div(AX, (u32) IMM);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1770  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1771  	ALU64_DIV_X:
876a7ae65b86d8 Alexei Starovoitov 2015-04-27  1772  		DST = div64_u64(DST, SRC);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1773  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1774  	ALU_DIV_X:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1775  		AX = (u32) DST;
144cd91c4c2bce Daniel Borkmann    2019-01-03  1776  		do_div(AX, (u32) SRC);
144cd91c4c2bce Daniel Borkmann    2019-01-03  1777  		DST = (u32) AX;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1778  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1779  	ALU64_DIV_K:
876a7ae65b86d8 Alexei Starovoitov 2015-04-27  1780  		DST = div64_u64(DST, IMM);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1781  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1782  	ALU_DIV_K:
144cd91c4c2bce Daniel Borkmann    2019-01-03  1783  		AX = (u32) DST;
144cd91c4c2bce Daniel Borkmann    2019-01-03  1784  		do_div(AX, (u32) IMM);
144cd91c4c2bce Daniel Borkmann    2019-01-03  1785  		DST = (u32) AX;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1786  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1787  	ALU_END_TO_BE:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1788  		switch (IMM) {
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1789  		case 16:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1790  			DST = (__force u16) cpu_to_be16(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1791  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1792  		case 32:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1793  			DST = (__force u32) cpu_to_be32(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1794  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1795  		case 64:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1796  			DST = (__force u64) cpu_to_be64(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1797  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1798  		}
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1799  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1800  	ALU_END_TO_LE:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1801  		switch (IMM) {
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1802  		case 16:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1803  			DST = (__force u16) cpu_to_le16(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1804  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1805  		case 32:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1806  			DST = (__force u32) cpu_to_le32(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1807  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1808  		case 64:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1809  			DST = (__force u64) cpu_to_le64(DST);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1810  			break;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1811  		}
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1812  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1813  
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1814  	/* CALL */
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1815  	JMP_CALL:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1816  		/* Function call scratches BPF_R1-BPF_R5 registers,
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1817  		 * preserves BPF_R6-BPF_R9, and stores return value
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1818  		 * into BPF_R0.
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1819  		 */
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1820  		BPF_R0 = (__bpf_call_base + insn->imm)(BPF_R1, BPF_R2, BPF_R3,
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1821  						       BPF_R4, BPF_R5);
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1822  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1823  
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1824  	JMP_CALL_ARGS:
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1825  		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1826  							    BPF_R3, BPF_R4,
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1827  							    BPF_R5,
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1828  							    insn + insn->off + 1);
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1829  		CONT;
1ea47e01ad6ea0 Alexei Starovoitov 2017-12-14  1830  
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1831  	JMP_TAIL_CALL: {
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1832  		struct bpf_map *map = (struct bpf_map *) (unsigned long) BPF_R2;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1833  		struct bpf_array *array = container_of(map, struct bpf_array, map);
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1834  		struct bpf_prog *prog;
90caccdd8cc021 Alexei Starovoitov 2017-10-03  1835  		u32 index = BPF_R3;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1836  
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1837  		if (unlikely(index >= array->map.max_entries))
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1838  			goto out;
ebf7f6f0a6cdcc Tiezhu Yang        2021-11-05  1839  
ebf7f6f0a6cdcc Tiezhu Yang        2021-11-05  1840  		if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1841  			goto out;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1842  
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1843  		tail_call_cnt++;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1844  
2a36f0b92eb638 Wang Nan           2015-08-06  1845  		prog = READ_ONCE(array->ptrs[index]);
1ca1cc98bf7418 Daniel Borkmann    2016-06-28  1846  		if (!prog)
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1847  			goto out;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1848  
c4675f935399cb Daniel Borkmann    2015-07-13  1849  		/* ARG1 at this point is guaranteed to point to CTX from
c4675f935399cb Daniel Borkmann    2015-07-13  1850  		 * the verifier side due to the fact that the tail call is
0142dddcbe9654 Chris Packham      2020-05-26  1851  		 * handled like a helper, that is, bpf_tail_call_proto,
c4675f935399cb Daniel Borkmann    2015-07-13  1852  		 * where arg1_type is ARG_PTR_TO_CTX.
c4675f935399cb Daniel Borkmann    2015-07-13  1853  		 */
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1854  		insn = prog->insnsi;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1855  		goto select_insn;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1856  out:
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1857  		CONT;
04fd61ab36ec06 Alexei Starovoitov 2015-05-19  1858  	}
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1859  	JMP_JA:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1860  		insn += insn->off;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1861  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1862  	JMP_EXIT:
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1863  		return BPF_R0;
503a8865a47752 Jiong Wang         2019-01-26  1864  	/* JMP */
503a8865a47752 Jiong Wang         2019-01-26  1865  #define COND_JMP(SIGN, OPCODE, CMP_OP)				\
503a8865a47752 Jiong Wang         2019-01-26  1866  	JMP_##OPCODE##_X:					\
503a8865a47752 Jiong Wang         2019-01-26  1867  		if ((SIGN##64) DST CMP_OP (SIGN##64) SRC) {	\
503a8865a47752 Jiong Wang         2019-01-26  1868  			insn += insn->off;			\
503a8865a47752 Jiong Wang         2019-01-26  1869  			CONT_JMP;				\
503a8865a47752 Jiong Wang         2019-01-26  1870  		}						\
503a8865a47752 Jiong Wang         2019-01-26  1871  		CONT;						\
503a8865a47752 Jiong Wang         2019-01-26  1872  	JMP32_##OPCODE##_X:					\
503a8865a47752 Jiong Wang         2019-01-26  1873  		if ((SIGN##32) DST CMP_OP (SIGN##32) SRC) {	\
503a8865a47752 Jiong Wang         2019-01-26  1874  			insn += insn->off;			\
503a8865a47752 Jiong Wang         2019-01-26  1875  			CONT_JMP;				\
503a8865a47752 Jiong Wang         2019-01-26  1876  		}						\
503a8865a47752 Jiong Wang         2019-01-26  1877  		CONT;						\
503a8865a47752 Jiong Wang         2019-01-26  1878  	JMP_##OPCODE##_K:					\
503a8865a47752 Jiong Wang         2019-01-26  1879  		if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {	\
503a8865a47752 Jiong Wang         2019-01-26  1880  			insn += insn->off;			\
503a8865a47752 Jiong Wang         2019-01-26  1881  			CONT_JMP;				\
503a8865a47752 Jiong Wang         2019-01-26  1882  		}						\
503a8865a47752 Jiong Wang         2019-01-26  1883  		CONT;						\
503a8865a47752 Jiong Wang         2019-01-26  1884  	JMP32_##OPCODE##_K:					\
503a8865a47752 Jiong Wang         2019-01-26  1885  		if ((SIGN##32) DST CMP_OP (SIGN##32) IMM) {	\
503a8865a47752 Jiong Wang         2019-01-26  1886  			insn += insn->off;			\
503a8865a47752 Jiong Wang         2019-01-26  1887  			CONT_JMP;				\
503a8865a47752 Jiong Wang         2019-01-26  1888  		}						\
503a8865a47752 Jiong Wang         2019-01-26  1889  		CONT;
503a8865a47752 Jiong Wang         2019-01-26  1890  	COND_JMP(u, JEQ, ==)
503a8865a47752 Jiong Wang         2019-01-26  1891  	COND_JMP(u, JNE, !=)
503a8865a47752 Jiong Wang         2019-01-26  1892  	COND_JMP(u, JGT, >)
503a8865a47752 Jiong Wang         2019-01-26  1893  	COND_JMP(u, JLT, <)
503a8865a47752 Jiong Wang         2019-01-26  1894  	COND_JMP(u, JGE, >=)
503a8865a47752 Jiong Wang         2019-01-26  1895  	COND_JMP(u, JLE, <=)
503a8865a47752 Jiong Wang         2019-01-26  1896  	COND_JMP(u, JSET, &)
503a8865a47752 Jiong Wang         2019-01-26  1897  	COND_JMP(s, JSGT, >)
503a8865a47752 Jiong Wang         2019-01-26  1898  	COND_JMP(s, JSLT, <)
503a8865a47752 Jiong Wang         2019-01-26  1899  	COND_JMP(s, JSGE, >=)
503a8865a47752 Jiong Wang         2019-01-26  1900  	COND_JMP(s, JSLE, <=)
503a8865a47752 Jiong Wang         2019-01-26  1901  #undef COND_JMP
f5e81d11175015 Daniel Borkmann    2021-07-13  1902  	/* ST, STX and LDX*/
f5e81d11175015 Daniel Borkmann    2021-07-13  1903  	ST_NOSPEC:
f5e81d11175015 Daniel Borkmann    2021-07-13  1904  		/* Speculation barrier for mitigating Speculative Store Bypass.
f5e81d11175015 Daniel Borkmann    2021-07-13  1905  		 * In case of arm64, we rely on the firmware mitigation as
f5e81d11175015 Daniel Borkmann    2021-07-13  1906  		 * controlled via the ssbd kernel parameter. Whenever the
f5e81d11175015 Daniel Borkmann    2021-07-13  1907  		 * mitigation is enabled, it works for all of the kernel code
f5e81d11175015 Daniel Borkmann    2021-07-13  1908  		 * with no need to provide any additional instructions here.
f5e81d11175015 Daniel Borkmann    2021-07-13  1909  		 * In case of x86, we use 'lfence' insn for mitigation. We
f5e81d11175015 Daniel Borkmann    2021-07-13  1910  		 * reuse preexisting logic from Spectre v1 mitigation that
f5e81d11175015 Daniel Borkmann    2021-07-13  1911  		 * happens to produce the required code on x86 for v4 as well.
f5e81d11175015 Daniel Borkmann    2021-07-13  1912  		 */
f5e81d11175015 Daniel Borkmann    2021-07-13 @1913  		barrier_nospec();
f5e81d11175015 Daniel Borkmann    2021-07-13  1914  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1915  #define LDST(SIZEOP, SIZE)						\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1916  	STX_MEM_##SIZEOP:						\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1917  		*(SIZE *)(unsigned long) (DST + insn->off) = SRC;	\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1918  		CONT;							\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1919  	ST_MEM_##SIZEOP:						\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1920  		*(SIZE *)(unsigned long) (DST + insn->off) = IMM;	\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1921  		CONT;							\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1922  	LDX_MEM_##SIZEOP:						\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1923  		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
caff1fa4118cec Menglong Dong      2022-05-24  1924  		CONT;							\
caff1fa4118cec Menglong Dong      2022-05-24  1925  	LDX_PROBE_MEM_##SIZEOP:						\
caff1fa4118cec Menglong Dong      2022-05-24  1926  		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
caff1fa4118cec Menglong Dong      2022-05-24  1927  				      (const void *)(long) (SRC + insn->off));	\
caff1fa4118cec Menglong Dong      2022-05-24  1928  		DST = *((SIZE *)&DST);					\
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1929  		CONT;
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1930  
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1931  	LDST(B,   u8)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1932  	LDST(H,  u16)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1933  	LDST(W,  u32)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1934  	LDST(DW, u64)
f5bffecda951b5 Alexei Starovoitov 2014-07-22  1935  #undef LDST
2a02759ef5f8a3 Alexei Starovoitov 2019-10-15  1936  

:::::: The code at line 1913 was first introduced by commit
:::::: f5e81d1117501546b7be050c5fbafa6efd2c722c bpf: Introduce BPF nospec instruction for mitigating Spectre v4

:::::: TO: Daniel Borkmann <daniel@iogearbox.net>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
