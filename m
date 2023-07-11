Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075874F2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjGKOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjGKOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC710FC;
        Tue, 11 Jul 2023 07:48:59 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJEfX-0000LD-R0; Tue, 11 Jul 2023 16:48:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org, Furkan Kardame <f.kardame@manjaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org, deller@gmx.de,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        dsterba@suse.com
Subject: Re: [PATCHv4 0/2] Add support for Firefly Station P2 aka rk3568-roc-pc
Date:   Tue, 11 Jul 2023 16:48:42 +0200
Message-Id: <168908688812.1964886.18351380238022459812.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620184746.55391-1-f.kardame@manjaro.org>
References: <20230620184746.55391-1-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 21:47:44 +0300, Furkan Kardame wrote:
> Patch 1 adds the requisite dt-binding.
> Patch 2 adds Firefly Station P2 device tree
> 
> Please review and I hope it is all good this time :)
> 
> Furkan Kardame
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
      commit: a1f814f782c3c7316b42e6fee4022c64da3bdf7c
[2/2] arm64: dts: rockchip: add dts for Firefly Station P2 aka rk3568-roc-pc
      commit: 007b4bb47f44ad1f2290b3bebfd1fac3822c9b23

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
