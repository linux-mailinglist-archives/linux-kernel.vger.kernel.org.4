Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BE6DF14B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDLJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDLJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376EC30CB;
        Wed, 12 Apr 2023 02:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E3662D5C;
        Wed, 12 Apr 2023 09:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA01C433EF;
        Wed, 12 Apr 2023 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293564;
        bh=/W6rfVmAoHdfAMN8rHOiddmSq8fFQpiYDiyXyTyXY4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z60c+znf1e1oR2lhp7EgZE9McFZ6FvpBnQh3Z3STDZRc4tUuPJ9Pc6vJWDeU4uoPB
         paNllylXyfhtWzj6V3XaAXuyzY+bkpritlqDiamD/QnWUN6Fks9UH0KGnoVwMj9ZgN
         CQjmpFpigQHYb7KCxaa6LbETv7pGE/e4amFM5cZK++raW9cLWHc4EMhuf1zT00l/9g
         iE1B0Eq1AscAq6yQKESyMuREANzI68UClfk5BvjsOR2TFzMJrapEERN6gWhySaaxiZ
         d8IXtMweMMEsuAtJZnsOASD82Q62P9+FR99ZWVuVvb15XVQiSfyBFcdnvj0uuMFvNB
         zNrw3W/V0RDoA==
Date:   Wed, 12 Apr 2023 10:59:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230412095918.GZ8371@google.com>
References: <a642e653-e3e2-c3d2-68cb-1efc92be05bb@linaro.org>
 <20230331165904.4e7f46a1@bootlin.com>
 <20230403142822.GA8371@google.com>
 <20230404092036.2d1cd5d9@bootlin.com>
 <f7ab2fcc-93fc-ce87-8767-579d33907225@linaro.org>
 <20230404100759.5bc9cd20@bootlin.com>
 <143754c2-9e37-4386-af92-174c0df2eb0a@linaro.org>
 <20230405135450.GF8371@google.com>
 <20230405180023.4aebaa08@bootlin.com>
 <20230411181640.50c19d4e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411181640.50c19d4e@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023, Herve Codina wrote:

