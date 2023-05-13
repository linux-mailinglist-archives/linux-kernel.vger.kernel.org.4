Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488F701843
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjEMQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEMQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:49:44 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FDD2D74;
        Sat, 13 May 2023 09:49:43 -0700 (PDT)
Received: from p508fce4f.dip0.t-ipconnect.de ([80.143.206.79] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pxsR0-0000Vh-WE; Sat, 13 May 2023 18:49:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andrew Powers-Holmes <aholmes@omnom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Tianling Shen <cnsztl@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andy Yan <andyshrk@163.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: add FriendlyARM NanoPi R2C Plus
Date:   Sat, 13 May 2023 18:49:25 +0200
Message-Id: <168399655506.610817.996905574714533571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230513135307.26554-1-cnsztl@gmail.com>
References: <20230513135307.26554-1-cnsztl@gmail.com>
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

On Sat, 13 May 2023 21:53:06 +0800, Tianling Shen wrote:
> Add devicetree binding documentation for the NanoPi R2C Plus.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: add FriendlyARM NanoPi R2C Plus
      commit: 8788595d66b9d6ac62d844af013edc3b393d8aef
[2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C Plus
      commit: d211665c5a833873ee37e501af58adbf028e6b5f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
