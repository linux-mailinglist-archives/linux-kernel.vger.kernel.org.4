Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9936660B69B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiJXTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiJXTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:04:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF71635C4;
        Mon, 24 Oct 2022 10:43:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 13so6783138ejn.3;
        Mon, 24 Oct 2022 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5dEsEgZ/MYkIBk3aJrt65fnhNjkvgLRnG0jJQz6jDU=;
        b=PjjgvEElO5osAliUOTVCQFOeYjdHlXiKcham5vx71LuYRj+RmHWNdn9pEE/ginrQNq
         G9dgaeQbeQC7xAE25//AGEvtg+bULsZDBTPSfh1ruBtyxXdVYmNkN4/aQlk0PSCeRK6w
         mVib5hbS9abLD8TZuMs49Iz2iWipNw4kf8iFuuky3v9agrwgqwPUlmcK2qGklTzJBHRh
         TE5jqtpFuuEpweTrUUrPbul0SRpLKoUwd17GGcNHlSMdmuQgzqo1cJpatTGZtfFAoIsX
         QjLVKJxKWqd/CWsKE0umP1xKonYHRv6xzCnQY/q+D6F9pxHPUkWvPQLx09YJ8McqAbQI
         g1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5dEsEgZ/MYkIBk3aJrt65fnhNjkvgLRnG0jJQz6jDU=;
        b=GaYnukHF/pRxiaDNYlrviu0dRPxsKmTRUr3ziFhQg9PheiM59A0sWeTWepyunUvMo0
         8ADsG5Ah2A/7MztuqoHTW+aXowBbYsch+2aCFqLsPLKEDcTG2fJXj4Zy5hWB1JzATcLQ
         Q2EdScDSbRA5GWSJgOEiQSJsmRQb3L5Y+ujhoEQOujeyKnFQcAWTKKMomQ/9zXpWORlQ
         4XUPiYOq4ed4ubS+fdty07t8vTM4w2gbxMQbwyih8BEp+zKaooyvBbbCjTS2HUK3hSMI
         YsVQvJLo5R6zu5iuAaMiXLiVnDEGPeUbteGBIqjoItQuuZz//JW5srspKh71w/RjFb/2
         aYNQ==
X-Gm-Message-State: ACrzQf3/7MEAPnVexma0LzflvqZ/eviiIhAJe5fu89bPjI6IhSblhIMn
        FuUjxczhtzAopw/SP4ToQ/CLOL2gaxk=
X-Google-Smtp-Source: AMsMyM7XPS+4QTEj+9w9kdtCBaOiJDGH58pvqCRCzZSYhUnYOAOEaECdyDqMrPlKKAhxZPPZJVW+WA==
X-Received: by 2002:a17:907:70a:b0:741:78ab:dce5 with SMTP id xb10-20020a170907070a00b0074178abdce5mr29052090ejb.527.1666633345683;
        Mon, 24 Oct 2022 10:42:25 -0700 (PDT)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id v7-20020aa7cd47000000b0044bfdbd8a33sm195278edw.88.2022.10.24.10.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:42:25 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Mon, 24 Oct 2022 20:42:20 +0300
Message-Id: <20221024174220.1649910-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add xiaomi,sagit board (Xiaomi Mi 6) binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v2:none
Changes for v3:
- remove unused 'sagit' compatible line
Changes for v4: none
Changes for v5: none
Changes for v6: Start with capital letter and finish with full-stop
Changes for v7: none
Changes for v8: none
Changes for v9: add Acked-by tag
Changes for v10: none

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..294075bafb97 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -239,6 +239,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

