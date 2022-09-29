Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF95EF579
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiI2M30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiI2M3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:29:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727C139F51;
        Thu, 29 Sep 2022 05:29:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5DB266022AF;
        Thu, 29 Sep 2022 13:29:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664454557;
        bh=mzK4A3nEDonQc1BysjBR3ZM8qwhDzgu0x5HwihbvINE=;
        h=From:To:Cc:Subject:Date:From;
        b=WGk7GeP5J30XARJXA0uxmgaX80EAmE4INj3OclXjUNrmnEiOChJhU2L6efDMWBgLW
         rqmXtokk6Xt8vuBpsZWsJ1bB3aTyLMXLz9KkCIPhuxJyYgmZztqP7nd9n47TFri5qM
         aLmGQyazgCc1Tqk2yHDezW13uTvaWd/jR/91c0nQ3XVTZFNYYnFRURNKt8uuLDp25i
         Cluxn2EpQC4tz0Lqcl+ovAKlnM+U6ADO0WCzPpXNDE0UW4+QDAP0U4LcE/3AkZCBxH
         OS1LCRExew+PntfbDPAAOE2aSqOvfBTLDIdWSDVShcEB6Z88xLM0F7ErH+BnMkWdDG
         4wUXz3OIRFNzA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] Convert mtk-timer to YAML
Date:   Thu, 29 Sep 2022 14:28:59 +0200
Message-Id: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a conversion of the mediatek,mtk-timer.txt binding to schema.

While checking the schema validity, I've seen that mt7629.dtsi was
declaring two timer interrupts while effectively there's only one:
removing it was also necessary to be compliant with the new schema.

AngeloGioacchino Del Regno (2):
  arm: dts: mt7629: Remove extra interrupt from timer node
  dt-bindings: timer: mediatek: Convert to json-schema

 .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
 .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
 arch/arm/boot/dts/mt7629.dtsi                 |  3 +-
 3 files changed, 87 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml

-- 
2.37.2

