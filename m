Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3816C81D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjCXPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjCXPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:52:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8649DF948
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:52:51 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ODPbF0010697;
        Fri, 24 Mar 2023 16:52:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Orov2Wj71gacCKJm+kuTZX9w05ghZJAYYdo65KlDR6U=;
 b=dXuunBoeV3rDenyDeLj1d7MqXKatlyVXIhcOvKuJE6w3bgHh6ovABIt1BGOy/WX6pZqK
 5qhzS2RrNWjHeg7FaqIRFVw3NUflyT5DLSnHGw1HnxXCMgxoi0Emdxj1wbtKovjIn6hl
 BVATwUfN5pjXQLhnDV/MptPg5Ng3s8H4vbDzsz1ryYGmW2KF/PGxW2KiIQ69GLqDmDqt
 e16Le86MvX11l3yFV/TBoJkwte5cvNq4avfdcw7Q4hUM7c+x+7kn3ZREe56mHiHgmb7B
 koaSm/kHhinZF7iBgYf+OxwpPdeDxhnC1j6vqvo5GzLS613MPoIRLud69n+W7kTT/JLe nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pgxjcdunb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:52:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18BB5100034;
        Fri, 24 Mar 2023 16:52:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F33C6217B88;
        Fri, 24 Mar 2023 16:51:27 +0100 (CET)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Mar
 2023 16:51:27 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 0/2] depends on ARCH_STM32 instead of MACH_STM32MP157
Date:   Fri, 24 Mar 2023 16:51:03 +0100
Message-ID: <20230324155105.826063-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_10,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to compile the driver on all STM32MP SOCs, we move the
"depends on" on ARCH_STM32.

Christophe Kerello (2):
  memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of
    MACH_STM32MP157
  mtd: rawnand: stm32_fmc2: depends on ARCH_STM32 instead of
    MACH_STM32MP157

 drivers/memory/Kconfig       | 2 +-
 drivers/mtd/nand/raw/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

