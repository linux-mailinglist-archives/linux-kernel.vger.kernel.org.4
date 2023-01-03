Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC54465C840
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbjACUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjACUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:39:30 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF94D2F0;
        Tue,  3 Jan 2023 12:39:29 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JglTv022711;
        Tue, 3 Jan 2023 20:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=6ojOKbvjctn5ulXO5a1Hn2afk2yz1RPUY1cDzDSTQ0U=;
 b=btKh6WuhxeKy96Zj/9SJIVGDaOBpVfAJvZ2b/BWM2kGtfmZwtedde2zSrklUCJKfxq+D
 wCp8Q8v4krjEvDyCHUsG5/wLHJVVUEw5RJsBbqFQNo1neUWfAVkJ5s5oD3yvHaokIKpB
 zDMp3IY07NBmdOx1oKjnvG2K0Q94p8OFRQmkynoajMqKC0sIpqjR1qGvR+lO2jUktTvR
 CBvpyYVMZvYZvDP8zPRDvmeSqZg1SV2zSdA6B7vj8LEPOmaFIB+hmBIo2GjuJxgO8OFh
 rXqx0yCjhfk2mYC8ZEKZKsnMTSds7eRRY0NNznKO5rF/PwvfOQvJ0YMbkeaq/t1zzEU2 iA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mvtrmg95c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 20:38:52 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 000D28085D8;
        Tue,  3 Jan 2023 20:38:51 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 607D4800BA0;
        Tue,  3 Jan 2023 20:38:51 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/5] ARM: multi_v7_defconfig: Add GXP Fan and SPI support
Date:   Tue,  3 Jan 2023 14:36:53 -0600
Message-Id: <20230103203654.59322-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103203654.59322-1-nick.hawkins@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: BMmqaeHlKLPmeoGdd_EM6X_8MCDd1ZJn
X-Proofpoint-ORIG-GUID: BMmqaeHlKLPmeoGdd_EM6X_8MCDd1ZJn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030174
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

---
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

