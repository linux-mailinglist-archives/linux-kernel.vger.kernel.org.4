Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF596B138C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCHVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:07:22 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6590CC78C7;
        Wed,  8 Mar 2023 13:07:21 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 269E9C3FE3;
        Wed,  8 Mar 2023 21:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1678309609; bh=PMrX5xa0wF8TVVqsH1Pb5phtfnFDeFZawPyCqxh4toA=;
        h=From:Date:Subject:To:Cc;
        b=fAk8YoCYgnE/Ev2v3jup6D8PiSI11iWUDBVrmUek0/hylb+wOeMbFVXITu6Se61jg
         7+1FxQXeUIXKUroC+b727uPoXux7umrx0/+3S4WfFFjkwCYd9TNp7839PA3Ot/v1vX
         Q6sQ5n55kVbckFqft+C21K3OyIzuWhviR0632Ym8=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 08 Mar 2023 22:06:03 +0100
Subject: [PATCH] ARM: dts: qcom: apq8026-lg-lenok: add missing reserved
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-lenok-reserved-memory-v1-1-b8bf6ff01207@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIALr4CGQC/x3NQQrCMBCF4auUWTslTqAmXkVcJOnUBk2iEyiW0
 rubuvzhfbwNKkvkCtduA+El1lhyi/OpgzC7/GCMY2sgRVppZfDFuTxRuLmFR0yciqzorb7oyQZ
 jrYZmvauMXlwO86E/oSRMNRmiAYee+vUYvYWn+P2f3+77/gMAbL/ujAAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=PMrX5xa0wF8TVVqsH1Pb5phtfnFDeFZawPyCqxh4toA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkCPjd/i4LQcuKqckTs5eRrV8+OxildEvCxJBdz
 DKzdIcdlUqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZAj43QAKCRBy2EO4nU3X
 Vq2lD/9+1I6fYor0IucI89r7Vz4yq8Wgi2Uvr2pp06CZiyMGAbu0KxAoIr6lhIN9ZhU8vj7m0DE
 1qWGEKe3UsFBYmwA1cCjChkCSUd+Qzqau7r6fK/LuP0eZNs6STXsxdUPKwYIv6qQnUq4cYPF3Yp
 nCQN4vbjlQtLGIy5bWj3sDwX9mYGKInMI6egWwtDBlnHaPfgVrYAfmxPkNOybwknip1l31QAzqF
 Cue8ZOI6zoDweIm7V4wzW+3FQT/cx4UPeD4gzVqtKfh3hSLjlsskKgddXVKAnzExzrnLNWS257t
 eZG7//f14T7lizdVxQV5BKSIwpuzGjyNgRN2MR2Sw+TYAx3K50y+sVid5qnMLFF96V6av8cMNJK
 Tr3gziyoKvQhugVCpDGxz4IeP8obiWMb0vEfqvx7zOkQkYge9Y3vTaYGWYJGu4EIEZ+wbuao7++
 1bu2fWmheKzcR8Cx6sqgh3kWDaXu4MVgyUrXSQ8HP3JKQs5mld7s8O36NO9TFjqSCXCwGb2LkrO
 CNuZlTvmTik3rLWqH4PUzZHt60ABqWbjgoHV1iaH2nek09Y7N30Gup/VXnc3btGHM5F1a4XtbT/
 TM2xuezwhaJP1IOMracMGWEurn0HpaDONUu0GiRrJ40pM9W5N+LJYcVeXDzlDHm8LRBbKUQyinp
 NTjeY6NhvzNEtzA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out these two memory regions also need to be avoided, otherwise
weird things will happen when Linux tries to use this memory.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index de2fb1c01b6e3..b82381229adf6 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -27,6 +27,16 @@ chosen {
 	};
 
 	reserved-memory {
+		sbl_region: sbl@2f00000 {
+			reg = <0x02f00000 0x100000>;
+			no-map;
+		};
+
+		external_image_region: external-image@3100000 {
+			reg = <0x03100000 0x200000>;
+			no-map;
+		};
+
 		adsp_region: adsp@3300000 {
 			reg = <0x03300000 0x1400000>;
 			no-map;

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230308-lenok-reserved-memory-b9373f9c8993

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

