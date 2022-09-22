Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380975E5D88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIVIbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiIVIa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:30:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64E89CF8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:30:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t14so14255528wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yMyeJjCdNNiGUuThqHk0PauP+dgra8U1iiTiP5AqZ5s=;
        b=3Drg2x6qOY2JRZezvdAW9KcV8FcwbDOaUIrBMpW9GG7FsWPDjLfbvkFF1yDS1r5Wsx
         Xu92RIDguJF6Gs/BKA2fclza5UCghMSfS0otTIa2HC92/P6OIItDMj3I9cKy6wqHXKPB
         GJdVa7Nxo8nsLwFaff9QWpdPDg4cn6Ibg0A5VVzdCcgKD4wkFhuf09vNvyLKIRM2OqjD
         CVLpwHSZxXXjxMCwbwIRzTb7HsRYlj+yUt/5ktbTQ/Of8zOcnrV+OXdKcm1AZFgGqhuo
         Yl2UUPvgdxVv+lQGQCAxjtKsE/Q2orLjzSgeKQP78loMzUORZbfycZ7tGRxOwJStP6Uc
         l0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yMyeJjCdNNiGUuThqHk0PauP+dgra8U1iiTiP5AqZ5s=;
        b=S85cN7fVNHqKNUNWAaOU/jGTdCR20tJjJRWPFdqgxClgpsmA6AjWu22yqZzFGU8xJS
         kgXgZarmdsQAd+kkCmtQoCsmyks10jZldensA8RiZ2rz67dzbymcJS+nCHRIbGV2pFrr
         XggN0rdPQYAv5runuOG5N3y/FFMxwC5u6rJD3z9eDux99/nE8jYx1Bm+DXbWb4BS5UJT
         5Ng8XhM0PQaFHf10eSfOCHN4XEfYzAjgAOSIAuwKN19o1fM9ykpEOEoQOgbn8/MAyn8N
         jLjuWTgDczNaxiMu3Xjy0DOdlns6XCAFeun4LQLT7mB2OrVgPUBZYQu53ihiSeZDENpc
         l2LQ==
X-Gm-Message-State: ACrzQf0DYBUSs8aN46PDZdOvknZBqt9l/3gDw78BzzrBWnKdUj4PYfRZ
        a/K8JbXOCjR1fGhHZbSMvppBNqX+lDEcHg==
X-Google-Smtp-Source: AMsMyM4AN39EDQ8ZS/jGzwQpomifGBPbh2W14gq6R14hh7MkoDjso8KCm3hHFeC7Y9mYAlo0edsnYQ==
X-Received: by 2002:a5d:5887:0:b0:22b:107e:7e39 with SMTP id n7-20020a5d5887000000b0022b107e7e39mr1250324wrf.694.1663835441133;
        Thu, 22 Sep 2022 01:30:41 -0700 (PDT)
Received: from otso.. (212095005231.public.telering.at. [212.95.5.231])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b00228b3ff1f5dsm5088476wrv.117.2022.09.22.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:30:40 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] soc: qcom: spmi-pmic: convert hex numbers to lowercase
Date:   Thu, 22 Sep 2022 10:29:22 +0200
Message-Id: <20220922082925.17975-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some IDs that are written in uppercase. For consistency
convert them to lowercase.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v3:
* reword subject
* pick up tags

 include/soc/qcom/qcom-spmi-pmic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 72398ff44719..fde0148d0077 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -29,9 +29,9 @@
 #define PM8998_SUBTYPE		0x14
 #define PMI8998_SUBTYPE		0x15
 #define PM8005_SUBTYPE		0x18
-#define PM660L_SUBTYPE		0x1A
-#define PM660_SUBTYPE		0x1B
-#define PM8150_SUBTYPE		0x1E
+#define PM660L_SUBTYPE		0x1a
+#define PM660_SUBTYPE		0x1b
+#define PM8150_SUBTYPE		0x1e
 #define PM8150L_SUBTYPE		0x1f
 #define PM8150B_SUBTYPE		0x20
 #define PMK8002_SUBTYPE		0x21
-- 
2.37.3

