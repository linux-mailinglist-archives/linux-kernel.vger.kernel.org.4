Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF126748847
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjGEPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjGEPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:45:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6A10F5;
        Wed,  5 Jul 2023 08:45:29 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365EYJpJ001517;
        Wed, 5 Jul 2023 17:45:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Jngokl21DT6n3m/EywbuHYpC/tnbgTz7e7o7NWl9Mvg=;
 b=JdZBeBuSZ3N4C0iYuav4pcuPuWWfHDy4CLrQPT13KDiVraQosX5DZDEtpXOIs75a5dMt
 f/ARz47mfYdsRIAI8J9hgDnR5OO6fbWSZfv7EUmrNOukeUqFdm0tYlIlTb2WWKJoqY7d
 U57Q35tFI5GfcJ+9xfdl1ZXkpd5EQpnZJZTvC4Q749uNwfX7903epaPrUWTHJH0VuPFF
 1/7Bnp0XVl+wj/ht94BIoYDXheBpofbx0YkU4CQpC5Q6CbdAYO5ntiPEiatN+0im/fwM
 o4FqpanahWYb/gLNadKnGWGH18R1y9TT4m3UXJinSGTOEpRTwbpTFgGrRveKJ/NxF0eJ Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rn09qngcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 17:45:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A276E100057;
        Wed,  5 Jul 2023 17:45:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C2C8236948;
        Wed,  5 Jul 2023 17:45:05 +0200 (CEST)
Received: from localhost (10.48.1.0) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 17:45:05 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     Christophe PRIOUZEAU <christophe.priouzeau@st.com>,
        Etienne CARRIERE <etienne.carriere@foss.st.com>,
        Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/2] ARM: dts: sm32mp: remove shmem for scmi-optee
Date:   Wed, 5 Jul 2023 17:44:57 +0200
Message-ID: <20230705154459.1194895-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.0]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_07,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the optional shared memory in SYSRAM and
use the OP-TEE native shared memory for SCMI-OPTEE to
- avoid boot issue with the latest OP-TEE version 3.22.0 for STM32MP15 SoC,
  when CFG_STM32MP1_SCMI_SHM_SYSRAM is disabled
- prepare migration with the same configuration for STM32MP13 SoC



Patrick Delaunay (2):
  ARM: dts: sm32mp: remove shmem for scmi-optee on stm32mp15
  ARM: dts: sm32mp: remove shmem for scmi-optee on stm32mp13

 arch/arm/boot/dts/st/stm32mp131.dtsi     | 14 --------------
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi | 16 ----------------
 2 files changed, 30 deletions(-)

-- 
2.25.1

