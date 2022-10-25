Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8760C199
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJYCTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJYCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:19:33 -0400
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com [192.185.145.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737618A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:19:30 -0700 (PDT)
Received: from atl1wswcm06.websitewelcome.com (unknown [50.6.129.167])
        by atl3wswob03.websitewelcome.com (Postfix) with ESMTP id 4756B49178
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:19:29 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id n9XMomLlFPz0tn9XNo7uQS; Tue, 25 Oct 2022 02:19:29 +0000
X-Authority-Reason: nr=8
Received: from [177.194.67.221] (port=49966 helo=arch-avell.meuintelbras.local)
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1on9XM-002QdP-CB;
        Mon, 24 Oct 2022 23:19:28 -0300
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>
Subject: [PATCH v2 3/3] media: uvc_driver: fix usage of symbolic permissions to octal
Date:   Mon, 24 Oct 2022 23:19:19 -0300
Message-Id: <20221025021919.929910-3-pedro.guilherme@espectro.eng.br>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025021919.929910-1-pedro.guilherme@espectro.eng.br>
References: <Y1c9nS04fpoLqPVe@pendragon.ideasonboard.com>
 <20221025021919.929910-1-pedro.guilherme@espectro.eng.br>
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
X-Exim-ID: 1on9XM-002QdP-CB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (arch-avell.meuintelbras.local) [177.194.67.221]:49966
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 9
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB0W4EiVPGy3sxxirojK+85b7oiyKvphiJ1KAiY3OvWn2mBc3S1XLoDxVqpJUs6uio6dQBAc4MopKpc6Xwuda9HlWwrUhumdmmZyh+yaNK9127aI28iD
 uv6rZJibzsJfrSmQVkFMUPcSiSXql8jrIYn1ELrE03qQ9XxPzKvCvnKgP34haKJ6QPyUWf+vvfUtUdq+hVTqavhiL8C/fxZ39FrfTQhXAm9lTK0MWrAC5n3v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

