Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684736F6696
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjEDICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjEDIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C863ABF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eff50911bfso178773e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187295; x=1685779295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHuJqh6clnMhDFgSRdYKRfsY4OFox3kTZVS9qASymWE=;
        b=zUipfNWaazL6ADynZcrfI01DUbRNogvA6LUhNvy2poxcQQzU2Jpsb0ktYJC/nSpVFf
         DkqZSLSzujw/tun5InCQmu35+nV9qnAWVgoGQlOzqQqBMgpw//jzw2E/3xRqDvQ0W91y
         KaEuNlbZYNYmCO+QChSO4QTI36SicJPWc33Z01H57/lVqzQNH90zBipn4cfencFclMqz
         KkhcRtp4zyHBFgl3MlqCvU5dvDQ9C8rrbPMR7aHzZaUvUhg48RwhHcK5CcYfG3UdvHuY
         FNyXAMDHDisRWW2jQifShPgdk61CGuq17aL9bRnNk1V5QX8nlnvsBPlzJ+gJtH80ixOz
         wPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187295; x=1685779295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHuJqh6clnMhDFgSRdYKRfsY4OFox3kTZVS9qASymWE=;
        b=Np79NfvvFN9O/0PWzeCpwRfSg49xNAhlBWANbs/mQn5U2ue24A8kuLi3k2d2mHkWIF
         412MgPV0o36VtSENA8heuh8Wo+lQaLgmGGKZHe+itWxLgvcluTruifri/L8YauwPRWKP
         CZdNo3b18MSd+U7XgI8kG7jqXuFR3hINkA5eZGzs1rOp7n2EIq4qC8bDJueel2g6Qs9b
         M2dBQuGwYGOKcJSawByeiGTIhLEPxzDw9oJWvd/QTfECkUW/nsuz7Oh0feQjMInSG3t4
         c95imSaikHeGl8ocye2uVDg5zdrDPZcA9MhUCEcAuqf9Rztpm3tGG0pC9cO0KBly43hY
         MBsg==
X-Gm-Message-State: AC+VfDzoR6UMkL8eYjl+G1m7OcdBnjV4m7WADj27HrjymGwJcvVHV35N
        SJDUY67gkLY28fmJ92zO0RuzkA==
X-Google-Smtp-Source: ACHHUZ4jXpNAXiNQ+8fkcQL4xLCnog3hMv3MDLsB0HYPtmUb77QHwSrtkX4hvj4cHiv5ONLcRZrciA==
X-Received: by 2002:a19:7503:0:b0:4f0:4b:538f with SMTP id y3-20020a197503000000b004f0004b538fmr1601126lfe.29.1683187295132;
        Thu, 04 May 2023 01:01:35 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:02 +0200
Subject: [PATCH v2 06/18] media: venus: firmware: Leave a clue for
 homegrown porters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-6-d95d14949c79@linaro.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
In-Reply-To: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1135;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EgjRQOY12/YgIbWH62eZ5y8nBX3H3pJik8G0F4SYRFY=;
 b=nQEw2k9F74MAxmf470Mil8wFjXEeWKtb4BAhs5r6xj+O8SHhrmSmWKpItUFOnSd0pmnBcqWBf
 EfAAgrecd0rDMOpthvvcK/aABUI8hm23nzqEXoXqbALT36JM+Qmn8SL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leave a clue about where the seemingly magic values come from, as it
is not obvious and requires some digging downstream..

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index cfb11c551167..a4cd919e1dbe 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -241,6 +241,13 @@ int venus_boot(struct venus_core *core)
 		return ret;
 
 	if (core->use_tz && res->cp_size) {
+		/*
+		 * Clues for porting using downstream data:
+		 * cp_start = 0
+		 * cp_size = venus_ns/virtual-addr-pool[0] (yes, addr not size)
+		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
+		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
+		 */
 		ret = qcom_scm_mem_protect_video_var(res->cp_start,
 						     res->cp_size,
 						     res->cp_nonpixel_start,

-- 
2.40.1

