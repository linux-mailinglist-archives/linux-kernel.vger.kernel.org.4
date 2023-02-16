Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A1698931
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBPAXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:23:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906DC3B659;
        Wed, 15 Feb 2023 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676507006; x=1708043006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBoSCAtz6fkkZle3VLj8Y/RmveUth+ypvnNypFuDpJs=;
  b=cIVCy0MQB7CqTgZnQ8iNJ+eEEX+eNJTMVQH3fJ38bNb1Bc5R/hIpAdlZ
   t7RVRuMtLl41/6fRIXd7Dn/2KBvaUteNkdHapk/pIR7XgzaKiiVNHP7fr
   x1r3aWvcYfBe14hsOQNm2TNkZ1gw7hhTEPZdTDaYo4YIqfOkTBa10IQcs
   nRG7UT2NV/cr97k8ukJAcQ0lOoayhlVCz13PhkdLNJe895CXmGFn03D3X
   /5I6rhOokzXpu5dK8tOxUrVH+hQ0/Kvb3ZQa0DyN5nSMXu77x5bYVanDU
   N0CR4LNH10yoMka6U08Txly4dCXxp9h4jBVvjhsitxS5XZ0ERRcNq0Y1y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="332899460"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="332899460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="779141898"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="779141898"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2023 16:23:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSS3K-0009tZ-0n;
        Thu, 16 Feb 2023 00:23:10 +0000
Date:   Thu, 16 Feb 2023 08:22:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 16/26] firmware: qcom_scm: Register Gunyah platform
 ops
Message-ID: <202302160838.BTq7ertw-lkp@intel.com>
References: <20230214212457.3319814-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212457.3319814-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
base:   3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
patch link:    https://lore.kernel.org/r/20230214212457.3319814-1-quic_eberman%40quicinc.com
patch subject: [PATCH v10 16/26] firmware: qcom_scm: Register Gunyah platform ops
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230216/202302160838.BTq7ertw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/33f0c4b130c7b249a1524da8076dd12333aa7cde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
        git checkout 33f0c4b130c7b249a1524da8076dd12333aa7cde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302160838.BTq7ertw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/qcom_scm.c: In function 'qcom_scm_gh_rm_pre_mem_share':
>> drivers/firmware/qcom_scm.c:1335:49: error: passing argument 3 of 'qcom_scm_assign_mem' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1335 |                                                 &src_cpy, new_perms, mem_parcel->n_acl_entries);
         |                                                 ^~~~~~~~
         |                                                 |
         |                                                 u64 * {aka long long unsigned int *}
   drivers/firmware/qcom_scm.c:912:39: note: expected 'unsigned int *' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
     912 |                         unsigned int *srcvm,
         |                         ~~~~~~~~~~~~~~^~~~~
   In file included from include/asm-generic/bug.h:7,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/firmware/qcom_scm.c:5:
   drivers/firmware/qcom_scm.c:1353:49: error: passing argument 3 of 'qcom_scm_assign_mem' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1353 |                                                 &src_cpy, new_perms, 1));
         |                                                 ^~~~~~~~
         |                                                 |
         |                                                 u64 * {aka long long unsigned int *}
   include/linux/once_lite.h:28:41: note: in definition of macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   drivers/firmware/qcom_scm.c:1350:33: note: in expansion of macro 'WARN_ON_ONCE'
    1350 |                                 WARN_ON_ONCE(qcom_scm_assign_mem(
         |                                 ^~~~~~~~~~~~
   drivers/firmware/qcom_scm.c:912:39: note: expected 'unsigned int *' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
     912 |                         unsigned int *srcvm,
         |                         ~~~~~~~~~~~~~~^~~~~
   drivers/firmware/qcom_scm.c: In function 'qcom_scm_gh_rm_post_mem_reclaim':
   drivers/firmware/qcom_scm.c:1385:49: error: passing argument 3 of 'qcom_scm_assign_mem' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1385 |                                                 &src_cpy, &new_perms, 1);
         |                                                 ^~~~~~~~
         |                                                 |
         |                                                 u64 * {aka long long unsigned int *}
   drivers/firmware/qcom_scm.c:912:39: note: expected 'unsigned int *' but argument is of type 'u64 *' {aka 'long long unsigned int *'}
     912 |                         unsigned int *srcvm,
         |                         ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/qcom_scm_assign_mem +1335 drivers/firmware/qcom_scm.c

  1303	
  1304	static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
  1305	{
  1306		struct qcom_scm_vmperm *new_perms;
  1307		u64 src, src_cpy;
  1308		int ret = 0, i, n;
  1309		u16 vmid;
  1310	
  1311		new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
  1312		if (!new_perms)
  1313			return -ENOMEM;
  1314	
  1315		for (n = 0; n < mem_parcel->n_acl_entries; n++) {
  1316			vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
  1317			if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
  1318				new_perms[n].vmid = vmid;
  1319			else
  1320				new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
  1321			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
  1322				new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
  1323			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
  1324				new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
  1325			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
  1326				new_perms[n].perm |= QCOM_SCM_PERM_READ;
  1327		}
  1328	
  1329		src = (1ull << QCOM_SCM_VMID_HLOS);
  1330	
  1331		for (i = 0; i < mem_parcel->n_mem_entries; i++) {
  1332			src_cpy = src;
  1333			ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
  1334							le64_to_cpu(mem_parcel->mem_entries[i].size),
> 1335							&src_cpy, new_perms, mem_parcel->n_acl_entries);
  1336			if (ret) {
  1337				src = 0;
  1338				for (n = 0; n < mem_parcel->n_acl_entries; n++) {
  1339					vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
  1340					if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
  1341						src |= (1ull << vmid);
  1342					else
  1343						src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
  1344				}
  1345	
  1346				new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
  1347	
  1348				for (i--; i >= 0; i--) {
  1349					src_cpy = src;
  1350					WARN_ON_ONCE(qcom_scm_assign_mem(
  1351							le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
  1352							le64_to_cpu(mem_parcel->mem_entries[i].size),
  1353							&src_cpy, new_perms, 1));
  1354				}
  1355				break;
  1356			}
  1357		}
  1358	
  1359		kfree(new_perms);
  1360		return ret;
  1361	}
  1362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
