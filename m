Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8465E962
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAEKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjAEKy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:54:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7244C65;
        Thu,  5 Jan 2023 02:54:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so892290wrv.7;
        Thu, 05 Jan 2023 02:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jv0GR470MWgiD3mfl5X1bKpTXHWvkolc5a9wY9HKdXc=;
        b=bIxbw96/A1sJN+bIpREHnJIorPMs8VvgHbuaNT/hFwUWdCsSGgO8RUcTOkpWRtjI9G
         oWHtiPdZYnoOqiyPy2gs6x38EfPE0ZEo+yn2INV9GU8AJbk7fugW0U8Sia7uxg+wN4+H
         a5eUzKEfEG3dZ1Q32U+0AWjIPEphHI4YaUjhfnNM0upYEUH44QiMGnndQpYXrjqhPwGY
         qfL7+0DWsb1KcZM2gE2eCYCn6jJuS1AsjwGxNRc0ryBZspPVxA8hKZLVaYC3H0tWgvLc
         tZnoGMWMiL/Dp4syYkFWEwDuWi5/YSC4i4EyGTOxc9v5+bDiSIr+dadoGN2/5PtgDq27
         0YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv0GR470MWgiD3mfl5X1bKpTXHWvkolc5a9wY9HKdXc=;
        b=HpLd+vqsLBnxTMl9MWIkzSgRi+MhdPG84vM3WRO7SnOhbnk+zglVWyv2OkhGvVMlHZ
         SAWzvyUbxSraxVS9wPUFBQclW+WHrtFfHZBsCminLYSp7rwtleKDmmZGTi/CXzDl9oYC
         vD5yobowDtiHXqjcM8SGvcN8l9m9pMOQi+gT/KHGf4WsASrvb5ISa019Hdxpa+svpReA
         t8tmagSp8qf116CMTTuJ1aSDs36ynv3aoVsKC+mCBsCXWKdpsMp006VWW9pgbc/u+ri1
         li9wr5bjlhAvbeEMJBXlgwVuxI5cpW2wsKGQ8+CgDhtdlAjeYM4urEcmRJG4P2QPeCsi
         z2rQ==
X-Gm-Message-State: AFqh2kpiviGWiljAHxlNGQeV7fUSuVZyRrj48LC6HTLtl2KnYriIezYp
        +U3PQR6FsdJRV6chlD+uLBI=
X-Google-Smtp-Source: AMrXdXu9fCIMloz3wZcsshGUNDrZpUQk+/zBa0oWHKenigtLxNcjAbzS44P/5mYopHMUNpokS6Y8AA==
X-Received: by 2002:adf:fe09:0:b0:242:149c:6d29 with SMTP id n9-20020adffe09000000b00242149c6d29mr28395857wrr.16.1672916064665;
        Thu, 05 Jan 2023 02:54:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bt18-20020a056000081200b002368f6b56desm4557610wrb.18.2023.01.05.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:54:24 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:54:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: dcc: Delete some bogus dead code
Message-ID: <Y7asVSr5ERGCZedk@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7asNqoIapctHmbI@kili>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It feels very wrong to assign "cfg.sram_offset" to be out of bounds.
Fortunately, this is just dead code and can be deleted.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/soc/qcom/dcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index 1e2cbefc1655..681d55018e66 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -483,10 +483,8 @@ static int dcc_emit_config(struct dcc_drvdata *drvdata, unsigned int curr_list)
 	/* Update ram_cfg and check if the data will overstep */
 	drvdata->ram_cfg = (cfg.sram_offset + total_len) / 4;
 
-	if (cfg.sram_offset + total_len > drvdata->ram_size) {
-		cfg.sram_offset += total_len;
+	if (cfg.sram_offset + total_len > drvdata->ram_size)
 		goto overstep;
-	}
 
 	drvdata->ram_start = cfg.sram_offset / 4;
 	return 0;
-- 
2.35.1

