Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36246642BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjAJOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjAJOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D350E43;
        Tue, 10 Jan 2023 06:04:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF4-0004vx-Fp; Tue, 10 Jan 2023 15:04:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Riabchenko <d3adme4t@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Add IR receiver to BPI-R2Pro
Date:   Tue, 10 Jan 2023 15:04:37 +0100
Message-Id: <167335938205.2550251.6143947309802400390.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214155433.112257-1-linux@fw-web.de>
References: <20221214155433.112257-1-linux@fw-web.de>
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

On Wed, 14 Dec 2022 16:54:33 +0100, Frank Wunderlich wrote:
> From: Alex Riabchenko <d3adme4t@gmail.com>
> 
> Add the infrared receiver and its associated pinctrl entry.
> 
> Based on Aurelien Jarno's patchset:
> https://lore.kernel.org/lkml/20220930051246.391614-14-aurelien@aurel32.net/
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add IR receiver to BPI-R2Pro
      commit: 91ab5a0dcf3f6718099b894312dee2f1a235348d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
