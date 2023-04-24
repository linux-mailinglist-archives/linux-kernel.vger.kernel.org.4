Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1046EBC7E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 04:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjDWCzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWCzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 22:55:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74BF210E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682218502; x=1713754502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0aFA++fNP5vaoo1SFePHfLfGQVr9FRjObX2wHkrLMdw=;
  b=E4lq9Q1JjkOSQ3sL/5EVoYU8ClvtmnMf8IOf2PDIK8OfpAFQL2u6SFL/
   +Y49HdFAvPUXtTFPvvTKmQzd9m4aaVPu+eqlsCyilgm3JNf6HSyB2Jcw9
   voHgq+d9f7xLo/lKQfnHIFMi1ufdoQSgyptF1Z/9xB8DSXLBqpu3aIDjP
   3FGe9/BZMktZ2m2qEsBp1MyEBsZlU7IxunWp2TPDEeDTFl+Az/BBhESfR
   WiLp5Cqu86DYcADvxr7I7I4biTb5SZZ9mcCgBbfirLeTZTl19KnE07hAc
   ELioh52DSWuTYGHHGoWcZvzZY2BKNO7s7xq3rVdBxwF0muTdewm+Sk4xQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="374177673"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="374177673"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 19:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="867079788"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="867079788"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2023 19:54:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqPsR-000hfA-0P;
        Sun, 23 Apr 2023 02:54:59 +0000
Date:   Sun, 23 Apr 2023 10:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202304231039.nmq4qjB3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2caeeb9d4a1bccd923b7918427f9e9ef7151ddd8
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   10 months ago
config: parisc-randconfig-s042-20230423 (https://download.01.org/0day-ci/archive/20230423/202304231039.nmq4qjB3-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304231039.nmq4qjB3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:438:29: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] SsidLength @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse:     expected unsigned int [usertype] SsidLength
   drivers/staging/rtl8712/rtl871x_cmd.c:439:38: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] Privacy @@
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse:     expected unsigned int [usertype] val
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse:     got restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: cast from restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: cast from restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: cast from restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:441:32: sparse: sparse: cast from restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] Rssi @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse:     expected signed int [usertype] Rssi
   drivers/staging/rtl8712/rtl871x_cmd.c:442:27: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse:     expected unsigned int enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse
   drivers/staging/rtl8712/rtl871x_cmd.c:443:39: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ATIMWindow @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse:     expected unsigned int [usertype] ATIMWindow
   drivers/staging/rtl8712/rtl871x_cmd.c:445:47: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BeaconPeriod @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse:     expected unsigned int [usertype] BeaconPeriod
   drivers/staging/rtl8712/rtl871x_cmd.c:447:49: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] DSConfig @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse:     expected unsigned int [usertype] DSConfig
   drivers/staging/rtl8712/rtl871x_cmd.c:449:45: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] DwellTime @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse:     expected unsigned int [usertype] DwellTime
   drivers/staging/rtl8712/rtl871x_cmd.c:451:55: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] HopPattern @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse:     expected unsigned int [usertype] HopPattern
   drivers/staging/rtl8712/rtl871x_cmd.c:453:56: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] HopSet @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse:     expected unsigned int [usertype] HopSet
   drivers/staging/rtl8712/rtl871x_cmd.c:455:52: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:457:52: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Length @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse:     expected unsigned int [usertype] Length
   drivers/staging/rtl8712/rtl871x_cmd.c:459:43: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse:     expected unsigned int enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode
   drivers/staging/rtl8712/rtl871x_cmd.c:461:41: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] IELength @@     got restricted __le32 [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse:     expected unsigned int [usertype] IELength
   drivers/staging/rtl8712/rtl871x_cmd.c:463:31: sparse:     got restricted __le32 [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:668:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:669:37: sparse: sparse: cast to restricted __le32
>> drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] Privacy @@     got unsigned int [usertype] @@
   drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse:     expected restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_cmd.c:670:27: sparse:     got unsigned int [usertype]
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:671:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:672:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:674:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:676:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:678:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:680:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:682:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:684:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:686:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:688:17: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_cmd.c:689:30: sparse: sparse: cast to restricted __le32
--
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:455:28: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:456:37: sparse: sparse: cast to restricted __le32
>> drivers/staging/rtl8712/rtl871x_mlme.c:457:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] Privacy @@     got unsigned int [usertype] @@
   drivers/staging/rtl8712/rtl871x_mlme.c:457:27: sparse:     expected restricted __le32 [usertype] Privacy
   drivers/staging/rtl8712/rtl871x_mlme.c:457:27: sparse:     got unsigned int [usertype]
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:458:26: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:459:38: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:461:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:463:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:465:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:467:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:469:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:471:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:473:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:475:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:477:18: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:478:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:673:30: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:674:34: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:675:36: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:675:36: sparse: sparse: cast to restricted __le32
   drivers/staging/rtl8712/rtl871x_mlme.c:675:36: sparse: sparse: too many warnings

