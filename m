Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E75F042E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiI3FN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiI3FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:13:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7F154448;
        Thu, 29 Sep 2022 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=EpyJR1O+18IlesRb1sVxkR2L/tT+4AYzN+FinO47AbI=; b=ZdNxBDaGzRZRVvevF+crC2ukEH
        JM3+800dHLclZWsuDVo+v05NhK9QguDiTLB59afD19PT7dMm1T0wPHIx/mfIp5z+kPMm3may05vS8
        9p0UJzWQLa+4tTejAMUeujLxydrvZDP/4yY7PxqEZZfAIwI8kuZxRGSEZ6zdXhPsqUN76ckGDZBBv
        vp32aSJGPRC9wjzkgcRtv5OzSH+1OsQQFrIBTvmVa/KcaYh1S+FlpAGhBU7qyF9xBiaxrURfiPjql
        tmM9ejBVWCXmLnOklaQnxnsITGvfpurDnxjNwjuvTBWS+NGdkthWnxvNVmUPIUjI3rOgFAD6BveZX
        qXoAEvNA==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kc-00Dje4-0V; Fri, 30 Sep 2022 07:13:02 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kb-001duJ-1d;
        Fri, 30 Sep 2022 07:13:01 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dan Johansen <strit@manjaro.org>
Subject: [PATCH v3 01/13] dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
Date:   Fri, 30 Sep 2022 07:12:34 +0200
Message-Id: <20220930051246.391614-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930051246.391614-1-aurelien@aurel32.net>
References: <20220930051246.391614-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongjin Kim <tobetter@gmail.com>

Add device tree binding for Hardkernel ODROID-M1 board based on RK3568
SoC.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Dan Johansen <strit@manjaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149c..a704d5389a82 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -432,6 +432,11 @@ properties:
           - const: hardkernel,rk3326-odroid-go2
           - const: rockchip,rk3326
 
+      - description: Hardkernel Odroid M1
+        items:
+          - const: rockchip,rk3568-odroid-m1
+          - const: rockchip,rk3568
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.35.1

