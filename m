Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1A6773C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 02:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAWBPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 20:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAWBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:15:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431510267
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 17:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674436551; x=1705972551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hzu9j5JZouZ7INEtZts0xqLFrUF2O3Wzu678kACYwR0=;
  b=Qqg/TOOW28EI74ZpEAxjcdeJQ2dKloxseTXJ+EHSF5kHXGI+L16v4m+y
   fE6S3kgEY6Nh30G/64TIPjkaPqXaJY/dq9lMR3uFagmaCIMQTQTHsMpOs
   LIDtD+p+7CxpIYMgLxfkFoNFTEwpFOpuLL/pfrstiuv98mojY4FrT8g3g
   gdPtso6uiePuKEnG+Ju6BU1A1TDyFIq1yIn8XQ5/gkREZKkUsEGDYI+5K
   lRGcHB+/uAmO/Tp+NOg07cEJEXSql3S72XEFkKmzztVpdtvKry+Qfci0E
   oxqcIEgvcHtIYzsIg+WYpWs4SipBmbRjddjMCBK/fPG+/7gQzFUchNUfZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="388314891"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="388314891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 17:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="769621110"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="769621110"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2023 17:15:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJlR5-0005Ke-2r;
        Mon, 23 Jan 2023 01:15:47 +0000
Date:   Mon, 23 Jan 2023 09:15:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: drivers/iommu/ipmmu-vmsa.c:946:34: warning: 'ipmmu_of_ids' defined
 but not used
Message-ID: <202301230927.BQK00lgd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2475bf0250dee99b477e0c56d7dc9d7ac3f04117
commit: b87d6d7fa405e23478f1e1dff6d66b5a533a5433 iommu/ipmmu-vmsa: Clean up bus_set_iommu()
date:   5 months ago
config: x86_64-buildonly-randconfig-r001-20230123 (https://download.01.org/0day-ci/archive/20230123/202301230927.BQK00lgd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b87d6d7fa405e23478f1e1dff6d66b5a533a5433
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b87d6d7fa405e23478f1e1dff6d66b5a533a5433
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/ipmmu-vmsa.c:946:34: warning: 'ipmmu_of_ids' defined but not used [-Wunused-const-variable=]
     946 | static const struct of_device_id ipmmu_of_ids[] = {
         |                                  ^~~~~~~~~~~~


vim +/ipmmu_of_ids +946 drivers/iommu/ipmmu-vmsa.c

7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  945  
33f3ac9b511612 Magnus Damm             2017-10-16 @946  static const struct of_device_id ipmmu_of_ids[] = {
33f3ac9b511612 Magnus Damm             2017-10-16  947  	{
33f3ac9b511612 Magnus Damm             2017-10-16  948  		.compatible = "renesas,ipmmu-vmsa",
33f3ac9b511612 Magnus Damm             2017-10-16  949  		.data = &ipmmu_features_default,
60fb0083c9d43b Fabrizio Castro         2018-08-23  950  	}, {
60fb0083c9d43b Fabrizio Castro         2018-08-23  951  		.compatible = "renesas,ipmmu-r8a774a1",
60fb0083c9d43b Fabrizio Castro         2018-08-23  952  		.data = &ipmmu_features_rcar_gen3,
757f26a3a9ec2c Biju Das                2019-09-27  953  	}, {
757f26a3a9ec2c Biju Das                2019-09-27  954  		.compatible = "renesas,ipmmu-r8a774b1",
757f26a3a9ec2c Biju Das                2019-09-27  955  		.data = &ipmmu_features_rcar_gen3,
b6d39cd82241bf Fabrizio Castro         2018-12-13  956  	}, {
b6d39cd82241bf Fabrizio Castro         2018-12-13  957  		.compatible = "renesas,ipmmu-r8a774c0",
b6d39cd82241bf Fabrizio Castro         2018-12-13  958  		.data = &ipmmu_features_rcar_gen3,
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  959  	}, {
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  960  		.compatible = "renesas,ipmmu-r8a774e1",
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  961  		.data = &ipmmu_features_rcar_gen3,
58b8e8bf409236 Magnus Damm             2017-10-16  962  	}, {
58b8e8bf409236 Magnus Damm             2017-10-16  963  		.compatible = "renesas,ipmmu-r8a7795",
0b8ac1409641e1 Magnus Damm             2018-06-14  964  		.data = &ipmmu_features_rcar_gen3,
0b8ac1409641e1 Magnus Damm             2018-06-14  965  	}, {
0b8ac1409641e1 Magnus Damm             2018-06-14  966  		.compatible = "renesas,ipmmu-r8a7796",
0b8ac1409641e1 Magnus Damm             2018-06-14  967  		.data = &ipmmu_features_rcar_gen3,
17fe1618163980 Yoshihiro Shimoda       2020-06-11  968  	}, {
17fe1618163980 Yoshihiro Shimoda       2020-06-11  969  		.compatible = "renesas,ipmmu-r8a77961",
17fe1618163980 Yoshihiro Shimoda       2020-06-11  970  		.data = &ipmmu_features_rcar_gen3,
98dbffd39a6513 Jacopo Mondi            2018-06-14  971  	}, {
98dbffd39a6513 Jacopo Mondi            2018-06-14  972  		.compatible = "renesas,ipmmu-r8a77965",
98dbffd39a6513 Jacopo Mondi            2018-06-14  973  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  974  	}, {
3701c123e1c13c Simon Horman            2018-06-14  975  		.compatible = "renesas,ipmmu-r8a77970",
3701c123e1c13c Simon Horman            2018-06-14  976  		.data = &ipmmu_features_rcar_gen3,
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  977  	}, {
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  978  		.compatible = "renesas,ipmmu-r8a77980",
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  979  		.data = &ipmmu_features_rcar_gen3,
b0c32912150565 Hai Nguyen Pham         2018-10-17  980  	}, {
b0c32912150565 Hai Nguyen Pham         2018-10-17  981  		.compatible = "renesas,ipmmu-r8a77990",
b0c32912150565 Hai Nguyen Pham         2018-10-17  982  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  983  	}, {
3701c123e1c13c Simon Horman            2018-06-14  984  		.compatible = "renesas,ipmmu-r8a77995",
3701c123e1c13c Simon Horman            2018-06-14  985  		.data = &ipmmu_features_rcar_gen3,
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  986  	}, {
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  987  		.compatible = "renesas,ipmmu-r8a779a0",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  988  		.data = &ipmmu_features_rcar_gen4,
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  989  	}, {
9f7d09fe23a011 Yoshihiro Shimoda       2022-06-17  990  		.compatible = "renesas,rcar-gen4-ipmmu-vmsa",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  991  		.data = &ipmmu_features_rcar_gen4,
33f3ac9b511612 Magnus Damm             2017-10-16  992  	}, {
33f3ac9b511612 Magnus Damm             2017-10-16  993  		/* Terminator */
33f3ac9b511612 Magnus Damm             2017-10-16  994  	},
33f3ac9b511612 Magnus Damm             2017-10-16  995  };
33f3ac9b511612 Magnus Damm             2017-10-16  996  

:::::: The code at line 946 was first introduced by commit
:::::: 33f3ac9b511612153bae1d328b0c84c0367cd08d iommu/ipmmu-vmsa: Introduce features, break out alias

:::::: TO: Magnus Damm <damm+renesas@opensource.se>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
