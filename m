Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3961EEF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKGJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:29:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A9A15732;
        Mon,  7 Nov 2022 01:29:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u24so16482602edd.13;
        Mon, 07 Nov 2022 01:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIjYm6JTwnli9URljlXV5J28hyaAyKTX8x4XHK8UduA=;
        b=IqkNR0fop9Go2dkeLda9lCJlfJaAr82zYUTLhYFK0IwkCE94Q8U2LRn/OB9RXM7IUl
         UoGTFNltkwtzJeMJpEynHM+EVSUDmmz65KBv8VAzbJ24Q2eRRSBAzXOFc57jVfbj+idP
         FWGxQc6dHEjxhbAUsPhzVznuyHb6nbdjioeOLdv5XMf+jOOK2mIjNEte2c7ugA+zzrnB
         l5XbASRDO+qJ5BRzPYdIFivUwSEy2ocY6TqMBeNtT+L2U1dFeaSvzgp8DL475t/Vx2vZ
         GxXETIyv7AFY2ivYStZeojkMkzA3yZdwIlp4oICAc2W1ZOwLFQljaI5da7LZO6B2XBB/
         7MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIjYm6JTwnli9URljlXV5J28hyaAyKTX8x4XHK8UduA=;
        b=d+ycXhAyyJ1tlFE2NNq8btD8QDDk4g5MNS8S5rNzjj/WNjxoBi2WnXdtQ49qIExaAM
         DzBO1117rEiAUYfuzZlg7PgNjFJ/aPaTU6HtpKeR8ILOS3ee2pAC/92tPJ0MwFuAR399
         Ryd38QF0GW3NZTdKM/erCLyANiCByaarYPBMFGJfwphq/FHicADXTm9iLRd1KdEommEh
         h5R3HfcXN5YGvSbOFOmRPbwiooKVC81TFVY5+KiEO7JPeY5t71SSxTnsQRGUYHPRGRf3
         ZT3oSJK/0VD31X8NjETT6JKGenoXZ+wjqykLKa0CdkdU/5gwyi+b8GKrOFUJ7ME4oagZ
         +uXQ==
X-Gm-Message-State: ACrzQf1LxVndQp3bi41OEVdNcH71nbA7OUtxrYt2tL6bnPXRP66hBuu3
        IXcoKJ1hXTWg33+jfOpbULo=
X-Google-Smtp-Source: AMsMyM5yUYRtpQfi9bM7MsDVeoB62ejIyeGeDBrlAENB4nI4fjY7PCvsk7O9SAMoOVLfYuvAZ1BgAw==
X-Received: by 2002:aa7:ce8d:0:b0:461:50fd:e358 with SMTP id y13-20020aa7ce8d000000b0046150fde358mr48982185edv.194.1667813373894;
        Mon, 07 Nov 2022 01:29:33 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id u10-20020a056402110a00b0045b3853c4b7sm3912837edv.51.2022.11.07.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:29:33 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/3] arm64: dts: qcom: hk10: use "okay" instead of "ok"
Date:   Mon,  7 Nov 2022 10:29:28 +0100
Message-Id: <20221107092930.33325-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "okay" instead of "ok" in USB nodes as "ok" is deprecated.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index db4b87944cdf..262b937e0bc6 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -22,7 +22,7 @@ memory {
 };
 
 &blsp1_spi1 {
-	status = "ok";
+	status = "okay";
 
 	flash@0 {
 		#address-cells = <1>;
@@ -34,33 +34,33 @@ flash@0 {
 };
 
 &blsp1_uart5 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 	perst-gpios = <&tlmm 58 0x1>;
 };
 
 &pcie1 {
-	status = "ok";
+	status = "okay";
 	perst-gpios = <&tlmm 61 0x1>;
 };
 
 &pcie_phy0 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie_phy1 {
-	status = "ok";
+	status = "okay";
 };
 
 &qpic_bam {
-	status = "ok";
+	status = "okay";
 };
 
 &qpic_nand {
-	status = "ok";
+	status = "okay";
 
 	nand@0 {
 		reg = <0>;
-- 
2.38.1

