Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA16E7EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjDSP44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjDSP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:56:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4376189;
        Wed, 19 Apr 2023 08:56:52 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ppAAc-0003JF-Ra; Wed, 19 Apr 2023 17:56:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marc Zyngier <maz@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: (subset) [PATCH v4 0/2] Add Rockchip RK3588 GIC ITS support
Date:   Wed, 19 Apr 2023 17:56:33 +0200
Message-Id: <168191977930.4131912.6423526852468293382.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230418142109.49762-1-sebastian.reichel@collabora.com>
References: <20230418142109.49762-1-sebastian.reichel@collabora.com>
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

On Tue, 18 Apr 2023 16:21:07 +0200, Sebastian Reichel wrote:
> This adds GIC ITS support to Rockchip RK3588, which is affected
> by an integration issue effectively breaking shareability support.
> PCIe2 support will follow in its own series.
> 
> Changelog:
>  * Changes since PATCHv3
>   - https://lore.kernel.org/lkml/20230417214035.101190-1-sebastian.reichel@collabora.com/
>   - Add RB from AngeloGioacchino Del Regno
>   - Update patch description
>   - Update Kconfig description
>   - rename flags from BROKEN_SHAREABILITY to FORCE_NON_SHAREABLE
>  * Changes since PATCHv2
>   - https://lore.kernel.org/lkml/20230417150038.51698-1-sebastian.reichel@collabora.com/
>   - apply changes requested by Marc Zyngier
>  * PATCHv1
>   - https://lore.kernel.org/lkml/20230227151847.207922-1-lucas.tanure@collabora.com/
>   - uses of_dma_is_coherent() instead of providing errata info from kernel
>  * RFCv1
>   - https://lore.kernel.org/lkml/20230310080518.78054-1-lucas.tanure@collabora.com/
>   - uses 0x0201743b IIDR for quirk detection and misses errata #
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: rk3588: add GIC ITS support
      commit: 9325c119312ce7e228216c1070fbaaeb96f7afcf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
