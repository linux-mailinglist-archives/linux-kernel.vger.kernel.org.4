Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2E5B5089
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIKSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIKSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:20:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD61252BE;
        Sun, 11 Sep 2022 11:20:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s6so181389lfo.7;
        Sun, 11 Sep 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Mhy+3CWxTNrO346Kg7VTtnGn/vofZ7u7oyFEO3SVd3g=;
        b=G1SC4zSV3RuG5u0WV4E6Fo8xz4Hhj5vVEP6SuuXC5K7vIiFtUcWl287d3KMBj8NW9R
         Y81zqrzejNcK2F3A+ZDNXfOSK0hkAHnFo8TDHXZY/OwzvRSehuleF/wCLlGSsfkFJnUD
         wWrQHIha6vaGZnSg8tnIDjdowDcg6YNvnGgmg8Wszud4lOd+rPE56LrCe4PMqkGB6MC8
         9AXWv+/NHWaufa/uqdb4JTfWvnU6I84iexXCtgUGOVrCymGPQPbGlkOVRXoprhyVD6s5
         kZ1wyN1beBMeAZgH8BEKqAGQVQ9SCF36XSp4e8eIooqCWNNAooJKXhF514b3m4QS9S1c
         Bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mhy+3CWxTNrO346Kg7VTtnGn/vofZ7u7oyFEO3SVd3g=;
        b=Bxkl3j8KetpYmPsFZCmNle4PsLGxEoZW6xF5SyqH/nOGDwbfPPU0PhgtY+rxYHYpNN
         Vcomu58JMhAOFQ1ssFeGPgraQgVqsvYhQiEwXlftWG+4LgqsndprHNiWHqVm2/o422lb
         QiT4q/u1hEtct6E2JaitEq7uQ1Oi5ylTghfDF8Fgp6WNTwD0VLw64+kepmmzFmZhBlbd
         DR6QndvNuy9zGi/Q+5Cws+UWNV4ywVg8bEKd2GrEcpR/g9AhVXDzUcgFyxK6+/ZKjHqp
         l+idbgXbVD/MIlh8VyB11PLcXbjyROJhbHirIouI2VWZAGklOMKL4dZvMycuhGAucytt
         CJ8g==
X-Gm-Message-State: ACgBeo15ktZxTbCXadB7hU+6n3rf3mjm/UklIm3cp36r1jSsTJcV9mNC
        sKILTOoQn7RnVDRwWRrXe7M=
X-Google-Smtp-Source: AA6agR5LSSiN/cax4urw2HZ7KDpGL+g/xPYKFXKs+PdODqUpgdWPFW990sj9/c+ITlhC2yEsbcqPYQ==
X-Received: by 2002:a05:6512:39d6:b0:498:f615:df07 with SMTP id k22-20020a05651239d600b00498f615df07mr4578653lfu.387.1662920424912;
        Sun, 11 Sep 2022 11:20:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id dt6-20020a0565122a8600b004976809d6a7sm677341lfb.283.2022.09.11.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 11:20:24 -0700 (PDT)
Date:   Sun, 11 Sep 2022 21:20:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Larson, Bradley" <Bradley.Larson@amd.com>
Cc:     Brad Larson <brad@pensando.io>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20220911182021.i5go6lfsedggq6wl@mobilestation>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-13-brad@pensando.io>
 <20220821181848.cxjpv2f4cqvdtnq3@mobilestation>
 <4aab1595-53a6-32af-8cfb-90f5e258d29e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aab1595-53a6-32af-8cfb-90f5e258d29e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 06:04:02PM +0000, Larson, Bradley wrote:
