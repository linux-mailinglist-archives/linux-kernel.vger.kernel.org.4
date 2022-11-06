Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10761E2F7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKFPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiKFPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8D2DCC;
        Sun,  6 Nov 2022 07:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB0160C88;
        Sun,  6 Nov 2022 15:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AF1C433D6;
        Sun,  6 Nov 2022 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667748313;
        bh=lZ9gOuIK/p/+AxLeA6qMbQ9qzDHEck1QexyR55L+9Dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c2y2LmsiNGpYap3pOrD5SdXfqIiha/uI8LpSIwt1cVR3iAeWm5IzMw4DEag7FexRL
         3psNGNKKApsOtEiNsGcFeMu0R2mf2KZSwsitsraVEfq0o4d79YzVhLtBkU03JbTfcb
         tko2Vmg+0BFDkqO8h48ldic8vzZoQX6nS+ygnGRGB5ALgOc8wmtP6+RhbbmaNPCzcA
         HDAdsOZC/0GownoZBG5hrHFU3fOZmuOcJrfvG2/i+jYXWtPZacVeYGScnDfan+Ghut
         kllEULi5d/JA5tUXwDLZQqptHULr1suHpqQEVo/LIMSdebhcQyfg2+QOl5zQHgJWMO
         l5Y2sUzyxDiAQ==
Date:   Sun, 6 Nov 2022 15:25:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        lars@metafoo.de, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v7] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221106152503.2f7e9f7f@jic23-huawei>
In-Reply-To: <202211041434.J9y1aows-lkp@intel.com>
References: <20221101174409.316447-1-rajat.khandelwal@linux.intel.com>
        <202211041434.J9y1aows-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 14:50:33 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Rajat,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.1-rc3 next-20221104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Rajat-Khandelwal/iio-temperature-Add-driver-support-for-Maxim-MAX30208/20221101-102308
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20221101174409.316447-1-rajat.khandelwal%40linux.intel.com
> patch subject: [PATCH v7] iio: temperature: Add driver support for Maxim MAX30208
> config: riscv-randconfig-c006-20221103
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/2375dabd39957ad8e80878c5604eda8a9f73932d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Rajat-Khandelwal/iio-temperature-Add-driver-support-for-Maxim-MAX30208/20221101-102308
>         git checkout 2375dabd39957ad8e80878c5604eda8a9f73932d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/block/ drivers/iio/temperature/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/temperature/max30208.c:195:36: warning: unused variable 'max30208_acpi_match' [-Wunused-const-variable]  
>    static const struct acpi_device_id max30208_acpi_match[] = {
>                                       ^
>    1 warning generated.
> 
See review comments on v6 that said to drop the use of ACPI_PTR(). It's not worth
the fiddly handling to save a trivial amount of data.

Jonathan

> 
> vim +/max30208_acpi_match +195 drivers/iio/temperature/max30208.c
> 
>    194	
>  > 195	static const struct acpi_device_id max30208_acpi_match[] = {  
>    196		{ "MAX30208" },
>    197		{ }
>    198	};
>    199	MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
>    200	
> 

