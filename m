Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8847128DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbjEZOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbjEZOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:45:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5108E4F;
        Fri, 26 May 2023 07:44:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34QEhv1O030834;
        Fri, 26 May 2023 09:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685112237;
        bh=bNnqfKQX33uDl/VjkwHyTIPOlTsHcLa+Z8TvV0qlZ5k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bvYhpGmlyMb8YToQZaiE/8Hk06lgeKVn6dyzhZI/tXJ3RJIy6DU6PWZBPSGDFMy40
         6hDfOjmkMAc2DPLgxcpd7obVsoxv08ta+nanvWeSb07OhK7CJ/QTFi8vDNOU6eVu7D
         tiCS9SDoPQDtuJ/OK9sXqgNZZjI6Md50JfCupfgc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34QEhv7N100161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 May 2023 09:43:57 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 May 2023 09:43:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 May 2023 09:43:57 -0500
Received: from udb0866455.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34QEhvYF030934;
        Fri, 26 May 2023 09:43:57 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
Subject: [PATCH 2/2] cpufreq: dt-platdev: Blacklist ti,am62a7 SoC
Date:   Fri, 26 May 2023 09:43:54 -0500
Message-ID: <20230526144354.38478-3-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526144354.38478-1-vibhore@ti.com>
References: <20230526144354.38478-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ti,am62a7 SoC to the blacklist as the ti-cpufreq driver will handle
creating the cpufreq-dt platform device after it completes so it is not
created twice.

Based on AM625 CPUFreq patch series by Dave Gerlach.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 338cf6cc6596..9368911ce20b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -165,6 +165,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,am625", },
+	{ .compatible = "ti,am62a7", },
 
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,apq8064", },
-- 
2.34.1

