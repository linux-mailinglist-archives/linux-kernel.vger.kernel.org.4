Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0126E1F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDNJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:34:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3396A54;
        Fri, 14 Apr 2023 02:34:17 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AEAD266031C6;
        Fri, 14 Apr 2023 10:34:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681464855;
        bh=M/Zt0EOj4LIQThEVbo30D78JWsDa3kNHxL7hcZHzi7E=;
        h=From:To:Cc:Subject:Date:From;
        b=Cd+LSSJOIQjJv3zflq8yIMpr4TqHH4Vg/BU0QGb+No+eNZb85JFOUKiIXXDgjZ6KJ
         p8Y1xm94v5VDfaSECLXmVnJ9BZJrGx1cpn1DCz5HzBQPg7MvyTLGpyTUkgc0yWpk4l
         9HGwIgFZxjxtUzdcMCmkpvj6u6xPOEu9mLiPzeGru+jPQhuKmlQiazYPaX9e3Gs8uC
         TDJ5E/LNd9SMyMHMyKIROB0nnBzb844wJ0C5Eypc7/hkm7ccftOG7HPiv7B6gd904G
         cyD9b1mHDyAzAc6FpQk25LgBN7RxwIUkwHcFhtoxP2Z/2wnoAl7OpyoHrKgw8kEMVn
         C5WNCmQoRWo4g==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/3] Add regulators to Rock 5B's CPU big cores
Date:   Fri, 14 Apr 2023 12:34:08 +0300
Message-Id: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU big cores on the Rock 5B board are powered by the RK8602/RK8603
regulators. Since the support for those regulators has been recently 
merged via [1], add the necessary device tree nodes and bind them to 
the corresponding CPU nodes.

Additionally, provide a couple of unrelated DTS fixes/improvements.

[1] https://lore.kernel.org/lkml/20230406194158.963352-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (3):
  arm64: dts: rockchip: Drop RTC clock-frequency on rk3588-rock-5b
  arm64: dts: rockchip: Use generic name for es8316 on rk3588-rock-5b
  arm64: dts: rockchip: Add vdd_cpu_big regulators to rk3588-rock-5b

 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 59 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

-- 
2.40.0

