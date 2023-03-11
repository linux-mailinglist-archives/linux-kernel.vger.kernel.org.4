Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9466B6148
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCKVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:54:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2672B27
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678571650; x=1710107650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W6xXpESimLDsJp6EkDZApfqoZkKXknJkh5Rzj8shKJY=;
  b=IhPFM97lIQlLgpYvsjzWquQel1fIUPejkUdTEFcYZN0hxnO3waBARR2O
   XfdxItbww1K538Ig6EIfTv+W0mhk9TN2RjkMmIh7Bxu7EaR9H+dHo5gGa
   i0g61M9w3GaPsLzOEvtFtyVPQV/C50pKG5SN0qkPrX4vtL4fPUpfKODoX
   R9zOLkDw5x4sGv1lzwpCI49kRPb81jTgzeeSDO7KrPCHzNity4ILpByxr
   WTGsRI1Q2GC4WywcSbKYeW8PXuao+Tnp99OdVRqsfQcDmcKMxyE4z3TCa
   TcVicGTmHqywqMt/E3HwOq/UTqnzcPo7XNZSysRDW9z4khLOQtAjWVuI+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="401808912"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="401808912"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 13:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="628197534"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="628197534"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2023 13:53:03 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pb79C-0004of-1X;
        Sat, 11 Mar 2023 21:53:02 +0000
Date:   Sun, 12 Mar 2023 05:52:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: drivers/scsi/bfa/bfad.c:169:3: warning: cast from 'void (*)(struct
 bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)')
 converts to incompatible function type
Message-ID: <202303120516.CraGyKvc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81ff855485a366a391dc3aed3942715e676ed132
commit: 552a23a0e5d0a84cecd4687043d8030673981d30 Makefile: Enable -Wcast-function-type
date:   1 year, 4 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230312/202303120516.CraGyKvc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=552a23a0e5d0a84cecd4687043d8030673981d30
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 552a23a0e5d0a84cecd4687043d8030673981d30
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/scsi/bfa/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303120516.CraGyKvc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/bfa/bfad.c:169:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_created);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:202:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_initializing);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:260:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:285:4: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           bfa_sm_set_state(bfad, bfad_sm_failed);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:288:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_operational);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:292:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:300:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_failed);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:319:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_operational);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:323:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_fcs_exit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:328:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:345:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_fcs_exit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:361:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_stopping);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:377:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_sm_set_state(bfad, bfad_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:1015:7: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   if (bfa_sm_cmp_state(bfad, bfad_sm_initializing))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:193:53: note: expanded from macro 'bfa_sm_cmp_state'
   #define bfa_sm_cmp_state(_sm, _state)   ((_sm)->sm == (bfa_sm_t)(_state))
                                                         ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:1016:4: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           bfa_sm_set_state(bfad, bfad_sm_failed);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:1342:2: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_sm_set_state(bfad, bfad_sm_uninit);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:190:52: note: expanded from macro 'bfa_sm_set_state'
   #define bfa_sm_set_state(_sm, _state)   ((_sm)->sm = (bfa_sm_t)(_state))
                                                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfad.c:1364:6: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           if (bfa_sm_cmp_state(bfad, bfad_sm_uninit))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:193:53: note: expanded from macro 'bfa_sm_cmp_state'
   #define bfa_sm_cmp_state(_sm, _state)   ((_sm)->sm == (bfa_sm_t)(_state))
--
>> drivers/scsi/bfa/bfad_bsg.c:2138:29: warning: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa.h:434:25: note: expanded from macro 'bfa_pending_q_init'
           (__qe)->hcb_qe.cbfn = (__cbfn);                         \
                                  ^~~~~~
   drivers/scsi/bfa/bfad_bsg.c:2162:29: warning: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa.h:434:25: note: expanded from macro 'bfa_pending_q_init'
           (__qe)->hcb_qe.cbfn = (__cbfn);                         \
                                  ^~~~~~
   drivers/scsi/bfa/bfad_bsg.c:2446:29: warning: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa.h:434:25: note: expanded from macro 'bfa_pending_q_init'
           (__qe)->hcb_qe.cbfn = (__cbfn);                         \
                                  ^~~~~~
   drivers/scsi/bfa/bfad_bsg.c:2477:29: warning: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa.h:434:25: note: expanded from macro 'bfa_pending_q_init'
           (__qe)->hcb_qe.cbfn = (__cbfn);                         \
                                  ^~~~~~
   4 warnings generated.
--
>> drivers/scsi/bfa/bfa_ioc.c:144:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_uninit), BFA_IOC_UNINIT},
            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:145:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_reset), BFA_IOC_RESET},
            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:146:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_enabling), BFA_IOC_ENABLING},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:147:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_getattr), BFA_IOC_GETATTR},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:148:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_op), BFA_IOC_OPERATIONAL},
            ^~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:149:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_fail_retry), BFA_IOC_INITFAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:150:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_fail), BFA_IOC_FAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:151:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_disabling), BFA_IOC_DISABLING},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:152:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_disabled), BFA_IOC_DISABLED},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:153:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_ioc_sm_hwfail), BFA_IOC_HWFAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
