Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246385FF642
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJNWNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJNWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:12:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E71CF57D;
        Fri, 14 Oct 2022 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665785532; x=1697321532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PdtJ+0TskRuL5tgpsJ+tnXE9FMPE8NKf3SWIqt8ZBEA=;
  b=LMjyV/G0QPGN6OQTGFcdD+rlSyHiuCohVEk0O3Q29hahkp/P7itTzW0s
   LXSjW8nzAE+gN85OQZ4oAPEjYz2uIqgkvQwxmB+1nXSQxh3/sDm9yAGW+
   a+tUKqerujtQAhwQoZjvAseLAYfQaMlCCgRpfdSeyYjZ81vFacbgJP674
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Oct 2022 15:11:52 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 15:11:52 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:37 -0700
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
Subject: [PATCH v2 0/4] Add misc support for QDU1000/QRU1000 SoCs
Date:   Fri, 14 Oct 2022 15:11:17 -0700
Message-ID: <20221014221121.7497-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series firmware, SoC, rpmpd, tz-log, and mmc bindings as well as
pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Melody Olvera (4):
  dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
  dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
  soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
  soc: qcom: socinfo: Add QDU1000/QRU1000 and variant IDs

 .../devicetree/bindings/firmware/qcom,scm.yaml   | 16 ++++++++++++++++
 .../devicetree/bindings/power/qcom,rpmpd.yaml    |  2 ++
 drivers/soc/qcom/rpmhpd.c                        | 15 +++++++++++++++
 drivers/soc/qcom/socinfo.c                       |  6 ++++++
 include/dt-bindings/power/qcom-rpmpd.h           |  6 ++++++
 5 files changed, 45 insertions(+)


base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
-- 
2.38.0

