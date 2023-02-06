Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A606568BF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBFN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBFN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:14 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0A27996
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:58:34 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id h3so2592690wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnaxyOtUPNOU2cKwBwASl1WNeZj+fgcT9n0v3Etq/6A=;
        b=SYXIzZ381IGT4ZNVpjknW0muG49Hf3FitrNNCJ+VOS+GTzHQ9i1cNTH/MMAZwjx6PH
         /vPy6UB6zuUZkWQFsgGeXpNTrbrqOYhX9XavarHwldOaoGe229j3vbAB4SOK+lJnsfOO
         7F6faj8uZwXArEyeB9VEwpLPcxEKnzlT6kBLX4C2mjk6Fvu/dsZp2vyLyFRl+Mu2Iwi3
         OX4XprRqyOoIcddTADouZu7NAx6lBdy36RyNwIdMT5dJnhys/cpZZd/ej/Rj0MKPef/l
         AlgSBu3N5kl22x8gCDHLu7XMUp1dTBo2MUaCPQmBusaMqB3BSYb7Ey7mzUb7eS+F+zUv
         r3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnaxyOtUPNOU2cKwBwASl1WNeZj+fgcT9n0v3Etq/6A=;
        b=RZDq/CLJPRjwfn/6rKusTEJ9lMgJQb1XpZxsHQ/+mwDv9FtwsFO2TpKwbQbbYfjH5L
         lawLE5hRi13EN6Q269ZhcZkUEWCtiu0tRY1iqSyE6sbUpN39ZVy03DzqPponOVKNG0xL
         scu/QYg6zRqpwETJgPlI/oU5rxxeENvk5jzViOPTkWOGERric5ZcY4PvM2yrnOX82DQ8
         vOL+5DW68RcyWlnlQLiHYRU4DWVGqKFA4l6wikhzpWIfoQQD1MLzVFj1HnkwQbnmrbX2
         FR92Kifzl8AOIaHTN/AecChkzJb7agwEOzQ0OcOS6f0f9RvmBJ9x6ZKndMpFqGGHDUtx
         EEkA==
X-Gm-Message-State: AO0yUKWdTuZcU+t93lx54SVM4gJpcCdjL2lJ3MYkEMPmg7HXFJ+Y57p+
        L2kBsKXom/oKANl29AwIkxBTTg==
X-Google-Smtp-Source: AK7set9PZVXf9K91w978zpO/9vUZnxBx+llHV3epEaFUn0yWEtFTQ+0tn9pEVGuyGRMeRr2a71f1uw==
X-Received: by 2002:adf:c713:0:b0:2bf:e05f:53ac with SMTP id k19-20020adfc713000000b002bfe05f53acmr18055137wrg.45.1675691613004;
        Mon, 06 Feb 2023 05:53:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d65cf000000b002bfc0558ecdsm8839943wrw.113.2023.02.06.05.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:53:32 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Feb 2023 14:53:31 +0100
Subject: [PATCH] remoteproc: qcom_q6v5_pas: enable sm8550 adsp & cdsp
 autoboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-v1-1-11445a0c27c6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFoG4WMC/x2O0QoCIRBFf2XxuQHXsK1+JXrQaWyF1ZFRI1j23
 5Mez4F7uLuqJJGquk+7EvrEGjkPmE+TwtXlN0F8DVZGm7M2+gKNS0So6Wqthl5qE3IJQvyCUOJ
 GRRjB9caeuYHFhULAMN8WVKPpXSXw4jKuo5r7tg1ZhMb+f+LxPI4fnUw/nJQAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the SM8550 adsp & cdsp auto_boot to true to match the behavior
of the previous platforms.

Fixes: 7eddedc97563 ("remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 4e1d9b08def4..90c5612a3045 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1108,7 +1108,7 @@ static const struct adsp_data sm8550_adsp_resource = {
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
 	.minidump_id = 5,
-	.auto_boot = false,
+	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -1127,7 +1127,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
 	.pas_id = 18,
 	.dtb_pas_id = 0x25,
 	.minidump_id = 7,
-	.auto_boot = false,
+	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mxc",

---
base-commit: ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf
change-id: 20230206-topic-sm8550-upstream-fix-remoteproc-autoboot-5c7effcf197c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

