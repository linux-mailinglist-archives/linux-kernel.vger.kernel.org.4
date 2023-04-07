Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F976DB293
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDGSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDGSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:13:06 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D0420F;
        Fri,  7 Apr 2023 11:13:05 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337CMGeF012601;
        Fri, 7 Apr 2023 20:12:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=F0o+B3Jxb3/uk+z8z/TkZpS2JFK+X2n8RM237B5Z72s=;
 b=bqgkoPZvUyir/9JcBxPvKJggAKC9PUuKLgNeIkclpMXM0GLtrtPN6cxMiCfkhJWlXCmJ
 ropCFJSTtStST82JiZPewnaKLFQNJdTASQ1c0UuWQ16chif+3rrAukGVwbQ1ZFYdZSNC
 O/gwQRqohI8PHDEFd8/JmHOTCA+7v0czgWSVMiEyc3iJRIkT2HbKGDvCAUy/4Ts+AOxD
 NcuS3i4UvnymrAJtOHqZZMhgtATXoamD4VZiGUJE2T72FljMT1p9cL5AvbhJUKYN/7lP
 pAktTMoCVdAp7ppgGumZgovQMr3lsY85Rc8FFyLzHPahrfS+1Ox5Y/mkbEIXZdY7Srxr Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pteygu39y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 20:12:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82C1210002A;
        Fri,  7 Apr 2023 20:12:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BB7024C44C;
        Fri,  7 Apr 2023 20:12:50 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 7 Apr
 2023 20:12:50 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] dt-bindings: mfd: stm32: Fix STM32F4 DT include file
Date:   Fri, 7 Apr 2023 20:12:43 +0200
Message-ID: <20230407201235.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_11,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cosmetic change, aligned with file in U-Boot:
- remove extra space

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 include/dt-bindings/mfd/stm32f4-rcc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
index 309e8c79f27b..36448a5619a1 100644
--- a/include/dt-bindings/mfd/stm32f4-rcc.h
+++ b/include/dt-bindings/mfd/stm32f4-rcc.h
@@ -34,7 +34,6 @@
 #define STM32F4_AHB1_RESET(bit) (STM32F4_RCC_AHB1_##bit + (0x10 * 8))
 #define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit)
 
-
 /* AHB2 */
 #define STM32F4_RCC_AHB2_DCMI	0
 #define STM32F4_RCC_AHB2_CRYP	4
-- 
2.25.1

