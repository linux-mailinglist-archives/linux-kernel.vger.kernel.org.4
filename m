Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850126183D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKCQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiKCQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:08:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4765518384;
        Thu,  3 Nov 2022 09:08:02 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3G233X030852;
        Thu, 3 Nov 2022 16:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=tdhKJ2aYYACy4JMxuIyet/qH+YIKSSsy28N/XIgDXIU=;
 b=MhjG5Q7ZuQ3zGYLwItaAOB2OkEUO3Wpiv8Uy/y2VhipJmKswyZK0zvotmvaYkQQR0DAi
 sXk6UlKlHEmnhUTugCkTpr0kb+cAYSUXdfks5xwrDrKJH11AsoQvemy6aQXpFGdw25vX
 5PSmJwhLS80Sn7CGrfPsoYJrRPlAleLIVTf3S68IHqnnudY/mlMOdHPSN9qHhLlAlUi0
 1NVLGjgSuoPDRMjJhXPWaV7iQzPifw+GHoFqmYEhmwuOLcr/fjysn19GmZoWKt1XIxhs
 1TXfsbf0tLWSwDK8ei4vl5pBK6g41HIyvi5FOGW0BRh7OUSHszROWMLFmKMSEZJ5Frjn Vg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmg5h0f7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:37 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E4AA6D264;
        Thu,  3 Nov 2022 16:07:36 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 550FF803A9B;
        Thu,  3 Nov 2022 16:07:36 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 7/7] MAINTAINERS: add USB support to GXP
Date:   Thu,  3 Nov 2022 11:06:25 -0500
Message-Id: <20221103160625.15574-8-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103160625.15574-1-richard.yu@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
X-Proofpoint-GUID: FK084rG75kcI_4xmpb2qxKpRtqrmaDPv
X-Proofpoint-ORIG-GUID: FK084rG75kcI_4xmpb2qxKpRtqrmaDPv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=835 clxscore=1015
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Add the usb driver and dt-binding documents

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56ff555ed5a4..b7280eb2dacd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2176,15 +2176,20 @@ F:	arch/arm/mach-sa1100/jornada720.c
 ARM/HPE GXP ARCHITECTURE
 M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Richard Yu <richard.yu@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
+F:	Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
+F:	Documentation/devicetree/bindings/usb/hpe,gxp-uvhc.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/spi/spi-gxp.c
+F:	drivers/usb/gadget/udc/gxp_udc.c
 F:	drivers/watchdog/gxp-wdt.c
 
 ARM/IGEP MACHINE SUPPORT
-- 
2.17.1