vim +670 drivers/staging/rtl8712/rtl871x_cmd.c

2865d42c78a912 Larry Finger        2010-08-20  651  
2865d42c78a912 Larry Finger        2010-08-20  652  void r8712_createbss_cmd_callback(struct _adapter *padapter,
2865d42c78a912 Larry Finger        2010-08-20  653  				  struct cmd_obj *pcmd)
2865d42c78a912 Larry Finger        2010-08-20  654  {
2865d42c78a912 Larry Finger        2010-08-20  655  	unsigned long irqL;
2865d42c78a912 Larry Finger        2010-08-20  656  	struct sta_info *psta = NULL;
2865d42c78a912 Larry Finger        2010-08-20  657  	struct wlan_network *pwlan = NULL;
2865d42c78a912 Larry Finger        2010-08-20  658  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
44367877c6c504 Joshua Clayton      2015-08-05  659  	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
2865d42c78a912 Larry Finger        2010-08-20  660  	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
2865d42c78a912 Larry Finger        2010-08-20  661  
34a2c5fe5b33fd Gulsah Kose         2014-03-12  662  	if (pcmd->res != H2C_SUCCESS)
c703c750cc247c Vaishali Thakkar    2015-02-27  663  		mod_timer(&pmlmepriv->assoc_timer,
c703c750cc247c Vaishali Thakkar    2015-02-27  664  			  jiffies + msecs_to_jiffies(1));
39a6e7376af08b Sudip Mukherjee     2015-05-15  665  	del_timer(&pmlmepriv->assoc_timer);
2865d42c78a912 Larry Finger        2010-08-20  666  #ifdef __BIG_ENDIAN
2865d42c78a912 Larry Finger        2010-08-20  667  	/* endian_convert */
2865d42c78a912 Larry Finger        2010-08-20  668  	pnetwork->Length = le32_to_cpu(pnetwork->Length);
2865d42c78a912 Larry Finger        2010-08-20  669  	pnetwork->Ssid.SsidLength = le32_to_cpu(pnetwork->Ssid.SsidLength);
2865d42c78a912 Larry Finger        2010-08-20 @670  	pnetwork->Privacy = le32_to_cpu(pnetwork->Privacy);
2865d42c78a912 Larry Finger        2010-08-20  671  	pnetwork->Rssi = le32_to_cpu(pnetwork->Rssi);
2865d42c78a912 Larry Finger        2010-08-20  672  	pnetwork->NetworkTypeInUse = le32_to_cpu(pnetwork->NetworkTypeInUse);
b78559b60518eb Martin Homuth       2017-12-19  673  	pnetwork->Configuration.ATIMWindow =
b78559b60518eb Martin Homuth       2017-12-19  674  		le32_to_cpu(pnetwork->Configuration.ATIMWindow);
b78559b60518eb Martin Homuth       2017-12-19  675  	pnetwork->Configuration.DSConfig =
b78559b60518eb Martin Homuth       2017-12-19  676  		le32_to_cpu(pnetwork->Configuration.DSConfig);
b78559b60518eb Martin Homuth       2017-12-19  677  	pnetwork->Configuration.FHConfig.DwellTime =
b78559b60518eb Martin Homuth       2017-12-19  678  		le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
b78559b60518eb Martin Homuth       2017-12-19  679  	pnetwork->Configuration.FHConfig.HopPattern =
b78559b60518eb Martin Homuth       2017-12-19  680  		le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
b78559b60518eb Martin Homuth       2017-12-19  681  	pnetwork->Configuration.FHConfig.HopSet =
b78559b60518eb Martin Homuth       2017-12-19  682  		le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
b78559b60518eb Martin Homuth       2017-12-19  683  	pnetwork->Configuration.FHConfig.Length =
b78559b60518eb Martin Homuth       2017-12-19  684  		le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
b78559b60518eb Martin Homuth       2017-12-19  685  	pnetwork->Configuration.Length =
b78559b60518eb Martin Homuth       2017-12-19  686  		le32_to_cpu(pnetwork->Configuration.Length);
b78559b60518eb Martin Homuth       2017-12-19  687  	pnetwork->InfrastructureMode =
b78559b60518eb Martin Homuth       2017-12-19  688  		le32_to_cpu(pnetwork->InfrastructureMode);
2865d42c78a912 Larry Finger        2010-08-20  689  	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
2865d42c78a912 Larry Finger        2010-08-20  690  #endif
2865d42c78a912 Larry Finger        2010-08-20  691  	spin_lock_irqsave(&pmlmepriv->lock, irqL);
2865d42c78a912 Larry Finger        2010-08-20  692  	if ((pmlmepriv->fw_state) & WIFI_AP_STATE) {
2865d42c78a912 Larry Finger        2010-08-20  693  		psta = r8712_get_stainfo(&padapter->stapriv,
2865d42c78a912 Larry Finger        2010-08-20  694  					 pnetwork->MacAddress);
2865d42c78a912 Larry Finger        2010-08-20  695  		if (!psta) {
2865d42c78a912 Larry Finger        2010-08-20  696  			psta = r8712_alloc_stainfo(&padapter->stapriv,
2865d42c78a912 Larry Finger        2010-08-20  697  						   pnetwork->MacAddress);
11975c56b6d130 Sandhya Bankar      2016-09-20  698  			if (!psta)
2865d42c78a912 Larry Finger        2010-08-20  699  				goto createbss_cmd_fail;
2865d42c78a912 Larry Finger        2010-08-20  700  		}
2865d42c78a912 Larry Finger        2010-08-20  701  		r8712_indicate_connect(padapter);
2865d42c78a912 Larry Finger        2010-08-20  702  	} else {
2865d42c78a912 Larry Finger        2010-08-20  703  		pwlan = _r8712_alloc_network(pmlmepriv);
11975c56b6d130 Sandhya Bankar      2016-09-20  704  		if (!pwlan) {
2865d42c78a912 Larry Finger        2010-08-20  705  			pwlan = r8712_get_oldest_wlan_network(
2865d42c78a912 Larry Finger        2010-08-20  706  				&pmlmepriv->scanned_queue);
11975c56b6d130 Sandhya Bankar      2016-09-20  707  			if (!pwlan)
2865d42c78a912 Larry Finger        2010-08-20  708  				goto createbss_cmd_fail;
2865d42c78a912 Larry Finger        2010-08-20  709  			pwlan->last_scanned = jiffies;
a7e585918ecd5a Liam Ryan           2017-09-12  710  		} else {
fdfbf7890dcac9 James A Shackleford 2014-06-24  711  			list_add_tail(&(pwlan->list),
2865d42c78a912 Larry Finger        2010-08-20  712  					 &pmlmepriv->scanned_queue.queue);
a7e585918ecd5a Liam Ryan           2017-09-12  713  		}
986fc8e7410d65 Joshua Clayton      2015-08-05  714  		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
2865d42c78a912 Larry Finger        2010-08-20  715  		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
2865d42c78a912 Larry Finger        2010-08-20  716  		pwlan->fixed = true;
2865d42c78a912 Larry Finger        2010-08-20  717  		memcpy(&tgt_network->network, pnetwork,
986fc8e7410d65 Joshua Clayton      2015-08-05  718  			(r8712_get_wlan_bssid_ex_sz(pnetwork)));
2865d42c78a912 Larry Finger        2010-08-20  719  		if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
2865d42c78a912 Larry Finger        2010-08-20  720  			pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
8292b4de4ee67a Louie Lu            2016-09-02  721  		/*
8292b4de4ee67a Louie Lu            2016-09-02  722  		 * we will set _FW_LINKED when there is one more sat to
8292b4de4ee67a Louie Lu            2016-09-02  723  		 * join us (stassoc_event_callback)
8292b4de4ee67a Louie Lu            2016-09-02  724  		 */
2865d42c78a912 Larry Finger        2010-08-20  725  	}
2865d42c78a912 Larry Finger        2010-08-20  726  createbss_cmd_fail:
2865d42c78a912 Larry Finger        2010-08-20  727  	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
2865d42c78a912 Larry Finger        2010-08-20  728  	r8712_free_cmd_obj(pcmd);
2865d42c78a912 Larry Finger        2010-08-20  729  }
2865d42c78a912 Larry Finger        2010-08-20  730  

:::::: The code at line 670 was first introduced by commit
:::::: 2865d42c78a9121caad52cb02d1fbb7f5cdbc4ef staging: r8712u: Add the new driver to the mainline kernel

:::::: TO: Larry Finger <Larry.Finger@lwfinger.net>
:::::: CC: Larry Finger <Larry.Finger@lwfinger.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
