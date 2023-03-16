Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD26BD45D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCPPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCPPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBEF1B5;
        Thu, 16 Mar 2023 08:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D66C862094;
        Thu, 16 Mar 2023 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664B5C433EF;
        Thu, 16 Mar 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678981915;
        bh=zcCZCxOddrY19dAifEoyyXbquULTfQJDNveTVJQHbvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnWrTRkhsriTufDefygk8Ww1IBalyeTruIf2nR/17/pSFOGkGUCvgXRqV2HFOWnQE
         94h9ApXSBJLsIfTYBABn7sIUUjY3mCpQGTm0lfmR9WEH3/9K/4IOFo+dbLxgWMoEcJ
         ptdJcsVu7FPdLxmEYvCds/oEgOvWSFFWI9ETI9ycSeJF5xBn8DPIiZhYHN7+6XAZ5j
         Sfipf1G1RMge8Ph2xaX2faK/ssY1SN2kKHxhraflL5S8FXS5FtWxdRGg6Y7yHTu+wp
         RP/AQ3hwm2T9BWoaD74VtyuGNt2IpChEMYrvlt3KY6SDR9opQklUgYY3yqmHSeTxrP
         2HUg8xr9rD89Q==
Date:   Thu, 16 Mar 2023 15:51:49 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, pavel@ucw.cz, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v18 3/3] docs: leds: Add MT6370 RGB LED pattern document
Message-ID: <20230316155149.GK9667@google.com>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <38f1e863b0f099158a63fb6f95056a1cb30d80a0.1678430444.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38f1e863b0f099158a63fb6f95056a1cb30d80a0.1678430444.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Document the MT6370 RGB LED pattern trigger.
>
> This simply describe how the pattern works, each timing period, and the
> pattern diagram for MT6370 RGB LED.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v18:
> - Revise the text in document title and description.
> ---
>  Documentation/leds/leds-mt6370-rgb.rst | 64 ++++++++++++++++++++++++++++++++++

These 3 patches now look good.

You do not need to make any more changes to these.

>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst
>
> diff --git a/Documentation/leds/leds-mt6370-rgb.rst b/Documentation/leds/leds-mt6370-rgb.rst
> new file mode 100644
> index 00000000..abf739e
> --- /dev/null
> +++ b/Documentation/leds/leds-mt6370-rgb.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +The device for Mediatek MT6370 RGB LED
> +=========================================
> +
> +Description
> +-----------
> +
> +The MT6370 integrates a four-channel RGB LED driver, designed to provide a
> +variety of lighting effect for mobile device applications. The RGB LED devices
> +includes a smart LED string controller and it can drive 3 channels of LEDs with
> +a sink current up to 24mA and a CHG_VIN power good indicator LED with sink
> +current up to 6mA. It provides three operation modes for RGB LEDs:
> +PWM Dimming mode, breath pattern mode, and constant current mode. The device
> +can increase or decrease the brightness of the RGB LED via an I2C interface.
> +
> +The breath pattern for a channel can be programmed using the "pattern" trigger,
> +using the hw_pattern attribute.
> +
> +/sys/class/leds/<led>/hw_pattern

However, this needs an entry in Documentation/ABI/testing.

> +--------------------------------
> +
> +Specify a hardware breath pattern for a MT6370 RGB LED.
> +
> +The breath pattern is a series of timing pairs, with the hold-time expressed in
> +milliseconds. And the brightness is controlled by
> +'/sys/class/leds/<led>/brightness'. The pattern doesn't include the brightness
> +setting. Hardware pattern only controls the timing for each pattern stage
> +depending on the current brightness setting.
> +
> +Pattern diagram::
> +
> +     "0 Tr1 0 Tr2 0 Tf1 0 Tf2 0 Ton 0 Toff" --> '0' for dummy brightness code
> +
> +      ^
> +      |           ============
> +      |          /            \                                /
> +Icurr |         /              \                              /
> +      |        /                \                            /
> +      |       /                  \                          /   .....repeat
> +      |      /                    \                        /
> +      |   ---                      ---                  ---
> +      |---                            ---            ---
> +      +----------------------------------============------------> Time
> +       < Tr1><Tr2><   Ton    ><Tf1><Tf2 ><  Toff    >< Tr1><Tr2>
> +
> +Timing description::
> +
> +Tr1:    First rising time for duty 0 to 30%.
> +Tr2:    Second rising time for duty 31% to 100%.
> +Ton:    On time for duty 100%.
> +Tf1:    First falling time for duty 100% to 31%.
> +Tf2:    Second falling time for duty 30% to 0%.
> +Toff:   Off time for duty 0%.
> +
> +Tr1/Tr2/Tf1/Tf2/Ton: 125ms to 3125ms, 200ms per step.
> +Toff: 250ms to 6250ms, 400ms per step.
> +
> +Pattern example::
> +
> +       "0 125 0 125 0 125 0 125 0 625 0 1050"
> +
> +This Will configure Tr1/Tr2/Tf1/Tf2 to 125m, Ton to 625ms, and Toff to 1050ms.
> --
> 2.7.4
>

--
Lee Jones [李琼斯]
