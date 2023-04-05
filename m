Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2880B6D852C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjDERqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjDERqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:46:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E174200;
        Wed,  5 Apr 2023 10:46:07 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk7Cu-0000Me-Qh; Wed, 05 Apr 2023 19:46:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Enable RTC support for Rock 5B
Date:   Wed,  5 Apr 2023 19:46:01 +0200
Message-Id: <168071663556.3186456.192019947395019850.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230405082711.46303-1-shreeya.patel@collabora.com>
References: <20230405082711.46303-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 13:57:11 +0530, Shreeya Patel wrote:
> Add DT node to enable RTC support for Rock 5B board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable RTC support for Rock 5B
      commit: 1e9c2404d8870ec08bfc338ae7113c3f7fe0b171

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
