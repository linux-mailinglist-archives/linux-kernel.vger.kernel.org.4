Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712495B6620
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIMDav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIMDas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:30:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F34BA76;
        Mon, 12 Sep 2022 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663039846; x=1694575846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvqAqZpTqInXF16KLzlc3IVvUN6JPd0bgtJFosO4hGE=;
  b=B/eVaQyDU/fPqxzb6dOjMIW7/BZoIL5RwFTNpmXpP/7vHH8CQVcl6nVD
   zvPGRIpKiGDjdyjmRyxg7grKCq36K3AAJsfUW+/xQ+yS559MN2aPSa+Lo
   uPX0HD/rBMn+oncMtRjXeqUAQygTjnnDTTtJSSetP9CZvKgLVmF8oOilU
   GcrKzJ/BJl9nIn8yazkvNaayyZaLNsCdeuQvoDMEuHDlfX2WgA8XidFmD
   bXxeef3VN+CONAgpbMYrJdLNWGLiDzTf8BZBK8AKERvs7JxBqGUbb1IFs
   to8aEIBo1pPTuhXVIZnHzIwqMyygu055Mpx+Tdldj2BSf/xkgSpKv9KZ6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324268690"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="324268690"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 20:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="684689796"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 20:30:43 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXwdG-0003AV-2u;
        Tue, 13 Sep 2022 03:30:42 +0000
Date:   Tue, 13 Sep 2022 11:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     kbuild-all@lists.01.org, SEO HOYOUNG <hy50.seo@samsung.com>
Subject: Re: [PATCH v1] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Message-ID: <202209131145.uQlsf9Uv-lkp@intel.com>
References: <20220912140000.95483-1-hy50.seo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912140000.95483-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SEO,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next krzk/for-next linus/master v6.0-rc5 next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/SEO-HOYOUNG/scsi-ufs-add-a-variant-operation-in-struct-ufs_hba_variant_ops/20220913-101855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220913/202209131145.uQlsf9Uv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/60f9cc2a287e2bfe58c8355519797a9071b00afa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review SEO-HOYOUNG/scsi-ufs-add-a-variant-operation-in-struct-ufs_hba_variant_ops/20220913-101855
        git checkout 60f9cc2a287e2bfe58c8355519797a9071b00afa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/ufs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ufs/host/ufs-exynos.c: In function 'exynos_ufs_check_int_error':
   drivers/ufs/host/ufs-exynos.c:1388:17: error: 'val' undeclared (first use in this function)
    1388 |                 val = hci_readl(ufs, HCI_AH8_STATE);
         |                 ^~~
   drivers/ufs/host/ufs-exynos.c:1388:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/ufs/host/ufs-exynos.c:1392:40: warning: assignment to 'bool *' {aka '_Bool *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1392 |                          queue_eh_work = true;
         |                                        ^
>> drivers/ufs/host/ufs-exynos.c:1383:67: warning: parameter 'queue_eh_work' set but not used [-Wunused-but-set-parameter]
    1383 | static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool *queue_eh_work)
         |                                                             ~~~~~~^~~~~~~~~~~~~


vim +1392 drivers/ufs/host/ufs-exynos.c

  1382	
> 1383	static void exynos_ufs_check_int_error(struct ufs_hba *hba, bool *queue_eh_work)
  1384	{
  1385		struct exynos_ufs *ufs = ufshcd_get_variant(hba);
  1386	
  1387		if (ufshcd_is_auto_hibern8_supported(hba)) {
  1388			val = hci_readl(ufs, HCI_AH8_STATE);
  1389	
  1390			if (val & HCI_AH8_STATE_ERROR) {
  1391				 ufshcd_set_link_broken(hba);
> 1392				 queue_eh_work = true;
  1393			}
  1394		}
  1395	}
  1396	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
