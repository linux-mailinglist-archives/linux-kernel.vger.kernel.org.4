Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5C7128DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbjEZOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbjEZOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:45:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FBE4C;
        Fri, 26 May 2023 07:44:46 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34QEhvCp030830;
        Fri, 26 May 2023 09:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685112237;
        bh=USyh1C0gDQk15XJxL0gneqmA6xncI/cx+HYb+2vZD7g=;
        h=From:To:CC:Subject:Date;
        b=cvyX+szw+zkFjBZudWKP2lX2ip8vGaUUN9P0MH4UwVeWkh+qu2i+zezq+zXFVtqGP
         UC+dpLtoNYkqOiFntJzuyvjYZboHvmeH4hfwRHRSv2XYW4haXVNOtw12vPETOjsF4U
         odRMiP0MR3i1zHCMQzwGbVmNoJH3yD2p31FfLAbw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34QEhvAs100155
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 May 2023 09:43:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 May 2023 09:43:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 May 2023 09:43:57 -0500
Received: from udb0866455.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34QEhvYD030934;
        Fri, 26 May 2023 09:43:57 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
Subject: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62A7 CPUFreq
Date:   Fri, 26 May 2023 09:43:52 -0500
Message-ID: <20230526144354.38478-1-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This series adds cpufreq support for TI AM62A7 SoC.

AM62A7 has the same A53 and efuse configuration as AM625. Thus, soc_data
from AM625 is reused. This series adds compatible string for AM62A7 to
ti-cpufreq and cpufreq-dt-platdev drivers respectively.

Tested on am62a-sk board using manual frequency changes and then reading
back frequency with k3conf, and this shows matching frequency to what
was set. 

Link to the complete series including the DT patches:
https://github.com/DhruvaG2000/v-linux/commits/am62a_cpufreq_2023

Based on patch series for AM625 by Dave Gerlach.

Regards,
Vibhore

Vibhore Vardhan (2):
  cpufreq: ti-cpufreq: Add support for AM62A7
  cpufreq: dt-platdev: Blacklist ti,am62a7 SoC

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/ti-cpufreq.c         | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1

