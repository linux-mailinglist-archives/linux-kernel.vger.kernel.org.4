Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3C60C33B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJYF1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:27:30 -0400
X-Greylist: delayed 1326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 22:27:29 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.59.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E9B87AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:27:29 -0700 (PDT)
Received: from atl1wswcm05.websitewelcome.com (unknown [50.6.129.166])
        by atl1wswob01.websitewelcome.com (Postfix) with ESMTP id BBCB7400E00E8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:05:04 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id nC7cosVhQP2h5nC7coW60S; Tue, 25 Oct 2022 05:05:04 +0000
X-Authority-Reason: nr=8
Received: from [177.194.67.221] (port=44582 helo=arch-avell.meuintelbras.local)
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1onC7b-001KDW-Qk;
        Tue, 25 Oct 2022 02:05:04 -0300
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>
Subject: [PATCH v2 3/3] media: uvc_driver: fix usage of symbolic permissions to octal
Date:   Tue, 25 Oct 2022 02:04:50 -0300
Message-Id: <20221025050450.1743072-3-pedro.guilherme@espectro.eng.br>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br984.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - espectro.eng.br
X-BWhitelist: no
X-Source-IP: 177.194.67.221
X-Source-L: No
X-Exim-ID: 1onC7b-001KDW-Qk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (arch-avell.meuintelbras.local) [177.194.67.221]:44582
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 9
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJR16QThSX1oiTq/mCJju+6F1pn63C15mkkSdDmP/gXuWParwvWRhfm14lzkpJ8C3NlLbVJYxs2w4/ZjOl2GbpiGUSfWbFnm6SDdUXimUaSGz69LfL0F
 AEbqkAEobDgD/kRTtTKbTQYpmBNSa+LYGJ2GqjmaehB/GDRBOq1HpaaC3qTFRxEluxeNY9QAFFccBjjW2FnzM/ZGd/wdoao3ZGtcQMMp8xEP2sBx93u6xGFI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change symbolic permissions to octal equivalents as recommended by
scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c.

Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
---
 drivers/media/usb/uvc/uvc_driver.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 7b6c97ad3a41..c5adad4e51e2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2362,17 +2362,17 @@ static int uvc_clock_param_set(const char *val, const struct kernel_param *kp)
 }
 
 module_param_call(clock, uvc_clock_param_set, uvc_clock_param_get,
-		  &uvc_clock_param, S_IRUGO|S_IWUSR);
+		  &uvc_clock_param, 0644);
 MODULE_PARM_DESC(clock, "Video buffers timestamp clock");
-module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, S_IRUGO|S_IWUSR);
+module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, 0644);
 MODULE_PARM_DESC(hwtimestamps, "Use hardware timestamps");
-module_param_named(nodrop, uvc_no_drop_param, uint, S_IRUGO|S_IWUSR);
+module_param_named(nodrop, uvc_no_drop_param, uint, 0644);
 MODULE_PARM_DESC(nodrop, "Don't drop incomplete frames");
-module_param_named(quirks, uvc_quirks_param, uint, S_IRUGO|S_IWUSR);
+module_param_named(quirks, uvc_quirks_param, uint, 0644);
 MODULE_PARM_DESC(quirks, "Forced device quirks");
-module_param_named(trace, uvc_dbg_param, uint, S_IRUGO|S_IWUSR);
+module_param_named(trace, uvc_dbg_param, uint, 0644);
 MODULE_PARM_DESC(trace, "Trace level bitmask");
-module_param_named(timeout, uvc_timeout_param, uint, S_IRUGO|S_IWUSR);
+module_param_named(timeout, uvc_timeout_param, uint, 0644);
 MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
 
 /* ------------------------------------------------------------------------
-- 
2.38.1

