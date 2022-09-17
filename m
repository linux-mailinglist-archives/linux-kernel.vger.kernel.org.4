Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97845BB6D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIQG5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:56:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C15AA30;
        Fri, 16 Sep 2022 23:56:56 -0700 (PDT)
Received: from [167.98.135.4] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZRkw-0007Hc-Il; Sat, 17 Sep 2022 08:56:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     zhangqing@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3128-cru.txt to YAML
Date:   Sat, 17 Sep 2022 08:56:48 +0200
Message-ID: <1754977.TLkxdtWsSY@phil>
In-Reply-To: <aa1fc003-eef9-13bb-b21b-ebccb12dc257@gmail.com>
References: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com> <14d7bbb5-51c4-8fc0-2303-f5164c6da903@linaro.org> <aa1fc003-eef9-13bb-b21b-ebccb12dc257@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. September 2022, 11:25:48 CEST schrieb Johan Jonker:
> 
> On 9/12/22 12:51, Krzysztof Kozlowski wrote:
> > On 11/09/2022 23:20, Johan Jonker wrote:
> >> Convert rockchip,rk3128-cru.txt to YAML.
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > 
> > Thank you for your patch. There is something to discuss/improve.
> > 
> >> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> >> new file mode 100644
> >> index 000000000..03e5d7f0e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
> >> @@ -0,0 +1,73 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> > 
> 
> > Can't it be Dual licensed?
> 
> That depends on Heiko and Rockchip.
> I can produce the patch for it, but I'm not in control whether they reply or not. 

Rockchip recently replied on other clock-patches to dual-license the
binding, so this will be ok [0] .

And for me, following in-kernel policies more, is always acceptable :-)

Heiko

[0] https://lore.kernel.org/all/510d1180-bc8e-7820-c772-ed7f35447087@rock-chips.com/
From Finley with an  @rock-chips.com address, so this should be ok


