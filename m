Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687CA74EC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGKLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC211D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C8661485
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A945C433C8;
        Tue, 11 Jul 2023 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689074731;
        bh=tl42imHbEy3iWRjfOyFYAww8EzIJLYW3adn6yI+iI5A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pdLMUjBBFpHSm+6DzrqywRJmyFzvfBynyUZGFV8/mI/kjC4/YD9N5IMv08JrPjqKo
         qHcmW8M4c6HQgZ4wb/o0ssNqQiR5Fim4HIPxsKWSa74WKkKaGDt2ocdtwakBe0E24D
         kujpBoanjjoA8/wpp/WUIGfE9ZsiovIgJYeIy5aXqXNra7ua3+in9vF7FZC2a0zdVo
         HMkrCeXynIPSpbYY+UMgj7gz9nwDdjom7uNGfqF4iQ0ZxCniJFXPUVXt7W9xLpcdou
         grIk7g//vtph81R8BMlkLyF490ia1Na+q96mcsHi645h0E/McQxaMGdBLvrgrQRovK
         4Knalx9Lbl5tg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Alex Bee <knaerzche@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230615171005.2251032-1-jonas@kwiboo.se>
References: <20230615171005.2251032-1-jonas@kwiboo.se>
Subject: Re: [PATCH v4 0/6] Support more HDMI modes on RK3228/RK3328
Message-Id: <168907472889.198426.9725171817617360411.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 16:55:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 17:10:15 +0000, Jonas Karlman wrote:
> This is a revival of a 3+ year old series that never got picked up,
> it contains fixes and adds support for more HDMI modes on RK3228/RK3328.
> 
> This v4 series contains the original v2/v3 patches targeting the inno
> hdmi phy driver, the last patch that adds support for more HDMI modes
> has been replaced with a new patch from Alex Bee.
> 
> [...]

Applied, thanks!

[1/6] phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
      commit: b98121a164bf4cc27dbf8a9cffd9f9e1b36dd9af
[2/6] phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate
      commit: 8d2b1b97536d471ffce3f906146038dcf321ca39
[3/6] phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
      commit: de25702be8fb7b822ae509e9d75413ed637cd2eb
[4/6] phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write
      commit: a52df75a83e8fc322ab9383aeb4945329f9069b4
[5/6] phy/rockchip: inno-hdmi: force set_rate on power_on
      commit: 5bfc7c86bc45978f848f08fc483f57d4ecb5ebd4
[6/6] phy/rockchip: inno-hdmi: add more supported pre-pll rates
      commit: 35e7d0e3e1fa7ff94a9f82ea643d12b5c8099040

Best regards,
-- 
~Vinod


