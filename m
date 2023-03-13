Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC496B820D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCMUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCMUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321E738B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r27so17184567lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVLgoHd5JRg28f+yh6JSFUHtXvcJzOao7oRBs3X+6SI=;
        b=l7YZPug7DZS32EIX8jDfsfrfcQWaFlddBm25jm86BggG4JTA/lhqLY5RtdBVUD32vI
         H/utAVFetq9kFczvfx+B2EERVQdvqfSTm0ev/TBwtbp9n2z41sAuKe1T23qJeQlAc5l9
         Q+ctTuVEBOOXUKPDXkSIT3Qs1VFKj4VVLVCg3AJj71IpNhSu2mv+IQ4Uc+dGj3iMz/L7
         KCv7miHVRXUCLbgycEmSrDHY1k3YL/bzfo+YTm/SQHow4GNLYbc391gNrsiSjLBXJRHa
         ZTJG5k9lfFVDVR8b0P4QcsUWzMQpeTmYUKVBAU0+MDXYWj/H556G7FRoBroegf0U4p7E
         sCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVLgoHd5JRg28f+yh6JSFUHtXvcJzOao7oRBs3X+6SI=;
        b=GDUhodcoBE9Muhs92ZqNEN9iU9ecvbHhAJQqT3iV9eX4R1Q76/Kx5OfE0x8Or00Ffl
         2vUEyO4iqppGhHb8lwRY1/Aj6V2cTnzZaTJz/6NLxDSWftCTkhdV7mnSQvGVW9bk77FK
         KrncOxFbvAYoQ0YTGaNWmhpx6JYwmFosEQqm4MdBxIorDeRDpjIeoe6N9UW4imzb5LN6
         3+PGtDpfqKkZwrV0iwS4DO3ppgAz0zDmq3brNOKmZAFDtueNbQARdfQATEARnDRob2ko
         NOCUMmGb3rxKbCkLhnR/YXTXQF5V0LgTJhwBlJS/5AFVkWdUyDNBRpYJhOVJPKNRVGNu
         n1Pg==
X-Gm-Message-State: AO0yUKUmGZZYPdgwbw+Jt1rpuGkA6KnQxGj+yuR58n7HDygu3JNuHWVF
        vLZ0fXWOobSuUul1Ec8osqk51w==
X-Google-Smtp-Source: AK7set+OoMy9xLLCnPpnHWGXg4+7/Q/drbXxcqbnv608WzvS4CChE0qV4mG9CqkUlYGqdn/eT05nZw==
X-Received: by 2002:a05:6512:4c7:b0:4e8:20f6:83f4 with SMTP id w7-20020a05651204c700b004e820f683f4mr6278101lfq.21.1678737612734;
        Mon, 13 Mar 2023 13:00:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 21:00:04 +0100
Subject: [PATCH v3 06/10] soc: qcom: rpmpd: Improve the naming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-rpmpd-v3-6-06a4f448ff90@linaro.org>
References: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
In-Reply-To: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=26373;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YPgvOib1w7EbBNa6mq+JUfbfGLE9w0c535k+nwrzZfQ=;
 b=zIrMyrFOipy+67hbIVhZ+ZMAL4ZbhKVGhT1+w6ubDSDhscC8qHRLcBtZlEwOYTaZuD5PgheLNCqo
 u79UDmIBDdcE+i2nKenwpTzJylgTuLFTG57XcHr0Wr/m63ZTVIVt
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

Now that we aren't bound by the preprocessor macros, improve the naming
to be a bit less preprocessor-y and touch up some rpmpd.pd.name fields
while at it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 432 +++++++++++++++++++++++------------------------
 1 file changed, 216 insertions(+), 216 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index df4e0d8a2aa9..695b2fc56f40 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -68,132 +68,132 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* CX */
