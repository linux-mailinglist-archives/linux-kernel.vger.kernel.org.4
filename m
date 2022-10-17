Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53B6012FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJQPux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJQPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:50:50 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335E659F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:50:48 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HFCEbL022394;
        Mon, 17 Oct 2022 17:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=qSzbP3o/we32XVDxgh1gT393pCI8v3pR1XiPNe9H29Q=;
 b=wEbfELusASE21icgslrix/c3sxtZuDj6XI+YKiPBPrIa7YYqqUNEBOk7GUHjJo/x1Uy8
 tUlNYGJ1VLHoP3QoaJnOIXS88i1VKDy0fhXlyHNrA19AAEn1zuYwEDBXKPNCOTq6xb/v
 9o277gN0DCmEr8D1+5PuxlLWCY3yQkQEDM3pu51YNoseQf74Mc3ZUnuuhOsE17yOYSN0
 2f9bW/0FzuIG0Pmqh0hDAY3yhvZEjJfYPjKPZFcSNi+OYpdkhm1qqsk9fLbDfW3RZxtd
 eQGLyCg4P7KnQ0+PWKVDukKIdQ9C6tyIonxT4kOxlcTAhlvtY95yumMQnpreipP6RXtR 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7j0cxabg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 17:50:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A97A100038;
        Mon, 17 Oct 2022 17:50:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62F5523C6A0;
        Mon, 17 Oct 2022 17:50:36 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:50:35 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/3] nvmem: stm32: several minor improvements
Date:   Mon, 17 Oct 2022 17:49:54 +0200
Message-ID: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Several minor improvement for BSEC driver = nvmem stm32 romem
- move STM32MP15_BSEC_NUM_LOWER in config, to prepare introduction
  of next STM32MP products with more OTP
- add warning when upper OTPs are updated to indicate possible ECC issue
  for second update
- add nvmem type attribute so userspace is able to know how the data is
  stored in OTPs

Changes in v2:
  - Add patch "move STM32MP15_BSEC_NUM_LOWER in config" in the serie,
    solve dependency issue for "priv->lower" in patch "nvmem: stm32:
    add warning when upper OTPs are updated"

Patrick Delaunay (3):
  nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
  nvmem: stm32: add warning when upper OTPs are updated
  nvmem: stm32: add nvmem type attribute

 drivers/nvmem/stm32-romem.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.25.1

