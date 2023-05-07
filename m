Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE6F984F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjEGKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEGKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 06:54:50 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398615B8F;
        Sun,  7 May 2023 03:54:45 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pvc25-0005gS-7Q; Sun, 07 May 2023 12:54:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Yan <andyshrk@163.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: Add doc for Fastrhino R66S / R68S
Date:   Sun,  7 May 2023 12:54:24 +0200
Message-Id: <168345676639.21260.15276266069370023718.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230506061108.17658-1-cnsztl@gmail.com>
References: <20230506061108.17658-1-cnsztl@gmail.com>
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

On Sat, 6 May 2023 14:11:06 +0800, Tianling Shen wrote:
> Add devicetree binding documentation for the
> Lunzn Fastrhino R66S and R68S boards.
> 
> 

Applied, thanks!

[1/3] dt-bindings: Add doc for Fastrhino R66S / R68S
      commit: b985ca5261171e559f4d9754481b5f6c6e15ad93
[2/3] arm64: dts: rockchip: Add Lunzn Fastrhino R66S
      commit: ddb6cde1cf59eb57820a6c277b8b5cff45e68d68
[3/3] arm64: dts: rockchip: Add Lunzn Fastrhino R68S
      commit: 5a9447fd17668c34449052e4f77eebc7a98eccf3

[v6.5-armsoc/dts64 branch, will be rebased once more after 6.4-rc1,
 resorted some properties to be more alphabetically sorted
 dropped one empty line at the end of the pmic node]


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
