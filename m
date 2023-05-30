Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB77170D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjE3Wj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjE3Wjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:39:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4FE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685486391; x=1717022391;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3ElfZ3+hg56VGFC2mULrmBi28yurnRX5FrUeCmmrpM8=;
  b=mlXlL+bT4hhcecP20Xa/uoqDbrKurIpsVFygWJEt/tw0AdMdG2C83K5G
   9VNGBOBNAmzAlt4pOx+VjWcDeIYLrNSUYNMWXYJVMyN/rNV+fxAsMbqGu
   7M/bQY0mlpqehI9JMSvtQNlts9rLdk4qQxrWk+oU+TgcYrHgoRzwsm7yp
   MgzoRLPoinDGB97DHswCI2CSVugPcg/HPf470LRslNtMTdFtkQnBMNKQ2
   xoIsLHmkY1URTd1G/nwchSrvNXlFqItlGgT12lPLhweTOEvs/hfGAvaw/
   nBEo8z27KygJ3bJMM+KzqARY7hHlctN/26wWUIt1YnV0gmyxJFr/MCmDm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="352564600"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="352564600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 15:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953355654"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="953355654"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2023 15:39:48 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q480K-0000st-0m;
        Tue, 30 May 2023 22:39:48 +0000
Date:   Wed, 31 May 2023 06:39:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: sigstruct.c:120:17: error: 'ERR_get_error_line' is deprecated: Since
 OpenSSL 3.0
Message-ID: <202305310621.FdRK5esz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: 2adcba79e69d4a4c0ac3bb86f466d8b5df301608 selftests/x86: Add a selftest for SGX
date:   2 years, 6 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2adcba79e69d4a4c0ac3bb86f466d8b5df301608
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2adcba79e69d4a4c0ac3bb86f466d8b5df301608
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310621.FdRK5esz-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from rseq.c:30:
   rseq.h: In function 'rseq_clear_rseq_cs':
>> rseq.h:143:27: error: request for member 'ptr' in something not a structure or union
     143 |         __rseq_abi.rseq_cs.ptr = 0;
         |                           ^
--
   sigstruct.c: In function 'check_crypto_errors':
>> sigstruct.c:120:17: error: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     120 |                 err = ERR_get_error_line(&filename, &line);
         |                 ^~~
   In file included from sigstruct.c:15:
   /usr/include/openssl/err.h:423:15: note: declared here
     423 | unsigned long ERR_get_error_line(const char **file, int *line);
         |               ^~~~~~~~~~~~~~~~~~
   sigstruct.c: In function 'get_modulus':
