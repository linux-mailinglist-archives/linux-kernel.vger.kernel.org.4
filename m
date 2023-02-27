Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EED6A44C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjB0Ojg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjB0Oje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:39:34 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F41B330;
        Mon, 27 Feb 2023 06:39:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2034E5FD19;
        Mon, 27 Feb 2023 17:39:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677508770;
        bh=tYgZUWm19uKbwUi7eTlgHZOmZ/p94X0Fb1vTQ3q8QDQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=fHlj3/t6cedaewXNtoScUPJQNeVSSLA5b0RZI4JxTfCognayaE5GnWEjd82ysxbSQ
         j97FRx2+VgQVqjx/npe+pxYjPBhzH25/x/gaewwdgC+hvNOBjrNxQOXgJrcOfAdlQC
         q6xBxEG4SZqbfKORd/x1JFkKSNCPq+06XmEcbUOOdX/OLYfJE3pEpyyR3c7E9Y2Eji
         kGdbCsivU7ZaUOoNphiO+D4XlK/VYSxKMXa2v35wp9u3UQ3D0Px1RIqjO6LdVnpjti
         gYnAXFYwTfEJ6+T8g+Ep93X7bzZAZ9oXmjfTwS238FE0B9SSgmBGIkgqLapeKwzDak
         FJhI/M9vBmrPw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 27 Feb 2023 17:39:29 +0300 (MSK)
Date:   Mon, 27 Feb 2023 17:39:29 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Alexey Romanov <avromanov@sberdevices.ru>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 3/3] arch/arm: dts: introduce meson-a1 device tree
Message-ID: <20230227143929.h2lppesdiaj7l3gn@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <20230222115020.55867-4-avromanov@sberdevices.ru>
 <bc514ba7-406e-bca8-4d3a-4f8997cd3241@linaro.org>
 <d5d9a1fe-2f66-66e3-d88a-76a12f2ec55e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5d9a1fe-2f66-66e3-d88a-76a12f2ec55e@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/27 12:14:00 #20900843
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof!

On Thu, Feb 23, 2023 at 10:09:25AM +0100, Krzysztof Kozlowski wrote:

[...]

> >> describes following compontents: CPU, GIC, IRQ, Timer, UART,
> >> PIN controller. It's capable of booting up into
> >> the serial console.
> >>
> >> This is based on arm64 version of meson-a1.dtsi.
> >>
> >> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> >> ---
> >>  arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++
> > 
> > There is such file and there is such DTS/hardware support. I don't see
> > any reason why entire DTSI should be duplicated. What's more, your
> > commit does not explain it - does not justify duplication.
> 
> One more comment - I think you just added dead code. It's
> uncompilable/untestable. Otherwise, please share how to build this DTSI
> without DTS.

You are right, Alexey doesn't provide any exact *.dts file for any
board, and *.dtsi file should be included somewhere, otherwise this is
dead code.
Unfortunately, our internal board *.dts file is useless for kernel
community, cause there is not any chance to burn locally compiled kernel
to our product due to secureboot protection.
But I think there is one possible option. We have reference Amlogic
boards somewhere in the office. So we can test 32-bit configuration on
it and prepare proper *.dts file for that. What do you think, it
reasanoble?

-- 
Thank you,
Dmitry
