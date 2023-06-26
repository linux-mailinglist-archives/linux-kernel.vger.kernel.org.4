Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB773DC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFZK6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjFZK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:58:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F82D3;
        Mon, 26 Jun 2023 03:58:05 -0700 (PDT)
Received: from [185.109.152.99] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qDjus-0000At-P9; Mon, 26 Jun 2023 12:57:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
Date:   Mon, 26 Jun 2023 12:57:37 +0200
Message-Id: <168777705004.859243.8169307365996789856.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
References: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
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

On Wed, 14 Jun 2023 16:47:50 +0300, Alibek Omarov wrote:
> PLL rate on RK356x is calculated through the simple formula:
> ((24000000 / _refdiv) * _fbdiv) / (_postdiv1 * _postdiv2)
> 
> The PLL rate setting for 78.75MHz seems to be copied from 96MHz
> so this patch fixes it and configures it properly.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
      commit: 17c6d0c5f2a4dd3f48e300d77c93780d5c36a37e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