>> drivers/scsi/bfa/bfa_ioc.c:232:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_reset), BFA_IOCPF_RESET},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:233:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_fwcheck), BFA_IOCPF_FWMISMATCH},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:234:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_mismatch), BFA_IOCPF_FWMISMATCH},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:235:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_semwait), BFA_IOCPF_SEMWAIT},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:236:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_hwinit), BFA_IOCPF_HWINIT},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:237:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_enabling), BFA_IOCPF_HWINIT},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:238:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_ready), BFA_IOCPF_READY},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:239:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_initfail_sync), BFA_IOCPF_INITFAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:240:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_initfail), BFA_IOCPF_INITFAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:241:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_fail_sync), BFA_IOCPF_FAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:242:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_fail), BFA_IOCPF_FAIL},
            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:243:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_disabling), BFA_IOCPF_DISABLING},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:244:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_disabling_sync), BFA_IOCPF_DISABLING},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:245:3: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           {BFA_SM(bfa_iocpf_sm_disabled), BFA_IOCPF_DISABLED},
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:203:22: note: expanded from macro 'BFA_SM'
   #define BFA_SM(_sm)     ((bfa_sm_t)(_sm))
                            ^~~~~~~~~~~~~~~
>> drivers/scsi/bfa/bfa_ioc.c:271:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_reset);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
>> drivers/scsi/bfa/bfa_ioc.c:284:2: warning: cast from 'void (*)(struct bfa_iocpf_s *, enum iocpf_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
           bfa_fsm_set_state(&ioc->iocpf, bfa_iocpf_sm_reset);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:297:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_enabling);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:305:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:331:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_getattr);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:338:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_fail);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:345:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_hwfail);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:349:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_disabling);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:353:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_uninit);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:384:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_op);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:393:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_fail);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:400:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_disabling);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:434:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_disabling);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:443:4: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           bfa_fsm_set_state(ioc, bfa_ioc_sm_fail_retry);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:445:4: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                           bfa_fsm_set_state(ioc, bfa_ioc_sm_fail);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:478:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_disabled);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:491:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_hwfail);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
                         ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_ioc.c:516:3: warning: cast from 'void (*)(struct bfa_ioc_s *, enum ioc_event)' to 'bfa_fsm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                   bfa_fsm_set_state(ioc, bfa_ioc_sm_enabling);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/bfa/bfa_cs.h:221:16: note: expanded from macro 'bfa_fsm_set_state'
           (_fsm)->fsm = (bfa_fsm_t)(_state);      \
..


vim +169 drivers/scsi/bfa/bfad.c

a36c61f9025b89 Krishna Gudipati 2010-09-15  158  
5fbe25c7a66460 Jing Huang       2010-10-18  159  /*
a36c61f9025b89 Krishna Gudipati 2010-09-15  160   * Beginning state for the driver instance, awaiting the pci_probe event
7725ccfda59715 Jing Huang       2009-09-23  161   */
a36c61f9025b89 Krishna Gudipati 2010-09-15  162  static void
a36c61f9025b89 Krishna Gudipati 2010-09-15  163  bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event event)
a36c61f9025b89 Krishna Gudipati 2010-09-15  164  {
a36c61f9025b89 Krishna Gudipati 2010-09-15  165  	bfa_trc(bfad, event);
a36c61f9025b89 Krishna Gudipati 2010-09-15  166  
a36c61f9025b89 Krishna Gudipati 2010-09-15  167  	switch (event) {
a36c61f9025b89 Krishna Gudipati 2010-09-15  168  	case BFAD_E_CREATE:
a36c61f9025b89 Krishna Gudipati 2010-09-15 @169  		bfa_sm_set_state(bfad, bfad_sm_created);
a36c61f9025b89 Krishna Gudipati 2010-09-15  170  		bfad->bfad_tsk = kthread_create(bfad_worker, (void *) bfad,
a36c61f9025b89 Krishna Gudipati 2010-09-15  171  						"%s", "bfad_worker");
a36c61f9025b89 Krishna Gudipati 2010-09-15  172  		if (IS_ERR(bfad->bfad_tsk)) {
a36c61f9025b89 Krishna Gudipati 2010-09-15  173  			printk(KERN_INFO "bfad[%d]: Kernel thread "
a36c61f9025b89 Krishna Gudipati 2010-09-15  174  				"creation failed!\n", bfad->inst_no);
a36c61f9025b89 Krishna Gudipati 2010-09-15  175  			bfa_sm_send_event(bfad, BFAD_E_KTHREAD_CREATE_FAILED);
a36c61f9025b89 Krishna Gudipati 2010-09-15  176  		}
a36c61f9025b89 Krishna Gudipati 2010-09-15  177  		bfa_sm_send_event(bfad, BFAD_E_INIT);
a36c61f9025b89 Krishna Gudipati 2010-09-15  178  		break;
a36c61f9025b89 Krishna Gudipati 2010-09-15  179  
a36c61f9025b89 Krishna Gudipati 2010-09-15  180  	case BFAD_E_STOP:
a36c61f9025b89 Krishna Gudipati 2010-09-15  181  		/* Ignore stop; already in uninit */
a36c61f9025b89 Krishna Gudipati 2010-09-15  182  		break;
a36c61f9025b89 Krishna Gudipati 2010-09-15  183  
a36c61f9025b89 Krishna Gudipati 2010-09-15  184  	default:
a36c61f9025b89 Krishna Gudipati 2010-09-15  185  		bfa_sm_fault(bfad, event);
a36c61f9025b89 Krishna Gudipati 2010-09-15  186  	}
a36c61f9025b89 Krishna Gudipati 2010-09-15  187  }
7725ccfda59715 Jing Huang       2009-09-23  188  

:::::: The code at line 169 was first introduced by commit
:::::: a36c61f9025b8924f99f54d518763bee7aa84085 [SCSI] bfa: cleanup driver

:::::: TO: Krishna Gudipati <kgudipat@brocade.com>
:::::: CC: James Bottomley <James.Bottomley@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
