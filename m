Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC6EF0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbjDZJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D9A30EE;
        Wed, 26 Apr 2023 02:12:32 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/GYePqlqlLt+stEnj3bUMe/e2dQ5Es2u1niZO91KLs=;
        b=hheFNBhSLKDjVtk6noT21+i9BUgSZsZKeQoy1pv3C1Tstp8snf9S7bavEVtAOUWW/LX3Fv
        MwhLWrRdrUoV7HrGQw3t6+AWwoVzWHnS1Ymcec0+UChIh9zgQKiTQ/s2d5OIdEG7Gd35wf
        fv4oj2vwmpOs+ZCSvlRQQ4g77C2EcuV1jRlIew80ER3RRotSqnKoPR9F0nL1alL7uDFBCQ
        om9625cXQilloxMv0V3IKRzMRFzC6THsu0GgpgdM1m1YfE7CcG3yGKvY+vUS8sL71JzCGZ
        tOHSY3iUloO/OXCNCQrdfJ0ca2zwc7HnM73nTKC4caGmUl5tIKadtTjNSDEAlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/GYePqlqlLt+stEnj3bUMe/e2dQ5Es2u1niZO91KLs=;
        b=kJnnoNZNXM0VKoaM+pVfCz+hLMGnufb5/fV/eLWCZdQB84zM5KPCtCBBfxZZCBWvK4Qcpw
        y5h31f515mAv6iAQ==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: rockchip: Drop superfluous
 rk3288 compatible
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230419181309.338354-2-cristian.ciocaltea@collabora.com>
References: <20230419181309.338354-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Message-ID: <168250035042.404.3359094038204866960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     51010c1dc487e7764b7e1ec1c4954068e5880757
Gitweb:        https://git.kernel.org/tip/51010c1dc487e7764b7e1ec1c4954068e5880757
Author:        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
AuthorDate:    Wed, 19 Apr 2023 21:13:07 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:14 +02:00

dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible

The compatible string for Rockchip RK3288 is wrongly provided in the
'enum' item, in addition to the subsequent 'const', which allows the
usage of an incorrect specification:

  compatible = "rockchip,rk3288-timer", "rockchip,rk3288-timer";

As the rk3288 string is also specified in the top-most 'const' item, the
binding already allows the usage of the correct variant:

  compatible = "rockchip,rk3288-timer";

Drop the unwanted rk3288 entry from the enum.

Fixes: faa186adbd06 ("dt-bindings: timer: convert rockchip,rk-timer.txt to YAML")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230419181309.338354-2-cristian.ciocaltea@collabora.com
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 65e5983..2bdb6e6 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -23,7 +23,6 @@ properties:
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
-              - rockchip,rk3288-timer
               - rockchip,rk3368-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
