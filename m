Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AAC6642BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbjAJOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjAJOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:04:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7650F42;
        Tue, 10 Jan 2023 06:04:47 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFFF4-0004vx-2X; Tue, 10 Jan 2023 15:04:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rk3399-pinephone-pro: reduce thermal limits
Date:   Tue, 10 Jan 2023 15:04:36 +0100
Message-Id: <167335938206.2550251.13143254102555744501.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207113212.8216-1-kernel@undef.tools>
References: <20221207113212.8216-1-kernel@undef.tools>
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

On Wed, 7 Dec 2022 11:32:13 +0000, Jarrah Gosbell wrote:
> While this device uses the rk3399 it is also enclosed in a tight package
> and cooled through the screen and back case. The default rk3399 thermal
> limits can result in a burnt screen.
> 
> These lower limits have resulted in the existing burn not expanding and
> will hopefully result in future devices not experiencing the issue.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rk3399-pinephone-pro: reduce thermal limits
      commit: 33e24f0738b922b6f5f4118dbdc26cac8400d7b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
