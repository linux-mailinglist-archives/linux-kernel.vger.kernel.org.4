Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD56B8202
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCMUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCMUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D26BDCC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i28so17254066lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+EYu8ePA3dMFVGocNPG9pYEHQq3W3rsNMZsR1ocQOs=;
        b=EOPBO/DQgdT2smOCJIOatrYCqLW+OhFpXU1JyPSWeQeFsgHANq8pxS5zO3TWwZErnA
         epJ1IiEV7x8P1/pEc7pmvCN44xYzRL24heE/nC9fhwDfy1I+4fnWRhE9p1/e+mEsvsSx
         cUcQqSf+4ywtXtx2FDn09poEIrk9gVi/4TkB5ufxBVlf9C6x1SfpoVprgmyVmVNWSdwn
         FZauV7payRJmE69Eaxzj7uCpFG3UfufWC9/a3noay9xPLv64zAjcgDPV33UmiIQ7tbOm
         7Mo1pz1P1g3gD9cYQnrFx6AH2NDek3dgLSLRbvYr9O/eUMaRZ4zXTKQMVkx3yH2A8Hgk
         d2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+EYu8ePA3dMFVGocNPG9pYEHQq3W3rsNMZsR1ocQOs=;
        b=xBgZh2kosesr1zEN4/97aPLzpn4RPdyto2VeYisDW3u9l0aZ8BMtK1ycmWxliBiOdl
         +NoOe6sEou0PG7EvV3Vr+yvhF4Zop3/dDB3IUYb6hjcelSOUssf53Zq9mXSa7GbUk8Q/
         orNrDbk7N796UvtZQVznJNFqNkG+iHcjMjQs9KoZl0PaMF/Nw4vI3F94THh7g3L4sbEQ
         SwchmbAX5vQPK64WpjdcyDqaExZ0ekyn1dmhXex4ib553EHarPw83bD8eN/mpbuDUOPv
         IfcOkqvtAt67jMGxto/1DyjszxwXzA0xAlh338flhE9ISWhzzg3exLdsBXhZOPUz9lde
         pLhQ==
X-Gm-Message-State: AO0yUKXm6TOEhOi8YwzLGuk4dVwECf9l6pW+hBhUE9S5dQaedCiozgWX
        oOeHTl4bibz+AnFxlH4zjtRzpg==
X-Google-Smtp-Source: AK7set8s02K8v15bAdMGo2NfxV+VELrtHBjbalDeJ3rekDF4upw1ahr+Gfhdk3crf2vuDvj4nrUE+Q==
X-Received: by 2002:ac2:442f:0:b0:4e0:54a3:4b3b with SMTP id w15-20020ac2442f000000b004e054a34b3bmr9905964lfl.69.1678737607704;
        Mon, 13 Mar 2023 13:00:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:00 +0100
Subject: [PATCH v3 02/10] soc: qcom: rpmpd: Bring all definitions to the
 top
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-2-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=7583;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tJz8D8f4CiouFxKHQ2BGayGyHthMiA7cOqLsJJ8H5rs=;
 b=7QrJX4Q0QrINj4LIQQYkyl62HC2ZAE60PjMkhac99xeHqD1P3pK2UOfhn4iIKF2hYnrUuyrU57Tk
 V8TSkzccAD6CqZIgru7VgVKY90C2hCiFl5ESJazdt4u6AOmxonSH
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

Keep all definitions in one place in preparation for a cleanup to make
things tidier.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 111 +++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index d99a56509e33..7d9e762232ea 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -117,12 +117,58 @@ struct rpmpd_desc {
 
 static DEFINE_MUTEX(rpmpd_lock);
 
-/* mdm9607 RPM Power Domains */
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
 DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 3);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
+DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
+DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
+DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
 DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 3);
 
+DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
+DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
+
+DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
+
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
 DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, LEVEL, 12);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
+DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
 DEFINE_RPMPD_VFL(vddmx_vfl, LDOA, 12);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
+DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
+
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
+DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
+
+DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
+
+DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
+
+DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
+DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
+DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
+DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
+
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
+DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
+DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
+
+/* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
 	[MDM9607_VDDCX] =	&SMPA3_LEVEL_vddcx,
 	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_vddcx_ao,
@@ -139,9 +185,6 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 /* msm8226 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 1);
-
 static struct rpmpd *msm8226_rpmpds[] = {
 	[MSM8226_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
@@ -155,14 +198,6 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 /* msm8939 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, CORNER, 1);
-DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
-
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, CORNER, 2);
-DEFINE_RPMPD_VFC(vddcx_vfc, SMPA, 2);
-
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, LDOA, CORNER, 3);
-
 static struct rpmpd *msm8939_rpmpds[] = {
 	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_vddmd,
 	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_vddmd_ao,
@@ -196,12 +231,6 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 /* msm8953 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, SMPA, LEVEL, 2);
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 7);
-
-DEFINE_RPMPD_VFL(vddcx_vfl, SMPA, 2);
-
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&SMPA1_LEVEL_vddmd,
 	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_vddmd_ao,
@@ -219,11 +248,6 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 /* msm8976 RPM Power Domains */
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, LEVEL, 6);
-
-DEFINE_RPMPD_VFL(vddcx_vfl, RWSC, 2);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWSM, 6);
-
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&SMPA2_LEVEL_vddcx,
 	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_vddcx_ao,
@@ -240,18 +264,14 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 /* msm8994 RPM Power domains */
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, SMPA, CORNER, 2);
-/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-DEFINE_RPMPD_CORNER(vddgfx, SMPB, 2);
-
-DEFINE_RPMPD_VFC(vddgfx_vfc, SMPB, 2);
-
 static struct rpmpd *msm8994_rpmpds[] = {
 	[MSM8994_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
 	[MSM8994_VDDCX_VFC] =	&SMPA1_vddcx_vfc,
 	[MSM8994_VDDMX] =	&SMPA2_CORNER_vddmx,
 	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_vddmx_ao,
+
+	/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
 	[MSM8994_VDDGFX] =	&SMPB2_vddgfx_corner,
 	[MSM8994_VDDGFX_VFC] =	&SMPB2_vddgfx_vfc,
 };
@@ -263,10 +283,6 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
-
-DEFINE_RPMPD_VFC(vddsscx_vfc, LDOA, 26);
-
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&SMPA1_CORNER_vddcx,
 	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_vddcx_ao,
@@ -284,18 +300,6 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 /* msm8998 RPM Power domains */
-DEFINE_RPMPD_PAIR(vddcx, vddcx_ao, RWCX, LEVEL, 0);
-DEFINE_RPMPD_VFL(vddcx_vfl, RWCX, 0);
-
-DEFINE_RPMPD_PAIR(vddmx, vddmx_ao, RWMX, LEVEL, 0);
-DEFINE_RPMPD_VFL(vddmx_vfl, RWMX, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWSC, 0);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWSC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWSM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWSM, 0);
-
 static struct rpmpd *msm8998_rpmpds[] = {
 	[MSM8998_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -316,12 +320,6 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 /* qcs404 RPM Power domains */
-DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
-
 static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
 	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
@@ -339,13 +337,6 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 /* sdm660 RPM Power domains */
-
-DEFINE_RPMPD_LEVEL(vdd_ssccx, RWLC, 0);
-DEFINE_RPMPD_VFL(vdd_ssccx_vfl, RWLC, 0);
-
-DEFINE_RPMPD_LEVEL(vdd_sscmx, RWLM, 0);
-DEFINE_RPMPD_VFL(vdd_sscmx_vfl, RWLM, 0);
-
 static struct rpmpd *sdm660_rpmpds[] = {
 	[SDM660_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -366,9 +357,6 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 /* sm4250/6115 RPM Power domains */
-DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
-
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =		&RWCX0_LEVEL_vddcx,
 	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_vddcx_ao,
@@ -402,7 +390,6 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
-DEFINE_RPMPD_PAIR(vddgx, vddgx_ao, RWGX, LEVEL, 0);
 static struct rpmpd *sm6375_rpmpds[] = {
 	[SM6375_VDDCX] = &RWCX0_LEVEL_vddcx,
 	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_vddcx_ao,

-- 
2.39.2

