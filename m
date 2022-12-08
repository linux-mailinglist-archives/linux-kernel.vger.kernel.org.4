Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC4646D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLHKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711858BCF;
        Thu,  8 Dec 2022 02:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44D0DB82378;
        Thu,  8 Dec 2022 10:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E072C433C1;
        Thu,  8 Dec 2022 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670495721;
        bh=25+oqWLVjVrNbO+hRmvsDdetN1PXbmACQaV7gHg5mrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/7DK0Rg5WFAxDIZdcmlM5pPNbiQgfKKYPA92P3viUVs9wQwEsjrn6c0BudU1l3RT
         0pdTEElaOqXYzCWO3xDA+ZvPF3OYsEcCc03qhkmGTiInQHTRQg8CPe+ZiMsJZBEeB4
         21LU22cveZ9zALMGWCyxOgv9aVmDjoRr7obf6ns6jzFvsjXIFOziXW1rgiefE/LGmP
         tQv68MyiPKFWGmwSsp2sfP+223xG2jggznzF6MxaNlIdhEAgSAEmjNih9HD7bvXdhJ
         cVbn4ii27zhIHOkpSmadZWTvrjOLPRnFIc/7yRGxOkGz3+yo6pt3sAmKszazb+0jCR
         3rb1xEWE5hKCg==
Date:   Thu, 8 Dec 2022 10:35:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Larry Lai <larry.lai@yunjingtech.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Noah Hung <noah.hung@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH V3 1/3] mfd: Add
 support for UP board CPLD/FPGA
Message-ID: <Y5G95OknX2dcBhDw@google.com>
References: <20221109090957.13167-1-larry.lai@yunjingtech.com>
 <20221109090957.13167-2-larry.lai@yunjingtech.com>
 <Y3T+B1zq/XYluO5s@google.com>
 <SG2PR06MB37427F013BD702117467B8A7F91A9@SG2PR06MB3742.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB37427F013BD702117467B8A7F91A9@SG2PR06MB3742.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Larry Lai wrote:

> Dear Jones,
> 
>         Thank you for spending time to review this code, please kindly check the following comments with Larry (11/25) beginning .
>         Some of issues we will fix in new RFC_1125, some may need you give us more examples or comments.
> We also explained more detail about the FPGA read and write protocol in RFC_1125.
> 
> Best Regards,
> Larry Lai
> 
> 寄件者: Lee Jones <lee@kernel.org>
> 日期: 星期三, 2022年11月16日 下午11:13
> 收件者: Larry Lai <larry.lai@yunjingtech.com>
> 副本: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org <linus.walleij@linaro.org>, pavel@ucw.cz <pavel@ucw.cz>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org <linux-gpio@vger.kernel.org>, linux-leds@vger.kernel.org <linux-leds@vger.kernel.org>, GaryWang@aaeon.com.tw <GaryWang@aaeon.com.tw>, Musa Lin <musa.lin@yunjingtech.com>, Jack Chang <jack.chang@yunjingtech.com>, Noah Hung <noah.hung@yunjingtech.com>, Javier Arteaga <javier@emutex.com>, Nicola Lunghi <nicola.lunghi@emutex.com>
> 主旨: Re: [PATCH V3 1/3] mfd: Add support for UP board CPLD/FPGA

Please fix your mailer so that these headers do not end up in the
email body.

