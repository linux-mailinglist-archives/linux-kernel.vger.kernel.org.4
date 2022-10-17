Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B725600F42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJQMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:34:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690CF1DF06;
        Mon, 17 Oct 2022 05:34:48 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okPKM-00087p-Ks; Mon, 17 Oct 2022 14:34:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: enable pcie3 support for rock-3a
Date:   Mon, 17 Oct 2022 14:34:33 +0200
Message-Id: <166601006783.173248.8896110075615281181.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221006152524.502445-1-amadeus@jmu.edu.cn>
References: <20221006152524.502445-1-amadeus@jmu.edu.cn>
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

On Thu, 6 Oct 2022 23:25:22 +0800, Chukun Pan wrote:
> Changes from v2:
> * Removed changes to pcie2x1 node.
> * Collected acked-by and tested-by.
> 
> Chukun Pan (2):
>   arm64: dts: rockchip: Add regulator suffix to rock-3a
>   arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add regulator suffix to rock-3a
      commit: 49665ab0ed5eed4fa7b8a6b236ff2df681c89673
[2/2] arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
      commit: 0522cd8112204d124d714eee7e9f0cac6de999d9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
