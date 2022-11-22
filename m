Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90CE634A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiKVWe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:34:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88639C72F0;
        Tue, 22 Nov 2022 14:34:20 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oxbqK-0004DQ-3V; Tue, 22 Nov 2022 23:34:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v2 00/23] Update cache properties for arm64 DTS
Date:   Tue, 22 Nov 2022 23:34:13 +0100
Message-Id: <166915627109.1689466.11523174827505571568.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107155825.1644604-1-pierre.gondois@arm.com>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
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

On Mon, 7 Nov 2022 16:56:53 +0100, Pierre Gondois wrote:
> v2:
> - Update/Add patches for missed cache properties requiring to be
>   updated for the following platforns: bcm, amazon, arm, exynos,
>   freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
>   Missed cache properties were detected using Rob Herring's branch:
>   https://github.com/robherring/dt-schema/tree/cache-rework
> - v1 of exynos, tesla were merged.
> - Updated wrong reference in commit message.
> - Added received Rb/Acked-by.
> 
> [...]

Applied, thanks!

[19/23] arm64: dts: Update cache properties for rockchip
        commit: 848343c0b4d64821aec19b2cff47b58f77362d38

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
