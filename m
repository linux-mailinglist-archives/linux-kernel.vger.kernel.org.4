Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A996C0906
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCTCy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCTCy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:54:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D002A5F0;
        Sun, 19 Mar 2023 19:54:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21FCFEC;
        Sun, 19 Mar 2023 19:55:07 -0700 (PDT)
Received: from [10.162.41.7] (a077893.blr.arm.com [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41163F67D;
        Sun, 19 Mar 2023 19:54:17 -0700 (PDT)
Message-ID: <f4f20cb2-de05-fbde-172e-03fa3ed7b390@arm.com>
Date:   Mon, 20 Mar 2023 08:24:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/7] coresight: etm4x: Drop pid argument from etm4_probe()
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230317030501.1811905-4-anshuman.khandual@arm.com>
 <202303181632.wBUDE5wa-lkp@intel.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202303181632.wBUDE5wa-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/23 13:51, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on soc/for-next rafael-pm/linux-next linus/master v6.3-rc2 next-20230317]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20230317030501.1811905-4-anshuman.khandual%40arm.com
> patch subject: [PATCH 3/7] coresight: etm4x: Drop pid argument from etm4_probe()
> config: arm64-randconfig-r021-20230312 (https://download.01.org/0day-ci/archive/20230318/202303181632.wBUDE5wa-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/39e224e4248f0f7b2c59b97c12a12f8343ab900e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
>         git checkout 39e224e4248f0f7b2c59b97c12a12f8343ab900e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303181632.wBUDE5wa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/hwtracing/coresight/coresight-etm4x-core.c: In function 'etm4_init_arch_data':
>>> drivers/hwtracing/coresight/coresight-etm4x-core.c:1169:43: warning: passing argument 2 of 'etm4_check_arch_features' makes integer from pointer without a cast [-Wint-conversion]
>     1169 |         etm4_check_arch_features(drvdata, csa);
>          |                                           ^~~
>          |                                           |
>          |                                           struct csdev_access *
>    drivers/hwtracing/coresight/coresight-etm4x-core.c:389:51: note: expected 'unsigned int' but argument is of type 'struct csdev_access *'
>      389 |                                      unsigned int id)
>          |                                      ~~~~~~~~~~~~~^~

Fallback stub's signature also needs an update. I will fold this change in next series.

--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -388,7 +388,7 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
 }
 
 static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
-                                    unsigned int id)
+                                    struct csdev_access *csa)
 {
 }
 #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
