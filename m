Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954F36296E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKOLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbiKOLKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:44 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675C5FBA;
        Tue, 15 Nov 2022 03:10:25 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1outpe-0007ai-DD; Tue, 15 Nov 2022 12:10:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/6] Misc SOQuartz Enablement
Date:   Tue, 15 Nov 2022 12:10:16 +0100
Message-Id: <166851058434.863884.2776372315894555670.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
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

On Sat, 12 Nov 2022 17:03:57 +0100, Nicolas Frattaroli wrote:
> This series enables the following functionality on the SOQuartz CM4
> module:
> 
>  * GPU (patch 1)
>  * Video output (patch 2)
>  * HDMI (also patch 2)
>  * HDMI audio (patch 3)
>  * PCIe2 (patch 4), CM4IO board
>  * SOQuartz Blade bindings (patch 5)
>  * SOQuartz Blade device tree (patch 6)
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: rockchip: Enable GPU on SOQuartz CM4
      commit: e48824e8a03e5bc3666e9f5461f68d440d9acba0
[2/6] arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
      commit: 36d7a605706d9648526a0574b8e7b0e02fa70c2a
[3/6] arm64: dts: rockchip: Enable HDMI sound on SOQuartz
      commit: 70b620c4ba919a87c607b8d98b08478b213877bd
[4/6] arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO
      commit: 3736aa7ecc4cd9b4abce30052bad00aba4f0362f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
