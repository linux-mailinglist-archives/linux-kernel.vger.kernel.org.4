Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6726AAEFC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCEKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCEKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:18:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079FD52C;
        Sun,  5 Mar 2023 02:18:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B172E60AF0;
        Sun,  5 Mar 2023 10:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D873C433D2;
        Sun,  5 Mar 2023 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678011511;
        bh=BqiMKn3RghRbcr4+/wUZ/+Ee50jKJj55sBSSUqyBSfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtThlPKDFnTfNx5xXDxaCUoxkiBM/T7WP33tkYkit2llqBNoPX93N91X8zCR+7Kg2
         iFXBb/OtAXkXJWncbFAI0A7lWLj4u6fHr08IBd/dinZpPlRIEtp/Q35sW+5JMI9Hmz
         Q2Xcyar0XSUkp+9gFb9jmlqKeCb0gVFwCy/0QXGOLDDsS2Wr9WhXZHP2w/+2m6azaj
         CwiGbBXMG+fPk8XEqByRrWYJKoAC2/DYbZ5rIArkYglc6oXTXsTfSZAGEf4+f77mtr
         X4DDTQj9BhWapPsktMtmyXpm6ZTXHpemaJoTiUtwhFgVMkKpmarqQ3KtRpOsc1t3NE
         tPwIjFe96wqZg==
Date:   Sun, 5 Mar 2023 10:18:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, pavel@ucw.cz, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v17 RESEND 3/3] docs: leds: Add MT6370 RGB LED pattern
 document
Message-ID: <20230305101824.GE2574592@google.com>
References: <cover.1677150607.git.chiaen_wu@richtek.com>
 <c6487954daff5e514023056ad7de1d0ddee674a8.1677150607.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6487954daff5e514023056ad7de1d0ddee674a8.1677150607.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023, ChiaEn Wu wrote:

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
>  Documentation/leds/leds-mt6370-rgb.rst | 64 ++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst
> 
> diff --git a/Documentation/leds/leds-mt6370-rgb.rst b/Documentation/leds/leds-mt6370-rgb.rst
> new file mode 100644
> index 00000000..d1b2e4f
> --- /dev/null
> +++ b/Documentation/leds/leds-mt6370-rgb.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +Kernel driver for Mediatek MT6370 RGB LED

Are you describing the device or the kernel driver?

> +=========================================
> +
> +Description
> +-----------
> +
> +The MT6370 integrates a four-channel RGB LED driver, designed to provide a
> +variety of lighting effect for mobile device applications. The RGB LED driver

"devices"

> +includes a smart LED string controller and it can drive 3 channels of LEDs with
> +a sink current up to 24mA and a CHG_VIN power good indicator LED with sink
> +current up to 6mA. It provides three operation modes for RGB LEDs:
> +PWM Dimming mode, breath pattern mode, and constant current mode. The device
> +can increase or decrease the brightness of the RGB LED via I2C interface.

"an I2C interface"

> +The breath pattern for a channel can be programmed using the "pattern" trigger,
> +using the hw_pattern attribute.
> +
> +/sys/class/leds/<led>/hw_pattern
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
