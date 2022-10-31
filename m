Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFA613D22
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJaSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:11:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CFF14;
        Mon, 31 Oct 2022 11:11:03 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9CB72CFEA4;
        Mon, 31 Oct 2022 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667239831; bh=i42qv3Hr7FKl1J9sbq/JpgJ5uEkM4T+MkVM2bNzRhiM=;
        h=From:To:Cc:Subject:Date;
        b=p4AKdEyMBjJaQy6L/iBRhDsawnvL23pKZa9JuT2DiGgCQWcuMHAPZu0Hl2/5/moCQ
         E184udnL7SwQCbg5AVRNgd/QsnfnDuhy6XkZxP8aW8kgQzLa86zLVjjo16mikNVE+p
         /ZpbMe8M8gsumqZbyIoIy0TnWXrDzvjsikkC6ksM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: qcom-pma8084: fix vadc channel node names
Date:   Mon, 31 Oct 2022 19:10:21 +0100
Message-Id: <20221031181022.947412-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spmi-vadc bindings require the '@' in the node.

Additionally change the node name to adc-chan which both makes it a
generic node name and also removes the underscore from it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Make commit message more accurate
* Make number actually hex in node address (made it decimal before)

 arch/arm/boot/dts/qcom-pma8084.dtsi | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index 0da6c1a5d547..2dd4c6aa71c9 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -64,22 +64,27 @@ pma8084_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			die_temp {
+			adc-chan@8 {
 				reg = <VADC_DIE_TEMP>;
 			};
-			ref_625mv {
+
+			adc-chan@9 {
 				reg = <VADC_REF_625MV>;
 			};
-			ref_1250v {
+
+			adc-chan@a {
 				reg = <VADC_REF_1250MV>;
 			};
-			ref_buf_625mv {
+
+			adc-chan@c {
 				reg = <VADC_SPARE1>;
 			};
-			ref_gnd {
+
+			adc-chan@e {
 				reg = <VADC_GND_REF>;
 			};
-			ref_vdd {
+
+			adc-chan@f {
 				reg = <VADC_VDD_VADC>;
 			};
 		};
-- 
2.38.1