>> sigstruct.c:132:9: error: 'RSA_get0_key' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     132 |         RSA_get0_key(key, &n, NULL, NULL);
         |         ^~~~~~~~~~~~
   In file included from /usr/include/openssl/x509.h:36,
                    from /usr/include/openssl/pem.h:23,
                    from sigstruct.c:16:
   /usr/include/openssl/rsa.h:217:28: note: declared here
     217 | OSSL_DEPRECATEDIN_3_0 void RSA_get0_key(const RSA *r,
         |                            ^~~~~~~~~~~~
   sigstruct.c: In function 'gen_sign_key':
>> sigstruct.c:143:9: error: 'RSA_new' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     143 |         key = RSA_new();
         |         ^~~
   /usr/include/openssl/rsa.h:201:28: note: declared here
     201 | OSSL_DEPRECATEDIN_3_0 RSA *RSA_new(void);
         |                            ^~~~~~~
>> sigstruct.c:152:9: error: 'RSA_generate_key_ex' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     152 |         ret = RSA_generate_key_ex(key, 3072, e, NULL);
         |         ^~~
   /usr/include/openssl/rsa.h:260:27: note: declared here
     260 | OSSL_DEPRECATEDIN_3_0 int RSA_generate_key_ex(RSA *rsa, int bits, BIGNUM *e,
         |                           ^~~~~~~~~~~~~~~~~~~
>> sigstruct.c:161:9: error: 'RSA_free' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     161 |         RSA_free(key);
         |         ^~~~~~~~
   /usr/include/openssl/rsa.h:293:28: note: declared here
     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
         |                            ^~~~~~~~
   sigstruct.c: In function 'encl_measure':
>> sigstruct.c:369:9: error: 'RSA_sign' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     369 |         if (!RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH,
         |         ^~
   /usr/include/openssl/rsa.h:348:27: note: declared here
     348 | OSSL_DEPRECATEDIN_3_0 int RSA_sign(int type, const unsigned char *m,
         |                           ^~~~~~~~
>> sigstruct.c:384:9: error: 'RSA_free' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     384 |         RSA_free(key);
         |         ^~~~~~~~
   /usr/include/openssl/rsa.h:293:28: note: declared here
     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
         |                            ^~~~~~~~
>> sigstruct.c:389:9: error: 'RSA_free' is deprecated: Since OpenSSL 3.0 [-Werror=deprecated-declarations]
     389 |         RSA_free(key);
         |         ^~~~~~~~
   /usr/include/openssl/rsa.h:293:28: note: declared here
     293 | OSSL_DEPRECATEDIN_3_0 void RSA_free(RSA *r);
         |                            ^~~~~~~~
   cc1: all warnings being treated as errors
--
   /usr/bin/ld: warning: /tmp/cc4ULjUa.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id ignored
--
>> single_step_syscall.c:60:22: error: variably modified 'altstack_data' at file scope
      60 | static unsigned char altstack_data[SIGSTKSZ];
         |                      ^~~~~~~~~~~~~
--
>> sigreturn.c:142:13: error: variably modified 'altstack_data' at file scope
     142 | static char altstack_data[SIGSTKSZ];
         |             ^~~~~~~~~~~~~
--
>> mov_ss_trap.c:50:22: error: variably modified 'altstack_data' at file scope
      50 | static unsigned char altstack_data[SIGSTKSZ];
         |                      ^~~~~~~~~~~~~
--
>> syscall_arg_fault.c:21:22: error: variably modified 'altstack_data' at file scope
      21 | static unsigned char altstack_data[SIGSTKSZ];
         |                      ^~~~~~~~~~~~~
--
>> make[3]: *** No rule to make target 'tools/include/linux/compiler_types.h', needed by 'tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o'.
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [Makefile:178: tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf-in.o] Error 2
   Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'
   Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
>> make[3]: *** No rule to make target 'tools/include/linux/compiler_types.h', needed by 'tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o'.
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [Makefile:165: tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o] Error 2
   make[2]: Target 'all_cmd' not remade because of errors.
--
   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
   Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
   Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
   Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
   Makefile.config:696: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
   In file included from sigchain.c:3:
   In function 'xrealloc',
       inlined from 'sigchain_push.isra' at sigchain.c:26:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   In function 'xrealloc',
       inlined from 'sigchain_push' at sigchain.c:26:2,
       inlined from 'sigchain_push_common' at sigchain.c:53:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:96: tools/perf/sigchain.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   In file included from help.c:12:
   In function 'xrealloc',
       inlined from 'add_cmdname' at help.c:24:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   pmu-events/jevents.c:72:22: warning: no previous prototype for 'convert' [-Wmissing-prototypes]
      72 | enum aggr_mode_class convert(const char *aggr_mode)
         |                      ^~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:96: tools/perf/help.o] Error 1
   make[5]: *** [Makefile:59: tools/perf/libsubcmd-in.o] Error 2
   make[4]: *** [Makefile.perf:826: tools/perf/libsubcmd.a] Error 2
   make[4]: *** Waiting for unfinished jobs....
     PERF_VERSION = 5.10.rc4.g2adcba79e69d
   make[3]: *** [Makefile.perf:233: sub-make] Error 2
   make[2]: *** [Makefile:70: all] Error 2
--
   tools/bpf/bpf_jit_disasm.c: In function 'get_asm_insns':
>> tools/bpf/bpf_jit_disasm.c:67:9: error: too few arguments to function 'init_disassemble_info'
      67 |         init_disassemble_info(&info, stdout, (fprintf_ftype) fprintf);
         |         ^~~~~~~~~~~~~~~~~~~~~
   In file included from tools/bpf/bpf_jit_disasm.c:24:
   /usr/include/dis-asm.h:480:13: note: declared here
     480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
         |             ^~~~~~~~~~~~~~~~~~~~~
   make[2]: *** [Makefile:67: tools/bpf/bpf_jit_disasm.o] Error 1
   make[2]: *** Waiting for unfinished jobs....
   jit_disasm.c: In function 'disasm_print_insn':
>> jit_disasm.c:100:17: error: too few arguments to function 'init_disassemble_info'
     100 |                 init_disassemble_info(&info, stdout,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from jit_disasm.c:23:
   /usr/include/dis-asm.h:480:13: note: declared here
     480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
         |             ^~~~~~~~~~~~~~~~~~~~~
>> jit_disasm.c:103:17: error: too few arguments to function 'init_disassemble_info'
     103 |                 init_disassemble_info(&info, stdout,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   /usr/include/dis-asm.h:480:13: note: declared here
     480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
         |             ^~~~~~~~~~~~~~~~~~~~~
   jit_disasm.c: In function 'disasm_print_insn':
>> jit_disasm.c:100:17: error: too few arguments to function 'init_disassemble_info'
     100 |                 init_disassemble_info(&info, stdout,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from jit_disasm.c:23:
   /usr/include/dis-asm.h:480:13: note: declared here
     480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
         |             ^~~~~~~~~~~~~~~~~~~~~
>> jit_disasm.c:103:17: error: too few arguments to function 'init_disassemble_info'
     103 |                 init_disassemble_info(&info, stdout,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   /usr/include/dis-asm.h:480:13: note: declared here
     480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
         |             ^~~~~~~~~~~~~~~~~~~~~
   make[4]: *** [Makefile:177: tools/bpf/runqslower/.output/jit_disasm.o] Error 1
   make[3]: *** [Makefile:84: .output/sbin/bpftool] Error 2
   make[2]: *** [Makefile:119: runqslower] Error 2
   make[3]: *** [Makefile:177: tools/bpf/bpftool/jit_disasm.o] Error 1
   make[3]: *** Waiting for unfinished jobs....
   make[2]: *** [Makefile:110: bpftool] Error 2
--
   In file included from sigchain.c:3:
   In function 'xrealloc',
       inlined from 'sigchain_push.isra' at sigchain.c:26:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   In file included from help.c:12:
   In function 'xrealloc',
       inlined from 'add_cmdname' at help.c:24:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   In function 'xrealloc',
       inlined from 'sigchain_push' at sigchain.c:26:2,
       inlined from 'sigchain_push_common' at sigchain.c:53:2:
>> subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
>> subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[4]: *** [tools/build/Makefile.build:96: tools/objtool/sigchain.o] Error 1
   make[4]: *** Waiting for unfinished jobs....
   cc1: all warnings being treated as errors
   make[4]: *** [tools/build/Makefile.build:96: tools/objtool/help.o] Error 1
   make[3]: *** [Makefile:59: tools/objtool/libsubcmd-in.o] Error 2
   make[2]: *** [Makefile:75: tools/objtool/libsubcmd.a] Error 2
   make[2]: *** Waiting for unfinished jobs....
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
