Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B265EB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjAEMvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjAEMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:28 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2B54C713;
        Thu,  5 Jan 2023 04:51:26 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6B094420BF;
        Thu,  5 Jan 2023 17:33:55 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922035; bh=o3SCIwB57u07TGO8NaHF0ZGaBCw07mfya4J9zUVafwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3TJdvGOF6JjP5ilD+522NW/BVSSI0hd9Y06yWNtu2fkVmt1t+eeBewVOP5w54+YG
         sL657ZZg2qFGqV1qSGaJ7vCGmcNr1FWsb7r8pYwRbvzX3J7v24q0qNmxO125V8OQqQ
         XWhqSKYtnGgkIHPok9qgULY2iK3iXjfdjK3C79QTDQ7zlYtQLTmAd6veFGe3I/4WHC
         LCxG7KpfyMsgqFNjCu8pn2R/mzjE5Nn2CaKOmhZj58eUzJj4Zz8P+U9LWcZWEGaJh9
         DUiwI8LmHwmteRpglBpdMiO6vHxu7jeXpZWhNDTzTvIk0PCWrCEQ6Ok/VSen8n92yK
         bcXFyYMWP1A2Q==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/8] dt-bindings: qcom: Document samsung,gt58 and gt510
Date:   Thu,  5 Jan 2023 17:32:33 +0500
Message-Id: <20230105123240.1089375-2-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gt58 and gt510 are Samsung Galaxy Tab A 8.0/9.7 (2015) tablets.
Document their compatibles.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 65ef7e442da0..6231df1cc14c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -207,6 +207,8 @@ properties:
               - samsung,e5
               - samsung,e7
               - samsung,grandmax
+              - samsung,gt510
+              - samsung,gt58
               - samsung,j5
               - samsung,serranove
               - wingtech,wt88047
-- 
2.38.1

