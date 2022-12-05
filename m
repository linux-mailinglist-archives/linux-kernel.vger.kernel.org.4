Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D664283E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiLEMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiLEMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:16:57 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28C2B8;
        Mon,  5 Dec 2022 04:16:53 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5930hN031201;
        Mon, 5 Dec 2022 13:16:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=F4E0mOmoaIAZJ9PkMgG7OOIOTBy4rN4EPATDJlorF/8=;
 b=TMbUdr1leDNXrqT78SlEXwx5O845Hlaf1jBS/tYqPq57OMs5bloLbXdrd0qsPYnYxsg7
 5rOnD8NPDaCUZ6T/NbiSbdzdXBUm4JtLlD/Djy3LHuYV2V5Kb8N8CdviqI7Fb3RRvyxK
 43dYjhbk6UnUHSP779EgH2oBjlD0T8raz+ch1pV8/m5GeEgWTE9FhckD7j4rVHdz1+Oq
 XN+2+kvcf6qe9hf9HwlG4Q7uRZaDV2dRenQbenTzlmfEIKNDQc1lRsMAy+Gt6EsMRhcL
 VyauH+cQ01gZapcJz0wcHUhqsVa++QUsKBswMlzf/f9WiTI08lUuJCV2g+V7IjjDtDVn 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m7xp6t12y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:16:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC96D10002A;
        Mon,  5 Dec 2022 13:16:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B56AD21ED31;
        Mon,  5 Dec 2022 13:16:27 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 5 Dec
 2022 13:16:27 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: stm32: update sound card on stm32mp15xx-dkx
Date:   Mon, 5 Dec 2022 13:16:00 +0100
Message-ID: <20221205121602.17187-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the following changes on STMP32MP15 DK boards
sound card:
- Rename the sound card to ease SOC diversity management
- Cleanup of useless clock property in SAI2A node

Olivier Moysan (2):
  ARM: dts: stm32: remove sai kernel clock on stm32mp15xx-dkx
  ARM: dts: rename sound card on stm32mp15xx-dkx

 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.1

