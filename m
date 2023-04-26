Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5586EF0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbjDZJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjDZJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637C40D5;
        Wed, 26 Apr 2023 02:12:32 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5E8r+mpV6hNShoIpBNm6cf6Wjd966RrW0Yu/pa9fiv8=;
        b=qdoJRXLgoYOUJK9XY+z/dMeRNd5PQeVDLjKmtBWlXfqmJl06HMW/G7akzeepcpb3I8beL6
        f90AO1mpZkKnhsDJ/bfUQKx8UWo64G3sJDhEoGi+kJqaq+hhPVQB6Ziwe5jhGdXWoCZLj7
        wZvnArapHFYNCssyZBwzFEXzbttv3EE50nm+NyScBVuPXLaKNMSGXqomKSrDUC2LKDvhlX
        5FENIKb7L2QwQZB+kd49VVrk7buNRU+7c4/8MBovOQy/S0HESCQqSz/beQD49zFM50/WT8
        NobAUvhB1UcsOLAUngZd4nUzrzmO6fcXRcwoxrnVVwlzCRct126NeTiSJtjcuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5E8r+mpV6hNShoIpBNm6cf6Wjd966RrW0Yu/pa9fiv8=;
        b=c52a+ujw3bs2R0LzLY2Fe/YuG0RkheFlHtnGPbzIrrjy8bzyzPqBZNdVybmfQwwNXTJAHE
        XUaW8Sjg53/SepAA==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: rockchip: Add rk3588 compatible
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230419181309.338354-3-cristian.ciocaltea@collabora.com>
References: <20230419181309.338354-3-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Message-ID: <168250035005.404.16490340426651738170.tip-bot2@tip-bot2>
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

Commit-ID:     e2a1406c84c43bd104e2f85c4d8ab0b0b1609ab0
Gitweb:        https://git.kernel.org/tip/e2a1406c84c43bd104e2f85c4d8ab0b0b1609ab0
Author:        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
AuthorDate:    Wed, 19 Apr 2023 21:13:08 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:14 +02:00

dt-bindings: timer: rockchip: Add rk3588 compatible

Add compatible string for Rockchip RK3588 timer.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230419181309.338354-3-cristian.ciocaltea@collabora.com
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 2bdb6e6..19e56b7 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -24,6 +24,7 @@ properties:
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
               - rockchip,rk3368-timer
+              - rockchip,rk3588-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
   reg:
