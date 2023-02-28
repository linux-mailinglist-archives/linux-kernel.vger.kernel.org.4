Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB06A54BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjB1IuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjB1IuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:50:03 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4C1BD8;
        Tue, 28 Feb 2023 00:49:56 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6EA825FD02;
        Tue, 28 Feb 2023 11:49:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677574193;
        bh=WTDff+9gxDSiq4AqgGvZY+eqS12sSl1fFBNNtQAELTw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=DpSD19ZrvLwLCBFstdb7Upko+A112qjp/5Fap0UQ59Akxu4XktCVHzRFV0TNEK4B0
         Px59EN1UDE19F8/Bxpsvm5hNb/lpyXns5wxqP26+0ijhgV+3JIGtOGfzw9vXIGHu4/
         wk0G8bLIzriC/v11/nvEv1L+ucV1F6IBqiTHF79wUiIewCQg/ql3N9074QtwHQlqiB
         7AZ0tJHg/lDcr37PgJ/c0ALbWm+Gi3jNKrsTlIePYT0OyU+O41tF41s1ofhmfnE4mx
         JNoq9nZ6vJIgCb4HdwzGsen5DCC1EsboUJygGWAUl6gdji4quYMs+Vsb7RW4un5L5c
         vxR8cO/W6RsPg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 28 Feb 2023 11:49:52 +0300 (MSK)
Date:   Tue, 28 Feb 2023 11:49:52 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Rob Herring <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
Message-ID: <20230228084952.mgx3d3nw65yo5ebu@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
 <f3e42012-609c-4085-b4f4-bd32bfc34aff@app.fastmail.com>
 <20230227155100.hhl4yvkyfqfyoa6h@CAB-WSD-L081021>
 <a5fa8b23-4ec8-475f-be5e-538b53d6f82d@app.fastmail.com>
 <33b58877-5167-c453-e686-1d10cdca66c0@linaro.org>
 <20230227165049.4y7jx5nnnlibe6kg@CAB-WSD-L081021>
 <7d29f3fd-b8c8-4687-b6a0-b8956dd39f0b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d29f3fd-b8c8-4687-b6a0-b8956dd39f0b@app.fastmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/28 06:24:00 #20902806
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:19:38PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 27, 2023, at 17:50, Dmitry Rokosov wrote:
> > On Mon, Feb 27, 2023 at 05:38:49PM +0100, Neil Armstrong wrote:
> >> On 27/02/2023 17:15, Arnd Bergmann wrote:
> >> > On Mon, Feb 27, 2023, at 16:51, Dmitry Rokosov wrote:
> >> > 
> >> > Most of these don't apply in userspace, so the incentive to
> >> > run smaller 32-bit userland on systems with less than 1GB of
> >> > RAM usually outweighs the benefits of 64-bit userspace.
> >> 
> >> Thanks for the details!
> >
> > Looks like Thomas has already prepared a basic patch series for buildroot,
> > but maintainers declined it.
> >
> > https://lore.kernel.org/all/20220730194331.GA2515056@scaer/
> 
> I see. I know very little about buildroot, but it sounds like
> there are other ways of doing the same thing here. In general,
> this is pretty much an Arm specific problem. While you clearly
> want compat mode for small userland on any architecture but don't
> want 32-bit kernels, arm is the only one that has a different
> kernel "ARCH=" value and needs a separate gcc toolchain.
> 
> If the problem is only the toolchain, an easy way out may
> be to use clang instead of gcc as your compiler, as a single
> clang binary can target both 32-bit userland and 64-bit kernel
> on all supported architectures.

Agreed with you. We will try different local approaches to support
compat build configurations. For now, prebuilt toolchain (buildroot make
sdk goal) is best way from my point of view. Anyway, we will try to
solve this problem in the our sandbox and stay on the 64-bit kernel.
Thank you for all the helpful details you shared, appreciate it!

-- 
Thank you,
Dmitry
