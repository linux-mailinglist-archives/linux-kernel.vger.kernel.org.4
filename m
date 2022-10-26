Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845B760E8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiJZTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiJZTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9438682;
        Wed, 26 Oct 2022 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666811162; x=1698347162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EQS9Q5jMwlYbAFoPI/rbFUZQV3CzeBB/JjESphNtHoc=;
  b=jQxMqX77f4xQrXSpHqPePJW1WS34W9mgwwbxt82EEbYzG1Al+3lmH3Ld
   bgTcqTDtes2u254W5RRB1qTkNFAEbu9jiojQblkwe1G53P92qjnX3ul0C
   XZHNzP1NcLKb6+32trngrUqOG7ybAEpye5FQ/ZueozU69rNYu2wtOypEt
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Oct 2022 12:06:02 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 12:06:02 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:06:01 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/5] Add misc support for QDU1000/QRU1000 SoCs
Date:   Wed, 26 Oct 2022 12:05:44 -0700
Message-ID: <20221026190549.4005703-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series containes firmware, SoC, rpmpd, and tz-log bindings as
well as pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v2:
- Dropped qru compat strings
- Marked no clocks on qdu/qru scm device
- Revised rpmhpd constants
- Updated socinfo driver to new format

Melody Olvera (5):
  dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
  dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
  soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
  dt-bindings: arm: qcom,ids: Add SoC IDs for QDU1000/QRU1000
  soc: qcom: socinfo: Add QDU1000/QRU1000 SoC IDs to the soc_id table

 .../devicetree/bindings/firmware/qcom,scm.yaml    | 15 +++++++++++++++
 .../devicetree/bindings/power/qcom,rpmpd.yaml     |  1 +
 drivers/soc/qcom/rpmhpd.c                         | 14 ++++++++++++++
 drivers/soc/qcom/socinfo.c                        |  6 ++++++
 include/dt-bindings/arm/qcom,ids.h                |  6 ++++++
 include/dt-bindings/power/qcom-rpmpd.h            |  6 ++++++
 6 files changed, 48 insertions(+)


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
-- 
2.25.1

