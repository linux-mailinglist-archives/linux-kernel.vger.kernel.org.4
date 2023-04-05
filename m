Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55C86D899D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDEVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjDEVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:35:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C56E97;
        Wed,  5 Apr 2023 14:35:14 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pkAmX-0001hG-Ps; Wed, 05 Apr 2023 23:35:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/2] Add PWM fan support to Rock 5B board
Date:   Wed, 05 Apr 2023 23:35:04 +0200
Message-ID: <840877554.0ifERbkFSE@diego>
In-Reply-To: <1a914522-8780-febd-7224-121b1f1fc2ba@roeck-us.net>
References: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
 <168071663557.3186456.17606522894011578076.b4-ty@sntech.de>
 <1a914522-8780-febd-7224-121b1f1fc2ba@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. April 2023, 21:04:04 CEST schrieb Guenter Roeck:
> On 4/5/23 10:45, Heiko Stuebner wrote:
> > On Tue, 4 Apr 2023 20:38:05 +0300, Cristian Ciocaltea wrote:
> >> This patch series enables support for the PWM controlled heat sink fan
> >> on the Rock 5B SBC and, additionally, converts the hwmon PWM fan bindings
> >> to DT schema format.
> >>
> >> Changes in v2:
> >>   - Updated PATCH 1/2 according to Rob's review
> >>   - Added Reviewed-by from Christopher to PATCH 2/2
> >>   - v1: https://lore.kernel.org/lkml/20230403105052.426135-1-cristian.ciocaltea@collabora.com/
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> 
> Both patches or only the second one ?

only the second one of course. According to earlier talks the dts patch
does already follow the text binding, so the yaml conversion is actually
not a requirement for it.

So I picked the dts patch let the binding sort itself when people have
time for it :-) .


Looking at the mail b4 created, I guessed this would also be visible
with the subject saying (subset) and the listed commits only showing

[2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
      commit: f36bb17653e4b9e26bbdb1224027d20614e77636


Heiko


