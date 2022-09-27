Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E05EC1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiI0LwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiI0Lvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:51:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F2A1D0A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:51:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so8857463pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=U3lfCgccZacgh+TSQp+9xE8hshjr/70Enldq2FxBY+w=;
        b=Q7AJCtV730cNB/lIe5AnV8hTEOSgJhMMEcD+T1teyqBhN6omTkVLiZS6+pjD9OxRMV
         ONdWXf6sQMLHAqT0BSYCb8Iigr+IsrTlCJUMe+mEU124ZqG72/HzSd+T+mfILlCDrJUF
         12PycQ/5M1ohE9z7S2Nwb0GPCPtkrU1ZdhKW9WrjQYhwVO9WddzbyFLX3FZQ0isDO0DW
         JmKWGM6xsUr7qDwJ9tiPHYx4LOX3qlNNIcD7kNvq4Jyd6a82/jXe7NRHw/UKTdPKyK1U
         vVXVywFdjqYzRbpBODF36q/f1SwgGC32nFvDIxhH0etw5bI6sj6nvYGYIesEk/+ehFyo
         pDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=U3lfCgccZacgh+TSQp+9xE8hshjr/70Enldq2FxBY+w=;
        b=UsOIWs8ZQLb1tJW85Vx/9D1Y5oHzgvEqJCFvh3KEvPndRfRqnP0xgviHuDRu1K8Au+
         PrLkMv5B3RZ5qTsmSUqmUaulgODCWou6prfN9yOJJEYBMDHkbE3Kvx5+oYkylGy4MmEN
         O41RWSoKOAeWejCaj1+Os3GgKc+IxYq2n6v/uJBtV9/aJIQFQdUL5Wlbu+uet7Zx5RmK
         aPmehSPZ4373A39qN5IkvlA6nzW7yTgEUpn6A8SEvIjCzV5xJs09WaUzG9fV0oM6Uhcg
         E7AS7cSudU8sIZtilK9fVfj83GvMhM+Dazh0Y07WqAElsYfJV2wfdAt/dig8SXY8gRvw
         LaOg==
X-Gm-Message-State: ACrzQf3txe/09OihQh3aPYfT+76wv70b6tSewBOmRpDTCs7/8vlRFEF0
        6ZaM+p5NX0lPVgq8PWqgx7w=
X-Google-Smtp-Source: AMsMyM5GDaN4YQyjR2a5Pfl9SmuWMx4BnJch/7YRntadhPPMcchhZkKvZl6ewsgyBCxKmQUuhQiWQw==
X-Received: by 2002:a17:902:864a:b0:179:f56e:ee7b with SMTP id y10-20020a170902864a00b00179f56eee7bmr1094045plt.45.1664279502395;
        Tue, 27 Sep 2022 04:51:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id fu1-20020a17090ad18100b001fd6066284dsm1247893pjb.6.2022.09.27.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:51:42 -0700 (PDT)
From:   zhangsongyi.cgel@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     mathieu.poirier@linaro.org
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] coresight: use sysfs_emit() to instead of scnprintf()
Date:   Tue, 27 Sep 2022 11:51:36 +0000
Message-Id: <20220927115136.259926-1-zhang.songyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/hwtracing/coresight/coresight-stm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 463f449cfb79..3a1b07217932 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -466,7 +466,7 @@ static ssize_t hwevent_enable_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmheer;
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t hwevent_enable_store(struct device *dev,
@@ -495,7 +495,7 @@ static ssize_t hwevent_select_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmhebsr;
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t hwevent_select_store(struct device *dev,
@@ -530,7 +530,7 @@ static ssize_t port_select_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t port_select_store(struct device *dev,
@@ -577,7 +577,7 @@ static ssize_t port_enable_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t port_enable_store(struct device *dev,
-- 
2.25.1


