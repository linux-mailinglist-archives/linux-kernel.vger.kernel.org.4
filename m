Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059CA629027
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiKOCzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiKOCyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F213F08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m22so32850902eji.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMatkpXRBfYZcOpwK4gKTH0eFwLe1XO/MVtN1h01A6s=;
        b=pRx3zIId767gjM7NXVu8V8PmGqYcR/4i6pri81J2dVsTmGdFdrOVQS9XriPKKLrM2J
         HcM20wGyaSiFQ8RMvwo7QxPuGX3QZa+wzUO2vp54uCA3+kTb98+EbYTsOfCDZCb73VXR
         CV67lwPGw3xS5VvxUMJsPuI/U5112u40Ltq6VsXTZ3VOQJBT8fsLEmFmbyNaHClpeSij
         mE4/7af4eNSDOYLZhNMzXu4KzBdWKcRKQy+wk5FUHrOuckKoHpRyw0K59WZcLmEB2JoG
         1hPsAxDy/cfLbqlgFXhx2CWBcXO2qBIcn3fFsxXE+ok1XQDbMpqhdE9nbCf+eRqR7FrY
         /Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMatkpXRBfYZcOpwK4gKTH0eFwLe1XO/MVtN1h01A6s=;
        b=iO3EWsW18kXn0Yz+lLHAyQwwVbh+PVdvbz6ODuaTyXsVsNOpSKpj57lnpVnrjfTNFn
         bpErIWDnCyMFM9pBOFyltXCZbVUSnwL+Z0W5LkU9G0I4HCIzk9GJvHRhT87hkQncbbX9
         uHqXsdqD1ZGckuxObA16ebLjSMpxrMGy61cxqL+X/horf7kY1+yMrQeWxT3cWmSzgyQW
         3pbJMJv4mWRtQWiFpDF0Pu+WIs23lEG8ixviiScT06LzkTM5LUhhcgBZhzujnj6fbjkR
         kZ2MPNW/QrDK95qkeB94q23uefC8rplx/3Uk9BP25VA8nB55LURa4x020hMMdmaGAwd4
         7NIA==
X-Gm-Message-State: ANoB5pmeTy0tXEfLJoZ7vRM5DWD3d32lLTbfoSpiqtDHz7X89mZ9/18m
        DsUnNpD8gof4rS5QEgV3Jl25xg==
X-Google-Smtp-Source: AA0mqf7yVrSTl6QoiMkprqkNQ9/YAbx/qUv/mivAcZBzk781qq/v68Bm/XB1ajZuwcArbC0YNAE3pg==
X-Received: by 2002:a17:906:6007:b0:78d:b6ea:174e with SMTP id o7-20020a170906600700b0078db6ea174emr12023955ejj.95.1668480874794;
        Mon, 14 Nov 2022 18:54:34 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:34 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 07/15] dt-bindings: mmc: mtk-sd: add bindings for MT8365 SoC
Date:   Tue, 15 Nov 2022 03:54:13 +0100
Message-Id: <20221115025421.59847-8-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add MMC bindings for MT8365 bindings.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 6f8ecb4788eb8..36f9fce8f4795 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -35,6 +35,9 @@ properties:
               - mediatek,mt8192-mmc
               - mediatek,mt8195-mmc
           - const: mediatek,mt8183-mmc
+      - items:
+          - const: mediatek,mt8365-mmc
+          - const: mediatek,mt8183-mmc
 
   reg:
     minItems: 1
-- 
2.38.1

