Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44920701842
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEMQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEMQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:49:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA67135A0;
        Sat, 13 May 2023 09:49:39 -0700 (PDT)
Received: from p508fce4f.dip0.t-ipconnect.de ([80.143.206.79] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pxsR1-0000Vh-GY; Sat, 13 May 2023 18:49:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] Add RK3588 OTP memory support
Date:   Sat, 13 May 2023 18:49:26 +0200
Message-Id: <168399655509.610817.6649297823886958542.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 23:06:40 +0300, Cristian Ciocaltea wrote:
> This patch series adds OTP memory support for Rockchip RK3588 SoC,
> while also providing a few improvements to the existing rockchip-otp
> driver, in addition to converting the bindings to dt-schema.
> 
> Changes in v2:
>  - Renamed rockchip-otp.yaml to rockchip,otp.yaml and removed clock's minItems
>    in PATCH 1/8, according to the review from Krzysztof
>  - Updated commit message in PATCH 2/8, per Heiko's suggestion
>  - Renamed rockchip_data's clocks to clks in PATCH 3/8, per Heiko's review
>  - Preserved clocks order/names from older SoC variants in PATCH 2/8, according
>    to Krzysztof's review; updated accordingly patches 7/8 and 8/8
>  - Added Tested-by tags from Vincent
>  - Added Reviewed-by tags from Heiko
>  - v1: https://lore.kernel.org/lkml/20230501084401.765169-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied, thanks!

[8/8] arm64: dts: rockchip: Add rk3588 OTP node
      commit: bcac467b7ca045224bd0f35e245b8edfcb1c452e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
