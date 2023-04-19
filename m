Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137776E8104
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjDSSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDSSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:13:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12CE53;
        Wed, 19 Apr 2023 11:13:15 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C03436603252;
        Wed, 19 Apr 2023 19:13:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681927993;
        bh=5wpEqApFj1eBs4XebojD3UFFhW8LqZtfNsukti4eYVw=;
        h=From:To:Cc:Subject:Date:From;
        b=f4q/WG/Xw2/G/I+j2N7iQoS3HKjpqf7X1jlqefn7/IXVL6bnt30k0+o9D8gN/CW0w
         xSTD9XtpZ2G1vE2Jdyh+5H2KXEE5e2yfEF+3VGnEyP+sH3CR5gzdGaYFLBK+hMDZCP
         KkCGSw5L8qSy00WRUCahRTGilVjBs2XqjXKox7S/D87TXxFttXwWqS8bxv1uYkmAQx
         ys9+r+Q8CUVXa8pEZWuroYPIifiIGwbQFx5OUfhXcKb99UtvpUEUkbzjS0+cdYmlj/
         xQWBmlVMg500CETIe3uF1ufZqD+nXkU4tB95pLJUYwpyRcny95cT2uTLZ7rHzyYJg1
         +v1wWqAvTHeOQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v3 0/3] Enable rk3588 timer support
Date:   Wed, 19 Apr 2023 21:13:06 +0300
Message-Id: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables Rockchip RK3588/RK3588S SoC timer support.
While here, it also handles a minor DT binding issue related to RK3288.

Changes in v3:
 - Updated commit description in patch 1, per Krzysztof's review
 - Added Acked-by tag from Krzysztof in patch 2
 - v2: https://lore.kernel.org/lkml/20230418120624.284551-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Added Reviewed-by tag from Heiko in patches 1 & 2
 - Update patch 3 according to Johan's review
 - v1: https://lore.kernel.org/lkml/20230418095344.274025-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (3):
  dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible
  dt-bindings: timer: rockchip: Add rk3588 compatible
  arm64: dts: rockchip: Add rk3588 timer

 .../devicetree/bindings/timer/rockchip,rk-timer.yaml      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi                 | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.40.0

