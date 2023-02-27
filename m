Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB36A46A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjB0QCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjB0QCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:02:05 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFF227A2;
        Mon, 27 Feb 2023 08:01:58 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6DE665FD23;
        Mon, 27 Feb 2023 19:01:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677513716;
        bh=NnkvUE19Ly88YE4py1Bip01LJrtgfHm0WJhoIJfHc6o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=YaX3Q3xBXtWolaD5d4b4ilGtUb4OYoNfYDbpX+kcm46Xl2P7dRTFrM7lWyuEGuKn+
         c91NsYXX5YcsIzecoDI5FOySRhnUOFNLTD1LroGurymqzkvXRg8mx/vpxe4A52HGvW
         +Ee1MBwHxM/m5LrDr11nPLdKHflRbSt/Bz85VxjsyXr6Nb6bJwgooa8blZ7IX50Vwo
         +1vnEJrSD6bb2zkhqdtdliPLRV2mrNJ8bb3j8C65LwIo79wZNCMTZEeq+farWU22cp
         xLHmr2QnUwOo+OAcHY57b5aXMsHsGaI9EPNecxoZmICjwrYNYvwGBkk7mHMOpTOkE+
         LYvZ9YfK0gXyw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 27 Feb 2023 19:01:56 +0300 (MSK)
Date:   Mon, 27 Feb 2023 19:01:55 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     <arm@kernel.org>, <soc@kernel.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
Message-ID: <20230227160155.swzhbchrn57yfe6w@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
 <13cf3223-d3fb-1a3e-f13a-77db3b6d144c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13cf3223-d3fb-1a3e-f13a-77db3b6d144c@linaro.org>
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

On Mon, Feb 27, 2023 at 03:46:50PM +0100, neil.armstrong@linaro.org wrote:
> On 27/02/2023 15:28, Dmitry Rokosov wrote:
> > Hello Neil!
> > 
> > On Mon, Feb 27, 2023 at 09:15:04AM +0100, neil.armstrong@linaro.org wrote:
> > 
> > [...]
> > 
> > > I'm aware Amlogic also runs their kernel as 32bit to gain a few kbytes
> > > of memory, but those processors are ARMv8 and the arm64 arch code
> > > has been designed for those CPUs.
> > > 
> > > So far I didn't find a single good reason to add 32bit support for
> > > ARMv8 Amlogic based SoCs, if you have a solid reason please share.
> > 
> > I totally agree with you, but I suppose it's fully related to 'big'
> > Amlogic SoC like S905_ or A311_ series. A113L (aka 'a1') is
> > a cost-efficient dual-core SoC which is used for small, cheap solutions
> > with cheap components. Every cent is important during BoM development.
> > That's why usually ODMs install small ROM and RAM capacity, and each
> > megabyte is important for RAM/ROM kernel and rootfs footprints.
> 
> Do you have figures ? is 32bit ARM kernel really lighter when ARM64 one is correctly configured ?

As I mentioned in the previous message, we have reached good results for
userspace profile. For the kernel, we have disabled heavy cost memory
features (like dynamic tracing) at both configurations, and get more or
less the same results for memory footprint (pre-allocated for kernel
sections).
I can provide rootfs figures/results, but I'm afraid it's so workload
dependent and very custom for us.

> 
> > Why am I talking about rootfs? For such small projects a good
> > choice is buildroot rootfs assembling framework. Unfortunatelly,
> > buildroot doesn't support 'compat' mode when kernel and userspace have
> > a different bitness.
> 
> well this is a buildroot problem... the kernel itself is perfectly capable
> of running an AArch32 userspace.

Based on your and Arnd arguments, agree, this is a buildroot problem
with compat mode definition.
Buildroot must have it for such configurations with mainline kernel.

[...]

-- 
Thank you,
Dmitry
