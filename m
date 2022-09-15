Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357A45B9C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIONtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIONtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:49:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29B213EB1;
        Thu, 15 Sep 2022 06:49:17 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYpEs-00053R-Up; Thu, 15 Sep 2022 15:49:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4} variants
Date:   Thu, 15 Sep 2022 15:49:06 +0200
Message-Id: <166324955276.172936.10946174997908284073.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
References: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 12:33:55 -0700, Brian Norris wrote:
> The Gru-Scarlet family includes a variety of SKU identifiers, using
> parts of a 3-bit space {0..7}. SKU2 and SKU4 devices (under a few
> different manufacturer names) also use the Innolux display.
> 
> For reference, the original vendor tree source:
> 
> CHROMIUM: arm64: dts: rockchip: add sku{0,2,4} compatibility
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f6ed665c9e2eb37fb2680debbb36ec9fb0e8fb97
> 
> [...]

I cornored Krzysztof at ELCE today and he had no objections, so

Applied, thanks!


[1/2] dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4} variants
      commit: b360cfbf86a918b835e673b9da5faf972a9bf146
[2/2] arm64: dts: rockchip: Support gru-scarlet sku{2,4} variants
      commit: 578980728868fcd99bbb5af12e50b38d2e66f5aa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
