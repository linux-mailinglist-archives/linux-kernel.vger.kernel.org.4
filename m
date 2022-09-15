Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B25B92A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIOCZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOCZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:25:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5BE28721;
        Wed, 14 Sep 2022 19:25:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r134so13845206iod.8;
        Wed, 14 Sep 2022 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FcCq5/dB7V3R5mFAoswVEVdxTdHGEshi3H6ToSrIfZc=;
        b=nXZjYXKuI8InaINvQFGf0O6l5pLOWovrE5BlFiYToLUzE2rdk7W8IdY8F8qlptRLNP
         7HcVJqrryB+5m6G/L8RM25h29asdAEth3DcIDvdWueTYXspof37QetUVs6lrfNMNphps
         nVdmoazQWSglSi3PJFfnPBVGhQ1vvBZm9ssLnFqtgQxzuxywhyi4T46mgN/8Skh7fD7t
         8lLDaIh2ZEssO0M2Zrgnu59+tJSkX4edEnVJeF0y8Fgct9k19QQf1yjhcOfkGO9SEQuO
         YlTX4uMQgTR6hTqWp4ICA2VoAaXj8fHLbO381u5+pgMR/LxSpR6fyb80qslwvejn8ywc
         KfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FcCq5/dB7V3R5mFAoswVEVdxTdHGEshi3H6ToSrIfZc=;
        b=Mxi+XA8Fr5hOJzGOwpGTzSMKkft7dHjYL3obt4do7fLVlnUDTslIq8zL6fF+oXTmWz
         RK6mUp7ikFlNc7/oQchiS8/sRWyk4f50Gxn1Qbkf5p59SfXzaxj4jALljrrzu0NmMCTn
         +ZmINA2/ARyLRjQmPfImaDd8RE2BzrE7GgKEckfHqIM3Wzk+tCvWZIS9lBqd+/AIdxZ0
         Iv/yQ+vN1MV+jUz3T7tORIsexDvElemHGJNFoqven+Pg9qe1B1tmmY4/nRmCYZYBJ9Jw
         ER1X1rDVZl0rS4/LTrHHuhppwHoS1fB0dkpprJ/AhIiF2T1ps4mKzhZEpbYHrFSoa2W/
         5wNw==
X-Gm-Message-State: ACgBeo2ZErSgQbNUc+IFyjw3zGiiKGlxoc2k6zBwgKMmaus4RJHU2KWM
        t7+yffCMWkgwxUXh7fbIpMo=
X-Google-Smtp-Source: AA6agR7UeT2Gsj8eCA5eJVM1A4mdD0avDGF633frBeNVkt98hM0mKYl/ldPoEiX6F4mEf7GrbROAHg==
X-Received: by 2002:a05:6638:488d:b0:356:72f3:1c83 with SMTP id ct13-20020a056638488d00b0035672f31c83mr20134847jab.307.1663208717591;
        Wed, 14 Sep 2022 19:25:17 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056602072300b006a11760aebbsm7238461iox.36.2022.09.14.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:25:17 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S Enterprise Edition
Date:   Thu, 15 Sep 2022 10:25:10 +0800
Message-Id: <20220915022511.4267-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220911040628.13774-1-cnsztl@gmail.com>
References: <20220911040628.13774-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R4S
Enterprise Edition.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149c..309f76b803a5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -151,6 +151,7 @@ properties:
               - friendlyarm,nanopi-m4b
               - friendlyarm,nanopi-neo4
               - friendlyarm,nanopi-r4s
+              - friendlyarm,nanopi-r4s-enterprise
           - const: rockchip,rk3399
 
       - description: GeekBuying GeekBox
-- 
2.25.1

