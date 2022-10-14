Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDD5FEBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJNJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJNJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:30:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2C5C069A;
        Fri, 14 Oct 2022 02:30:40 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E6mf2b021647;
        Fri, 14 Oct 2022 11:30:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Aii0wEtTzYyeG8wgGH0XuNz7wBYepHeOofFIh/pfnuU=;
 b=VJivwK47RPaJPD2GvPFkjY7suDDyrNe12n72hXvnEBkH77uYNrD0YlfuSB60MQcphxpp
 dAdGNOT8Oz6elvxAwPLvNnX5acj89aI4gbv25Wat7Ujb6euReydmso+Fapn5ITcZbXVl
 vZ3pFsUYRewVQTdLGnCB8I1q3i1nLmL8s2ydi1KXuWeEG0+x+nmr/AdzGvXr1IBJFTRB
 ii/zEvx/0P/U6r8ufiwAnYo4QHZbWNo4K21gf5SAL0oUv2piKwglWhE1WjpJCjHxjMm/
 oG+PIF2FZMuHXD7FitIUBNUqWEQfrRbnZMnZfAPG6Kn8gKSTdrg1PVPwGiuZe6AHWGh/ Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7v562-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:30:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2371610002A;
        Fri, 14 Oct 2022 11:30:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7D2C21A90B;
        Fri, 14 Oct 2022 11:30:22 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:30:19 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 10/10] ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as modules
Date:   Fri, 14 Oct 2022 11:26:51 +0200
Message-ID: <20221014092651.25202-11-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB Type-C UCSI, and the STM32G0 UCSI drivers as modules, since
used on STM32MP13 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12b35008571f..d391f8216eea 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -899,6 +899,8 @@ CONFIG_USB_CONFIGFS_F_UVC=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ETH=m
 CONFIG_TYPEC=m
+CONFIG_TYPEC_UCSI=m
+CONFIG_UCSI_STM32G0=m
 CONFIG_TYPEC_STUSB160X=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
-- 
2.25.1