-static struct rpmpd RWCX0_LEVEL_cx_ao;
-static struct rpmpd RWCX0_LEVEL_cx = {
+static struct rpmpd cx_rwcx0_lvl_ao;
+static struct rpmpd cx_rwcx0_lvl = {
 	.pd = { .name = "cx", },
-	.peer = &RWCX0_LEVEL_cx_ao,
+	.peer = &cx_rwcx0_lvl_ao,
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWCX0_LEVEL_cx_ao = {
+static struct rpmpd cx_rwcx0_lvl_ao = {
 	.pd = { .name = "cx_ao", },
-	.peer = &RWCX0_LEVEL_cx,
+	.peer = &cx_rwcx0_lvl,
 	.active_only = true,
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA1_CORNER_cx_ao;
-static struct rpmpd SMPA1_CORNER_cx = {
+static struct rpmpd cx_s1a_corner_ao;
+static struct rpmpd cx_s1a_corner = {
 	.pd = { .name = "cx", },
-	.peer = &SMPA1_CORNER_cx_ao,
+	.peer = &cx_s1a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA1_CORNER_cx_ao = {
+static struct rpmpd cx_s1a_corner_ao = {
 	.pd = { .name = "cx_ao", },
-	.peer = &SMPA1_CORNER_cx,
+	.peer = &cx_s1a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA2_CORNER_cx_ao;
-static struct rpmpd SMPA2_CORNER_cx = {
+static struct rpmpd cx_s2a_corner_ao;
+static struct rpmpd cx_s2a_corner = {
 	.pd = { .name = "cx", },
-	.peer = &SMPA2_CORNER_cx_ao,
+	.peer = &cx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA2_CORNER_cx_ao = {
+static struct rpmpd cx_s2a_corner_ao = {
 	.pd = { .name = "cx_ao", },
-	.peer = &SMPA2_CORNER_cx,
+	.peer = &cx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA2_LEVEL_cx_ao;
-static struct rpmpd SMPA2_LEVEL_cx = {
+static struct rpmpd cx_s2a_lvl_ao;
+static struct rpmpd cx_s2a_lvl = {
 	.pd = { .name = "cx", },
-	.peer = &SMPA2_LEVEL_cx_ao,
+	.peer = &cx_s2a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA2_LEVEL_cx_ao = {
+static struct rpmpd cx_s2a_lvl_ao = {
 	.pd = { .name = "cx_ao", },
-	.peer = &SMPA2_LEVEL_cx,
+	.peer = &cx_s2a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA3_LEVEL_cx_ao;
-static struct rpmpd SMPA3_LEVEL_cx = {
+static struct rpmpd cx_s3a_lvl_ao;
+static struct rpmpd cx_s3a_lvl = {
 	.pd = { .name = "cx", },
-	.peer = &SMPA3_LEVEL_cx_ao,
+	.peer = &cx_s3a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA3_LEVEL_cx_ao = {
+static struct rpmpd cx_s3a_lvl_ao = {
 	.pd = { .name = "cx_ao", },
-	.peer = &SMPA3_LEVEL_cx,
+	.peer = &cx_s3a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWCX0_cx_vfl = {
+static struct rpmpd cx_rwcx0_vfl = {
 	.pd = { .name = "cx_vfl", },
 	.res_type = RPMPD_RWCX,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd RWSC2_cx_vfl = {
+static struct rpmpd cx_rwsc2_vfl = {
 	.pd = { .name = "cx_vfl", },
 	.res_type = RPMPD_RWSC,
 	.res_id = 2,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd SMPA1_cx_vfc = {
+static struct rpmpd cx_s1a_vfc = {
 	.pd = { .name = "cx_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd SMPA2_cx_vfc = {
+static struct rpmpd cx_s2a_vfc = {
 	.pd = { .name = "cx_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd SMPA2_cx_vfl = {
+static struct rpmpd cx_s2a_vfl = {
 	.pd = { .name = "cx_vfl", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd SMPA3_cx_vfl = {
+static struct rpmpd cx_s3a_vfl = {
 	.pd = { .name = "cx_vfl", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 3,
@@ -201,32 +201,32 @@ static struct rpmpd SMPA3_cx_vfl = {
 };
 
 /* G(F)X */
-static struct rpmpd SMPB2_gfx_corner = {
+static struct rpmpd gfx_s2b_corner = {
 	.pd = { .name = "gfx", },
 	.res_type = RPMPD_SMPB,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPB2_gfx_vfc = {
+static struct rpmpd gfx_s2b_vfc = {
 	.pd = { .name = "gfx_vfc", },
 	.res_type = RPMPD_SMPB,
 	.res_id = 2,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd RWGX0_LEVEL_gx_ao;
-static struct rpmpd RWGX0_LEVEL_gx = {
+static struct rpmpd gx_rwgx0_lvl_ao;
+static struct rpmpd gx_rwgx0_lvl = {
 	.pd = { .name = "gx", },
-	.peer = &RWGX0_LEVEL_gx_ao,
+	.peer = &gx_rwgx0_lvl_ao,
 	.res_type = RPMPD_RWGX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWGX0_LEVEL_gx_ao = {
+static struct rpmpd gx_rwgx0_lvl_ao = {
 	.pd = { .name = "gx_ao", },
-	.peer = &RWGX0_LEVEL_gx,
+	.peer = &gx_rwgx0_lvl,
 	.active_only = true,
 	.res_type = RPMPD_RWGX,
 	.res_id = 0,
@@ -234,129 +234,129 @@ static struct rpmpd RWGX0_LEVEL_gx_ao = {
 };
 
 /* MX */
-static struct rpmpd LDOA3_CORNER_mx_ao;
-static struct rpmpd LDOA3_CORNER_mx = {
+static struct rpmpd mx_l3a_corner_ao;
+static struct rpmpd mx_l3a_corner = {
 	.pd = { .name = "mx", },
-	.peer = &LDOA3_CORNER_mx_ao,
+	.peer = &mx_l3a_corner_ao,
 	.res_type = RPMPD_LDOA,
 	.res_id = 3,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd LDOA3_CORNER_mx_ao = {
+static struct rpmpd mx_l3a_corner_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &LDOA3_CORNER_mx,
+	.peer = &mx_l3a_corner,
 	.active_only = true,
 	.res_type = RPMPD_LDOA,
 	.res_id = 3,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd LDOA12_LEVEL_mx_ao;
-static struct rpmpd LDOA12_LEVEL_mx = {
+static struct rpmpd mx_l12a_lvl_ao;
+static struct rpmpd mx_l12a_lvl = {
 	.pd = { .name = "mx", },
-	.peer = &LDOA12_LEVEL_mx_ao,
+	.peer = &mx_l12a_lvl_ao,
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd LDOA12_LEVEL_mx_ao = {
+static struct rpmpd mx_l12a_lvl_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &LDOA12_LEVEL_mx,
+	.peer = &mx_l12a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA2_CORNER_mx_ao;
-static struct rpmpd SMPA2_CORNER_mx = {
+static struct rpmpd mx_s2a_corner_ao;
+static struct rpmpd mx_s2a_corner = {
 	.pd = { .name = "mx", },
-	.peer = &SMPA2_CORNER_mx_ao,
+	.peer = &mx_s2a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA2_CORNER_mx_ao = {
+static struct rpmpd mx_s2a_corner_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &SMPA2_CORNER_mx,
+	.peer = &mx_s2a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 2,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd RWMX0_LEVEL_mx_ao;
-static struct rpmpd RWMX0_LEVEL_mx = {
+static struct rpmpd mx_rwmx0_lvl_ao;
+static struct rpmpd mx_rwmx0_lvl = {
 	.pd = { .name = "mx", },
-	.peer = &RWMX0_LEVEL_mx_ao,
+	.peer = &mx_rwmx0_lvl_ao,
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWMX0_LEVEL_mx_ao = {
+static struct rpmpd mx_rwmx0_lvl_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &RWMX0_LEVEL_mx,
+	.peer = &mx_rwmx0_lvl,
 	.active_only = true,
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA6_LEVEL_mx_ao;
-static struct rpmpd SMPA6_LEVEL_mx = {
+static struct rpmpd mx_s6a_lvl_ao;
+static struct rpmpd mx_s6a_lvl = {
 	.pd = { .name = "mx", },
-	.peer = &SMPA6_LEVEL_mx_ao,
+	.peer = &mx_s6a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 6,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA6_LEVEL_mx_ao = {
+static struct rpmpd mx_s6a_lvl_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &SMPA6_LEVEL_mx,
+	.peer = &mx_s6a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 6,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA7_LEVEL_mx_ao;
-static struct rpmpd SMPA7_LEVEL_mx = {
+static struct rpmpd mx_s7a_lvl_ao;
+static struct rpmpd mx_s7a_lvl = {
 	.pd = { .name = "mx", },
-	.peer = &SMPA7_LEVEL_mx_ao,
+	.peer = &mx_s7a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 7,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA7_LEVEL_mx_ao = {
+static struct rpmpd mx_s7a_lvl_ao = {
 	.pd = { .name = "mx_ao", },
-	.peer = &SMPA7_LEVEL_mx,
+	.peer = &mx_s7a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 7,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd LDOA12_mx_vfl = {
+static struct rpmpd mx_l12a_vfl = {
 	.pd = { .name = "mx_vfl", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 12,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd RWMX0_mx_vfl = {
+static struct rpmpd mx_rwmx0_vfl = {
 	.pd = { .name = "mx_vfl", },
 	.res_type = RPMPD_RWMX,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd RWSM6_mx_vfl = {
+static struct rpmpd mx_rwsm6_vfl = {
 	.pd = { .name = "mx_vfl", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 6,
@@ -364,43 +364,43 @@ static struct rpmpd RWSM6_mx_vfl = {
 };
 
 /* MD */
-static struct rpmpd SMPA1_CORNER_md_ao;
-static struct rpmpd SMPA1_CORNER_md = {
+static struct rpmpd md_s1a_corner_ao;
+static struct rpmpd md_s1a_corner = {
 	.pd = { .name = "md", },
-	.peer = &SMPA1_CORNER_md_ao,
+	.peer = &md_s1a_corner_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA1_CORNER_md_ao = {
+static struct rpmpd md_s1a_corner_ao = {
 	.pd = { .name = "md_ao", },
-	.peer = &SMPA1_CORNER_md,
+	.peer = &md_s1a_corner,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd SMPA1_LEVEL_md_ao;
-static struct rpmpd SMPA1_LEVEL_md = {
+static struct rpmpd md_s1a_lvl_ao;
+static struct rpmpd md_s1a_lvl = {
 	.pd = { .name = "md", },
-	.peer = &SMPA1_LEVEL_md_ao,
+	.peer = &md_s1a_lvl_ao,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA1_LEVEL_md_ao = {
+static struct rpmpd md_s1a_lvl_ao = {
 	.pd = { .name = "md_ao", },
-	.peer = &SMPA1_LEVEL_md,
+	.peer = &md_s1a_lvl,
 	.active_only = true,
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd SMPA1_md_vfc = {
+static struct rpmpd md_s1a_vfc = {
 	.pd = { .name = "md_vfc", },
 	.res_type = RPMPD_SMPA,
 	.res_id = 1,
@@ -408,102 +408,102 @@ static struct rpmpd SMPA1_md_vfc = {
 };
 
 /* LPI_CX */
-static struct rpmpd RWLC0_lpi_cx_lvl = {
+static struct rpmpd lpi_cx_rwlc0_lvl = {
 	.pd = { .name = "lpi_cx", },
 	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWLC0_lpicx_vfl = {
-	.pd = { .name = "lpicx_vfl", },
+static struct rpmpd lpi_cx_rwlc0_vfl = {
+	.pd = { .name = "lpi_cx_vfl", },
 	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
 /* LPI_MX */
-static struct rpmpd RWLM0_lpi_mx_lvl = {
+static struct rpmpd lpi_mx_rwlm0_lvl = {
 	.pd = { .name = "lpi_mx", },
 	.res_type = RPMPD_RWLM,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWLM0_lpimx_vfl = {
-	.pd = { .name = "lpimx_vfl", },
+static struct rpmpd lpi_mx_rwlm0_vfl = {
+	.pd = { .name = "lpi_mx_vfl", },
 	.res_type = RPMPD_RWLM,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
 /* SSC_CX */
-static struct rpmpd LDOA26_sscx_corner = {
-	.pd = { .name = "sscx", },
+static struct rpmpd ssc_cx_l26a_corner = {
+	.pd = { .name = "ssc_cx", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 26,
 	.key = KEY_CORNER,
 };
 
-static struct rpmpd RWLC0_ssccx_lvl = {
-	.pd = { .name = "ssccx", },
+static struct rpmpd ssc_cx_rwlc0_lvl = {
+	.pd = { .name = "ssc_cx", },
 	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWSC0_ssccx_lvl = {
-	.pd = { .name = "ssccx", },
+static struct rpmpd ssc_cx_rwsc0_lvl = {
+	.pd = { .name = "ssc_cx", },
 	.res_type = RPMPD_RWSC,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd LDOA26_sscx_vfc = {
-	.pd = { .name = "sscx_vfc", },
+static struct rpmpd ssc_cx_l26a_vfc = {
+	.pd = { .name = "ssc_cx_vfc", },
 	.res_type = RPMPD_LDOA,
 	.res_id = 26,
 	.key = KEY_FLOOR_CORNER,
 };
 
-static struct rpmpd RWLC0_ssccx_vfl = {
-	.pd = { .name = "ssccx_vfl", },
+static struct rpmpd ssc_cx_rwlc0_vfl = {
+	.pd = { .name = "ssc_cx_vfl", },
 	.res_type = RPMPD_RWLC,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd RWSC0_ssccx_vfl = {
-	.pd = { .name = "ssccx_vfl", },
+static struct rpmpd ssc_cx_rwsc0_vfl = {
+	.pd = { .name = "ssc_cx_vfl", },
 	.res_type = RPMPD_RWSC,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
 /* SSC_MX */
-static struct rpmpd RWLM0_sscmx_lvl = {
-	.pd = { .name = "sscmx", },
+static struct rpmpd ssc_mx_rwlm0_lvl = {
+	.pd = { .name = "ssc_mx", },
 	.res_type = RPMPD_RWLM,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWSM0_sscmx_lvl = {
-	.pd = { .name = "sscmx", },
+static struct rpmpd ssc_mx_rwsm0_lvl = {
+	.pd = { .name = "ssc_mx", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 0,
 	.key = KEY_LEVEL,
 };
 
-static struct rpmpd RWLM0_sscmx_vfl = {
-	.pd = { .name = "sscmx_vfl", },
+static struct rpmpd ssc_mx_rwlm0_vfl = {
+	.pd = { .name = "ssc_mx_vfl", },
 	.res_type = RPMPD_RWLM,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
 };
 
-static struct rpmpd RWSM0_sscmx_vfl = {
-	.pd = { .name = "sscmx_vfl", },
+static struct rpmpd ssc_mx_rwsm0_vfl = {
+	.pd = { .name = "ssc_mx_vfl", },
 	.res_type = RPMPD_RWSM,
 	.res_id = 0,
 	.key = KEY_FLOOR_LEVEL,
@@ -511,12 +511,12 @@ static struct rpmpd RWSM0_sscmx_vfl = {
 
 /* mdm9607 RPM Power Domains */
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&SMPA3_LEVEL_cx,
-	[MDM9607_VDDCX_AO] =	&SMPA3_LEVEL_cx_ao,
-	[MDM9607_VDDCX_VFL] =	&SMPA3_cx_vfl,
-	[MDM9607_VDDMX] =	&LDOA12_LEVEL_mx,
-	[MDM9607_VDDMX_AO] =	&LDOA12_LEVEL_mx_ao,
-	[MDM9607_VDDMX_VFL] =	&LDOA12_mx_vfl,
+	[MDM9607_VDDCX] =	&cx_s3a_lvl,
+	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
+	[MDM9607_VDDCX_VFL] =	&cx_s3a_vfl,
+	[MDM9607_VDDMX] =	&mx_l12a_lvl,
+	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
+	[MDM9607_VDDMX_VFL] =	&mx_l12a_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -527,9 +527,9 @@ static const struct rpmpd_desc mdm9607_desc = {
 
 /* msm8226 RPM Power Domains */
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&SMPA1_CORNER_cx,
-	[MSM8226_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
-	[MSM8226_VDDCX_VFC] =	&SMPA1_cx_vfc,
+	[MSM8226_VDDCX] =	&cx_s1a_corner,
+	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8226_VDDCX_VFC] =	&cx_s1a_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -540,14 +540,14 @@ static const struct rpmpd_desc msm8226_desc = {
 
 /* msm8939 RPM Power Domains */
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&SMPA1_CORNER_md,
-	[MSM8939_VDDMDCX_AO] =	&SMPA1_CORNER_md_ao,
-	[MSM8939_VDDMDCX_VFC] =	&SMPA1_md_vfc,
-	[MSM8939_VDDCX] =	&SMPA2_CORNER_cx,
-	[MSM8939_VDDCX_AO] =	&SMPA2_CORNER_cx_ao,
-	[MSM8939_VDDCX_VFC] =	&SMPA2_cx_vfc,
-	[MSM8939_VDDMX] =	&LDOA3_CORNER_mx,
-	[MSM8939_VDDMX_AO] =	&LDOA3_CORNER_mx_ao,
+	[MSM8939_VDDMDCX] =	&md_s1a_corner,
+	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
+	[MSM8939_VDDMDCX_VFC] =	&md_s1a_vfc,
+	[MSM8939_VDDCX] =	&cx_s2a_corner,
+	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[MSM8939_VDDCX_VFC] =	&cx_s2a_vfc,
+	[MSM8939_VDDMX] =	&mx_l3a_corner,
+	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -558,11 +558,11 @@ static const struct rpmpd_desc msm8939_desc = {
 
 /* msm8916 RPM Power Domains */
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&SMPA1_CORNER_cx,
-	[MSM8916_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
-	[MSM8916_VDDCX_VFC] =	&SMPA1_cx_vfc,
-	[MSM8916_VDDMX] =	&LDOA3_CORNER_mx,
-	[MSM8916_VDDMX_AO] =	&LDOA3_CORNER_mx_ao,
+	[MSM8916_VDDCX] =	&cx_s1a_corner,
+	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8916_VDDCX_VFC] =	&cx_s1a_vfc,
+	[MSM8916_VDDMX] =	&mx_l3a_corner,
+	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -573,13 +573,13 @@ static const struct rpmpd_desc msm8916_desc = {
 
 /* msm8953 RPM Power Domains */
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&SMPA1_LEVEL_md,
-	[MSM8953_VDDMD_AO] =	&SMPA1_LEVEL_md_ao,
-	[MSM8953_VDDCX] =	&SMPA2_LEVEL_cx,
-	[MSM8953_VDDCX_AO] =	&SMPA2_LEVEL_cx_ao,
-	[MSM8953_VDDCX_VFL] =	&SMPA2_cx_vfl,
-	[MSM8953_VDDMX] =	&SMPA7_LEVEL_mx,
-	[MSM8953_VDDMX_AO] =	&SMPA7_LEVEL_mx_ao,
+	[MSM8953_VDDMD] =	&md_s1a_lvl,
+	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
+	[MSM8953_VDDCX] =	&cx_s2a_lvl,
+	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8953_VDDCX_VFL] =	&cx_s2a_vfl,
+	[MSM8953_VDDMX] =	&mx_s7a_lvl,
+	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -590,12 +590,12 @@ static const struct rpmpd_desc msm8953_desc = {
 
 /* msm8976 RPM Power Domains */
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&SMPA2_LEVEL_cx,
-	[MSM8976_VDDCX_AO] =	&SMPA2_LEVEL_cx_ao,
-	[MSM8976_VDDCX_VFL] =	&RWSC2_cx_vfl,
-	[MSM8976_VDDMX] =	&SMPA6_LEVEL_mx,
-	[MSM8976_VDDMX_AO] =	&SMPA6_LEVEL_mx_ao,
-	[MSM8976_VDDMX_VFL] =	&RWSM6_mx_vfl,
+	[MSM8976_VDDCX] =	&cx_s2a_lvl,
+	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8976_VDDCX_VFL] =	&cx_rwsc2_vfl,
+	[MSM8976_VDDMX] =	&mx_s6a_lvl,
+	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
+	[MSM8976_VDDMX_VFL] =	&mx_rwsm6_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -606,15 +606,15 @@ static const struct rpmpd_desc msm8976_desc = {
 
 /* msm8994 RPM Power domains */
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&SMPA1_CORNER_cx,
-	[MSM8994_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
-	[MSM8994_VDDCX_VFC] =	&SMPA1_cx_vfc,
-	[MSM8994_VDDMX] =	&SMPA2_CORNER_mx,
-	[MSM8994_VDDMX_AO] =	&SMPA2_CORNER_mx_ao,
+	[MSM8994_VDDCX] =	&cx_s1a_corner,
+	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8994_VDDCX_VFC] =	&cx_s1a_vfc,
+	[MSM8994_VDDMX] =	&mx_s2a_corner,
+	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
 
 	/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-	[MSM8994_VDDGFX] =	&SMPB2_gfx_corner,
-	[MSM8994_VDDGFX_VFC] =	&SMPB2_gfx_vfc,
+	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
+	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -625,13 +625,13 @@ static const struct rpmpd_desc msm8994_desc = {
 
 /* msm8996 RPM Power domains */
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&SMPA1_CORNER_cx,
-	[MSM8996_VDDCX_AO] =	&SMPA1_CORNER_cx_ao,
-	[MSM8996_VDDCX_VFC] =	&SMPA1_cx_vfc,
-	[MSM8996_VDDMX] =	&SMPA2_CORNER_mx,
-	[MSM8996_VDDMX_AO] =	&SMPA2_CORNER_mx_ao,
-	[MSM8996_VDDSSCX] =	&LDOA26_sscx_corner,
-	[MSM8996_VDDSSCX_VFC] =	&LDOA26_sscx_vfc,
+	[MSM8996_VDDCX] =	&cx_s1a_corner,
+	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[MSM8996_VDDCX_VFC] =	&cx_s1a_vfc,
+	[MSM8996_VDDMX] =	&mx_s2a_corner,
+	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[MSM8996_VDDSSCX] =	&ssc_cx_l26a_corner,
+	[MSM8996_VDDSSCX_VFC] =	&ssc_cx_l26a_vfc,
 };
 
 static const struct rpmpd_desc msm8996_desc = {
@@ -642,16 +642,16 @@ static const struct rpmpd_desc msm8996_desc = {
 
 /* msm8998 RPM Power domains */
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =		&RWCX0_LEVEL_cx,
-	[MSM8998_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
-	[MSM8998_VDDCX_VFL] =		&RWCX0_cx_vfl,
-	[MSM8998_VDDMX] =		&RWMX0_LEVEL_mx,
-	[MSM8998_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
-	[MSM8998_VDDMX_VFL] =		&RWMX0_mx_vfl,
-	[MSM8998_SSCCX] =		&RWSC0_ssccx_lvl,
-	[MSM8998_SSCCX_VFL] =		&RWSC0_ssccx_vfl,
-	[MSM8998_SSCMX] =		&RWSM0_sscmx_lvl,
-	[MSM8998_SSCMX_VFL] =		&RWSM0_sscmx_vfl,
+	[MSM8998_VDDCX] =		&cx_rwcx0_lvl,
+	[MSM8998_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
+	[MSM8998_VDDCX_VFL] =		&cx_rwcx0_vfl,
+	[MSM8998_VDDMX] =		&mx_rwmx0_lvl,
+	[MSM8998_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
+	[MSM8998_VDDMX_VFL] =		&mx_rwmx0_vfl,
+	[MSM8998_SSCCX] =		&ssc_cx_rwsc0_lvl,
+	[MSM8998_SSCCX_VFL] =		&ssc_cx_rwsc0_vfl,
+	[MSM8998_SSCMX] =		&ssc_mx_rwsm0_lvl,
+	[MSM8998_SSCMX_VFL] =		&ssc_mx_rwsm0_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -662,13 +662,13 @@ static const struct rpmpd_desc msm8998_desc = {
 
 /* qcs404 RPM Power domains */
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] = &RWMX0_LEVEL_mx,
-	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
-	[QCS404_VDDMX_VFL] = &RWMX0_mx_vfl,
-	[QCS404_LPICX] = &RWLC0_lpi_cx_lvl,
-	[QCS404_LPICX_VFL] = &RWLC0_lpicx_vfl,
-	[QCS404_LPIMX] = &RWLM0_lpi_mx_lvl,
-	[QCS404_LPIMX_VFL] = &RWLM0_lpimx_vfl,
+	[QCS404_VDDMX] = &mx_rwmx0_lvl,
+	[QCS404_VDDMX_AO] = &mx_rwmx0_lvl_ao,
+	[QCS404_VDDMX_VFL] = &mx_rwmx0_vfl,
+	[QCS404_LPICX] = &lpi_cx_rwlc0_lvl,
+	[QCS404_LPICX_VFL] = &lpi_cx_rwlc0_vfl,
+	[QCS404_LPIMX] = &lpi_mx_rwlm0_lvl,
+	[QCS404_LPIMX_VFL] = &lpi_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -679,16 +679,16 @@ static const struct rpmpd_desc qcs404_desc = {
 
 /* sdm660 RPM Power domains */
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =		&RWCX0_LEVEL_cx,
-	[SDM660_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
-	[SDM660_VDDCX_VFL] =		&RWCX0_cx_vfl,
-	[SDM660_VDDMX] =		&RWMX0_LEVEL_mx,
-	[SDM660_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
-	[SDM660_VDDMX_VFL] =		&RWMX0_mx_vfl,
-	[SDM660_SSCCX] =		&RWLC0_ssccx_lvl,
-	[SDM660_SSCCX_VFL] =		&RWLC0_ssccx_vfl,
-	[SDM660_SSCMX] =		&RWLM0_sscmx_lvl,
-	[SDM660_SSCMX_VFL] =		&RWLM0_sscmx_vfl,
+	[SDM660_VDDCX] =		&cx_rwcx0_lvl,
+	[SDM660_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
+	[SDM660_VDDCX_VFL] =		&cx_rwcx0_vfl,
+	[SDM660_VDDMX] =		&mx_rwmx0_lvl,
+	[SDM660_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
+	[SDM660_VDDMX_VFL] =		&mx_rwmx0_vfl,
+	[SDM660_SSCCX] =		&ssc_cx_rwlc0_lvl,
+	[SDM660_SSCCX_VFL] =		&ssc_cx_rwlc0_vfl,
+	[SDM660_SSCMX] =		&ssc_mx_rwlm0_lvl,
+	[SDM660_SSCMX_VFL] =		&ssc_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -699,14 +699,14 @@ static const struct rpmpd_desc sdm660_desc = {
 
 /* sm4250/6115 RPM Power domains */
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =		&RWCX0_LEVEL_cx,
-	[SM6115_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
-	[SM6115_VDDCX_VFL] =		&RWCX0_cx_vfl,
-	[SM6115_VDDMX] =		&RWMX0_LEVEL_mx,
-	[SM6115_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
-	[SM6115_VDDMX_VFL] =		&RWMX0_mx_vfl,
-	[SM6115_VDD_LPI_CX] =		&RWLC0_lpi_cx_lvl,
-	[SM6115_VDD_LPI_MX] =		&RWLM0_lpi_mx_lvl,
+	[SM6115_VDDCX] =		&cx_rwcx0_lvl,
+	[SM6115_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
+	[SM6115_VDDCX_VFL] =		&cx_rwcx0_vfl,
+	[SM6115_VDDMX] =		&mx_rwmx0_lvl,
+	[SM6115_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
+	[SM6115_VDDMX_VFL] =		&mx_rwmx0_vfl,
+	[SM6115_VDD_LPI_CX] =		&lpi_cx_rwlc0_lvl,
+	[SM6115_VDD_LPI_MX] =		&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -717,12 +717,12 @@ static const struct rpmpd_desc sm6115_desc = {
 
 /* sm6125 RPM Power domains */
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =		&RWCX0_LEVEL_cx,
-	[SM6125_VDDCX_AO] =		&RWCX0_LEVEL_cx_ao,
-	[SM6125_VDDCX_VFL] =		&RWCX0_cx_vfl,
-	[SM6125_VDDMX] =		&RWMX0_LEVEL_mx,
-	[SM6125_VDDMX_AO] =		&RWMX0_LEVEL_mx_ao,
-	[SM6125_VDDMX_VFL] =		&RWMX0_mx_vfl,
+	[SM6125_VDDCX] =		&cx_rwcx0_lvl,
+	[SM6125_VDDCX_AO] =		&cx_rwcx0_lvl_ao,
+	[SM6125_VDDCX_VFL] =		&cx_rwcx0_vfl,
+	[SM6125_VDDMX] =		&mx_rwmx0_lvl,
+	[SM6125_VDDMX_AO] =		&mx_rwmx0_lvl_ao,
+	[SM6125_VDDMX_VFL] =		&mx_rwmx0_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -732,16 +732,16 @@ static const struct rpmpd_desc sm6125_desc = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] = &RWCX0_LEVEL_cx,
-	[SM6375_VDDCX_AO] = &RWCX0_LEVEL_cx_ao,
-	[SM6375_VDDCX_VFL] = &RWCX0_cx_vfl,
-	[SM6375_VDDMX] = &RWMX0_LEVEL_mx,
-	[SM6375_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
-	[SM6375_VDDMX_VFL] = &RWMX0_mx_vfl,
-	[SM6375_VDDGX] = &RWGX0_LEVEL_gx,
-	[SM6375_VDDGX_AO] = &RWGX0_LEVEL_gx_ao,
-	[SM6375_VDD_LPI_CX] = &RWLC0_lpi_cx_lvl,
-	[SM6375_VDD_LPI_MX] = &RWLM0_lpi_mx_lvl,
+	[SM6375_VDDCX] = &cx_rwcx0_lvl,
+	[SM6375_VDDCX_AO] = &cx_rwcx0_lvl_ao,
+	[SM6375_VDDCX_VFL] = &cx_rwcx0_vfl,
+	[SM6375_VDDMX] = &mx_rwmx0_lvl,
+	[SM6375_VDDMX_AO] = &mx_rwmx0_lvl_ao,
+	[SM6375_VDDMX_VFL] = &mx_rwmx0_vfl,
+	[SM6375_VDDGX] = &gx_rwgx0_lvl,
+	[SM6375_VDDGX_AO] = &gx_rwgx0_lvl_ao,
+	[SM6375_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
+	[SM6375_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -751,14 +751,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] = &RWCX0_LEVEL_cx,
-	[QCM2290_VDDCX_AO] = &RWCX0_LEVEL_cx_ao,
-	[QCM2290_VDDCX_VFL] = &RWCX0_cx_vfl,
-	[QCM2290_VDDMX] = &RWMX0_LEVEL_mx,
-	[QCM2290_VDDMX_AO] = &RWMX0_LEVEL_mx_ao,
-	[QCM2290_VDDMX_VFL] = &RWMX0_mx_vfl,
-	[QCM2290_VDD_LPI_CX] = &RWLC0_lpi_cx_lvl,
-	[QCM2290_VDD_LPI_MX] = &RWLM0_lpi_mx_lvl,
+	[QCM2290_VDDCX] = &cx_rwcx0_lvl,
+	[QCM2290_VDDCX_AO] = &cx_rwcx0_lvl_ao,
+	[QCM2290_VDDCX_VFL] = &cx_rwcx0_vfl,
+	[QCM2290_VDDMX] = &mx_rwmx0_lvl,
+	[QCM2290_VDDMX_AO] = &mx_rwmx0_lvl_ao,
+	[QCM2290_VDDMX_VFL] = &mx_rwmx0_vfl,
+	[QCM2290_VDD_LPI_CX] = &lpi_cx_rwlc0_lvl,
+	[QCM2290_VDD_LPI_MX] = &lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {

-- 
2.39.2

