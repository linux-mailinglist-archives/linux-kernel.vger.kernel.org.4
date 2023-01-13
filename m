Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E1668EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbjAMHAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbjAMG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:58:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5486B595;
        Thu, 12 Jan 2023 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YJruvXG7kiwPmKxC/nF7gon5wmgRUYksNeIoAbOzgU0=; b=piNcqQ1Cf4XjLCWmyQAz6vK1cL
        vce3b8lKz0sVE444kluJuofenZYfKc8E8KMF1NfqRNyTkKOglkSP1ke1s67G8XQZBT9wZn0Qi5WUs
        SqXYwEfV5SzVhOPDYeOCESjyCYMexzxgAghw3RqWWWyzR5qnwg/aibOgXtA+j9qyP7gh8PBQtcS8G
        LIKydudI/rJHqIFE77wjNWUf1XYWpfGGcKEqDIoBZn7TUlm+Q9S3EV/XhztwDmDFhG6hK41tMIS2Q
        9JjD0PSTSO4sS7mP0hbZyzyyZEk3C+1pN9Bk5WMdI6Ghckz9UxIGqGcxEnTigE666H2xjuzPqu7CI
        uUJhI0VQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDo2-000rw1-Kd; Fri, 13 Jan 2023 06:44:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal: mtk_thermal: fix kernel-doc function name
Date:   Thu, 12 Jan 2023 22:44:49 -0800
Message-Id: <20230113064449.15061-1-rdunlap@infradead.org>
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

Use the correct function name in a kernel-doc comment to prevent
a warning:

drivers/thermal/mtk_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
 drivers/thermal/mtk_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -550,7 +550,7 @@ static const struct mtk_thermal_data mt8
 };
 
 /**
- * raw_to_mcelsius - convert a raw ADC value to mcelsius
+ * raw_to_mcelsius_v1 - convert a raw ADC value to mcelsius
  * @mt:	The thermal controller
  * @sensno:	sensor number
  * @raw:	raw ADC value
