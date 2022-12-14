Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B264CC32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiLNO1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiLNO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:11 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869622099A;
        Wed, 14 Dec 2022 06:27:10 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p5Sir-00050J-Ny; Wed, 14 Dec 2022 15:27:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: use correct reset names
Date:   Wed, 14 Dec 2022 15:26:57 +0100
Message-Id: <167102796002.2796496.14016944673146684477.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221212124423.1239748-1-clabbe@baylibre.com>
References: <20221212124423.1239748-1-clabbe@baylibre.com>
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

On Mon, 12 Dec 2022 12:44:23 +0000, Corentin Labbe wrote:
> The reset names does not follow the binding, use the correct ones.
> 
> 

Applied as fix for 6.2, thanks!

[1/1] arm64: dts: rockchip: rk3399: use correct reset names
      commit: 53e8e1e6e9c1653095211a8edf17912f2374bb03

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
