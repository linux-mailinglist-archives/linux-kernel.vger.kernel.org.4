Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1EC6DAAB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbjDGJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjDGJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:14:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFDC900C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:14:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso4089542wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680858846; x=1683450846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gvRZGzZ81MG5/Kz7opKkMvHNkqBqpdFUorIdo7o5i0=;
        b=xGMUQH8iksEJ8YfExMZNgPR/bg8PQl8w/Qm3p8yAoOnLfxp/qQHfGQsT7zA9DBCMSa
         jbVc6ldqKsbilNojY7mVUwQOcmpV7IFk2IMmFtZmw0oXXhfmMiiKj+Svt0+c5zn6wBQB
         HOcZDsR8aaTwLFrCGep6le0PhA48SsKqumaZMAjGYgih4RB6DiFppRcn+lXy9dFzrCN7
         OWC8bBzY/UKtiAXRrZgytyfiOe3Fb197ke50mBbVfBZFcnHfNjxHXMt59eOPktEMUrmY
         gx5ndQcbxpALYm6Zll5QpoMuPa7HfllcLlIezWoYtOR/nihABCkNrAhNccj2ys2pjJXH
         0KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858846; x=1683450846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gvRZGzZ81MG5/Kz7opKkMvHNkqBqpdFUorIdo7o5i0=;
        b=m/8FVAWayV1eR6nae/XpOAk74vJENzIV4ZQRyQlilVcOrqF1q+Nfm0yOd0qsIAmg8R
         ZDkxr2pHGAljUO9U6HmJDlsTxnuYz7VxsHsE4h9JswA5HpQ/e+bdBlesIkN6gB7FBead
         vRJUBg3yeSk/1MKlkNJzatkrHBP2mSMF5mzkPQEVEmxzA2Y7Xn3jj8teCTXM7pgtKKaC
         TiystUu7B3RowXc1FL3wmSjGwv9EYATMKUX81Y3gCsC8MhDIzxfjd4pNez3bvrCXIMxk
         41bIUhz6XVKBojRUt960zn27Yel7v8AFNOQLxv0Ji9ELr5UaH7kID/8ZH6HLrrS4Ch0P
         dCrg==
X-Gm-Message-State: AAQBX9cYzjMhddc78nOsM4Y84PWNegNxL9qKZh2AwgyBSMNxE2Hh3vaD
        hfrVIWf2AjPDU9h1FsbF+ucpVg==
X-Google-Smtp-Source: AKy350ZRrTOfycKW9wpb1ySxaW2Z852gPkXpKIHM/8ZPrQgUAJnMq62jSsj7nPudOUhDoiebI/srKQ==
X-Received: by 2002:a1c:f719:0:b0:3ed:9212:b4fe with SMTP id v25-20020a1cf719000000b003ed9212b4femr793548wmh.0.1680858846111;
        Fri, 07 Apr 2023 02:14:06 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b003f04f0c5a6fsm4026429wmi.26.2023.04.07.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:14:05 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:13:53 +0200
Subject: [PATCH v2 3/3] dt-bindings: memory-controllers: mediatek,smi-larb:
 add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-smi-driver-v2-3-8da6683cdb5c@baylibre.com>
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
In-Reply-To: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=dRVBiL9RiPJX/FXqDzKoQWbHskXPf7KJD11X+Bn//b4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL97ZGgOc4pIupSNVBNwzWquNMS9nseDM+yjJIvB1
 +Dfza6GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/e2QAKCRArRkmdfjHURWJED/
 0bCm/8nQsFGhHGeEqIxX9hTkSaIRJOb4F/1r9lSCfquAUx8xV4ArzZu/AmQad0YBbYjSLKtRe6syP/
 nAe+u/8rzKqcb7mITsPUtQ9r2LMHkePwwzRIbiTvm5aw9XTLkK7tHZjqFFlzMfp/DqurdTXTO37TIK
 4jbFYUguWI33kDHvQfjdSc1rq94IALcD7uCqhNiHjEq7lfJdReZ4SX/u97liUieDv4edDlLJPcQcI3
 I34rW2fZU6ETMVozsRDysD/NPq8Ux+jvmxAa4cS6b30rbfwb00+68iCtc4jS307LUEXAc4Odb1LPlj
 /3LH9BtyzuVsNdN+d+ByjPsrV947p5cklLP/MoSaC3Z08VYIaghcLRd4KJIy76UtHn1n5HcPvl4W6C
 ZiQfr2ycl0TK7m7QtkrH9SB/9pVUFTFSOQhCPyqMnx4X5r/RZUAtn+bVzNI0cP6tg37MLvUiCNsj0x
 wCHjFrhEFKDmbT5nUUniLI+6xMIk6T8cJg8EyEb7moE6KsZe+GSD1/yQHrZzb/sXm/D7pMLiMEjPJ9
 Lh7RqARBb280RhjDGrHVnNWs0+82lfRk16xGlp7oYtd7StIOIWX837WGbNlyxHhJGS90f+QVlmnavh
 2SXS+01KaySmjWKmMF7GNZs9XxHMYMZf0Ukd8mYDfXlFtKkapnhdvNPf36Dg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-smi-larb

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 5f4ac3609887..aee7f6cf1300 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -34,6 +34,10 @@ properties:
           - const: mediatek,mt7623-smi-larb
           - const: mediatek,mt2701-smi-larb
 
+      - items:
+          - const: mediatek,mt8365-smi-larb
+          - const: mediatek,mt8186-smi-larb
+
   reg:
     maxItems: 1
 

-- 
2.25.1

