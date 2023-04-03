Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208446D4287
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDCKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:51:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A8B75A;
        Mon,  3 Apr 2023 03:50:59 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F10366016BD;
        Mon,  3 Apr 2023 11:50:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680519057;
        bh=3qEFOeZjSFPDZuAih2rvjo48GXJkxFBE9+hVoCCPrnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=odTpCRqf5S76SzsIo9CrCJ4Ad+vpG5atWQ6OFJaf9Y2+icWyTyQGYYovNFoFZXpOU
         HrYkU1S4sBggOgpSt6VybMeiKtthEVYTWzS6g0Shda9yU4pm+e4Olc8Vk7HLZ5pA5i
         qVlLESS3X2VjjAy3x2cYdhZej/32yzouBxtvp9LvvWGIOFvAWbQkhkH0ZlWJ7BeFey
         Pbr7clShVr4iN6JsTA2zch8psDSK6Tx8kj8Eoyw/WFLls+1Jnmz4BU4Ge9RWTEwI8D
         j/mbUXPU4lusuJxrFJXDdxQmWPIIs0ZAbuYvVDxH7FFSxi9SnvAoLrIRR5y/rR9ZFv
         Lk5mzaQAmzWYA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/2] Add PWM fan support to Rock 5B board
Date:   Mon,  3 Apr 2023 13:50:50 +0300
Message-Id: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
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

Cristian Ciocaltea (2):
  dt-bindings: hwmon: pwm-fan: Convert to DT schema
  arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan

 .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
 .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  12 ++
 3 files changed, 122 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml

-- 
2.40.0

