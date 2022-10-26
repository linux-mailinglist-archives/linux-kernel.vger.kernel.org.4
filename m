Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5E60E893
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiJZTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiJZTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:07:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F4357E8;
        Wed, 26 Oct 2022 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666811147; x=1698347147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CTeiZ4hWxpNnCAIJGQUzuGaxbO50pTdY/6SPH/RoXJk=;
  b=Be0j/Bk0JlkUcxucy6jAX7RRkivgRkqhNbqVDMl2O4QhHnQGDZ0ZvWFF
   QFesCYzrTu8nMMjlozFjFY6wVFzCFdA45QBL5erN0rDEaprAUFhmcC9eS
   z87QG6oahY71Wocap4HEfAm90uesgqED2ThkqU4GqMcJRJqC++iQEInrv
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Oct 2022 12:05:47 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 12:05:47 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:05:46 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Date:   Wed, 26 Oct 2022 12:05:32 -0700
Message-ID: <20221026190534.4004945-1-quic_molvera@quicinc.com>
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

This patchset adds smmu bindings and driver support for the QDU1000
and QRU1000 SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v2:
- Removed qru compat strings

Melody Olvera (2):
  dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
  drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
-- 
2.25.1

