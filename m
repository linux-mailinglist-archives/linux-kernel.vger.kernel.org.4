Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9140E66595C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjAKKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbjAKKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:48:40 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D6A13F98;
        Wed, 11 Jan 2023 02:48:36 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFYen-0004Wz-CE; Wed, 11 Jan 2023 11:48:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Christopher Obbard <chris.obbard@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com
Subject: Re: [PATCH v2 0/3] Update eMMC alias for Radxa ROCK 5 Model A and Model B DTS
Date:   Wed, 11 Jan 2023 11:48:26 +0100
Message-Id: <167343400175.2680857.9550436621987040330.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110195352.272360-1-chris.obbard@collabora.com>
References: <20230110195352.272360-1-chris.obbard@collabora.com>
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

On Tue, 10 Jan 2023 19:53:49 +0000, Christopher Obbard wrote:
> The MMC aliases for the Radxa ROCK 5 Model A and Model B do not match the other
> Rockchip devices: mmc0 is usually the eMMC. In the initial devicetree series,
> I incorrectly set the alias for the eMMC to mmc1 to match the vendor kernel.
> 
> Update the alias for the eMMC to mmc0 to better match other Rockchip devices.
> 
> While we are here, remove an empty line to keep good style across the tree.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Update sdhci alias for rock-5a
      commit: 991f136c9f8de181b25cef056ab5fe7f49413919
[2/3] arm64: dts: rockchip: Remove empty line from rock-5a
      commit: 304c8a759953fb4a6cd399cf78f87501d7fd8bbc
[3/3] arm64: dts: rockchip: Update sdhci alias for rock-5b
      commit: 6fb13f888f2a6155fe4c19d14721e8909eda9b52

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