> On Wed, 09 Nov 2022, chengwei wrote:
> 
> > The UP Squared board <http://www.upboard.com> implements certain
> > features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
> >
> > This mfd driver implements the line protocol to read and write registers
> > from the FPGA through regmap. The register address map is also included.
> >
> > The UP Boards provide a few I/O pin headers (for both GPIO and
> > functions), including a 40-pin Raspberry Pi compatible header.
> >
> > This patch implements support for the FPGA-based pin controller that
> > manages direction and enable state for those header pins.
> >
> > Partial support UP boards:
> > * UP core + CREX
> > * UP core + CRST02
> >
> > PATCH V3:
> > (1) fixed kernel test robot compiler warning
> >
> > PATCH V2:
> > (1) Synchronizing upboard github to rc2
> > (2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
> 
> The change log should be below the '---' below.

Please fix your mailer to quote the message you're replying to.

Then you can omit the "Larry ..." tags.

> Larry (11/25) : We already fixed it on RFC 1125, thx.

You don't have to reply to comments if you agree with them.

> > Signed-off-by: Javier Arteaga <javier@emutex.com>
> > [merge various fixes]
> 
> Drop this line please.
> 
> > Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> > Signed-off-by: chengwei <larry.lai@yunjingtech.com>
> 
> Full name?
> Larry (11/25) : We already fixed it on RFC 1125, thx.
> 
> > ---
> >  drivers/mfd/Kconfig              |  12 +
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/upboard-fpga.c       | 620 +++++++++++++++++++++++++++++++
> >  include/linux/mfd/upboard-fpga.h |  56 +++
> >  4 files changed, 689 insertions(+)
> >  create mode 100644 drivers/mfd/upboard-fpga.c
> >  create mode 100644 include/linux/mfd/upboard-fpga.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index abb58ab1a1a4..c1d72a70e5f2 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig

[...]

> > +#define UPBOARD_DEVID 0
> 
> No, that's not what this means.
> 
> Please use the defines already provided for you.
> Larry (11/25) :  please refer https://www.kernel.org/doc/htmldocs/writing_musb_glue_layer/device-platform-data.html
> The id field could be set to -1 (equivalent to PLATFORM_DEVID_NONE),
> -2 (equivalent to PLATFORM_DEVID_AUTO) or start with 0 for the first
> device of this kind if we want a specific id number.

Just use '0' in-place.

[...]

> > +static struct upboard_led_data upboard_up2_led_data[] = {
> > +     { .bit = 0, .colour = "blue" },
> > +     { .bit = 1, .colour = "yellow" },
> > +     { .bit = 2, .colour = "green" },
> > +     { .bit = 3, .colour = "red" },
> > +};
> > +
> > +static const struct mfd_cell upboard_up2_mfd_cells[] = {
> > +     { .name = "upboard-pinctrl" },
> > +     UPBOARD_LED_CELL(upboard_up2_led_data, 0),
> > +     UPBOARD_LED_CELL(upboard_up2_led_data, 1),
> > +     UPBOARD_LED_CELL(upboard_up2_led_data, 2),
> > +     UPBOARD_LED_CELL(upboard_up2_led_data, 3),
> > +};
> > +
> > +static const struct upboard_fpga_data upboard_up2_fpga_data = {
> > +     .regmapconf = &upboard_up2_regmap_config,
> > +     .cells = upboard_up2_mfd_cells,
> > +     .ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
> > +};
> 
> You'd be better off getting rid of 'struct upboard_fpga_data'
> altogether.
> Larry (11/25) : we cannot understand it clearly. could you kindly give us more examples, thanks.

You shouldn't mix platform initialisation strategies.  Doing so gets
messy real quick.  So no passing MFD data through ACPI or DT
match-data please.  Pass device IDs though, then match on those
instead.

[...]

> > +static void upboard_led_gpio_init(struct upboard_fpga *fpga)
> 
> Should this all live in drivers/led?
> Larry (11/25) :  MFD upboard-fpga is acpi driver and can recognize the AANT ID from different kind of upboards.
> We get the led gpio initialized information from this then add led-upboard driver.

MFD doesn't know (or want to know) about LEDs.

Please place all LED initialisation inside the LED driver.

> > +{
> > +     struct gpio_led blue_led, yellow_led, green_led, red_led;
> > +     struct gpio_desc *desc;
> > +     int blue_gpio = -1, yellow_gpio = -1, green_gpio = -1, red_gpio = -1;
> > +     int leds = 0;
> > +     static struct gpio_led upboard_gpio_leds[8];
> > +     static struct gpio_led_platform_data upboard_gpio_led_platform_data;
> > +     static const struct mfd_cell upboard_gpio_led_cells[] = {
> > +             MFD_CELL_BASIC("leds-gpio", NULL,
> > +                            &upboard_gpio_led_platform_data,
> > +                            sizeof(upboard_gpio_led_platform_data), 0)
> > +     };
> > +
> > +     desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
> > +
> > +     if (!IS_ERR(desc)) {
> > +             blue_gpio = desc_to_gpio(desc);
> > +             leds++;
> > +             devm_gpiod_put(fpga->dev, desc);
> > +     }
> > +     desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
> > +     if (!IS_ERR(desc)) {
> > +             yellow_gpio = desc_to_gpio(desc);
> > +             leds++;
> > +             devm_gpiod_put(fpga->dev, desc);
> > +     }
> > +     desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
> > +     if (!IS_ERR(desc)) {
> > +             green_gpio = desc_to_gpio(desc);
> > +             leds++;
> > +             devm_gpiod_put(fpga->dev, desc);
> > +     }
> > +     desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
> > +     if (!IS_ERR(desc)) {
> > +             red_gpio = desc_to_gpio(desc);
> > +             leds++;
> > +             devm_gpiod_put(fpga->dev, desc);
> > +     }
> > +
> > +     if (leds == 0)  //no leds
> > +             return;
> > +
> > +     leds = 0;
> > +     if (blue_gpio > -1) {
> > +             blue_led.name = "upboard:blue:";
> > +             blue_led.gpio = blue_gpio;
> > +             blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> > +             upboard_gpio_leds[leds++] = blue_led;
> > +     }
> > +     if (yellow_gpio > -1) {
> > +             yellow_led.name = "upboard:yellow:";
> > +             yellow_led.gpio = yellow_gpio;
> > +             yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> > +             upboard_gpio_leds[leds++] = yellow_led;
> > +     }
> > +     if (green_gpio > -1) {
> > +             green_led.name = "upboard:green:";
> > +             green_led.gpio = green_gpio;
> > +             green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> > +             upboard_gpio_leds[leds++] = green_led;
> > +     }
> > +     if (red_gpio > -1) {
> > +             red_led.name = "upboard:red:";
> > +             red_led.gpio = red_gpio;
> > +             red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> > +             upboard_gpio_leds[leds++] = red_led;
> > +     }
> > +
> > +     upboard_gpio_led_platform_data.num_leds = leds;
> > +     upboard_gpio_led_platform_data.leds = upboard_gpio_leds;
> > +
> > +     if (devm_mfd_add_devices(fpga->dev, UPBOARD_DEVID,
> > +                              upboard_gpio_led_cells,
> > +                              ARRAY_SIZE(upboard_gpio_led_cells),
> > +                              NULL, 0, NULL)) {
> > +             dev_info(fpga->dev, "Failed to add GPIO leds");
> > +     }
> > +}
> > +
> > +static const struct acpi_device_id upboard_fpga_acpi_match[] = {
> > +     { "AANT0000", (kernel_ulong_t)&upboard_pinctrl_data },
> > +     { "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
> > +     { "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
> > +     { "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
> > +     { "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
> > +     { "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
> 
> Please don't push MFD configuration data through the ACPI API.

Ah look, I already said this.

> Larry (11/25) : we cannot understand it clearly. could you kindly give us more  examples, thanks.

All of these point to MFD cell initialisation structs.  Please don't
do that.  Assign each platform with an ID, then pull that ID out of
the ACPI match-data and assign local 'cells', 'ncells', etc based on
the ID.

[...]

-- 
Lee Jones [李琼斯]
