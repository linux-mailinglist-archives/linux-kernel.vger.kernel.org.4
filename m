Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC326AA3E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjCCWJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjCCWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:08:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E73565042
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:59:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s22so5367953lfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677880700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQTyZcO6FNqmddoHzVzEIHqpO3JKFdaOcoa693p0iLI=;
        b=zyQg6n8nh8uqdbShuv3zfbxNqiJLQa2d+mR7RSXXUSUFwn3KQGOzhKUvjLoYBS0HRp
         CYIzshqTT/sTg7Rar+rEFHEndG/2f5w2exQFsh4AhY7kC2O27zaZXfWZW96yQ80u38VI
         RV6ATm9NVy9d5/I6/q2kNpWP1GkPlt1zv3weN+/1Xzes3zAqCi5O9KT3pcr/N4elURRB
         94ocUtXZ2lSg7FGBsU3/OGz+wUC4tLmj1RnCb3fuV9IUStYizb1J5vh+RndQTGeyQMiY
         N1rMpfEdnVP+cMN3F2ruVe7VGbcMysgtpK/bhsxr5Pxg48KxU178Pm5B/CktMgEY94Lc
         DmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677880700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQTyZcO6FNqmddoHzVzEIHqpO3JKFdaOcoa693p0iLI=;
        b=vnpaRU3IM0U/KP0E6xImrDng9h1HsPnnkJJ9clodAbdhBDtmnVig9AMc4f5j8UXkaa
         1qDyXXpCSGRRt+ggLckw28XfWJIF2d5nNy1pDy2K6FJQGdqXuEcikjqsvp6ImsDR0cny
         zuGeysHXr8DeqWU9JiXb0VwPzWFhCwoyO5zX18cfX9NoZAlN0FHKA03fbjLk57lDkCxJ
         ygykHFeLChLB4ft4HyK+fOamHdpnDwZE01RUmQWb2zbQdZaRHdgtt/iwAkFkTKuMnYii
         gckbJfW3Z7rc6rgLl7rkZDor1zpMoT2oX7DfyzY2j91oGLnXjMS77v02ZJ/k4SDFbEPN
         9RLA==
X-Gm-Message-State: AO0yUKXt1cfIBDLeEt6FapqswyGsY98MFNXIX03jMxF76CTo4aZcMa78
        D7bQu7jg1NWUPHWm7ErXe6lc0w==
X-Google-Smtp-Source: AK7set/ceSNzp69S+7cNWbZnj09upQzochmePhhDJoDjboVTFBTe8YeTm/F/6/I76KsLj2vqbDgnCg==
X-Received: by 2002:a19:a403:0:b0:4b5:8fbf:7dd6 with SMTP id q3-20020a19a403000000b004b58fbf7dd6mr992286lfc.61.1677880700119;
        Fri, 03 Mar 2023 13:58:20 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:19 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:06 +0100
Subject: [PATCH 06/15] arm64: dts: qcom: sm6375: Add RMTFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-6-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=1141;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uH0RgNHZmHlst/xmB30MnTlB0owLxkAZmTcQ5HED9bM=;
 b=c1OTL8Pm7s2fqz6fkw2Q2S7TqG+CV8SbQ83c236r6ugiZYmDtO1jjb/MmcGNer7UpIO/hJW4Or7p
 yD5jPVsfAKNpR0U15c+u7qbGmyj9QcORxF6TUzxTAufmAE9w5CgN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for RMTFS on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 5a0abb7f7124..2cdd000a4e2b 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,sm6375-gcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -424,6 +425,15 @@ removed_mem: removed@c0000000 {
 			no-map;
 		};
 
+		rmtfs_mem: rmtfs@f3900000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xf3900000 0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
+		};
+
 		debug_mem: debug@ffb00000 {
 			reg = <0 0xffb00000 0 0xc0000>;
 			no-map;

-- 
2.39.2

