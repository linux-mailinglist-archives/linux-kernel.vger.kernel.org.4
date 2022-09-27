Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7D5ECE13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiI0UNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiI0UNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB181ED6E6;
        Tue, 27 Sep 2022 13:12:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y2so1202773ede.11;
        Tue, 27 Sep 2022 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ERvPP1DCVp4MiILdBHqOveoWvWBbcTJhOIDbP+BpDP4=;
        b=fLLNDoKDfemMdsY0bCDH3C1zn23t6tFyKihHht7uqnk7c7dgxatgZ+tdjfiEdUvHzM
         JoJSEKtlG/aeDzfyPWKEHR8SmcFGk8WjovljYGk6/MdGcV1Bxezr00B+KGJmE7c+5Vmt
         cz7ZKjD/Fm8xquWRHh31MpPv0bRMGAT8KktiMDbNAKFTeGMp85CMaPS4JiJr8cCBLsXd
         ibrSSGPuS1oxImWsnLOmpxdlZSBoyYXqdEyt5KS8vukZRXNc2qppchqkUaoCn/g0oS+w
         J2bN3dELY4KmmZ7Jask+tDKdnKIst0rd21qQg09dqXHTgvf+jX0wHYE/Ih47FG9NWvzY
         dGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ERvPP1DCVp4MiILdBHqOveoWvWBbcTJhOIDbP+BpDP4=;
        b=KYSL3dKMMAb0qKRhQTH4vCaFdEYdk4kl7SpLinOXsI8NCJUM6iDvuZmC9towh/Bv27
         DOIoDEde/6QV464TD/+HejARduF1/jea06enXIkY+gu1b+X8cXG3F+fS2l867IEYn3h1
         u8Iiuqe82K3emiJxrKT+EeV372cdSgevF99Y+BuXofjFj00ySHfKWQ4m2fiusuyTwDn2
         8r7mFGtXwzDUey2SzsmeL/aQLdk4XMEZo1ccbdnZ0hBJSYqm0nlNkj1eHWjhAcOM5Ncf
         iFgzYp1r1tExKGutgUo5g3KCfc26pBV9ARiEjykbfZApDw5qaRyuIV1CvTmCn17aSP1o
         QwSQ==
X-Gm-Message-State: ACrzQf0E+OdbpweWyv1+wQJeA0JJd0s1BHvrXkxWTI6PEY0bCEXOm38X
        Pfe1E08arhYBdo4N2bC1eQTUz9YpKQyFFw==
X-Google-Smtp-Source: AMsMyM5Fkomjs+4IzUYdSSmWO16uQdRL8K9X35JYWpEtVfxAn5hNbbfgtp2q1Ns+0OABUGJG9STXLw==
X-Received: by 2002:a05:6402:1e96:b0:451:129e:1a2c with SMTP id f22-20020a0564021e9600b00451129e1a2cmr29918017edf.60.1664309541475;
        Tue, 27 Sep 2022 13:12:21 -0700 (PDT)
Received: from fedora.. (dh207-96-59.xnet.hr. [88.207.96.59])
        by smtp.googlemail.com with ESMTPSA id t7-20020a170906a10700b0074136cac2e7sm1267548ejy.81.2022.09.27.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:12:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq6018: fix NAND node name
Date:   Tue, 27 Sep 2022 22:12:17 +0200
Message-Id: <20220927201218.1264506-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Per schema it should be nand-controller@79b0000 instead of nand@79b0000.
Fix it to match nand-controller.yaml requirements.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a7c7ca980a71..57978a8ab498 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -348,7 +348,7 @@ qpic_bam: dma-controller@7984000 {
 			status = "disabled";
 		};
 
-		qpic_nand: nand@79b0000 {
+		qpic_nand: nand-controller@79b0000 {
 			compatible = "qcom,ipq6018-nand";
 			reg = <0x0 0x079b0000 0x0 0x10000>;
 			#address-cells = <1>;
-- 
2.37.3

