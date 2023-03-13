Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8772E6B6CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCMABb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:01:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46B34312;
        Sun, 12 Mar 2023 17:01:29 -0700 (PDT)
Date:   Mon, 13 Mar 2023 00:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1678665687; bh=wxLpf8Jdf0lk2RvWY5sDFzQ0yrucDslEDAxZjcXQwvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oh1GpygvP9tfgUVJOQp59jFcyft77uuDARurkyb8HATS/m1mO/ET8TXTPn4yzGDfj
         33yKZLVDyglpXe0UQxjecpYMQtPJ54+w2/iiXLeHATSUvm4F0Zhgp8OS1XkbHQCoq5
         1NRqtrhscTWAzLSHQzwDmjVWAVgs1Zy1e8HteeLA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx: Add devicetree for Tolino Vison
Message-ID: <0d08c091-2923-43d8-bec1-86e9edf2ac57@t-8ch.de>
References: <20230312205236.2281466-1-andreas@kemnade.info>
 <20230312205236.2281466-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312205236.2281466-3-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 09:52:36PM +0100, Andreas Kemnade wrote:
> This adds a devicetree for the Kobo Aura 2 Ebook reader. It is based
> on boards marked with "37NB-E60Q30+4A3". It is equipped with an i.MX6SL
> SoC.

Kobo Aura 2?

> Expected to work:
>  - Buttons
>  - Wifi
>  - LEDs
>  - uSD
>  - eMMC
>  - USB
>  - RTC
>  - Touchscreen
>  - Backlight
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/imx6sl-tolino-vision.dts | 490 +++++++++++++++++++++
>  2 files changed, 491 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sl-tolino-vision.dts
