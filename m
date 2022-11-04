Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5461A13B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKDTjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:52 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E311133;
        Fri,  4 Nov 2022 12:38:44 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4IoIwU001106;
        Fri, 4 Nov 2022 19:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=3Ab0l4BQEdQ0EZsODVtz4hycEf/kQkZSan6UGQa7vLE=;
 b=CIKjf71Eey3rjH0O+o4VQFtER5+camDWuXOVX5YJOLBdy990OaCoqRuHBELeFGsjqVm+
 CCK5pfGbS0T0oBsMKTeXtsnrQTG/K4l0ftiIoCAHxANnDE3kYqVYn5e4uONnkVpH4bDr
 oIcbGgYy94jMVD7CfgAitbdR0z6+QjQLwpNgluFIv5Kt0t2AYGEB+U/SRJr7TMbpNV9G
 rbHr8lSTB42A1zEonGc24A/cKnr5Bi/whsNCtp0Xg966bQodlfh9Wtdd+50qe2mL5lTi
 Dj6zDYxRS/iNlVRPwN0112E/9x5IYWYu9ggkpFzKbNWjbbIxsfZyXKkXwGT4f3XFgNIK Dw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kn8bv08t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 1B889804722;
        Fri,  4 Nov 2022 19:38:12 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 80284808166;
        Fri,  4 Nov 2022 19:38:11 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 5/6] ARM: multi_v7_defconfig: Add GXP Fan and SPI support
Date:   Fri,  4 Nov 2022 14:36:56 -0500
Message-Id: <20221104193657.105130-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104193657.105130-1-nick.hawkins@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: QNe_Y22Spqo68Ydf2Z-0DiaOsCLdPagj
X-Proofpoint-GUID: QNe_Y22Spqo68Ydf2Z-0DiaOsCLdPagj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12b35008571f..92a854e7b01b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -445,6 +445,7 @@ CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_GPIO=m
+CONFIG_SPI_GXP=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
@@ -535,6 +536,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_SENSORS_GXP_FAN_CTRL=m
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_IMX_THERMAL=y
-- 
2.17.1

