Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166426D6AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjDDRiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjDDRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:38:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9011BC7;
        Tue,  4 Apr 2023 10:38:12 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D66FF660316F;
        Tue,  4 Apr 2023 18:38:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680629891;
        bh=sZFCIz3WQaocYqGt8p6qjyCRTLYO1hDQ2ldahEwFXv4=;
        h=From:To:Cc:Subject:Date:From;
        b=hFHbiL3TJVhsYMuvzK8o18BLOGxDgwWEH81iBBbqrTyGS4mfzVyAX/3+/01lRfh1I
         wLGJmgr1PozqCNMvtbzGlH3o3X9pIiNFq6td/A0VE6678oUhNtnXJJ/KmSkfAaFBS3
         fK04DrX40o8AkUf/mckoZ+Iiq6asgZxEdKmnPD57XSw/ehhi2h1h7aC4exa5tc6zuf
         NNqjwLnT9PMsPbToEyBQ0OHmPYhPN55dOVV2Ha/dwKSqIOayz5oEiF81hYgxQcocXJ
         CcJWaV+PuIuoAGaFVjFgF27CVA5KUhok0C1e2rVH6XG8a4ZNSHFv7e1AxAtuTovzKe
         iLJaptXNdUmUw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 0/2] Add PWM fan support to Rock 5B board
Date:   Tue,  4 Apr 2023 20:38:05 +0300
Message-Id: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
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

This patch series enables support for the PWM controlled heat sink fan 
on the Rock 5B SBC and, additionally, converts the hwmon PWM fan bindings 
to DT schema format.

Changes in v2:
 - Updated PATCH 1/2 according to Rob's review
 - Added Reviewed-by from Christopher to PATCH 2/2
 - v1: https://lore.kernel.org/lkml/20230403105052.426135-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  dt-bindings: hwmon: pwm-fan: Convert to DT schema
  arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan

 .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +---------
 .../devicetree/bindings/hwmon/pwm-fan.yaml    | 119 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  12 ++
 3 files changed, 132 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml

-- 
2.40.0

