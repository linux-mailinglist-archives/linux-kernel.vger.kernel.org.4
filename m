Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BB5F74B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJGHbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJGHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:31:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD4C0696;
        Fri,  7 Oct 2022 00:31:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s20so6039399lfi.11;
        Fri, 07 Oct 2022 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EYSGULqa5xfW659MCGZ1cJazL97U/ExMDYm/HUp34jc=;
        b=aWEK54yQMnoWsg52sifbjsz+ERvWv8idSbv7d/i7YgBWk3Q0eMeZueLfGWlBbGUB51
         0Bdfj7vIhEFfak3R/EGLhKguWiPd1BcPW3zQfCncEiv3Xnu071lYO8+AgnlHw6H8ST45
         GEWcmyJxni4RxaOmx6TN3QlCOCuh5N3/L4VS3Q78L3UGqdJPeqHsuNwzQOO21x2LAswi
         588I9NAaFl85/HWWRGZeRObyEndpifEcNDNN+7plEINLZyU4b1j9mVkDMJa85Znpo0xO
         Fx6qwV1JTwwH4K9U3Y9J8XDC5GOaxVFhRE1cohOJhP9wzAB+7+fCLysFlbKzErJKBss5
         SfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EYSGULqa5xfW659MCGZ1cJazL97U/ExMDYm/HUp34jc=;
        b=FBDAuZhvJl10wPlg5Odr1Fi3jqMZf8c0rtuR67+XBm5J5GR7rWV51AMVrGOaBD608w
         en3a2ITqhcDzvkO/pdaooDGbys2W1pvFC1pLpwPt8jEpUk4ohRiNLyj+Z6tVU52/6kNT
         pBpaOG05rnc1khLEXme1+RfzlyMvuQ+uoosaB7BCfpUdz8LoJ1fWPj0a8vGdQxHAtbC8
         ysxKC4bEK+yzZuk03s5LOmX9sHFmBdbY8Fx8IQCddOS0VdlXdiq14fJo9kxL6NBp1M1t
         SIyh3yZj1PqOz0DXOiOs3Pd0JH/A/nX3OkeUFDIClM1vp+vMFj3yZmF4HJS/sfnnZPUt
         tw5w==
X-Gm-Message-State: ACrzQf1Z9Ws+NldIwA+mGgoUjaq0l4pD4O7cIuTA+imwx+RftY5K9K1/
        J0vt6p6eGmXzhZTEpFddhuM=
X-Google-Smtp-Source: AMsMyM7VcZMfaeRok8chUjeQBJg6+kCAAGwiL9obfGOWsOtiYCMpNuM5IaftejwLSI0AqVvsCBEcrA==
X-Received: by 2002:a05:6512:6c2:b0:4a2:e7c:6164 with SMTP id u2-20020a05651206c200b004a20e7c6164mr1415568lff.329.1665127868220;
        Fri, 07 Oct 2022 00:31:08 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b004917a30c82bsm185611lfr.153.2022.10.07.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:31:07 -0700 (PDT)
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
Subject: [PATCH v2] thermal: imx8mm_thermal: wait for a valid measurement
Date:   Fri,  7 Oct 2022 09:30:57 +0200
Message-Id: <20221007073057.41803-1-marcus.folkesson@gmail.com>
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

Check if first measurement is still pending or if temperature is out of
range.
Return and try again later if that is the case.

Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2: Also invalidate if temperature > max (125 degrees C)

 drivers/thermal/imx8mm_thermal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..e42bf373cebc 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -62,11 +62,17 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
 {
 	struct tmu_sensor *sensor = data;
 	struct imx8mm_tmu *tmu = sensor->priv;
-	u32 val;
+	bool ready;
+	unsigned long val;
+
+	val = readl_relaxed(tmu->base + TRITSR);
+	ready = test_bit(probe_status_offset(1), &val);
+	if (!ready)
+		return -EAGAIN;
 
-	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
+	val = val & TRITSR_TEMP0_VAL_MASK;
 	*temp = val * 1000;
-	if (*temp < VER1_TEMP_LOW_LIMIT)
+	if (*temp < VER1_TEMP_LOW_LIMIT || *temp > VER2_TEMP_HIGH_LIMIT)
 		return -EAGAIN;
 
 	return 0;
-- 
2.37.1

