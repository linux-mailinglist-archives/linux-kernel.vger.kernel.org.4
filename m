Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3D6B4B19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjCJPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjCJPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:30:15 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6051220A7;
        Fri, 10 Mar 2023 07:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678461472;
        bh=i5ecUFTtu8gE2VtNKUKEO0PlHAqi+1Iwkf2T4V9zR8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lmxYkmqr29L2LWuMOLm05jwyMn82LZPVSLEMC/HxVICp0xd72aHBWS0lICP5Fa4th
         pW4Dtv4dj+B6OkTcNX4ERaBn65duI66GX0qt/1eGbmgMEoLBWADrugCX8o0F4vM4ke
         X7Jp7U9jVZ9kWHt0Xs3j2d7GEImLwGMEfY7a9WQ4=
Received: from DESKTOP-ZMX.localdomain ([115.156.143.0])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 8A61225E; Fri, 10 Mar 2023 22:34:38 +0800
X-QQ-mid: xmsmtpt1678458901tvdq2of68
Message-ID: <tencent_61B4697855AD14BA2930AC7B21FFC75C4406@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTkpZXdI0KmUOakjYxFf3TJBcnTvjsonGe8oB2aMXKQhIMuTGzOI
         h92UByFh0TAoRgHqcVMOcdccq1skiQE32YG5LEn8ITcsnDltMmX9QPx3F4pEFyWUQcW6OQIbtZry
         H2IyfU4yMHTOllwD5qXnsC8sQ3ohnd5SH1XYvqWAwOD+0ErRLhWn5Jp9l0Y5C4HHMDAdQ6e49wN3
         8uus6jL1W52nQxONMqude0IsQD606jOodzzScg1CnkPIYtRKzgdMvKi1gA25we00y1Dj4dlIUQRU
         4EcHfFfVXKMRacgD6X8tYl5O2fXppvZv2R5hxHuFfJ58eq5O/xzsa9/2t7sh75xaom9P/vn0mYeE
         4geniVrO3dHi62isTxa94YUfp99aXzt8eu8bqqaeoUaqUQFEKKEhpqpIfVfVdoNLuDiffQ3VJyBB
         lvXms5nORoxmDzj4kn6aJCBc4xjfxmKiJFsHfOjXKMvVlzfuzRSokPqYzmw7GxtvgVsjnb6t8lUR
         vw1+Yua96xW2kvEK6HZNTkCCqM7dLYlBO4GTB8upRYw+Do7Eg8wqC36a3wveyrHN6IDfTYKpUD/o
         2LdnFe4hroNz1V3OG2B6AMtYwMMYSeA7D/VX9B3PWacLeU8lbMV8LfRwGcXONxHU9iUXUJlPTd5p
         Zw9fEmuz+8tpUQvTtQ5s+tOuNSxdyuj9eMUJK0QNEgN75a77LHqQMcD4vYkHznUJayuYFDHvFQsP
         oWq4uiXUTeaYiH5o09vo1epeUJMTDSQI2g1h1YRPz7Mbsj+SwXtPsE1nkvCRIHqTU4cBFTyPFy9h
         xIVaswInBbwr1KTv9RcU5FNcnp99Hw4nPUX0zU2GbWe+jvooupUl9mjknyxJZue1JcTNo2LXsObI
         Hp96WSiS9p8bD7L1VsArDw0fE4KSIy+HAAgMVBRIdkVp5gWzu5KhX6Q6Gxkf6J72usl6NGemVuNa
         IaGKR/yOq3ghUNXFZiL8UihNPYPQKb7SFWJfF7BuimuXXQ1ZdTxhdASmc5D9ghqzDj9rRjiB4=
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add Yiming LTE dongle uz801-v3.0 (yiming-uz801v3)
Date:   Fri, 10 Mar 2023 22:33:29 +0800
X-OQ-MSGID: <20230310143330.9485-3-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310143330.9485-1-forbidden405@foxmail.com>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Yiming LTE dongle uz801-v3.0

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1bb24d46e4eec..6e17cb0726918 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -226,6 +226,7 @@ properties:
               - thwc,uf896
               - thwc,ufi001c
               - wingtech,wt88047
+              - yiming,uz801-v3
           - const: qcom,msm8916
 
       - items:
-- 
2.39.1

