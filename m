Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEEE600126
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJPQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJPQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:16:08 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68240BBE;
        Sun, 16 Oct 2022 09:16:05 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 832B9C78D1;
        Sun, 16 Oct 2022 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665936963; bh=qcJsUZQCMIkMA+JI/065x3bdEKFPd1nhWP6lAckCliQ=;
        h=From:To:Cc:Subject:Date;
        b=fZSqRL36AXjOysJRApODEXSxa1GxJf3JVkvPVBlZK62jPoO7Fjp8/vCKHZqvOmGYc
         tttg8yE+C5x0bNPth6Qwy0OfN8dTBEdWizztn9cSmR1yzY6sPSYJjX+68ck4lKM3e7
         Cz5jsQ/qptuhHGLLIxtbHLHFsbWiG94oYWAGDhhw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] MDSS support for MSM8953
Date:   Sun, 16 Oct 2022 18:15:50 +0200
Message-Id: <20221016161554.673006-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the APPS IOMMU and the MDSS block for display that is
found on msm8953 SoCs.

Luca Weiss (1):
  dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible

Vladimir Lypak (2):
  arm64: dts: qcom: msm8953: add APPS IOMMU
  arm64: dts: qcom: msm8953: add MDSS

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 244 ++++++++++++++++++
 2 files changed, 245 insertions(+)

-- 
2.38.0

