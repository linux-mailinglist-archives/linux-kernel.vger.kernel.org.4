Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7E668EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbjAMHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAMG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:58:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12817288E;
        Thu, 12 Jan 2023 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q0w3UQ9FMb1baaM0Abx1oc6KdQ6KFkDqGd9dd6I9iOk=; b=Ooiu9MVorI3SQOFQ2KlvZgHG5O
        yxXFsduQqg8E59NDKFmtBDZVI3L5dC22RLWDhR3nBn94TwzZjWPjuQXC4vAl+1ypKS9cYMNI5ObpW
        YlQc66GWc3kI/V+fJ9NdeqIKqFyzBSzKdgt5v+rWJGHn1+nOxveRslT2H0cksUbbD9MbSSidB34zz
        gp/zpgKNrgn2+JmQlw2Ko/Rx20S0sI/EMu14wxqG1eLUcjLa5gzvXhqp7DhCB5niuK7HiVCDKcfMp
        ST7o5f5VWa7i81dNzvKMe0+sJdn+TR/9m/g5ocXnelSQjQDmOgK6M7wFPbZD9OvWG8wtNoxj+R9Ft
        OXAiXqSA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDoC-000rxk-Rg; Fri, 13 Jan 2023 06:45:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] thermal: rockchip: fix kernel-doc warnings
Date:   Thu, 12 Jan 2023 22:45:00 -0800
Message-Id: <20230113064500.16103-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use "/**" to begin non-kernel-doc comments.
Convert one function description to kernel-doc format.
Prevents these kernel-doc warnings:

drivers/thermal/rockchip_thermal.c:64: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The max sensors is two in rockchip SoCs.
drivers/thermal/rockchip_thermal.c:179: warning: expecting prototype for TSADC Sensor Register description(). Prototype was for TSADCV2_USER_CON() instead
drivers/thermal/rockchip_thermal.c:1342: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Reset TSADC Controller, reset all tsadc registers.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
---
 drivers/thermal/rockchip_thermal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -60,7 +60,7 @@ enum adc_sort_mode {
 
 #include "thermal_hwmon.h"
 
-/**
+/*
  * The max sensors is two in rockchip SoCs.
  * Two sensors: CPU and GPU sensor.
  */
@@ -169,7 +169,7 @@ struct rockchip_thermal_data {
 	enum tshut_polarity tshut_polarity;
 };
 
-/**
+/*
  * TSADC Sensor Register description:
  *
  * TSADCV2_* are used for RK3288 SoCs, the other chips can reuse it.
@@ -1339,7 +1339,7 @@ rockchip_thermal_register_sensor(struct
 }
 
 /**
- * Reset TSADC Controller, reset all tsadc registers.
+ * rockchip_thermal_reset_controller - Reset TSADC Controller, reset all tsadc registers.
  * @reset: the reset controller of tsadc
  */
 static void rockchip_thermal_reset_controller(struct reset_control *reset)
