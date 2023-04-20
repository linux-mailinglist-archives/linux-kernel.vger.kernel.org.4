Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4086E8E75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjDTJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjDTJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:45:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3611707;
        Thu, 20 Apr 2023 02:44:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E314E660325E;
        Thu, 20 Apr 2023 10:44:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681983884;
        bh=68zdNUXDpJ8cN3/P2jWta2FlLdWOTdLtngTHhQNCf+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=mDHqb5aPFBSb6iBFtvaXQENJchILKhe40cIAYr4YP6mXnRq7MDs8i9KloFU+5Gxgw
         RFItZvxuuBafyihdNczuWdqN6ngIDx01l3styj4ozPvtobLyDsY7PLkpv4l5zVq8fv
         JiEaxKOYmyK/pZIoSIxT8v7QrvJmTVeQu1Jda2RaLMY9Mdj7x/aaElL3YB8kNaWtB5
         bpo02cIJnUxYWlpeF8jkAbJ51Ug1gN4NilvT3Eof9oKM01ErYb7JQX05KcOttyaW+w
         W/wcYe0+OiQuwugPYwXHgiKADfKuUK+JYt8xJMIt5Z/NQJF17ijADs/RGf6eQE4Lsv
         sshJhnY85+QKA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/5] MT8195 Acer Tomato - devicetrees Part 3
Date:   Thu, 20 Apr 2023 11:44:28 +0200
Message-Id: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
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

This series adds support for the WiFi card on PCI-Express,
eDP (internal) and DP (external) displays and adds thermal
configuration for the "extra" thermistors present on Cherry boards.

All Cherry Chromebooks now have working display and wireless
connectivity!

At this point, the only missing component is vcodec decoders, but
that's to be done in mt8195.dtsi, globally, not machine specific.
Please note that in this series the eDP panel was put on aux-bus,
hence this depends on the series introducing support for it [1]
in the mtk-dp driver.

[1]: https://lore.kernel.org/lkml/20230404104800.301150-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (5):
  arm64: dts: mediatek: cherry: Add platform thermal configuration
  arm64: dts: mediatek: cherry: Assign dp-intf aliases
  arm64: dts: mediatek: cherry: Configure eDP and internal display
  arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
  arm64: dts: mediatek: cherry-tomato-r1: Enable NVMe PCI-Express port

 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |   7 +
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 164 ++++++++++++++++++
 2 files changed, 171 insertions(+)

-- 
2.40.0

