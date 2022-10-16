Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E05FFE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJPJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJPJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:01:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FB36BE6;
        Sun, 16 Oct 2022 02:01:22 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 02964C9D5F;
        Sun, 16 Oct 2022 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665910880; bh=o6090StYy9rrjYaQWTN5tjx96AqoXxW9GLTito76qxA=;
        h=From:To:Cc:Subject:Date;
        b=TwFgrKTq+WxkR/CGI0UldtmvRK0iYDoXEFtmgLDLcMBRDh7qASbnAuFx8PJaNqUO8
         XXhMfn9XvzmQbgseQfUdUBIAtDi5JJKPEXk8jfbgYOKzUxCn3ZDLmVFcec+bgM9geH
         j7lvtOftvNvROCrOBok3dZi0r+cXJ/EFx3wYEA6o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing compatibles
Date:   Sun, 16 Oct 2022 11:00:30 +0200
Message-Id: <20221016090035.565350-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the cpufreq-epss compatibles currently used in the tree, plus
the sc7280 which will be added in a separate commit.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 24fa3d87a40b..d6af29ee889a 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -25,8 +25,12 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,sc7280-cpufreq-epss
+              - qcom,sc8280xp-cpufreq-epss
               - qcom,sm6375-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
+              - qcom,sm8350-cpufreq-epss
+              - qcom,sm8450-cpufreq-epss
           - const: qcom,cpufreq-epss
 
   reg:
-- 
2.38.0