> On 8/21/22 11:18 AM, Serge Semin wrote:
> > On Sat, Aug 20, 2022 at 12:57:45PM -0700, Brad Larson wrote:
> >> From: Brad Larson <blarson@amd.com>
> >>
> >> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> >> with device specific chip-select control.  The Elba SoC
> >> provides four chip-selects where the native DW IP supports
> >> two chip-selects.  The Elba DW_SPI instance has two native
> >> CS signals that are always overridden.
> >>
> >> Signed-off-by: Brad Larson <blarson@amd.com>
> >> ---
> >>   drivers/spi/spi-dw-mmio.c | 77 +++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 77 insertions(+)
> >>
> >> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> >> index 26c40ea6dd12..36b8c5e10bb3 100644
> >> --- a/drivers/spi/spi-dw-mmio.c
> >> +++ b/drivers/spi/spi-dw-mmio.c
> >> @@ -53,6 +53,24 @@ struct dw_spi_mscc {
> >>        void __iomem        *spi_mst; /* Not sparx5 */
> >>   };
> >>
> >> +struct dw_spi_elba {
> >> +     struct regmap *syscon;
> >> +};
> >> +
> >> +/*
> >> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> >> + * gpios for cs 2,3 as defined in the device tree.
> >> + *
> >> + * cs:  |       1               0
> >> + * bit: |---3-------2-------1-------0
> >> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> >> + */
> >> +#define ELBA_SPICS_REG                       0x2468
> >> +#define ELBA_SPICS_SHIFT(cs)         (2 * (cs))
> >> +#define ELBA_SPICS_MASK(cs)          (0x3 << ELBA_SPICS_SHIFT(cs))
> >> +#define ELBA_SPICS_SET(cs, val)      \
> >> +                     ((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
> > Please take the @Andy' notes into account:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2FCAHp75Vex0VkECYd%3DkY0m6%3DjXBYSXg2UFu7vn271%2BQ49WZn22GA%40mail.gmail.com%2F&amp;data=05%7C01%7CBradley.Larson%40amd.com%7C25d0f17dfcbd44f661c808da83a19a98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637967027418603429%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=VFI%2FptM79YYbZm%2FyQmtssLsNIQ75AOU05ronZ1QStlU%3D&amp;reserved=0
> 
> Yes, I had a tested change for this but missed adding to the patch update.
> This is the change and I'll resend just this patch.
> 
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -66,10 +66,6 @@ struct dw_spi_elba {
>    *      |  cs1   cs1_ovr   cs0   cs0_ovr
>    */
>   #define ELBA_SPICS_REG 0x2468

> -#define ELBA_SPICS_SHIFT(cs)           (2 * (cs))
> -#define ELBA_SPICS_MASK(cs)            (0x3 << ELBA_SPICS_SHIFT(cs))
> -#define ELBA_SPICS_SET(cs, val)        \
> -                       ((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))

Why do you remove these macros? Just replace 0x3 with GENMASM(1, 0),
0x1 with BIT(0), (2 * (cs)) statement with ((cs) << 1) as Andy
suggested. Using macros for such complex statement is a good practice.

Also please rename ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET() so to
have a more coherent CSR-related macros naming in the driver.

-Sergey

> 
>   /*
>    * The Designware SPI controller (referred to as master in the 
> documentation)
> @@ -257,8 +253,9 @@ static int dw_spi_canaan_k210_init(struct 
> platform_device *pdev,
> 
>   static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int 
> cs, int enable)
>   {
> - regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
> -                          ELBA_SPICS_SET(cs, enable));
> + regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG,
> +                          (GENMASK(1, 0) << ((cs) << 1)),
> +                          ((enable) << 1 | BIT(0)) << ((cs) << 1));
> 
>   }
> 
> > One more nitpick below.
> >
> > +static int dw_spi_elba_init(struct platform_device *pdev,
> > +                         struct dw_spi_mmio *dwsmmio)
> > +{
> > +     const char *syscon_name = "amd,pensando-elba-syscon";
> > +     struct device_node *np = pdev->dev.of_node;
> >> +     struct device_node *node;
> >> +     struct dw_spi_elba *dwselba;
> > Please, use the reverse xmas tree order of the local variables
> > as the rest of the driver mainly implies.
> Changed to reverse xmas tree ordering.
> 
> Regards,
> Brad
