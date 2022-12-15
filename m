Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAE64D9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLOKze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:55:31 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3313DBE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:55:30 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v126so1256777ybv.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAzkART/K+H1BtBy2iGf2pMDNR/MlfcpKi3QLVUBijc=;
        b=3XwC3z+7qmKuu3PPVK1x6/x3iu4IDgw/47F0Lq1kOaCXFWv8uu6uZuN0gLYi7w+3zm
         kvOWLkPOSsh36KlrBfmKIhkfe/QDvyP3UP7uIXDDmxQdZDEa5EsMOvn6+lDuqPlMc6Fr
         Ty4+PnXwXPwWp1sDc83bUv7lHZRyie5AddZzNEOK4QgPZwK/WTzIbp6ftggolib+6jsR
         5JCm/goNnWG0lhyid5lCYJ/kZuOuwQKNSiY61WUFC/ksL09Lbg1JdIhY5rMzqAmXyItM
         ow4QCkRMSJRujiAmdHAupsiQoE/3rZREJGls9+gGjPrA5XMDMLUjk4bovi7CdB3dvN2s
         rkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAzkART/K+H1BtBy2iGf2pMDNR/MlfcpKi3QLVUBijc=;
        b=mzvfUawkGjPdVfgpviYn5c8W6mrdAkRJ/hbECjeJPkY0Q+S/pUNTflj6nAtGmk2wcq
         VVt6W9unGC1VifpegYpN22t1JKgcS54Xi3lAKSqjCtg3q9JeUXGgJTWibeU83mhZicD0
         /FEhl4qM2QybVbUe/r0F8L58UTaHS+5HSjgdW+N0BncX8AXjXI4GyNTIny8x3DKXWZrr
         uPnl2imp2fRmOJL37xc0uoyeq5potwVLBjQ5seV2vGwP2eRlzS/YIuHmIHWPJkbfaGV/
         JQFrU17od++j1+pbOALYyeOAllTcrU5AENBKNAlPUIkK+TYCXpzy+4CW/Q4FXxY8d8fg
         Kugw==
X-Gm-Message-State: ANoB5pk4BGqhd16Za5q/YlstwyHQSIFvO/OMyrT5I5VUU4T1lEVvz78U
        Pq7lZZUzYGiS4RwCxfLLOqKg8GuO6iW2r47vK74sPQ==
X-Google-Smtp-Source: AA0mqf5D2ka2OLSU6EKaH/KzAy3R9CDYQoDtyeqHkE52AM+pBVLuEEW2g1AXaXRdS9FL2SHNiUg+soG/TsJ0Rrphz/I=
X-Received: by 2002:a5b:ac6:0:b0:702:5c2c:c9ee with SMTP id
 a6-20020a5b0ac6000000b007025c2cc9eemr14594410ybr.44.1671101729873; Thu, 15
 Dec 2022 02:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
 <20221214182247.79824-4-sebastian.reichel@collabora.com> <CA+VMnFzMgOC7sgcpQ7nZx2gaJfqqvRu8RxETguaBHN1Lg_nG_w@mail.gmail.com>
 <9a3cf2f1567f2a5990ed6dea9d6a5669@kernel.org>
In-Reply-To: <9a3cf2f1567f2a5990ed6dea9d6a5669@kernel.org>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Thu, 15 Dec 2022 16:25:19 +0530
Message-ID: <CA+VMnFxuzmP_7Rxp9UtUaeyZe=WCLCd2idqk8rorYsQWMSaF9g@mail.gmail.com>
Subject: Re: [PATCHv6 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 at 16:20, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-12-15 10:45, Jagan Teki wrote:
>
> > One nick with dtbs_check,
> > ethernet@fe1c0000: Unevaluated properties are not allowed ('reg',
> > 'interrupts', 'interrupt-names', 'power-domains', 'resets',
> > 'reset-names', 'snps,axi-config', 'snps,mixed-burst',
> > 'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'mdio',
> > 'stmmac-axi-config', 'rx-queues-config', 'tx-queues-config' were
> > unexpected)
>
> You did read the cover letter, right?

Now I checked, thanks. Seems a known issue to go.

Jagan.
