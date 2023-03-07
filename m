Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB37C6AFA99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCGXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCGXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:37:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46026A92D6;
        Tue,  7 Mar 2023 15:37:17 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pZgqP-00025h-E6; Wed, 08 Mar 2023 00:35:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3588: Add sdmmc node
Date:   Wed,  8 Mar 2023 00:35:35 +0100
Message-Id: <167823207786.205469.9201588450242165959.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230228103610.25108-1-lucas.tanure@collabora.com>
References: <20230213152740.359055-2-lucas.tanure@collabora.com> <20230228103610.25108-1-lucas.tanure@collabora.com>
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

On Tue, 28 Feb 2023 10:36:10 +0000, Lucas Tanure wrote:
> Add SD Card node for RK3588s and RK3588.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588: Add sdmmc node
      commit: dbe406d1397ffccd4a0f85daef456291f265505a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
