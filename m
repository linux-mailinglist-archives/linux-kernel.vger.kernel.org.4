Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1B680E58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjA3NBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjA3NBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:01:16 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A78692
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:01:13 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UCK1If016076;
        Mon, 30 Jan 2023 14:00:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=6/pjEhiHQ91y3GOVKq+sivTC4hOzk5hM5IK0ztMFPZI=;
 b=POj8U4LH6p+TFbl+3gHE38K1o46wvuvurDDEoTOXfFcVQw30Q0Mj8OCRbqRX2ITemXdx
 1lpwK//qTgUfXMVy397QPbSYrnbFqCz2JiXECiC/unPcYGiiKz0oeJZM7DRplJz8O3Lj
 guF6OCQXBXSdj2NQnChCO9b2fOwM7xvysSq6pzaR8RUJDNjUwf6Flzp45joJ30WuloIQ
 njTLjL/uk6JyHEVFV0uPVx3moupPpfXJv/YrSYVDprM5VrsupDZCCEvN4Hf8vn9r6gaj
 uP+XIfW/RLZ5Q+nklT1ZAl0vFIc2BzmLSajmbNrkwZ0Bv1608aDaf+BBE5SbfpxwFBxk nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ncsqeusbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 14:00:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E09710002A;
        Mon, 30 Jan 2023 14:00:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D366217B6C;
        Mon, 30 Jan 2023 14:00:26 +0100 (CET)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 30 Jan
 2023 14:00:25 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: multi_v7_defconfig: enable NVMEM driver for STM32
Date:   Mon, 30 Jan 2023 14:00:00 +0100
Message-ID: <20230130135951.1.I609229f603520144b3831bea4b026000ae0dd9a8@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the STMicroelectronics NVMEM drivers used on
STM32 MPU, STM32MP15x and STM32MP13x, to access OTPs.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d2f218341ad0..9b3ef21f44c1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1209,6 +1209,7 @@ CONFIG_RAS=y
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_QCOM_QFPROM=y
 CONFIG_NVMEM_ROCKCHIP_EFUSE=m
+CONFIG_NVMEM_STM32_ROMEM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_NVMEM_MESON_MX_EFUSE=m
-- 
2.25.1

