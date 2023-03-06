Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019C6ABDE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCFLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCFLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:13:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812AD27D7D;
        Mon,  6 Mar 2023 03:12:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PVbSq5cFkz6J9kD;
        Mon,  6 Mar 2023 19:09:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 6 Mar
 2023 11:12:23 +0000
Date:   Mon, 6 Mar 2023 11:12:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <20230306111223.00005f9b@Huawei.com>
In-Reply-To: <202303041001.G9OUGQ6l-lkp@intel.com>
References: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
        <202303041001.G9OUGQ6l-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2023 10:46:28 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jonathan,
> 
> I love your patch! Yet something to improve:
> 

Last minute rebase mess up.  Will fix for v2.

One day I'll remember to run a sanity check build on a clean tree.

Jonathan

> [auto build test ERROR on cxl/next]
> [also build test ERROR on cxl/pending linus/master next-20230303]
> [cannot apply to v6.2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230304-015342
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
> patch link:    https://lore.kernel.org/r/20230303175022.10806-3-Jonathan.Cameron%40huawei.com
> patch subject: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
> config: alpha-randconfig-r003-20230302 (https://download.01.org/0day-ci/archive/20230304/202303041001.G9OUGQ6l-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/0790ed82bb7adf04c834e8c03008b92c1b23945e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230304-015342
>         git checkout 0790ed82bb7adf04c834e8c03008b92c1b23945e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/cxl/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303041001.G9OUGQ6l-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/cxl/core/regs.c:9:10: fatal error: cpmu.h: No such file or directory  
>        9 | #include <cpmu.h>
>          |          ^~~~~~~~
>    compilation terminated.
> --
> >> drivers/cxl/core/cpmu.c:8:10: fatal error: cpmu.h: No such file or directory  
>        8 | #include <cpmu.h>
>          |          ^~~~~~~~
>    compilation terminated.
> 
> 
> vim +9 drivers/cxl/core/regs.c
> 
>    > 9	#include <cpmu.h>  
>     10	
> 

