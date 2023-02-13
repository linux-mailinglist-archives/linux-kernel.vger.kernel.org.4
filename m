Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D86694F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBMS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D072127;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18akg3o+FmGtMbSMT3mc07aIvCAO9Z6Wui8upHi2WQQ=;
        b=EGUbY8mAfpTk6/hYo12jUNJJ/IeFDSTORGk5KqLX+C6g+4+4bIuOsLYgb4kB3Brrb+L7HM
        NhjzETAk92b0goouvIqde5ucvK30aBfmJx5AOefO1S+mGLx12ujlyMcS2bdFpcl/T07Bn0
        BRPv+2OK1DLnTzN0SqGoE6l8OxJPBDrHA8fnxTYoEFTPTlI9/xdgRZIveQ3ph94+pmGlGS
        hwws4uETNeLe4qRAkz+BBBh59TOi7BWqd3hyBFhkQV+dwNhjHiXq+VuSVA2yYOGklKy0k5
        my38/Qty0ELTaK0KG83sRGPAfyXQ5wKzGrYMbb8bg/kWcVaXAkMlMqsrWKmJLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18akg3o+FmGtMbSMT3mc07aIvCAO9Z6Wui8upHi2WQQ=;
        b=0YizqaKF+FExyqg553UW8uWc+FFaNtHJM4zvCvKGZbMHlVF5D7enOetzSuRHpzVMyrphQe
        pDdqPrxjRdZXF2Dw==
From:   tip-bot2 for Bernhard =?utf-8?q?Rosenkr=C3=A4nzer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: mediatek,mtk-timer: add MT8365
Cc:     bero@baylibre.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230125143503.1015424-8-bero@baylibre.com>
References: <20230125143503.1015424-8-bero@baylibre.com>
MIME-Version: 1.0
Message-ID: <167631278337.4906.9636825546029750986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     27788e01a6507c882946b9aa87318c3185cd83e6
Gitweb:        https://git.kernel.org/tip/27788e01a6507c882946b9aa87318c3185c=
d83e6
Author:        Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
AuthorDate:    Wed, 25 Jan 2023 15:35:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

dt-bindings: timer: mediatek,mtk-timer: add MT8365

Add binding description for mediatek,mt8365-systimer

Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230125143503.1015424-8-bero@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b=
/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 8bbb6e9..b3e797e 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -33,6 +33,7 @@ Required properties:
=20
 	For those SoCs that use CPUX
 	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+	* "mediatek,mt8365-systimer" for MT8365 compatible timers (CPUX)
=20
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
