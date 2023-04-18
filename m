Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CA6E5DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDRJxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDRJxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:53:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA42510D9;
        Tue, 18 Apr 2023 02:53:51 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16EC7660323B;
        Tue, 18 Apr 2023 10:53:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681811630;
        bh=/NJxn0jj07PRnWQuDhRCLKMSDEpUWnx1vXPAvpNIRiY=;
        h=From:To:Cc:Subject:Date:From;
        b=ctSgWBJBvh81NE3Wh3VBdnpbh5bi/H+OYBZWgbCfxQs03f5HYw/mLzREjYxX7T8rf
         55b+FyEnL1yo1PEFP9jqPFc3YC/A7ZzhiVd8Utfk3pdwjCHRiHXurzgLf6zOuUKeR5
         xCj2QxTBBgYoVx3yvcqdGeq7e6tsehOjatqxbXIoW6PvOws1Qb5FYfH23bbmP8lVg/
         OTX6iYAy9TNvNiT+shN4ZLu0yVznOkKOEoJNYc+v8HHZrU2qmxlpzuBB4TmhL5HNyI
         TD/wkqKx2UZ6z8B3Sj+FEvl7iJHjVZgEsgVSpkxw7W0mpeXRzcEK+r6eGPAy/+J8ff
         1NQC5s0MBMp7g==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/3] Enable rk3588 timer support
Date:   Tue, 18 Apr 2023 12:53:41 +0300
Message-Id: <20230418095344.274025-1-cristian.ciocaltea@collabora.com>
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

Cristian Ciocaltea (3):
  dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible
  dt-bindings: timer: rockchip: Add rk3588 compatible
  arm64: dts: rockchip: Add rk3588 timer

 .../devicetree/bindings/timer/rockchip,rk-timer.yaml      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi                 | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.40.0

