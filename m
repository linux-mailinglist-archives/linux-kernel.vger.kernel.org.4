Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994405B46FB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIJOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIJOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:41:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2F402C1;
        Sat, 10 Sep 2022 07:41:31 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28A3iQIS015622;
        Sat, 10 Sep 2022 16:40:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Gid0SJMDIjGfJ5o7+2Vo2+dM66g08Y+kR1spMDEUU/8=;
 b=rmMYqiQH3ueFfdi09r+ZD5MkFaCDWMKaqBEO32VPniGfeCkJQFqfeysND9qMkHUsDiip
 WgTMi4V9GihiNPSh0C2Eaa4pbeyqnpMy4PD1c6i0D3Gh2UXWSBM/D6VlsCxp/vn5WC9Q
 0C3biKI/ZfaP3xb02EmCQB0/YbFVLwQ05cmB6UHnjRjXxGTg1p+5/fsTJmL+43b6tsj0
 OKfhRaOWlEZsooD3FdGjnzKXNUt+eRZh3sJ52EvATucDXBmhDeyLb7U+2a8P1EGrua6V
 vZFxOBoCsGpX+gWmuZzF1AKSrAwNlfWeUTk5jsEfaZaCOnr/8nMyz8RG0oQ64qMwUgys Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jgjxnhq4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 16:40:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0042100039;
        Sat, 10 Sep 2022 16:40:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB70822D164;
        Sat, 10 Sep 2022 16:40:18 +0200 (CEST)
Received: from localhost (10.75.127.121) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Sat, 10 Sep
 2022 16:40:18 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: [PATCH v1 2/5] media: MAINTAINERS: add entry for STM32 DCMIPP driver
Date:   Sat, 10 Sep 2022 16:40:07 +0200
Message-ID: <20220910144010.34272-3-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_07,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Add the entry related to the STM32 MEDIA DCMIPP driver within the
MAINTAINERS file.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fee641d10847..269ffe3c6f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12729,6 +12729,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
 F:	drivers/media/platform/st/stm32/stm32-dcmi.c
 
+MEDIA DRIVERS FOR STM32 - DCMIPP
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
+M:	Alain Volmat <alain.volmat@foss.st.com>
+L:	linux-media@vger.kernel.org
+S:	Supported
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
+F:	drivers/media/platform/st/stm32/stm32-dcmipp/*
+
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
-- 
2.25.1

