Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2D6FB84C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjEHU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjEHU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:28:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A655AD;
        Mon,  8 May 2023 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683577730; x=1715113730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kGJO5bW7l9MO0KOgZZZ6RDiyfHYcSzVdXZEnB631cPo=;
  b=OV6tan0kKL6DAWs3P0epKyz1ci0yUrhCg0E4CDN2K51uS3hv5E15qMGm
   OPqKP4xfixAqa7eQAblxOPEMbKA4Rj1YsIFpN5tj65Uejqh4VZnJQC1Pz
   Z/i2dPykpyaSqoWgjsI2aXq5TJKncySk1ewHeNCLubon1tM0uqXWQHJS/
   NkS/NtAcR9++Cwjr0+ZQe2SFUguavDHA0CtFDLF/gyx4Os13laQ016Q8k
   LfzbGPEFNTKLgL/+BCIwcBgzvyaenVm0HdNLFnZ7mvMxFCgX44KhW9b42
   K+OVGqRRhM5wdSYXeVSV28dHUGrBVsFo+NUCpwrbw9RpAWzK0wIiahqaH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349782838"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349782838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="729212406"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="729212406"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2023 13:28:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw7TL-0001Ob-2V;
        Mon, 08 May 2023 20:28:39 +0000
Date:   Tue, 9 May 2023 04:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, xueshuai@linux.alibaba.com,
        jaylu102@amd.com, benjamin.cheatham@amd.com, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, lenb@kernel.org,
        rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jannadurai@marvell.com,
        cchavva@marvell.com, Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: EINJV2 support added
Message-ID: <202305090445.WSd683gm-lkp@intel.com>
References: <20230503143759.10485-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503143759.10485-1-pmalgujar@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piyush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Piyush-Malgujar/ACPI-APEI-EINJ-EINJV2-support-added/20230503-223915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230503143759.10485-1-pmalgujar%40marvell.com
patch subject: [PATCH] ACPI: APEI: EINJ: EINJV2 support added
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230509/202305090445.WSd683gm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ca5bbbdcc074577ee88ccaa2d078a37eb5eec36f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Piyush-Malgujar/ACPI-APEI-EINJ-EINJV2-support-added/20230503-223915
        git checkout ca5bbbdcc074577ee88ccaa2d078a37eb5eec36f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/apei/ drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090445.WSd683gm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/apei/einj.c:247:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vendor_error_type_extension *v @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:247:11: sparse:     expected struct vendor_error_type_extension *v
   drivers/acpi/apei/einj.c:247:11: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:255:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct vendor_error_type_extension *v @@
   drivers/acpi/apei/einj.c:255:29: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj.c:255:29: sparse:     got struct vendor_error_type_extension *v
>> drivers/acpi/apei/einj.c:286:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct einjv2_set_error_type *v65param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:286:26: sparse:     expected struct einjv2_set_error_type *v65param
   drivers/acpi/apei/einj.c:286:26: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:295:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct set_error_type_with_address *v5param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:295:25: sparse:     expected struct set_error_type_with_address *v5param
   drivers/acpi/apei/einj.c:295:25: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:305:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct einj_parameter *v4param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:305:25: sparse:     expected struct einj_parameter *v4param
   drivers/acpi/apei/einj.c:305:25: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:309:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct einj_parameter *v4param @@
   drivers/acpi/apei/einj.c:309:45: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj.c:309:45: sparse:     got struct einj_parameter *v4param
   drivers/acpi/apei/einj.c:376:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:376:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj.c:376:21: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:402:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj.c:402:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj.c:402:17: sparse:     got struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj.c:403:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj.c:403:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj.c:403:21: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj.c:468:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj.c:468:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj.c:468:25: sparse:     got struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj.c:930:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void *static [assigned] [toplevel] einj_param @@
   drivers/acpi/apei/einj.c:930:37: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj.c:930:37: sparse:     got void *static [assigned] [toplevel] einj_param

vim +286 drivers/acpi/apei/einj.c

   237	
   238	static void check_vendor_extension(u64 paddr,
   239					   struct set_error_type_with_address *v5param)
   240	{
   241		int	offset = v5param->vendor_extension;
   242		struct	vendor_error_type_extension *v;
   243		u32	sbdf;
   244	
   245		if (!offset)
   246			return;
 > 247		v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
   248		if (!v)
   249			return;
   250		sbdf = v->pcie_sbdf;
   251		sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
   252			sbdf >> 24, (sbdf >> 16) & 0xff,
   253			(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
   254			 v->vendor_id, v->device_id, v->rev_id);
   255		acpi_os_unmap_iomem(v, sizeof(*v));
   256	}
   257	
   258	static void *einj_get_parameter_address(void)
   259	{
   260		int i;
   261		u64 pa_v4 = 0, pa_v5 = 0, pa_v65 = 0;
   262		struct acpi_whea_header *entry;
   263	
   264		entry = EINJ_TAB_ENTRY(einj_tab);
   265		for (i = 0; i < einj_tab->entries; i++) {
   266			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE &&
   267			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   268			    entry->register_region.space_id ==
   269			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   270				pa_v4 = get_unaligned(&entry->register_region.address);
   271			if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
   272			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   273			    entry->register_region.space_id ==
   274			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   275				pa_v5 = get_unaligned(&entry->register_region.address);
   276			if (entry->action == ACPI_EINJV2_SET_ERROR_TYPE &&
   277			    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
   278			    entry->register_region.space_id ==
   279			    ACPI_ADR_SPACE_SYSTEM_MEMORY)
   280				pa_v65 = get_unaligned(&entry->register_region.address);
   281			entry++;
   282		}
   283		if (pa_v65) {
   284			struct einjv2_set_error_type *v65param;
   285	
 > 286			v65param = acpi_os_map_iomem(pa_v65, sizeof(*v65param));
   287			if (v65param) {
   288				einjv2_supp = 1;
   289				return v65param;
   290			}
   291		}
   292		if (pa_v5) {
   293			struct set_error_type_with_address *v5param;
   294	
   295			v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
   296			if (v5param) {
   297				acpi5 = 1;
   298				check_vendor_extension(pa_v5, v5param);
   299				return v5param;
   300			}
   301		}
   302		if (param_extension && pa_v4) {
   303			struct einj_parameter *v4param;
   304	
   305			v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
   306			if (!v4param)
   307				return NULL;
   308			if (v4param->reserved1 || v4param->reserved2) {
   309				acpi_os_unmap_iomem(v4param, sizeof(*v4param));
   310				return NULL;
   311			}
   312			return v4param;
   313		}
   314	
   315		return NULL;
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
