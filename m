Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB10A6CA98F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjC0PuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC0PuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:50:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFC198A;
        Mon, 27 Mar 2023 08:50:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Plcg30hrgz6J7m2;
        Mon, 27 Mar 2023 23:48:47 +0800 (CST)
Received: from localhost (10.48.153.9) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 16:50:18 +0100
Date:   Mon, 27 Mar 2023 16:50:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <20230327165017.000010dd@Huawei.com>
In-Reply-To: <202303250419.FANh4fIC-lkp@intel.com>
References: <20230324171313.18448-4-Jonathan.Cameron@huawei.com>
        <202303250419.FANh4fIC-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.9]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023 05:01:09 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jonathan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on acme/perf/core]
> [also build test ERROR on tip/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> patch link:    https://lore.kernel.org/r/20230324171313.18448-4-Jonathan.Cameron%40huawei.com
> patch subject: [PATCH v2 3/5] cxl/pci: Find and register CXL PMU devices
> config: arm-randconfig-r023-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250419.FANh4fIC-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/ab99ab31e5c4aa9f68425f3505f22a790d64bfe9
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
>         git checkout ab99ab31e5c4aa9f68425f3505f22a790d64bfe9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/cxl/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303250419.FANh4fIC-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/cxl/core/port.c:60:20: error: use of undeclared identifier 'cxl_cpmu_type'; did you mean 'cxl_bus_type'?  
>            if (dev->type == &cxl_cpmu_type)
>                              ^~~~~~~~~~~~~
Definition is under the CXL_REGION ifdef and it shouldn't be.
Moved it up to alongside the nvdimm ones.

>                              cxl_bus_type
>    drivers/cxl/cxl.h:732:24: note: 'cxl_bus_type' declared here
>    extern struct bus_type cxl_bus_type;
>                           ^
>    1 error generated.
> 
> 
> vim +60 drivers/cxl/core/port.c
> 
>     40	
>     41	static int cxl_device_id(const struct device *dev)
>     42	{
>     43		if (dev->type == &cxl_nvdimm_bridge_type)
>     44			return CXL_DEVICE_NVDIMM_BRIDGE;
>     45		if (dev->type == &cxl_nvdimm_type)
>     46			return CXL_DEVICE_NVDIMM;
>     47		if (dev->type == CXL_PMEM_REGION_TYPE())
>     48			return CXL_DEVICE_PMEM_REGION;
>     49		if (dev->type == CXL_DAX_REGION_TYPE())
>     50			return CXL_DEVICE_DAX_REGION;
>     51		if (is_cxl_port(dev)) {
>     52			if (is_cxl_root(to_cxl_port(dev)))
>     53				return CXL_DEVICE_ROOT;
>     54			return CXL_DEVICE_PORT;
>     55		}
>     56		if (is_cxl_memdev(dev))
>     57			return CXL_DEVICE_MEMORY_EXPANDER;
>     58		if (dev->type == CXL_REGION_TYPE())
>     59			return CXL_DEVICE_REGION;
>   > 60		if (dev->type == &cxl_cpmu_type)  
>     61			return CXL_DEVICE_CPMU;
>     62		return 0;
>     63	}
>     64	
> 

