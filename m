Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21A74F2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjGKOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjGKOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4610C4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:48:50 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJEfY-0000LD-Fs; Tue, 11 Jul 2023 16:48:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: rockchip: grf: Fix SDMMC not working on RK3588 with bus-width > 1
Date:   Tue, 11 Jul 2023 16:48:44 +0200
Message-Id: <168908688813.1964886.12363086739056642575.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619011002.2249960-1-megi@xff.cz>
References: <20230619011002.2249960-1-megi@xff.cz>
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

On Mon, 19 Jun 2023 03:09:58 +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> RK3588 has the same issue as other earlier RK SoCs. JTAG
> functionality muxed to some SDMMC data pins causes issues with SDMMC
> interface. Without this patch, I can only use SDMMC inteface
> with bus-width = <1>. (JTAG is muxed to data pins D2 and D3)
> 
> [...]

Applied, thanks!

[1/1] soc: rockchip: grf: Fix SDMMC not working on RK3588 with bus-width > 1
      commit: 8813520a80efe3e7d280637bb1d47a9d473fd24d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
