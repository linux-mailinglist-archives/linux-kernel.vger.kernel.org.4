Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2790F69C9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjBTLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBTLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:30:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F1216338;
        Mon, 20 Feb 2023 03:30:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ei9-20020a17090ae54900b002349a303ca5so983919pjb.4;
        Mon, 20 Feb 2023 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1P9/6aReNdXAKar49I2nURKgXArBVnKjo9gr/F/R4YM=;
        b=OheKix9MsQGFeo1ke3nrz6jBnbxh3nUNpiYiEqKwuQq6pQuo4ir+OzmfKqciNCqpSB
         y8884pqAmNE51J6fxXdkmlXcKkqEm4tjrInY3rkpD7VbQREdpjM2ZZbU6OxdZQRnEVWV
         TYGFGN4GivnCDeWVV1Y+eOYuiwDqjeP4or9MNBXKU/hKPZ7tdLCY6BLR21HOn9c9h9Vf
         DFM+EQaVmK0HWzAk0Y5C12piqXmfqKGJtbcCgqNxxP7h8kmw8yOTFXadO/QaB34GP2vY
         TdkucHj+aCQE3B9VAZEGJHKjwuh1yR4g4ZLB4xGwGYeo6BLJoJAuGJOwdQbGCx6pjhd9
         Uuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P9/6aReNdXAKar49I2nURKgXArBVnKjo9gr/F/R4YM=;
        b=n+MLk35d+sCTmosdVNEtcNVzgIx3WcmnRhrNwRBpv6yyX/V/89OshTIkNeROnT2qMy
         uZr66bhDrvzlLxE4jdxIuiykzXWQq3IvCcuUrlOSunu0qrjbDSXijUd2GRgmj0/6USpP
         eLA7uBkNSMGJbpHdBT70GKAaHlsetpy6EOV8ODQUuZOgXEW+sAAPVoB0kRvUYVrhYh3f
         +pva3/NT7ZMDUjqEDP+Z26FFNP0hm2h5cNMyUYoWJOUYRixdBC9i9ZgpiRnmFc+YaAn2
         cgZePUOSUQoQTrRWllDhfWrPltW2s2NkwX8Oo4SFJ5CdiojZQQ3Y/wt9Cv8lz2Ef3DoY
         Zmzg==
X-Gm-Message-State: AO0yUKXvFYPRShnzFnC24dwNG6uMobU3k/DVm4FNSq4j3QLzpdEmswRc
        XQt6stu41cEzE9DfupvzGt6TE8ZQHn2+YQ==
X-Google-Smtp-Source: AK7set8wGeIaO0DDGtCgyjja7YMqKByomt9SfIQRgGs7K7+3mw/nhFvObj2bfvD0dvFOGLC4hOn/HA==
X-Received: by 2002:a17:90b:1b03:b0:233:d3ac:5dc2 with SMTP id nu3-20020a17090b1b0300b00233d3ac5dc2mr277633pjb.18.1676892641968;
        Mon, 20 Feb 2023 03:30:41 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id c26-20020a6566da000000b004fb171df68fsm1525527pgw.7.2023.02.20.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:30:41 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] dt-bindings: mips: loongson: Add Loongson-1 based boards
Date:   Mon, 20 Feb 2023 19:30:07 +0800
Message-Id: <20230220113007.2037750-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two Loongson-1 based boards: LSGZ 1B and Smartloongson 1C.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../devicetree/bindings/mips/loongson/devices.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
index f13ce386f42c..6ed6e8d1c0a6 100644
--- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
@@ -37,6 +37,16 @@ properties:
         items:
           - const: loongson,loongson64v-4core-virtio
 
+      - description: LSGZ 1B Development Board
+        items:
+          - const: lsgz,1b
+          - const: loongson,ls1b
+
+      - description: Smart Loongson 1C Board
+        items:
+          - const: smartloongson,1c
+          - const: loongson,ls1c
+
 additionalProperties: true
 
 ...

base-commit: 39459ce717b863556d7d75466fcbd904a6fbbbd8
-- 
2.34.1

