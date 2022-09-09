Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203655B42E9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiIIXMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiIIXMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:12:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4791269F8;
        Fri,  9 Sep 2022 16:11:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWn9J-0000Qa-1A; Sat, 10 Sep 2022 01:11:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add PCIe 2 nodes to quartz64-b
Date:   Sat, 10 Sep 2022 01:10:54 +0200
Message-Id: <166276502653.27767.1922290388399507834.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718033145.792657-1-frattaroli.nicolas@gmail.com>
References: <20220718033145.792657-1-frattaroli.nicolas@gmail.com>
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

On Mon, 18 Jul 2022 05:31:45 +0200, Nicolas Frattaroli wrote:
> This adds the regulator node to the quartz64-b device tree,
> and enables the PCIe 2 controller and combphy for it.

Applied, thanks!

[1/1] arm64: dts: rockchip: Add PCIe 2 nodes to quartz64-b
      commit: cd4e5f30f51f1066170a7c5f267cba6f062213e7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
