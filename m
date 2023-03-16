Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAD6BD1F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCPON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCPONV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4ED5A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h9so1855465ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=anO7XhKiTxQ7PspWlz0W5RuZllTBEpxpRK56MzaCLB1+qFfkKSjL7GCkvelyz5Kmna
         5ExrTeNfHAv0qorhHh8Ag5AC0/SN9Q+IOJ9DThhWLZoSxmgP3rDpyZeXSQajbuKOSic7
         KLfdXS9/uf8OoACfBtE28A37tN3jhlrVp2G6Cbm0C6sXxIRdwYqrz9Dz8kmd//Kfq0bV
         oF1JTzWexjcZVgZTSPyOZvNuljqWGrYcS+NRyYTxbKzUF3W8X/c7/+Ma0FFLAxDr8u1g
         2bwjcXZ3kiZLJvNyXqF/gHE2dLFjWa1EGKwkIeMcIH8hqZuz8JmplPxl9DquFGkfGzJ6
         6fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=rV1rNFfsOCOeZjCEReBJfHqzDSFJ5SBtO/AosM/4mvOM1Erm0LMpjGRO2VWg/ExQh+
         tkIn87NBh0VE3adfNIiO25MXagXTU4E7E/6PtF+LQJ9Q+eU/dV+GVHVX4Ct8FtI+uL80
         +4+qS9iqmX4NgwDCer9JRm3hNbCPiv6TLWwaSpc4FioA5xlzt+pvj0yb0ng1l+JUpCIQ
         4MWwWpdPsdZVMTHTMjVQO/xsYvKsUN/5oihkYiqyKl6GPAcwd+TT3exyF/2Au38JYVZt
         o0kUqTYVg/Cs7Ub4ah6UdfkhUhCFvewGM7dw/6V9wHBVvUqnUOr7Kog4XVPmbSuX9sUn
         rFbg==
X-Gm-Message-State: AO0yUKWo6GSkNzu1h6nIpjYN/hyG2N4TVc6C22Ju8IcqFV9N2qUw1WBL
        uiwLYffjQDS8Hb6PHMrbbhhgGg==
X-Google-Smtp-Source: AK7set8MJYAhH90ZMr/PPhTGr3fg5R05/wF93P/RTeowmczTTO9NNtDiRGAJTI1D0GqhTNm5TZjtvA==
X-Received: by 2002:a05:651c:1a21:b0:295:9517:b98f with SMTP id by33-20020a05651c1a2100b002959517b98fmr2416206ljb.15.1678975988657;
        Thu, 16 Mar 2023 07:13:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:54 +0100
Subject: [PATCH v2 05/14] arm64: dts: qcom: sm6375: Add IMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-5-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=952;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XeByskUh4IJy5GUSRGVEOURhAeiNtSqMfR5ebBA6Oes=;
 b=mMAFk6AuU/gMpqPyPUUUhzoWQDrmjRlIU1ZiIzMYlaaCXfIpkR1Gf2xkYL/WskH9spuP5ffJlJOb
 H/ScjN/2BaU3hl3N5lADcQaDr/OLOi1WI32ZPyhUss9gyoU1iIa1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the IMEM block on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index de5882c0ff81..5a0abb7f7124 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1233,6 +1233,20 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		sram@c125000 {
+			compatible = "qcom,sm6375-imem", "syscon", "simple-mfd";
+			reg = <0 0x0c125000 0 0x1000>;
+			ranges = <0 0 0x0c125000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6375-smmu-500", "arm,mmu-500";
 			reg = <0 0x0c600000 0 0x100000>;

-- 
2.39.2

