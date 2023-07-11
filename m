Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9074F2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGKOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjGKOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5D10E5;
        Tue, 11 Jul 2023 07:48:53 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJEfZ-0000LD-4F; Tue, 11 Jul 2023 16:48:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v4 0/5] Add RK3588 SATA support
Date:   Tue, 11 Jul 2023 16:48:45 +0200
Message-Id: <168908688815.1964886.16094073283802293132.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612171337.74576-1-sebastian.reichel@collabora.com>
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 19:13:32 +0200, Sebastian Reichel wrote:
> This enables SATA support for RK3588.
> 
> Changes since PATCHv3:
>  * https://lore.kernel.org/all/20230608162238.50078-1-sebastian.reichel@collabora.com/
>  * Add Reviewed-by from Serge and Krzysztof to patch 1
>  * Update patch 2
>    - Add maxItems to 'clocks' property; without specifying minItems it's
>      implied to be the same
>    - Keep allOf above the properties in snps,dwc-ahci.yaml
>    - Add 'sata-port@0' to list of allowed properties
>    - Replace sata-port pattern property, so that it disallows using any
>      sata-port nodes besides @0 to override the pattern property from the
>      common binding
>  * Add Reviewed-by from Krzysztof to patch 3
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: rockchip: rk3588: add combo PHYs
      commit: 6ebd55b3bba383e0523b0c014f17c97f3ce80708
[5/5] arm64: dts: rockchip: rk3588: add SATA support
      commit: 34d6c15d8e86256ef2456c604b1c8d8242720871

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
