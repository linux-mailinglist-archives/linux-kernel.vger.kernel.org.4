Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585026D03B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjC3Lpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjC3Lpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:45:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD019EF3;
        Thu, 30 Mar 2023 04:45:18 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phqi1-0003YZ-Kn; Thu, 30 Mar 2023 13:44:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Add support for NanoPi R2C and OrangePi R1 Plus LTS
Date:   Thu, 30 Mar 2023 13:44:44 +0200
Message-Id: <168017666944.2380317.18295584038615074467.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230325074022.9818-1-cnsztl@gmail.com>
References: <20230325074022.9818-1-cnsztl@gmail.com>
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

On Sat, 25 Mar 2023 15:40:18 +0800, Tianling Shen wrote:
> got supported/fixed in kernel v6.3:
> 
> * FriendlyARM NanoPi R2C - yt8521s
> * Xunlong OrangePi R1 Plus LTS - yt8531c
> 
> Changes since v1:
> * https://lore.kernel.org/linux-rockchip/20230323123807.11882-1-cnsztl@gmail.com/
> * Updated dt-binding description for NanoPi R2C
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
      commit: ceb2e18487c322f3becae0959d48ef12a829a2dc
[2/4] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
      commit: 004589ff9df5b75672a78b6c3c4cba93202b14c9
[3/4] dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
      commit: 564cfdb866535662d74a6a1c5b5e7e99845d7e25
[4/4] arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS
      commit: 387b3bbac5ea6a0a105d685237f033ffe0f184f1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
