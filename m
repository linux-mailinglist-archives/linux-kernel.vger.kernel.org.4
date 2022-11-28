Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF8963A76D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiK1LyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiK1Lx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:53:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017AD64F3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:53:59 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669636437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKfncnLF0HwHvAnkTKJcH7GL/ab2JfZMuDBxMekw1Vw=;
        b=vqe5gmtNZUwDU7NtobOsTkW6OuxcihMbaghfW9ux77QdVTZEq3qLCByrJj8E7sH5CBUjaj
        L5OfGRH2aRQR0TGjF3lWpvN5m6hLbeM43MP00WKf1W8TIKzozPjc7L+6FAG/eKzcQFk291
        pGRFo56ni/czJaBN7pFoGzIJuW9aK61TLYy1FIlt3xKAL5Jd+7bCsJNu0SuNjGvQSJ+v6L
        gNG6RTHES2LpcK2MgK9hr9Su1mIECb0kR+wFT9D0g/sXYqL2aGgRvi/DI1At2AyD/rqRIg
        Ft2EDNGp6DSQtAvr7HJFsVI6WO1Sq54DyR9h8LbHYD151PkOnofc7thuQjN2/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669636437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKfncnLF0HwHvAnkTKJcH7GL/ab2JfZMuDBxMekw1Vw=;
        b=PFDmZOOP2y/fnrCr1aRtjh4sMmzsW/k5r0pWvX9nBB8k3v3XsW3GN7hQfV+Eb7JlmyxzKh
        G/b3KpFtPlpMVuDQ==
From:   "irqchip-bot for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 mediatek,cirq: Document MT8192
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221128092217.36552-3-angelogioacchino.delregno@collabora.com>
References: <20221128092217.36552-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Message-ID: <166963643638.4906.14053199000425811667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     85de640c6b89eb76fc314a3b451d054bedd5e9dc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/85de640c6b89eb76fc314a3b451d054bedd5e9dc
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
AuthorDate:    Mon, 28 Nov 2022 10:22:15 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Nov 2022 11:43:42 

dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192

Add compatible to support the SYS_CIRQ controller found on MT8192.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221128092217.36552-3-angelogioacchino.delregno@collabora.com
---
 Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
index 4f1132c..fdcb4d8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt2701-cirq
           - mediatek,mt8135-cirq
           - mediatek,mt8173-cirq
+          - mediatek,mt8192-cirq
       - const: mediatek,mtk-cirq
 
   reg:
