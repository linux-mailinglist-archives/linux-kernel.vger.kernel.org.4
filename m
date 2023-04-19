Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429D6E7A54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjDSNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDSNKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:10:03 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA6BBBC;
        Wed, 19 Apr 2023 06:09:58 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 291395FD04;
        Wed, 19 Apr 2023 16:09:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681909795;
        bh=IItLTqDxjvCGXdjeoJBZnXotcgeQ3UjMBOLSC4wQqX8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=GohN/u7AQ9sxe95m+jrE0LJMpS/4E9mXc6FMMgMBqZQJVskpo+carnzbQ65hrRwNO
         4xAIWpANJpbqEs7ppJTJkmSlFvBEJgFig2AQscL+pFxEdo1WS/2MqaNaidNWt4oiuT
         jKQa8Lhcs7BFdsNL6SGIks5ETEkEnml3JrZtJGxdUV2S9JtfdrGdA6yZIDgf6q2LAU
         V552y3ifwIil99+TFR30fz/g6SE/tQvjUI7EknyO3Yj6ngPrrQWDu5Np5NfQIJAYyr
         J47afxniSviUmr/Sb31VUjmbmmYwvb7T3EkPhYH79+ylOfhi0BtPFKrdXbchyGHVJ/
         3Hp5bRvwMPfqA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 19 Apr 2023 16:09:50 +0300 (MSK)
Date:   Wed, 19 Apr 2023 16:09:50 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 0/2] Baisc devicetree support for Amlogic C3
Message-ID: <20230419130950.p7u4sqpi4ed65hie@CAB-WSD-L081021>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/19 10:42:00 #21127526
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please replace "Baisc" with "Basic" in the subject, it's a mistyping.

On Wed, Apr 19, 2023 at 03:38:32PM +0800, =Xianwei Zhao wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
> applications.
> 
> Add ARCH_AMLIPC for the new series.
> 
> Add basic devicetree support for the C3 based Amlogic AW409 board,
> which describes the following components: CPU, GIC, IRQ, Timer, UART.
> It's capable of booting up into the serial console.
> 
> Xianwei Zhao (2):
>   arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
>   arm64: dts: add support for C3 based Amlogic AW409
> 
>  arch/arm64/Kconfig.platforms                  | 12 +++
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 30 +++++++
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 87 +++++++++++++++++++
>  arch/arm64/configs/defconfig                  |  2 +
>  5 files changed, 132 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> 
> 
> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
