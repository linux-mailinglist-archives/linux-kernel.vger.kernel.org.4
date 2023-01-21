Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483B86765FC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAULYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAULYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:24:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7F1A978;
        Sat, 21 Jan 2023 03:24:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z11so9556207ede.1;
        Sat, 21 Jan 2023 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKJUg2/VuVaRDNmWxbhDG78UOqpMzcjPsE81MatemVY=;
        b=hLuurZpQAzMNhhxxtWYP5opWmKzAHQ+BNF3HA1f+KqlnBpS2y0v9dg6MetfkqzcBxs
         rr9uKrN6qY4JDVESqfbQmOhKsreO2P/pwmgQOYrxLaBSSs1KfVGX5QJAJEJuqjGUGEkp
         znkzgPBL4fktfDEFatax7h0rtDMBiHgJlPLoBH3qUfKsOB3W8NFVWrXSucbQSONY7AID
         ZBXFA/tbIY7IGu+AxoYHt/r2UO8ZAxsRK+bkLpECFif3asBe/YOQ2gV4YMkFP/cIPSGC
         I8h5qV7EvogXyR1gVSjihDkPUc1xH5hwPKU5t/Dt4IY/4dya1ABUkRHV3iayYbQXYWpX
         KrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKJUg2/VuVaRDNmWxbhDG78UOqpMzcjPsE81MatemVY=;
        b=LulhXJVcMsvUw6vavFcYyNK7Bak4wXa9a1itdWyQehncfRlioYvxq/3uU3z2ROhpLn
         yljnoSAjnxUIoCgiRGIXn84oPpQO4bSuFdTOs9v9l8Ute03zKnMe1wyflcBf3FXrS8Pl
         ga8I3U7Qb6TMBNtHy0nAeu+QpC5sA6jSpKRx7WHWXbdvc3MmU07SCWV+jR+6yaTjYI60
         CMIfc0ChjSAGPb+8JDcX8eJQgniNRO+6sai/dPLY4BtNUvGEEwGQ3SEH7r9yZIMU+o1D
         fHKvySbBbURkcYFrjAS7ynC3xA4arYPAaSSQnbmLGeDnakC85+u7vElNGnvugW492wAl
         TBEQ==
X-Gm-Message-State: AFqh2krQtrz8JATOmStK9e2+MQfQuev6Es5uEkpkEbR/vX7XQt5j0OrL
        OiKJcdeB2ohDb4BjLfrfGiU=
X-Google-Smtp-Source: AMrXdXtvmvbZPiSoWOpKrKOb779VWpXPyMwSmkpiw/lM80k1Mopbk7SIpEaFVkETG8kPVVerDiRCcA==
X-Received: by 2002:aa7:dc03:0:b0:49e:1d4f:a9f0 with SMTP id b3-20020aa7dc03000000b0049e1d4fa9f0mr18291487edu.42.1674300242356;
        Sat, 21 Jan 2023 03:24:02 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170906319500b0086faa5b06d4sm9236365ejy.181.2023.01.21.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:24:01 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Sat, 21 Jan 2023 12:23:57 +0100
Message-Id: <20230121112358.52216-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Document IPQ8074 compatible for QFPROM, its compatible with the generic
QFPROM fallback.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 9ddf3cef9e84..2173fe82317d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
+          - qcom,ipq8074-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.39.1

