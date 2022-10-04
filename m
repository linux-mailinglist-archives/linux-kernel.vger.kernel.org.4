Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5A5F3FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJDJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJDJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:28:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987942E9F9;
        Tue,  4 Oct 2022 02:27:30 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/3N0A7uL8s/m0sqzLpMnNer5zg4GzZHXs0Vtv9jjek=;
        b=GYS6CETEZym7e/2JoXdlO4MVdcH3ty4ynM7H4BWIvr9wcXZUMw7ShOH1zObqRbQk9dWV6p
        0A4jjGihq6jYhlwlgMu6IRHt2XbOKmpQ71lpx7wmxl+jYGHuvnmf5OPUGiTxJew+qGUfWq
        do+OG4h/pO80pWxZrk/pcfKB1eTvRYLdr6DCFqNK9n72XciI7D+NxBICYVfqNZBZFrPcuF
        Knm5RaM4EMtJii4yzOYlzZFbmxDOGncNcCUEBS2jnuLQsifECn6xfi75bQODxEA7hMWBQm
        drXjJEqqjTAjYSGSwvf2X20zg8XBPSotavPofTOVsK2K+zaXdAqUQnaX5GO7TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/3N0A7uL8s/m0sqzLpMnNer5zg4GzZHXs0Vtv9jjek=;
        b=w31Gm9Yb20Q7998J7Rezm7BM5hmNkQVN3WBvYhaWHbomiK5yksWXAWJsZw+HU67uGUPq0G
        YaDJy7ze9TicSrDg==
From:   "tip-bot2 for Johnson Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add compatible for MediaTek MT8188
Cc:     Johnson Wang <johnson.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124602.20394-1-johnson.wang@mediatek.com>
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Message-ID: <166487564807.401.5601837078988190598.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b830774c7e4168997ba42deb186f72e6a845742b
Gitweb:        https://git.kernel.org/tip/b830774c7e4168997ba42deb186f72e6a845742b
Author:        Johnson Wang <johnson.wang@mediatek.com>
AuthorDate:    Thu, 18 Aug 2022 20:46:02 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 19 Aug 2022 11:06:54 +02:00

dt-bindings: timer: Add compatible for MediaTek MT8188

Add dt-binding documentation of timer for MediaTek MT8188 SoC
platform.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220818124602.20394-1-johnson.wang@mediatek.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index f1c848a..8bbb6e9 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -25,6 +25,7 @@ Required properties:
 	For those SoCs that use SYST
 	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
 	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
+	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
 	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
 	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
