Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD47F617E65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiKCNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKCNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:50:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA595B8;
        Thu,  3 Nov 2022 06:50:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so2837512wrt.11;
        Thu, 03 Nov 2022 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THbX1EhgVaNh83+sx5ydTUKPbkRpoGl3oIFhFRQm/vs=;
        b=ajsjzDRCTwC4tLwlV6oQlpoQBt6VGNxiinVyYG876NsWH5cpgnWZSQcX/ZBAxixFSq
         FiiTWm4D4rVmAW6h9SbBWQhuFZmWq5Utq27tZtWj8gEW9ktcf6i64kdMnDHz+0Gjrgs6
         pkjLe0hF+XqcBKTD/s614z5Pl+DMH5sE1W9MFqj1IiufRizNXIp+UeLrJzvZ5i2qY6Nk
         4DTpePodRvS/BoAFNaUmF5EnDdeQdSHZej2wzQiEUta+U4+m2V4l7wi+BzPtyuj9Dx9V
         EKMUz/R11LZcS8AbL3TnR3P0yA7r6ATvpKd0NkIoe16lD+CIRiHCQ1puy2mFj91sJ0de
         Coig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THbX1EhgVaNh83+sx5ydTUKPbkRpoGl3oIFhFRQm/vs=;
        b=UdRGLJsQKE9Y6JmT131C4nrkmmbWrrePgayk5Xl5XRtDCjGloETAdFsO5cBSjfBwn5
         ZgCVJ6lOeDMsLFjyUb1+bxBZ0zZPGjgaqEgc9gCNNQ4aVh3AZHZq5OTBJMvyFDe0caBw
         maPrBZbux7vZDMH3dr/k6udMrq3PGJO7YPPBysQPuLoIN1rpSHWuga73l+dWyta727z9
         v/8sDRWJWlIEy0UZDCVnef0DK6voKKoBBB8pK8lqasqCrZuhJ4dCPiNVEkLp0P2vBQJr
         P8RmgzEKGuS+I382QMdd+l90SjmKmhj0pCTKZjv8X3tBurkQDkscQ6rHOF9iwy1Y1qdv
         Yw7g==
X-Gm-Message-State: ACrzQf0TsayYXCioglKHdq+oKSa/CiDqHboDqAsakM4R/PYCrqDO9NHm
        07P31VufhnPV0h/lAi0oVF/6mtP+nlo=
X-Google-Smtp-Source: AMsMyM4yIgJaQxba4QvDvKfMkGAxJxaOLKXNeC2uHrFj5CPn929hQ920/v7wPgWne6gNSqTfyRPw4Q==
X-Received: by 2002:a5d:65cf:0:b0:236:9119:be3 with SMTP id e15-20020a5d65cf000000b0023691190be3mr18412969wrw.602.1667483405892;
        Thu, 03 Nov 2022 06:50:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm957414wrb.12.2022.11.03.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:50:05 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/4] clk: qcom: gcc-sdm660: drop redundant F define
Date:   Thu,  3 Nov 2022 14:49:42 +0100
Message-Id: <20221103134944.23275-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103134944.23275-1-ansuelsmth@gmail.com>
References: <20221103134944.23275-1-ansuelsmth@gmail.com>
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

The same exact F frequency table entry is defined in clk-rcg.h
Drop the redundant define to cleanup code.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-sdm660.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index db918c92a522..6afce8e42ede 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -25,8 +25,6 @@
 #include "reset.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_SLEEP_CLK,
-- 
2.37.2