> Hi Lee,
>
> On Wed, 5 Apr 2023 18:00:23 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
>
> > Hi Lee,
> > On Wed, 5 Apr 2023 14:54:50 +0100
> > Lee Jones <lee@kernel.org> wrote:
> >
> > > On Tue, 04 Apr 2023, Krzysztof Kozlowski wrote:
> > >
> > > > On 04/04/2023 10:07, Herve Codina wrote:
> > > >
> > > > >>> So, the structure I have in mind:
> > > > >>> - pef2256.c (MFD)
> > > > >>>   implement and do the setup at probe()
> > > > >>>   Add the children at probe():
> > > > >>>     - pef2256-pinctrl (pinctrl) added using mfd_add_devices()
> > > > >>>     - pef2256-codec (ASoC codec) added using devm_of_platform_populate()
> > > > >>>
> > > > >>> Lee, with this in mind, can the core pef2256.c be a MFD driver ?
> > > > >>
> > > > >> You do not use MFD here, so why do you want to keep it in MFD? If you
> > > > >> disagree, please tell me where is the MFD code in your patch?
> > > > >
> > > > > I don't want to absolutely use MFD.
> > > > > I just want to put my driver somewhere and I don't know the right location
> > > > > between MFD and Misc.
> > > > >
> > > > > Basically, the driver needs to do (little simplified and error path removed):
> > > > >
> > > > >   static const struct mfd_cell pef2256_devs[] = {
> > > > >   	{ .name = "lantiq-pef2256-pinctrl", },
> > > > >   };
> > > > >
> > > > >   static int pef2256_probe(struct platform_device *pdev)
> > > > >   {
> > > > > 	struct pef2256 *pef2256;
> > > > > 	void __iomem *iomem;
> > > > > 	int ret;
> > > > > 	int irq;
> > > > >
> > > > > 	pef2256 = devm_kzalloc(&pdev->dev, sizeof(*pef2256), GFP_KERNEL);
> > > > > 	if (!pef2256)
> > > > > 		return -ENOMEM;
> > > > >
> > > > > 	pef2256->dev = &pdev->dev;
> > > > >
> > > > > 	iomem = devm_platform_ioremap_resource(pdev, 0);
> > > > >
> > > > > 	pef2256->regmap = devm_regmap_init_mmio(&pdev->dev, iomem,
> > > > > 						&pef2256_regmap_config);
> > > > >
> > > > > 	pef2256->mclk = devm_clk_get_enabled(&pdev->dev, "mclk");
> > > > > 	pef2256->sclkr = devm_clk_get_enabled(&pdev->dev, "sclkr");
> > > > > 	pef2256->sclkx = devm_clk_get_enabled(&pdev->dev, "sclkx");
> > > > >
> > > > > 	pef2256->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
> > > > > 	if (pef2256->reset_gpio) {
> > > > > 		gpiod_set_value_cansleep(pef2256->reset_gpio, 1);
> > > > > 		udelay(10);
> > > > > 		gpiod_set_value_cansleep(pef2256->reset_gpio, 0);
> > > > > 		udelay(10);
> > > > > 	}
> > > > >
> > > > > 	pef2556_of_parse(pef2256, np);
> > > > >
> > > > > 	irq = platform_get_irq(pdev, 0);
> > > > > 	ret = devm_request_irq(pef2256->dev, irq, pef2256_irq_handler, 0, "pef2256", pef2256);
> > > > >
> > > > > 	platform_set_drvdata(pdev, pef2256);
> > > > >
> > > > > 	mfd_add_devices(pef2256->dev, PLATFORM_DEVID_NONE, pef2256_devs,
> > > > > 	      		ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
> > > >
> > > > Wait, now you use MFD framework, so the driver is suitable for MFD.
> > > > Before there was nothing like that in your code.
> > >
> > > Agree, the above is suitable for MFD, since it does all the things I
> > > said your last one did not.  You *can* also use of_platform_populate()
> > > here, since you are *also* requesting and initialising shared resources.
> > > You cannot do *both* however.
> > >
> >
> > Thanks for having confirmed that this driver can be a MFD driver.
> >
> > Related to of_platform_populate() / mfd_add_devices(), I wanted to use both
> > because:
> > - the pinctrl part does not have (and does not need to have) a specific node
> >   with a specific compatible property. In order to instantiate the related
> >   driver mfd_add_devices() is the only way I know.
> > - the audio component nodes have a compatible string and several components
> >   (ie several nodes) can be present. of_platform_populate() call seems the
> >   simple way to instantiate them.
> >
> > Is there a way to use mfd_add_devices() in this case without the need to
> > count the audio component nodes in order to allocate as much mfd_cell as
> > nodes having a matching compatible property ? Is there an other API to do
> > it ?
> >
>
> I looked deeper for using mfd_add_devices() only and found an issue (related
> to my use-case).
>
> mfd_add_devices() calls mfd_add_device() and in this function we have:
> ---- 8< ----
> 	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> 		for_each_child_of_node(parent->of_node, np) {
> 			if (of_device_is_compatible(np, cell->of_compatible)) {
> 				/* Ignore 'disabled' devices error free */
> 				if (!of_device_is_available(np)) {
> 					of_node_put(np);
> 					ret = 0;
> 					goto fail_alias;
> 				}
>
> 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> 				if (ret == -EAGAIN)
> 					continue;
> 				of_node_put(np);
> 				if (ret)
> 					goto fail_alias;
>
> 				break;
> 			}
> 		}
>
> 		if (!pdev->dev.of_node)
> 			pr_warn("%s: Failed to locate of_node [id: %d]\n",
> 				cell->name, platform_id);
> 	}
> ---- 8< ----
>
> My issue is related to the loop.
> The loop is aborted if the device is not available (typically 'Disabled' in the
> DT node).
>
> My full pef2256 node can have several pef2256 audio subnodes with compatible
> set to "lantiq,pef2256-codec" and some of them can have 'status = "Disabled";'
> As soon as one device (with my expected compatible) is found 'Disabled', there
> is no way to look at other children.
>
> Having 'continue' in case of device not available in the loop to look at the
> next child will change the behavior of mfd_add_device().
> Do you think that looking at next child if we find a 'not available' child
> can be correct for mfd_add_device() ?
> This probably will have impacts on other MFD drivers.

Looks like a bug.  Encountering one disabled cell should not prevent the
others from registering IMHO.

--
Lee Jones [李琼斯]
