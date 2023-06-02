Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D472034F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjFBN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjFBN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:29:24 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E11B5;
        Fri,  2 Jun 2023 06:29:22 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CEUrY023929;
        Fri, 2 Jun 2023 15:29:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=JXOkz1yMnYf3hSK6OQ9FOlo+6ogfqWnCLWQ9vPUkJP8=;
 b=nxrD9qk5R+hp5P1V1ITwxK4MnVOEvJxlkwhOL0tjIiZctfE/YbqgtpIGAuLRkcFNPw4+
 hxiHA8xabXvf54Q0icPv/MKWhCM8Abel9d24XwODbjHrO7/9gZH1dNGwj02yI530SjCD
 /mYIqsfnekos7vYpoGFIa3/IN3iRgXuPb09lLev21IjrZjLZaIbIM7KYv+MyDtAvp90n
 KxtyiZ89IrHPGasd6zk2AgOaDra6ao/nqAIz8VZo9+8lFFUy6PorP2QZGNUWon4jnJYf
 OhXAzZAtLmKTvyWDEIUDKQMmGMt1Ugt2i7YdKdz6ISLi2hlSWfBSaeiHcLLAVa+f2MuS qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qyc08a1uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:29:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E1DA0100034;
        Fri,  2 Jun 2023 15:29:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D88E5236927;
        Fri,  2 Jun 2023 15:29:04 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 15:29:04 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 01/10] dt-bindings: pinctrl: stm32: support for stm32mp257 and additional packages
Date:   Fri, 2 Jun 2023 15:28:50 +0200
Message-ID: <20230602132859.16442-2-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for st,stm32mp257-pinctrl and st,stm32mp257-z-pinctrl.
Add packages AI, AK and AL (values : 0x100, 0x400 and 0x800)

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 1ab0f8dde477..2120ef71a78d 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -27,6 +27,8 @@ properties:
       - st,stm32mp135-pinctrl
       - st,stm32mp157-pinctrl
       - st,stm32mp157-z-pinctrl
+      - st,stm32mp257-pinctrl
+      - st,stm32mp257-z-pinctrl
 
   '#address-cells':
     const: 1
@@ -56,7 +58,7 @@ properties:
       Indicates the SOC package used.
       More details in include/dt-bindings/pinctrl/stm32-pinfunc.h
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2, 4, 8]
+    enum: [0x1, 0x2, 0x4, 0x8, 0x100, 0x400, 0x800]
 
 patternProperties:
   '^gpio@[0-9a-f]*$':
diff --git a/include/dt-bindings/pinctrl/stm32-pinfunc.h b/include/dt-bindings/pinctrl/stm32-pinfunc.h
index e6fb8ada3f4d..28ad0235086a 100644
--- a/include/dt-bindings/pinctrl/stm32-pinfunc.h
+++ b/include/dt-bindings/pinctrl/stm32-pinfunc.h
@@ -37,6 +37,9 @@
 #define STM32MP_PKG_AB	0x2
 #define STM32MP_PKG_AC	0x4
 #define STM32MP_PKG_AD	0x8
+#define STM32MP_PKG_AI	0x100
+#define STM32MP_PKG_AK	0x400
+#define STM32MP_PKG_AL	0x800
 
 #endif /* _DT_BINDINGS_STM32_PINFUNC_H */
 
-- 
2.17.1

