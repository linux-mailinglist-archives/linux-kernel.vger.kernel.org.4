Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D85F852D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJHMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJHMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:12:03 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E804316E;
        Sat,  8 Oct 2022 05:12:00 -0700 (PDT)
Message-ID: <8e84786d-8ae9-0f51-3438-24fb340199c6@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1665231118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddNkVrba/EFnig8p208wtNiaW3ykO4vqSHsplkdSsys=;
        b=SIFz4p0heRVDbNoYwzEyMdHzCn2skoSPucuMOhWOQyJHiOyjGAvZAIElgwjOVA/6KgDx71
        SxzKTcvB3wq4/0U3/S6Q5nmvxm+X3VOwgmP57H5L9jtC98YzRiwZWWzdea9+bEF9wH0pfG
        cgUprXzVknoFR1bbOuphLa6B+a9TYyyk9/jiRZdgY2uuK2jrPBnqF0JKzEjCkDX7ApoJYv
        bd0nRfdVhMCoW1RH50YK4B0+mM/rhc+oOFFniGEPUZdi3WN9jcS9ZIQ80CDHpSGwAh7Xrw
        em3rxP9g2JC7xQDIjEleHIC/vOh+6qTgYFfyYlUPOEheKw51aSkGaINOjZ0GQQ==
Date:   Sat, 8 Oct 2022 14:11:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] Add support for the Hardkernel ODROID-M1 board
Content-Language: da-DK
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Dongjin Kim <tobetter@gmail.com>
References: <20220930051246.391614-1-aurelien@aurel32.net>
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <20220930051246.391614-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 30.09.2022 kl. 07.12 skrev Aurelien Jarno:
> On the ODROID forum, Dongjin Kim said he is not planning to submit a new
> version of the patchset adding support for the Hardkernel ODROID-M1
> board. I therefore decided to address the issues reported during the
> initial review, and I also did some small fixes either because some
> things changed in the meantime on the kernel side or because I noticed
> some warning or issues when using the hardware.
>
> I continued writing some additional patches to complete the ODROID M1
> DTS to almost fully support the hardware, the drivers being already
> present in the kernel.
>
> This new version includes feedback from the linux-rockchip mailing list
> and from the Odroid forum.
>
> Changes since v2:
> * Renamed "Rockchip RK3568 Hardkernel ODROID-M1" into "Hardkernel Odroid
>    M1" and fix the sorting.
> * Fix sorting of arch/arm64/boot/dts/rockchip/Makefile
> * Collected Acked-by and Tested-by

Even though I added my Tested-by to this series, it seems I didn't test 
it on eMMC.

This fails to boot for me on eMMC, but works on SD card and NVMe.

Sorry about that.

> * Switched the NOR flash to dual I/O from quad I/O to solve a pin
>    conflicts with the EMMC.
> * Added a comment about the pull-up on the IR receiver GPIO
>
> Changes since v1 (patches 1 & 2):
> * Added Acked-by to the first patch
> * Fixed indentation
> * Removed unneeded labels
> * Renamed labels to not use underscore
> * Renamed regulator nodes
> * Added -pin to pinctrl bindings
> * Changed GPU related regulators to always on (see 2cda380102ff)
> * Added phy-supply to gmac0
> * Added supplies to sdhci
> * Changed SD card speed to SDR50 from SDR104 (see 1ea90b2d293f)
> * Fixed power LED polarity and set the default-state to "keep"
>
> Aurelien Jarno (11):
>    arm64: dts: rockchip: add thermal support to ODROID-M1
>    arm64: dts: rockchip: Add NOR flash to ODROID-M1
>    arm64: dts: rockchip: Add analog audio on ODROID-M1
>    arm64: dts: rockchip: Enable vop2 and hdmi tx on ODROID-M1
>    arm64: dts: rockchip: Enable HDMI audio on ODROID-M1.
>    arm64: dts: rockchip: Enable the GPU on ODROID-M1
>    arm64: dts: rockchip: Enable the USB 2.0 ports on ODROID-M1
>    arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
>    arm64: dts: rockchip: Add SATA support to ODROID-M1
>    arm64: dts: rockchip: Add PCIEe v3 nodes to ODROID-M1
>    arm64: dts: rockchip: Add IR receiver node to ODROID-M1
>
> Dongjin Kim (2):
>    dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
>    arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
>
>   .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 744 ++++++++++++++++++
>   3 files changed, 750 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
>
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
