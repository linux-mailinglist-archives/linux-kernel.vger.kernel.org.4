Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56F6642BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjAJOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjAJOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6485793C;
        Tue, 10 Jan 2023 06:04:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF3-0004vx-Ht; Tue, 10 Jan 2023 15:04:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Yan <andyshrk@163.com>,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, lasstp5011@gmail.com
Subject: Re: [PATCH v2 0/2] Add support for EmbedFire LubanCat 2.
Date:   Tue, 10 Jan 2023 15:04:34 +0100
Message-Id: <167335938204.2550251.1765349953442710324.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108110708.2214718-1-andyshrk@163.com>
References: <20230108110708.2214718-1-andyshrk@163.com>
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

On Sun, 8 Jan 2023 19:07:08 +0800, Andy Yan wrote:
> Lubancat series are rk3566/8 based SBC from EmbedFire.
> So these Lubancat 2 patch should apply on top of Wenhao's
> series for LBC1 [0].
> 
> [0] https://patchwork.kernel.org/project/linux-rockchip/patch/Y6Ud9MhRjCVAYMCj@VM-66-53-centos/
> 
> Changes in v2:
> - keep only one blank line
> - Fix underscores in node pmic-int
> - Keep rockcip,pins of pmic-int in one line
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
      commit: 7943a9ddb48c986008879b43342ac2bf81d5c3a3
[2/2] arm64: dts: rockchip: Add dts for EmbedFire rk3568 LubanCat 2
      commit: 49fda9e691c13fd4fb438b8290b064ef42e8b2a5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
