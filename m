Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270F76E459B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDQKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDQKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:49:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F07EF6;
        Mon, 17 Apr 2023 03:48:44 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1poLHB-00027c-EW; Mon, 17 Apr 2023 11:35:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add regulators to Rock 5B's CPU big cores
Date:   Mon, 17 Apr 2023 11:35:54 +0200
Message-Id: <168172146374.3844162.4496409077876685871.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230414125425.124994-1-cristian.ciocaltea@collabora.com>
References: <20230414125425.124994-1-cristian.ciocaltea@collabora.com>
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

On Fri, 14 Apr 2023 15:54:22 +0300, Cristian Ciocaltea wrote:
> The CPU big cores on the Rock 5B board are powered by the RK8602/RK8603
> regulators. Since the support for those regulators has been recently
> merged via [1], add the necessary device tree nodes and bind them to
> the corresponding CPU nodes.
> 
> Additionally, provide a couple of unrelated DTS fixes/improvements.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Drop RTC clock-frequency on rk3588-rock-5b
      commit: d7f5e83913d1bcd50968972a7b50e49c9a14b2af
[2/3] arm64: dts: rockchip: Use generic name for es8316 on Pinebook Pro and Rock 5B
      commit: 0af7164cb0e076dbfeed28956658a1ad94bd5927
[3/3] arm64: dts: rockchip: Add vdd_cpu_big regulators to rk3588-rock-5b
      commit: 1bb69cd4a344299a382695a2de1a84c0b23fe6da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
