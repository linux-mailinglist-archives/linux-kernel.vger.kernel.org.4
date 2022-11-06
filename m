Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43961E2CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKFO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:56:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA056614F;
        Sun,  6 Nov 2022 06:56:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7671F60C02;
        Sun,  6 Nov 2022 14:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0EDC433D6;
        Sun,  6 Nov 2022 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667746602;
        bh=pTF6DEG0iD2tUKx6NfIbRgijF+x5iwhtNqdOL8+Fo/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGxt+3pgotEhPFCiPHcYKPlcajj1SWsBPCIho6sIYahdnEA62PuvGcbjbS3HlCcDr
         LCCRtAIQrn3gNaez2l0mMKxhnIDgwr7jfSefYoJRS8hVTI1eoYJjBvLRWJ/Lv9LklH
         etaTt+9lfzrdWwxfpCM4FMZw6B6fGP+r7iNT5YzrlCglOQFqYNuJYh1eLh+/xfJC5Q
         LM6lAqLTtpnZUB2Ehyg4Dv1HP77CZDr4T29QRvq5ilSURYwAoSNf6mfjXutGMMadjn
         5HacU+aGql6sAs630roS2cxm5WOLtERRwR/4608W8X+OEvBNpnbbRkl2SfwvRrVeqQ
         OnozqV6ifc8NA==
Date:   Sun, 6 Nov 2022 14:56:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add ADC driver for the TI LMP92064
 controller
Message-ID: <20221106145635.29716833@jic23-huawei>
In-Reply-To: <202211011818.QyWLsBVu-lkp@intel.com>
References: <20221101064804.720050-2-l.goehrs@pengutronix.de>
        <202211011818.QyWLsBVu-lkp@intel.com>
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

On Tue, 1 Nov 2022 18:36:14 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Leonard,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v6.1-rc3 next-20221101]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leonard-G-hrs/dt-bindings-iio-adc-add-TI-LMP92064-controller/20221101-145036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20221101064804.720050-2-l.goehrs%40pengutronix.de
> patch subject: [PATCH v2 2/2] iio: adc: add ADC driver for the TI LMP92064 controller
> config: x86_64-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/4b264b5bc9425f051a3ce5c5a9a30a66d3a0a477
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Leonard-G-hrs/dt-bindings-iio-adc-add-TI-LMP92064-controller/20221101-145036
>         git checkout 4b264b5bc9425f051a3ce5c5a9a30a66d3a0a477
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/adc/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/ti-lmp92064.c: In function 'lmp92064_adc_probe':
>    drivers/iio/adc/ti-lmp92064.c:267:15: error: implicit declaration of function 'devm_regulator_get_enable'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>      267 |         ret = devm_regulator_get_enable(dev, "vdd");
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |               devm_regulator_get_optional

That's odd. it's definitely in the trees referenced above and there are stubs
for when regulator support isn't built.  No idea... 


>    At top level:
> >> drivers/iio/adc/ti-lmp92064.c:293:35: warning: 'lmp92064_id_table' defined but not used [-Wunused-const-variable=]  
>      293 | static const struct spi_device_id lmp92064_id_table[] = {
>          |                                   ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

This one is obvious though as the relevant entry in the struct spi_driver
is not set.
 
> 
> 
> vim +/lmp92064_id_table +293 drivers/iio/adc/ti-lmp92064.c
> 
>    292	
>  > 293	static const struct spi_device_id lmp92064_id_table[] = {  
>    294		{ "lmp92064", 0 },
>    295		{}
>    296	};
>    297	MODULE_DEVICE_TABLE(spi, lmp92064_id_table);
>    298	
> 

