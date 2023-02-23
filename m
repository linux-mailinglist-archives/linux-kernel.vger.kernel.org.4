Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138276A0834
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjBWMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjBWMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:07:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653255C0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:06 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so10499231ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSXIYjxNwQB5rC697KFH22B37Wkj2tNCcehY+B4TiSY=;
        b=Psnw1sT6NYQB65Gw4hVD+6qknVqFCL+OTzW+fcAVAHrxMhpLxwnvPL3eTr8JxPz99w
         36ONyLp1ha+EF1B5YvEoQpWMOQTTFxDPUcy1RRnPvFdI7jZwelKqtUxioL4yT/ukkeiq
         076vZB4Uvew3aYuXw76kQ/2bigVyg6L0tsX4MuS2D7e6DDMmtEElEzzd+Wgnvdx4ftPU
         qeBhEgNtdHk/9JEe/H0JGnwqA1znmNmvD7Doc592jRrD9d+lDFlZd0t2DQWJHT8VLhls
         03B3oHFdoPgPyqE6OQGRhjP+ihFwAM7wRltJvEIbj8m3FVZMV1VRwEkE0S3S7UMkAfYY
         RsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSXIYjxNwQB5rC697KFH22B37Wkj2tNCcehY+B4TiSY=;
        b=SSHMboQNsayudYuFiulfTmk87nN1bzdSLtUojKc3b45kfm9j3b0uSBmC5DCbEQQCW+
         zU3K4ebOre1PJMNVivVhhZOUbpyb5SHm20DSj3pjbnv1evLKZTiejOxr9J9SDVpb07zL
         BsOYgGalzsEfjff3MPK0RfeUnxgIzm4FOK2I8Mt4AxyRuNOAdFDCC2kCkMm2N4MVoqDb
         fSd5JG38P3NpzsEro9zsuAZj89+ivn+WLI0n5LHO83gHvi+CnmioL+O92bzPrmjaXMx6
         H27oMbVFMPBnAMYAbr+0IJwh3wTcj57PU+KwoUpdMKBiUNnbN9Au+RgFhAeYbxUy1+7r
         xFxA==
X-Gm-Message-State: AO0yUKVrqkUepxvpgrd/68hPqguJ5XF3pakg3fBvLyjRsDTDL22dZ3Fz
        rXDeOdiy4EALqy7oiiHys1N/lQ==
X-Google-Smtp-Source: AK7set8yIQJDUE1VGoY2e5auhBs7dIG4WhOSuybeiyheT5uB6fe12uO9Zp50iQ9siFy2FcXt5enWTw==
X-Received: by 2002:a05:651c:106:b0:293:315a:7bf with SMTP id a6-20020a05651c010600b00293315a07bfmr5309917ljb.23.1677154026481;
        Thu, 23 Feb 2023 04:07:06 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm414838lji.75.2023.02.23.04.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:07:06 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 13:06:48 +0100
Subject: [PATCH v3 14/15] drm/msm/a6xx: Add A619_holi speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v3-14-5be55a336819@linaro.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677154003; l=1972;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vvT7USAtDT475uQ6rC2hStDRDcbJP8m6WcfL8eku2dk=;
 b=vn8ZUf8ziT2rGzu3gkbCADd22G9dr4oBxmjAlpq1d+ChSxrwFHoyBTxlp4nLoBmJlDwM81pccaGu
 TegrqfQTCOsZSDD26iJBhEJU7FqtGiz+nTGSWjFv0NTUMNPUC8jr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A619_holi is implemented on at least two SoCs: SM4350 (holi) and SM6375
(blair). This is what seems to be a first occurrence of this happening,
but it's easy to overcome by guarding the SoC-specific fuse values with
of_machine_is_compatible(). Do just that to enable frequency limiting
on these SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d49b649ebecf..81f99f8d1978 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2163,6 +2163,34 @@ static u32 a618_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a619_holi_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) two SoCs implementing A619_holi: SM4350 (holi)
+	 * and SM6375 (blair). Limit the fuse matching to the corresponding
+	 * SoC to prevent bogus frequency setting (as improbable as it may be,
+	 * given unexpected fuse values are.. unexpected! But still possible.)
+	 */
+
+	if (fuse == 0)
+		return 0;
+
+	if (of_machine_is_compatible("qcom,sm4350")) {
+		if (fuse == 138)
+			return 1;
+		else if (fuse == 92)
+			return 2;
+	} else if (of_machine_is_compatible("qcom,sm6375")) {
+		if (fuse == 190)
+			return 1;
+		else if (fuse == 177)
+			return 2;
+	} else
+		pr_warn("Unknown SoC implementing A619_holi!\n");
+
+	return UINT_MAX;
+}
+
 static u32 a619_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2222,6 +2250,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_is_a619_holi(adreno_gpu))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 

-- 
2.39.2

