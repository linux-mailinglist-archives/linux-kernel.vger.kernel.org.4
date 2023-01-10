Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05175664552
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjAJPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjAJPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:51:08 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343912DDE;
        Tue, 10 Jan 2023 07:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673365859;
        bh=4/YKl/eTVRRiZDnoxzaO7yaGY3LnIpNVPZCSRuNQDJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aXf8aPgh+EYU3DS/UStPulTu3+gtZAZfQkcd8W+6/vwzpEjfM9vQksAbDlgy6KRYm
         mwLoECjsDXWnjidl62LnkBwhw909wabvQNgGUd9Lx6pAelif283YtkgYrCOtBO/OkD
         Z7SnEguJKpuJ1b8kpA3k5Rz6FM0IKg4Gh1mI1HtM=
Received: from localhost.localdomain ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id C9A3CA11; Tue, 10 Jan 2023 23:50:26 +0800
X-QQ-mid: xmsmtpt1673365856t3phw9xgi
Message-ID: <tencent_5AB8DBF2B3CDE947BB84B3D6D2A0D7023F0A@qq.com>
X-QQ-XMAILINFO: NqxKgsaVX1mSYOx0oEDccgwlKomuxRCqNmupjfqnE2AnDfKKFC/qedb4HBPOTn
         MB3FR4Cj6PmudGK6ZZhVkL6zSXvs/k5enXu++nGfl/bw2keBx+uhGpRYDDL2yPktrFbjWZJwLWsz
         /ER0C8zuY019kFKnifHBHgdieH6+AFenoQ9884FHBdeiD2JxxZbaT/4l5qYYgdIUJAvQloE+J0ni
         TLQW/oStqIr90ws6iPwy52Q61SsmmThO4Q7nPzmy0YZs92LsCnIW4eoeAfsxFF33uaVaSveMaPaJ
         hzOBuYiARK62pti1TiG2gKb9jYtlZlvV9mIu2C+H+amDIu0/O9MoJ3oUMqZCPw2+VBGYruusETgl
         /1sjXtoW5PqeY6V5ScKX2hwgJEuVDbtfOc5+X6bucvPbUJ18mFv3Upg1fbP6Te/+E1jgADlNia8+
         Po8Se20IzCr6pdTiNrphUWL3D0mut3r83hlAGTWe66uQSseB5fi9hBgNAXynRg82A6l5sFvPWSye
         mZ6/XfHQNnfwrS2utoDR7HrkK+yCqRw9f/EAvR59z1OVE3SpKUki9CdWFxm95JPtK7eVf3CH0/q3
         Z3LBncnyYNiYwKuzlcp+nsqsFj0GLeP+nRtSyghaLoJniYouTZEJMcAXRsO6gZCr5KzgxV/61bn9
         4JwzkHuFtMWiYeCV/9T+VksgbeixQ8ot+9FCDVpRWjTwVeg/n5TLeb0cBDi065Vu+DjeT38Na6xP
         6k5QXH1BBQNeVmgfaSQS7xZL2TNdfGK7VZM8sSO9r6jHK1JYQwkOkCoBNpVXlVlZIbTnjs6V0HBj
         C2MErhGCBbmONIO3gkfZ/FsvFYf66etQtG9hOC9U8W2rNSOGsmpH89UM0/H/nIZh3iEWAIxDK+Cn
         NjbZpFX8oj/HMvYzFf5wTIcPTIKc4Z6ewZcLQcU6oSYayRKdze8BHgd9yeHzkMK3JBFb5O87xWks
         M4QEuiO75qmu8aur9QieTV9MHyPzR3VKh2Q0vSnjP4EibbUdPbnXhQomHHPMmvnYv3u/1b4g/Cq+
         wu6N/OjPml5cdfPinHSgwxw7FmKQU=
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
Subject: [PATCH 2/3] dt-bindings: qcom: Ducument bindings for new msm8916-zhihe-uf896 and msm8916-zhihe-ufi001c
Date:   Tue, 10 Jan 2023 23:50:13 +0800
X-OQ-MSGID: <20230110155014.31664-3-forbidden405@foxmail.com>
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

Document the new zhihe,uf896/ufi001c device tree bindings used in
their device trees.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 65ef7e442da0d..efe5f6c384b69 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -210,6 +210,8 @@ properties:
               - samsung,j5
               - samsung,serranove
               - wingtech,wt88047
+              - zhihe,uf896
+              - zhihe,ufi001c
           - const: qcom,msm8916
 
       - items:
-- 
2.39.0

