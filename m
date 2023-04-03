Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8A6D4690
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDCOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjDCOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07142CAFD;
        Mon,  3 Apr 2023 07:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2578361C32;
        Mon,  3 Apr 2023 14:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F27BC433D2;
        Mon,  3 Apr 2023 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680530998;
        bh=0Ex0ZsFbQxobZtRcZENMiUIZrpBKKkQ4bRLze0E3zKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ac0N1oPKEcRP4bUmR+JaEcexhluCIbYbM1fxeOQ+PYxh67XAvY5sQbqhJWwdj4eOG
         UuDOCGl6UfBsQ9VI5fny862JxQAqUsa8Pv+rEjDBPoUUZ/p19uNKRxbKx9MCjtWL6N
         58pkHaKZzL8CImeqPy7haoszOw/ETZRj8cNI9VlxEgJfBsc/yzaDv224Yu6+oArJSs
         7/5F9qPDPgL4sFLLubh76P4WHYIC4dKO8SwNYSdIjF+HiD09ENzcU2hVn3H3Y4zHny
         Nl2biIcntx3STnRQ1qmByMsPwnljBgI5K5HMw5IEgu9WhdakkIgB0PauUkkInK3UGL
         ciIodwZYyr5CA==
Date:   Mon, 3 Apr 2023 15:09:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230403140950.GF548901@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023, Sahin, Okan wrote:

> >On Tue, 28 Mar 2023, Sahin, Okan wrote:
> >
> >> >On Wed, 15 Mar 2023, Lee Jones wrote:
> >> >
> >> >> On Tue, 07 Mar 2023, Okan Sahin wrote:
> >> >>
> >> >> > MFD driver for MAX77541/MAX77540 to enable its sub devices.
> >> >> >
> >> >> > The MAX77541 is a multi-function devices. It includes buck
> >> >> > converter and ADC.
> >> >> >
> >> >> > The MAX77540 is a high-efficiency buck converter with two 3A
> >> >> > switching phases.
> >> >> >
> >> >> > They have same regmap except for ADC part of MAX77541.
> >> >> >
> >> >> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> >> >> > ---
> >> >> >  drivers/mfd/Kconfig          |  13 ++
> >> >> >  drivers/mfd/Makefile         |   1 +
> >> >> >  drivers/mfd/max77541.c       | 224
> >> >+++++++++++++++++++++++++++++++++++
> >> >> >  include/linux/mfd/max77541.h |  97 +++++++++++++++
> >> >> >  4 files changed, 335 insertions(+)  create mode 100644
> >> >> > drivers/mfd/max77541.c  create mode 100644
> >> >> > include/linux/mfd/max77541.h
> >> >>
> >> >> FYI: I'm not re-reviewing this since you've chosen to ignore some
> >> >> of my previous review comments.  Issues highlighted by review
> >> >> comments don't just go away on resubmission.
> >> >
> >> >... and the subject is malformed.
> >> >
> >> >--
> >> >Lee Jones [李琼斯]
> >>
> >> Hi Lee,
> >>
> >> I am sorry if I missed your review comments, this was not my intention. I want
> >to thank you for your contribution. Your feedbacks are very valuable, and I am
> >trying to understand and fix each one before sending the patch. Indeed, I sorted
> >your feedback on previous patches. As far as I know, I have fixed all of them, is
> >there a problem with any of them that I fixed, or is there any missing review?
> >From you, there were some comments like "why did you use this?", I suppose I
> >need to respond them before sending following patches. I thought I should not
> >bother the maintainers unnecessarily. I am sorry for them.
> >
> >Please ask your email client to line-wrap.
> >
> >Here is the part of the review you ignored:
> >
> >[...]
> >
> >> +static const struct chip_info chip[] = {
> >
> >Why do you need this require sub-structure?
> >
> >> +	[MAX77540] = {
> >> +		.id = MAX77540,
> >> +		.n_devs = ARRAY_SIZE(max77540_devs),
> >> +		.devs = max77540_devs,
> >> +	},
> >> +	[MAX77541] = {
> >> +		.id = MAX77541,
> >> +		.n_devs = ARRAY_SIZE(max77541_devs),
> >> +		.devs = max77541_devs,
> >> +	},
> >> +};
> >
> >[...]
> >
> >> +static const struct of_device_id max77541_of_id[] = {
> >> +	{
> >> +		.compatible = "adi,max77540",
> >> +		.data = &chip[MAX77540],
> >> +	},
> >> +	{
> >> +		.compatible = "adi,max77541",
> >> +		.data = &chip[MAX77541],
> >> +	},
> >> +	{ /* sentinel */  }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, max77541_of_id);
> >> +
> >> +static const struct i2c_device_id max77541_i2c_id[] = {
> >> +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
> >> +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
> >
> >Just 'MAX77540' is fine.
> >
> >> +	{ /* sentinel */ }
> >
> >Remove the comment, we know how terminators work.
> >
> >Same comments for max77541_of_id.

Your mailer is still broken.  Please line wrap.

> In fact, one of the maintainers suggested assigning chip_info to data instead of enumeration. Then I added chip_info and put devices into sub-structure above. I will replace chip_info with id structure in max77541 device structure, right? I will use enumeration for data as I will assign it to id, and distinguish different devices.

Yes, that's correct.  Please remove chip_info altogether.

--
Lee Jones [李琼斯]
