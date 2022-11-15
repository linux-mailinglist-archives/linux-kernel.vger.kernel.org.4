Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00EB6296E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKOLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiKOLKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29367103C;
        Tue, 15 Nov 2022 03:10:29 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1outpf-0007ai-Ka; Tue, 15 Nov 2022 12:10:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
Date:   Tue, 15 Nov 2022 12:10:20 +0100
Message-Id: <166851058430.863884.3049189227884445450.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221106161513.4140-1-wens@kernel.org>
References: <20221106161513.4140-1-wens@kernel.org>
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

On Mon, 7 Nov 2022 00:15:13 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Ths PMIC's interrupt line is tied to GPIO0_A3. This is described
> correctly for the pinmux setting, but incorrectly for the interrupt.
> 
> Correct the interrupt setting so that interrupts from the PMIC get
> delivered.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
      commit: 562105c1b072411c71ac2202410d83ee79297624

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
