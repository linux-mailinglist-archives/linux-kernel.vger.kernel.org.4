Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C3669D63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjAMQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAMQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:15:32 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423D876D8;
        Fri, 13 Jan 2023 08:09:29 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFSbQm030643;
        Fri, 13 Jan 2023 16:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=BT46m0GFyZvdPoAAhfhdMehIokzv4T5w1f0EE/g4HzU=;
 b=gAjfH527j4tsrLKuxDul2aWmBDD+LSIfY0Nll6tAjRYFMKTGH5kLld0Gmg4MzMdS7AWK
 EKAkvulsjwVu3p3KCPXgM/QE7aSIDMDZk1tUtHsrCeybGxAmRx633guKmlJsC9jNjj/z
 l+gzuIsjyKTTjXIRPxzh7jWwgnKL4RHcoJy21VzMKUBUIHSzcaY8RxdDAXWXFt4DlGxH
 YWr7e5ttonupcAXJHTx5DROdQxbTo7fpr1MrSWWMWPTQa6RSZhHZ7Nn34G2WkYPqcHKv
 322F5crnhFam8axXd5ZyLiID/KWLGUtvK8HkWDSUijmeaATJEl7g6ofMQgHgRDAl2rmR NA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n39th0da2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:08:55 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 834013D7B0;
        Fri, 13 Jan 2023 16:08:54 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E61E180CCF0;
        Fri, 13 Jan 2023 16:08:53 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux@roeck-us.net, verdun@hpe.com,
        nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/2] ARM: multi_v7_defconfig: Add GXP Fan and SPI support
Date:   Fri, 13 Jan 2023 10:06:51 -0600
Message-Id: <20230113160651.51201-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113160651.51201-1-nick.hawkins@hpe.com>
References: <20230113160651.51201-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: oCfOTr_2_J9GLRPoGZV69o8y8_Dj6aIv
X-Proofpoint-GUID: oCfOTr_2_J9GLRPoGZV69o8y8_Dj6aIv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=851
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

In order for HPE platforms to be supported by linux on GXP it is
necessary for there to be fan and spi driver support. There fan driver
can support up to 16 fans that are driven by pwm through the CPLD. The
SPI driver supports access to the core flash and bios part. The SPI
driver spi-gxp was added previously to linux.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---
v5:
 *No change
v4:
 *No change
v3:
 *No change
v2:
 *No change
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b61b2e3d116b..192c89bfd02a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -441,6 +441,7 @@ CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_GPIO=m
+CONFIG_SPI_GXP=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
@@ -530,6 +531,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_SENSORS_GXP_FAN_CTRL=m
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_IMX_THERMAL=y
-- 
2.17.1

