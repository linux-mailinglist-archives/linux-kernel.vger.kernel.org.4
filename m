Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B786D8525
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDERqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDERqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:46:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259040C4;
        Wed,  5 Apr 2023 10:46:07 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk7Cu-0000Me-Eh; Wed, 05 Apr 2023 19:46:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCHv1 1/1] arm64: dts: rockchip: rk3588: add thermal sensor
Date:   Wed,  5 Apr 2023 19:46:00 +0200
Message-Id: <168071663558.3186456.6497656083450780396.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230404154429.51601-1-sebastian.reichel@collabora.com>
References: <20230404154429.51601-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 17:44:29 +0200, Sebastian Reichel wrote:
> Add thermal sensor IP, which allows monitoring temperatures at
> seven different places in the SoC:
> 
> * Chip Center
> * CPU Cluster 1 (Dual A76 "Big" Cores)
> * CPU Cluster 2 (Dual A76 "Big" Cores)
> * CPU Cluster 0 (Quad A55 "Little" Cores)
> * Power Domain Center
> * Graphics Processing Unit
> * Neural Processing Unit
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588: add thermal sensor
      commit: 32641b8ab1a5bd08e898cec3d46a8ecb4b4e895e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
