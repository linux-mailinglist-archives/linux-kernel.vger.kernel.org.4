Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AE6CA990
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC0Pur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjC0Puo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:50:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A33198A;
        Mon, 27 Mar 2023 08:50:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PlcgR5PrVz6J7lh;
        Mon, 27 Mar 2023 23:49:07 +0800 (CST)
Received: from localhost (10.48.153.9) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 16:50:39 +0100
Date:   Mon, 27 Mar 2023 16:50:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <oe-kbuild-all@lists.linux.dev>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230327165038.00002037@Huawei.com>
In-Reply-To: <202303250523.JdddC4Ld-lkp@intel.com>
References: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
        <202303250523.JdddC4Ld-lkp@intel.com>
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

On Sat, 25 Mar 2023 05:12:01 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jonathan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on acme/perf/core]
> [also build test ERROR on tip/perf/core cxl/next cxl/pending linus/master v6.3-rc3 next-20230324]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> patch link:    https://lore.kernel.org/r/20230324171313.18448-5-Jonathan.Cameron%40huawei.com
> patch subject: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
> config: parisc-randconfig-r036-20230324 (https://download.01.org/0day-ci/archive/20230325/202303250523.JdddC4Ld-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
>         git checkout a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/cxl/

Wow. This wasn't one of my best :(

Anyhow thanks for the reports + detailed build description.

> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303250523.JdddC4Ld-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cxl/cpmu.c: In function 'cpmu_parse_caps':
>    drivers/cxl/cpmu.c:101:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>      101 |         val = readq(base + CPMU_CAP_REG);

Added include of linux/io-64-non-atomic-lo-hi.h

>          |               ^~~~~
>          |               readl
>    In file included from <command-line>:
>    drivers/cxl/cpmu.c: In function 'cpmu_config_get_mask':
> >> drivers/cxl/cpmu.c:416:51: error: 'struct perf_event' has no member named 'attr'  
>      416 |         return FIELD_GET(GENMASK_ULL(31, 0), event->attr.config);

Added depends on PERF_EVENTS
which I'd missed because it comes for free if a driver is under the drivers/perf/Kconfig menu.

>    drivers/cxl/cpmu.c:578:24: note: in expansion of macro 'GENMASK'
>      578 |                 writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);

GENMASK_ULL() here and a couple of other places where it's not a compile
time constant.


> >> drivers/cxl/cpmu.c:632:9: error: implicit declaration of function 'local64_set'; did you mean 'local_set'? [-Werror=implicit-function-declaration]  
>      632 |         local64_set(&hwc->prev_count, 0);
>          |         ^~~~~~~~~~~
>          |         local_set
...

> >> drivers/cxl/cpmu.c:636:28: error: implicit declaration of function 'local64_read'; did you mean 'local_read'? [-Werror=implicit-function-declaration]  
>      636 |                 prev_cnt = local64_read(&hwc->prev_count);
>          |                            ^~~~~~~~~~~~
>          |                            local_read
>    drivers/cxl/cpmu.c:636:45: error: 'struct hw_perf_event' has no member named 'prev_count'
>      636 |                 prev_cnt = local64_read(&hwc->prev_count);
>          |                                             ^~
>    drivers/cxl/cpmu.c:637:61: error: 'struct hw_perf_event' has no member named 'idx'
>      637 |                 writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
>          |                                                             ^~
>    drivers/cxl/cpmu.h:46:63: note: in definition of macro 'CPMU_COUNTER_REG'
>       46 | #define CPMU_COUNTER_REG(n)                     (0xc00 + 8 * (n))
>          |                                                               ^
