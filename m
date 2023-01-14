Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52466A9AC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjANGjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjANGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:39:40 -0500
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55924ECF;
        Fri, 13 Jan 2023 22:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673678375;
        bh=bLzeRljVs+ZlIyVkXGJql4FciYOu/LH6om5Nne+Iqog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W8AAF9OwW8IFN1BDmCUlcwxjKqw/I47ZzEnd8ATlQVRxMOS4RiHLNmcgaIaWdtb8r
         S30RZkm+aKAxyvpof5trhDFAgKazN+zqBycE3Txj18U/1+MMu18LrGbJpHuU98J/iT
         Y0htn3WTV3qSoUyYkzCgi0ICJ6yRS2WhtdMFBsZ0=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 9D611E2E; Sat, 14 Jan 2023 14:39:22 +0800
X-QQ-mid: xmsmtpt1673678372tdj0ackyb
Message-ID: <tencent_7ECF5944FB84A7D6CAA37F011FBAFBF16B0A@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurkR7e8S3Q6JFnjTJgJ8N4obzXaumh/HnJp71IirOhYFWr3OtcTih
         7Xgo6YsZiSGRVIubbaPlfziH3xFIFv2Gy/dbUBHjekBK3P+eoPumkOaM+mNjqnefob0q5lrE7udR
         zjMIiRY2p+W91YIY/MkT7DznSTE2eoIQRYWNGbTQeO2GV7hevJkYijYnIzVhK0QxZD4OlXhaNNHt
         Tsw67+WBSHSJxRFC/RQyrJD0S4gEOKEHaNPSUP+so3OjI1KZPuZh1z/u/SkQ7adZ5Tzc9/PTAni7
         4+V5oXoQuGI7QJ2S6SZgmS+BUtsaAXCvs9Yi3K19b/qljUiKJYdPsMmvC+HLZ3SKiCViSBQmcYI2
         y3158l+xcyStRMIH95KejzbTHJljqCAUQybKhZpaAot6CfaTLxQdeaqt/BebXtGIP6rkLi3BvBlB
         qXiqqFquzno8PocNRK4Zi9RFYxmoYvaXttp1dPHgYFuX/yQFNbA+GJhazecxNLY4w//xryRTmkwi
         YV6IwniEW/zh8tf8ONUwBIe4xFbjBmi98Zevt/IiFn6Cz8OvmGuAGuWMREZq4aBWJ5oQJnbf0NCj
         zWRNo1mx194WbA+T2WfcCdAVP3PoLDAU4x2sAPApN9jLnGM4fJzYiGrev0+jd1hadT61UfzfZtaT
         HfQZBJM5UGFQIP68bIB0Q9voXI7wqngmNdKfLJdg8KZeMmze8cwrF71a/PUZ91wdYY+EcWwd/2Kj
         fiRWbxpl5OtLR1c9OU3EqwpvD/B3H1rfjh8piUExR9iVDMTJZk0FgMc7r8q/tOtf0uKqXr+ccSQ3
         c9BVlVKg6lznjTn4eDnTLYa37KmBj4Yfs0ZUSWUNFFS2F/nB5cp5VmEX0NWMxzfSofWx6+ZmAeNG
         bLuv4DGnLJem07rkxhEHjmxkgRJD0x65CX/xLjbYPhUP+AZP6itOUDbcCviuQi7RV2+9HlZGtjmr
         LptdjOKjcNHzXRAm+W77VJQTsI+iw4NcTFx/1P0kVheQTyiNAk4OOQj0aMWUvoahWAOdjL6DuRTf
         U/SUPGi4wkDFfaCkf3
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add thwc
Date:   Sat, 14 Jan 2023 14:38:44 +0800
X-OQ-MSGID: <20230114063846.2633-2-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114063846.2633-1-forbidden405@foxmail.com>
References: <20230114063846.2633-1-forbidden405@foxmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 38edfa65fde82..ceab1498688c6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1331,6 +1331,8 @@ patternProperties:
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

