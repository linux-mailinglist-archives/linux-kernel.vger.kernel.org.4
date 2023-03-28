Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138F6CCBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjC1VBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1VBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:01:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8582137;
        Tue, 28 Mar 2023 14:01:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDE376600011;
        Tue, 28 Mar 2023 22:01:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680037303;
        bh=k91HPwR7LcyzejO9VePWYMNLZezHnwPxhbbY3jkeELg=;
        h=From:To:Cc:Subject:Date:From;
        b=DUVBG5X1PLkrNcuuYwG4HcgQg+BgtNR2sdGVBkQCKm7EqGGW/2iN/OWje09QSYduh
         oCb1JpNgq9yD5mVD1kZQYl8ua/AKVbh8MgYCF1JR7uNS5bMNww3sU1HGCtP0CE63lV
         ngiXiUuHNB3Krovc4RNGJ0qmY6yuZsYOD0E0UOxqUtAFjB8Iy7VimAbEBD9qFYZC90
         sD3lbdGQxorhTbkM1GUrkpmEWrLMbNUVE993fvEBpw2AmS48uU0F662YdPdfS9OF3r
         C+GFXumJsRCH00rp6MEvLEzCpCSPoye4ZhOqzgy0fXzLCHt4Py1v7cPCE1tDrwfSe7
         X/kEHiIwySo+g==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jamie@jamieiles.com,
        heiko@sntech.de
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 0/2] RK3588 watchdog support
Date:   Wed, 29 Mar 2023 02:30:46 +0530
Message-Id: <20230328210048.195124-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables watchdog support for RK3588 and updates the
DT bindings for the same.

Shreeya Patel (2):
  arm64: dts: rockchip: Enable watchdog support for RK3588
  dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt string

 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml         | 1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi                 | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.30.2

