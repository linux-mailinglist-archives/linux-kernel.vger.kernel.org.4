Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBE6556A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLXAVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 19:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiLXAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 19:21:31 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CAB11449
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 16:21:30 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m15so3174401ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 16:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ho+2OT1cU7+wj0oYRnyuh0fOK7IL6ZBjbwYcTjcTdno=;
        b=AyiY51eZhjTqZRG99hBVw6wwzSDUx43zUw7FN0Uzj5vXJTDwLz8Tta5aVy3ElXlLz6
         P6/So66wT8hTKZYIENEHkvZ/2cxahmTyth4W4b1y4KM9lCTk6jD+qnNPECtGWsRj9uOC
         UBa50bMx8KAnSiXE0wN4GpkwJeynSJ+25K60zUGB7j0BBt34SotpDT0pS0oIllaJraW6
         5t2ZNzcvPS53rcc1i4j9ThDNcb8TuWruMHdtD49d9ywLHz+Nc/fqdsC8KElZYiqFOCjM
         ZPevv+k+vHATA5sxtmn7zTixMRlTYvFsHl4Jsg46yIjwvpvqHpbmYzW4TKbpjC5nghcK
         JVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ho+2OT1cU7+wj0oYRnyuh0fOK7IL6ZBjbwYcTjcTdno=;
        b=maIpbyLoCLOwZ3MnkDHdpDsJLIE1DYRJEExV1n5zypT9JE+63O4XST/SPcEy4VvHmc
         3cU5AWG6/kO4sNzhTrpuKBHR71y3PwM/vMvvi9iCwMwT1ffXn/hk7Q642w1a5O9cVcNZ
         O99VKIgNp1fE/9TXNN6QgQUEk8sOxq1HgdSK8rk4EtRNc6ZZBsKbEJiRW1aaPmiF+PjB
         0Nror37+QWdxZIxosZYRZ2amHPpfOrDfmOy9efQ/Te0ejQGvj+pa7RFQnQtF6ZY4quYH
         0VCQBP/wtUYGM7iXy3K8qYWUsXTMqKA7wiBhWwnU/ymGGV80kCbHd+EDEbEt9sbLGx7A
         C77g==
X-Gm-Message-State: AFqh2kpFAwV70lN/syTxED2u/1gBDygiBFctA/ah8OO0dJ208kKeuMWX
        o6I90dy6M6GCELq4SP1lJ8b56Q==
X-Google-Smtp-Source: AMrXdXu1eLtbh7BBL6jqdRe+hyXD7o6lzlMV3Vy0CczN8IOLP7VsHnIIaZ2IBk2nRvGOQXrIBleS+Q==
X-Received: by 2002:a05:6e02:1246:b0:303:2d1e:f28c with SMTP id j6-20020a056e02124600b003032d1ef28cmr6928313ilq.24.1671841289495;
        Fri, 23 Dec 2022 16:21:29 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id x39-20020a0294aa000000b0038a0182e0casm1381189jah.11.2022.12.23.16.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 16:21:29 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org
Cc:     quic_sibis@quicinc.com, mka@chromium.org, dianders@chromium.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: qcom: sc7280: only enable IPA for boards with a modem
Date:   Fri, 23 Dec 2022 18:21:26 -0600
Message-Id: <20221224002126.1518552-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPA is only needed on a platform if it includes a modem, and not all
SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
used to encapsulate definitions related to Chrome OS SC7280 devices
where a modem is present, and that's the proper place for the IPA
node to be enabled.

Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
DTS files for Qualcomm reference platforms (all of which include the
modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
to enable it.

The only other place IPA is enabled is "sc7280-qcard.dtsi".
That file is included only by "sc7280-herobrine.dtsi", which
is (eventually) included only by these top-level DTS files:
  sc7280-herobrine-crd.dts
  sc7280-herobrine-herobrine-r1.dts
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-evoker-lte.dts
  sc7280-herobrine-villager-r0.dts
  sc7280-herobrine-villager-r1.dts
  sc7280-herobrine-villager-r1-lte.dts
All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
for those cases, enabling IPA there means there is no need for it to
be enabled in "sc7280-qcard.dtsi".

The two remaining cases will no longer enable IPA as a result of
this change:
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-villager-r1.dts
Both of these have "lte" counterparts, and are meant to represent
board variants that do *not* have a modem.

This is exactly the desired configuration.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v3:  Rewrote the subject line as suggested by Matthias
v2:  Moved &ipa node update earlier, and status property to end

 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 5 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 5 -----
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi             | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index ad66e5e9db4ed..c5309b25d0860 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -20,6 +20,11 @@ mba_mem: memory@9c700000 {
 	};
 };
 
+&ipa {
+	modem-init;
+	status = "okay";
+};
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index f7efb9966afd1..0ddbe7f732bd9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -376,11 +376,6 @@ &gpi_dma1 {
 	status = "okay";
 };
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_cpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index df49564ae6dc1..cd6ee84b36fd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -336,11 +336,6 @@ vreg_bob: bob {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_va_macro {
 	vdd-micb-supply = <&vreg_bob>;
 };
-- 
2.34.1

