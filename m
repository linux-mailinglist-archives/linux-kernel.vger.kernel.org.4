Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8904274041E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF0TtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF0TtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:49:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109730CF;
        Tue, 27 Jun 2023 12:48:55 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 73A8BCEF4B;
        Tue, 27 Jun 2023 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687895303; bh=WQfLl7OfFm+7vEzr6DvwYm+yVB/bM3NCu3Q+HA/I2CQ=;
        h=From:Subject:Date:To:Cc;
        b=LNYsFG99xcWLOLrRebbEBUBFNQfVKzuDN7kdgg2cy+xw13N6helDdkXzfgctOHgki
         0alOBOajXRwz8sLDDj+rb75IerELtDF2YyDuAY/2TTTTRWckohZgzGdUNSlqU5U5kb
         dnRApTNrqa4YX3f2Ew/GFny1DgIjU+puMpd4hse8=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Small style fixes in msm8974.dtsi
Date:   Tue, 27 Jun 2023 21:45:12 +0200
Message-Id: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEg8m2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDMyNz3dziXAtLcxPd4vyiEt1UY5MkI4s0Q4NEYxMloJaCotS0zAqwcdG
 xtbUAwAUuWV4AAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=604; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=WQfLl7OfFm+7vEzr6DvwYm+yVB/bM3NCu3Q+HA/I2CQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkmzz+3GctDA05lNilZYVW0LMuK19ZFB4CQKYFW
 YkOdzJvVFWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZJs8/gAKCRBy2EO4nU3X
 VmqcEACSkTr/6pJmspl5Aqo/BTk0a/NgfzcHwOGbGFEDGwG3rHISFkK6+vIhk6K8P1j86v1yM4B
 OCrxmIj1coer93NcJEWPazrJ4HiVy4pRZhAlnGguTNjJUFTmzOtu6reyCSzTCnclufiEHODfHvT
 p8CRJVlLfrKlYMy2KA6ctqRWMIVAvMBXSQ3sAR3ItfiLbOJ6WbkChhtE3jYzVXonpCclAfPodWC
 BNf9HNKk3ZRNxW3mHPxRos4TJbnZRE45raj3T5D7XljKAcvGHQ0G1vxVGuxtB68NZxwrsaN/BXA
 2cryFTwCXBSkd6s0ikVz2eL+qs2uaDglb0ZuDA/YiMa15feNIWVjQjGUsjhVZ07EeB+NDt4T0GV
 ZQ3os9zRAngLw3M2hq3POvldJeGM8yXJQBJMH+/ITKvHVKHibYQTOam4dBmQonm8YsiPWxFZr1N
 kCHF/gHUbfT+KjlVdqhDHZeulq+38PXMWXQezhZ70ewocqwNqGbfGaTtypuE0dI+amlcfeG+ulf
 LXm+/LZwKLvjIKJpq0ri9bKONOIR49IxIgsl41Y5FQfZkR458HxOT1UK3CVzaXh/2GAQXe9s80f
 Lw64fufGu8XMryoj/JeTTJ3Vj2/wcMSuY7XHcKBGsbzZE7gUrGQ/jSuautD8MQzIxQm8bgokD7E
 K2HUxramt9aTW4A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While making sure the nodes are sorted correctly, I also noticed that
some lines are wrongly indented. Fix both.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      ARM: dts: qcom: msm8974: replace incorrect indentation in interconnect
      ARM: dts: qcom: msm8974: sort nodes by reg

 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 80 ++++++++++++++++----------------
 1 file changed, 40 insertions(+), 40 deletions(-)
---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230627-msm8974-sort-e34b28f10a34

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

