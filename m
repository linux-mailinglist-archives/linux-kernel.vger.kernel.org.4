Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8A5FE9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJNHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJNHfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:35:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A2748DB;
        Fri, 14 Oct 2022 00:35:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a6so5034717ljq.5;
        Fri, 14 Oct 2022 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIrAOKwVuY5kEsu3nbUg3gcHFVvE5jEAz03maY5C6/Q=;
        b=UOO74Gnm40KO5uUURhv6pfgy1fP2pYjxeJ/fpThwsIfZoremffV/su/bQr56v9fyNm
         A+MkE1XZQ1P+lJPHStdfCR3ZlsVEjPo+Jr0TpGWuAnOGd/FpDaiSuXw4avKyYOsceEJl
         v/8RHDdtjZ/2t9V/T68nLUwM10dvvpjeoYbovP1ZH2G6hJiffEBIv63vfVx7sIiNjADW
         SpJUP5lfxXM3+wcr9jsbspNa/0Kcgu7GQcPX/NnkOOe2Pg/Je2zzjjVG8LDSjw3j/7UT
         e0tw+dzVA6xS30Sm4HTtf7hzqqsU5y5S3QiI+lDPaI2+vHtbyJ0/e1ZBzsP/VuTPaYgt
         dnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIrAOKwVuY5kEsu3nbUg3gcHFVvE5jEAz03maY5C6/Q=;
        b=0cshdIsjxjMydpO5FL3rwOvetFVhohRwiUIit8cvhpEkdlvNPPo8qFaZtBUxuj1Sjw
         JHtIXQVdthafmiqvGgH62GrEkkQmuXQ5eNkQs5h4RDcdYpBMB3KXW2W36CcQRGKWIi05
         K0VXISRYFGhxIEo6wfAsu0wip4fOZOLS4h6g4iMGPZFklvHWn8Nb5zCUb300KEnd7lug
         23GbuGwHxRStgFEuIivD+ajtjd3ZWugM8P8T83gCJ18Fgvye/7JYEEK2tNoLr+kf3jH+
         EmIBjjEBVsud4ziXMIn60GPV9LF1S0B3ucl8o3fvqWF7EpcfV4KlhG0S59VU3c1ojUtW
         izTA==
X-Gm-Message-State: ACrzQf3cPZjjI/N5ujam1TXY6o9KfGe6Np6GAQzyCGWjSNd1TGlpBLG5
        DyzPcmPYDdGEt8OCZ4B4vUE=
X-Google-Smtp-Source: AMsMyM607f+HvLj+Q7vb7EKtlnJxT117/QNV5iJ2skOd/Y7BWPwtqH2zEjnybMzC8DYCQamdmIs52w==
X-Received: by 2002:a05:651c:242:b0:26d:fb4b:9c8 with SMTP id x2-20020a05651c024200b0026dfb4b09c8mr1373763ljn.353.1665732918422;
        Fri, 14 Oct 2022 00:35:18 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id j18-20020ac253b2000000b004a05622a852sm229295lfh.241.2022.10.14.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:35:17 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
Date:   Fri, 14 Oct 2022 09:35:07 +0200
Message-Id: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Check against the upper temperature limit (125 degrees C) before
consider the temperature valid.

Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2: Also invalidate if temperature > max (125 degrees C)
    v3: Only check temperature range as the valid bit is invalid.

 drivers/thermal/imx8mm_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..c5cd873c6e01 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -65,8 +65,14 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
 	u32 val;
 
 	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
+
+	/*
+	 * Do not validate against the V bit (bit 31) due to errata
+	 * ERR051272: TMU: Bit 31 of registers TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid
+	 */
+
 	*temp = val * 1000;
-	if (*temp < VER1_TEMP_LOW_LIMIT)
+	if (*temp < VER1_TEMP_LOW_LIMIT || *temp > VER2_TEMP_HIGH_LIMIT)
 		return -EAGAIN;
 
 	return 0;
-- 
2.37.1

