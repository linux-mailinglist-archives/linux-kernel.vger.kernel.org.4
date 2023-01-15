Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4066B1A1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjAOOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAOOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:47:09 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC8125A4;
        Sun, 15 Jan 2023 06:47:04 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pH4He-0007bK-3g; Sun, 15 Jan 2023 15:46:54 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jensen Huang <jensenhuang@friendlyarm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add missing #interrupt-cells to rk356x pcie2x1
Date:   Sun, 15 Jan 2023 15:46:50 +0100
Message-Id: <167379396101.36245.10680301028456952223.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113064457.7105-1-jensenhuang@friendlyarm.com>
References: <20230113064457.7105-1-jensenhuang@friendlyarm.com>
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

On Fri, 13 Jan 2023 14:44:57 +0800, Jensen Huang wrote:
> This fixes the following issue:
>   pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add missing #interrupt-cells to rk356x pcie2x1
      commit: a323e6b5737bb6e3d3946369b97099abb7dde695

Moved the new line to a better position inside the node
(similar to the pcie3 on rk3568)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
