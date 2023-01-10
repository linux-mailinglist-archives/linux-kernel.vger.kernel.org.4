Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D221A664551
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjAJPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbjAJPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:51:08 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCC266A;
        Tue, 10 Jan 2023 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673365856;
        bh=H7P7j0DldiMjNlQt7A+LpXPyB5yVc97aFwFru494oJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UWtLUEj2nBijSLREco5KwmzjKbydBNDd/xq8f6GK5T0q0k00ekHUGHp2K6WFNdDuL
         qjU/On1bPgqS/HJr5f6SIFor2gre+nkp8FqIsOn1bAgXS2wljRPsnhL6BI2IZo8HqY
         RrVbyrY1YkxiLovjJsOTtPIk4VVULh/SO1Z5a0E0=
Received: from localhost.localdomain ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id C9A3CA11; Tue, 10 Jan 2023 23:50:26 +0800
X-QQ-mid: xmsmtpt1673365854tna3jf7ur
Message-ID: <tencent_89603CF732FEF0B9A2E88CF0E45A62F42D07@qq.com>
X-QQ-XMAILINFO: NGsJ5Fy+2UsSw0v8rXZxyCjscayR4Kbp+t6W7A5V1sMNZU33oPOSbLUlSJorSe
         wrEHBFDThEDK+2YOvIcLOVklIk4jEIUxVo1lJqmHxTqXhwVrF5pIkP7BDRul1Jj9LR6rMUPsumGR
         TcuZXFsdFUxOb8hGJDHkSzwSbnt1SlrIgDjunrjlDANgKCVXJa0Eo0RlymTHyKMdZuhijmx9VPsM
         eaJ9nL9MpVC5iHDA6+SJTuL1Qlc67xWWWfqP+TSH8mBplSs/MoseADh92ZEXjJdGykj5qGpThgUL
         /1mxBrM1pICiqgf+93mcZXFvq9KsTMFJ67M8wzPFYWzUAIVvc6Yd6YPysPuVbhK5oX/DXPjx1X39
         pyefxkzuC7gB/PsdXbpOhh7CMjmcsTNtM1kznm5b8juRfovMuWKiUe6mK3eW0k+JZfkPEQbTG3eE
         t97KUDPc9N2WxtXh2atiT7Vw9S/1Z+tOtKA0VPKQKTt60hd0SoiqVOHxlzi/y/sPR3JvLugmQzCW
         l1pD+hM0Fr/VW0CLhox4dXk5vi82ZyfAHiRl3QhPQsJP31qIsS3Sc4MogvF8/gqdZ7nugaZ6xYG1
         ewuWb8MWQfjfaQiDMZxJOjpjbyYiflbDd1CH+GhE2bZL+0LIULFJ5/8MLViS3DKjgF3D7vZjRaZY
         D6wU/f6vwoliFIh+yR/kVZq94CE/YqaR1jGoD1z/lUAanECgbdSb+O+CA9MZzhOxQb+4yCTGuA+W
         OJoqwTXyTJhxf16dGdmGKvnoZx3PRkea1UDgYZ71hydRWK+LwRccOI/9SmCFeAVw7ZIOZoOJdE5T
         e2x59Itbsf7yt2QR8CdisQG6xc5et4KB613tb+q9SiHGie5RBR4vxtBg32GLqROR6r8oFXlBE+Xp
         1BG7FX4FW+ct91GSPp5NDmeH84AS0rH8VSzpv1QAjvtBA0KofM4Lo4uT45s1QxC1ifCBIuKiKLog
         NYAbVEmBjrJC8JCoWIm9QX9lrONHd4N6Ke90T+HJEIHFWk2p1EwFxZM5AOQqMMzuMz1lR8NlpPpg
         tvH0zxG7vEgkf084agE+AAJk5AsBnQ0a/v8glY0A==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add zhihe
Date:   Tue, 10 Jan 2023 23:50:12 +0800
X-OQ-MSGID: <20230110155014.31664-2-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110155014.31664-1-forbidden405@foxmail.com>
References: <20230110155014.31664-1-forbidden405@foxmail.com>
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

zhihe is a placeholder for various 4G USB dongles made by unknown
manufactures with similar design. It is widely used in China to refer to
these dongles.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3893c45963a26..795627741a322 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1520,6 +1520,8 @@ patternProperties:
     description: Zealz
   "^zeitec,.*":
     description: ZEITEC Semiconductor Co., LTD.
+  "^zhihe,.*":
+    description: Placeholder for various 4G USB dongles made by unknown manufactures with similar design
   "^zidoo,.*":
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
-- 
2.39.0

