Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF84666279
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjAKSFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjAKSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:05:49 -0500
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB31056E;
        Wed, 11 Jan 2023 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673460343;
        bh=dOzKijcvaNNdMhzpGv7PUERkFEUFDKLcNyIL06jtdtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iH2tXGEytHBttMQ1/zbIzLMsGjuMdXk1Dcllga7s7O1DPxjX24lH765QuiQ1RIAr8
         vNXIsslPRsiEo+7+2Ex5yOOZrXeuQmsXLWTjz0xDee4CfAupu1aIm17uYE4h96OxBS
         z+TZMLYyMFaqhPAugP+ijAxI9gAbbrH/NtzOxKWc=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 14F2600F; Thu, 12 Jan 2023 02:05:15 +0800
X-QQ-mid: xmsmtpt1673460340t9pmkemx2
Message-ID: <tencent_FF77D11FE1B5B5D6E83CC03FEED8FCD87308@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie9yR/60qDFl5SJSa8OALbWbZdviDzJQnfD54hho82hiVpgv91s0
         ej8u/aSNB1xB/7cT8oD4yxLIHW2OgR3oCTIZ9wTRrs9bf1BtLGcgwiXIGLaND8bF0zmJNJkPISjt
         BTXrYL82Eu1pTwp2HTE0S/9oJIJJF9yYzg1p6a7fVUBXrTN6LNGNutR0Y5xjMEKKVnruDV3vrUB1
         QOfc37A9qHubX9munca8z4cwQZ2ss2/se2sfAxf4rMqmjR/hE74GI07KR9tn8uLyminnAZ4MfGRa
         y2/I2WNVgT7XQn/W0xn0H7mW015N6Pdj0/kqh6nCpjzvmSXRQhxmFpoMmJASykJspPEujLTcvdfq
         R18/9dpw5gXMI1RvjT2X3tdyPv1X+LKjGIsBCD6kyz9Z7kEjDNvFOTuPndh+UpZWqzlvCEa3o414
         JABrToGQ+iGSLcqauDq2h/bOQW14/DPKiYdJU6DZGlFX4nY4QS6Zt/qqGGO3PNzPkDsUktoQHZ5e
         N6wOeg0kBTUP9aLPuC02uqOy+DNhlEslzfvXBVqZwylpANkLVRUcyWoFXrixGVVs63oQ+4OwLZ+m
         vf2ZaekPQ/8cu3O1J9l0CAhgtOpAB13KZpecgsMLlTk6kRkiooRj6HUcbhZ0LHDxlpgqpVMpOqCw
         cmim98lLXZqfv8GIcse1aJNW76wHjeFXJ4YTu7BNFMbnVtcoWXEtROgLahKGyQtDZj+gI6+ulHYE
         1ExvGwEXwLmaNJhG1ZjACU0nJNDoGaBFOnHa21cYqRfMOeeRG+aFTjU2n1Jba9qEiZI7wus75e+A
         Ef2cZFIuE5I/Tnr9ZAUoFm5erzG641fobf0S5KDKvyz2C2AdF38p1dwJz0AokTge2pQrfbI6xvKq
         RycRwPy6Z2IeF55W8s4yr5D+GTRQ0pa983js8NJWNBqjOFpPivJ8v9UqgVnKjtdPqqlrdU52mTvb
         nC4Kfl39XyE6pZfMIA41vz7oaJJ7untE53O9AVBhfpX0i4dvX/+Ak5ml/X4Oymww4lLtiSamzlGS
         b2LrL72Q==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add thwc
Date:   Thu, 12 Jan 2023 02:03:20 +0800
X-OQ-MSGID: <20230111180322.21874-2-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111180322.21874-1-forbidden405@foxmail.com>
References: <20230111180322.21874-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Tong Heng Wei Chuang Technology Co., Ltd. (hereinafter referred
to as "Tong Heng Wei Chuang") is a focus on wireless communications
equipment brand manufacturers.

Link: http://www.szthwc.com/en/about.html
Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 88227c14da99a..57d04039aca3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1329,6 +1329,8 @@ patternProperties:
     description: thingy.jp
   "^thundercomm,.*":
     description: Thundercomm Technology Co., Ltd.
+  "^thwc,.*":
+    description: Shenzhen Tong Heng Wei Chuang Technology Co., Ltd.
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.39.0

