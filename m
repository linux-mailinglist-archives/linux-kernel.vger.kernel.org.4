Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0181F5FBAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJKS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJKS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:28 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5F6B653;
        Tue, 11 Oct 2022 11:56:27 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BGr9M1020777;
        Tue, 11 Oct 2022 18:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=kuMXJWDh9ijnVOyY2MpUKCv+pp7r7Hb1VeAR5RUJD1c=;
 b=jF9+oWgRRM80YsenokPH32fx5TIGC7zF00J4WtBqUZm6dFaN1k0mQDWbXnOFAZZRV8OC
 USULalfqcW9HKMvbzDmdob05cFJ9pReSK3lVSX5/ZJJMioE16zLXpbYgGjIFhTui57c3
 sKv1pw7tfJvUCBsHjlcXe9YCVveBlFperkbuvG/UMrg6aue6S5/nh+MDd+cPyZlzEx9o
 rqVLvnc0PVljP3VgOIFMoBg7sCkF8FPfhWhpLrUZS3s89TLtK6RHfLMbaEzaVHUJNxJ4
 D+NhrDk+DEhLljPu0mzS0x+ycleR1si16AsyqE9Sp2RaYT1dH/APiRgmek8Uw6vSIxQ0 nQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k5cd4s0ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 430DB804704;
        Tue, 11 Oct 2022 18:56:02 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D251080873C;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/5] ARM: multi_v7_defconfig: Enable GXP SPI and PLREG Drivers
Date:   Tue, 11 Oct 2022 13:55:24 -0500
Message-Id: <20221011185525.94210-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011185525.94210-1-nick.hawkins@hpe.com>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: Qod-UAjyxm7OHmbi82F5SUoFd5CeQ_et
X-Proofpoint-ORIG-GUID: Qod-UAjyxm7OHmbi82F5SUoFd5CeQ_et
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=399
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Adding support for the GXP SPI and PLREG Drivers.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12b35008571f..b1932e258e2b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -444,6 +444,7 @@ CONFIG_SPI_BCM2835AUX=y
 CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
+CONFIG_SPI_GXP=m
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
@@ -1136,6 +1137,7 @@ CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
+CONFIG_HPE_GXP_PLREG=y
 CONFIG_STM32_DAC=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
-- 
2.17.1

