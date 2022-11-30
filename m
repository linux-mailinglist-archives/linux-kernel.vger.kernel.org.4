Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89063CFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiK3Hfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK3Hfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:35:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E055ADCC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:35:33 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWFv3J2fz5BNRf;
        Wed, 30 Nov 2022 15:35:31 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AU7ZELP093349;
        Wed, 30 Nov 2022 15:35:14 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 15:35:17 +0800 (CST)
Date:   Wed, 30 Nov 2022 15:35:17 +0800 (CST)
X-Zmail-TransId: 2af9638707b54cb41bce
X-Mailer: Zmail v1.0
Message-ID: <202211301535171577902@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <agk@redhat.com>
Cc:     <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRtOiByZW1vdmUgcmVkdW5kYW50IHN6IHZhcmlhYmxl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AU7ZELP093349
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638707C3.000 by FangMail milter!
X-FangMail-Envelope: 1669793731/4NMWFv3J2fz5BNRf/638707C3.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638707C3.000/4NMWFv3J2fz5BNRf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Return value from hst_status() directly instead of taking
this in another redundant variable.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/md/dm-ps-historical-service-time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
index 1d82c95d323d..6c8e83ad2662 100644
--- a/drivers/md/dm-ps-historical-service-time.c
+++ b/drivers/md/dm-ps-historical-service-time.c
@@ -237,7 +237,6 @@ static void hst_destroy(struct path_selector *ps)
 static int hst_status(struct path_selector *ps, struct dm_path *path,
                     status_type_t type, char *result, unsigned int maxlen)
 {
-       unsigned int sz = 0;
        struct path_info *pi;

        if (!path) {
@@ -261,7 +260,7 @@ static int hst_status(struct path_selector *ps, struct dm_path *path,
                }
        }

-       return sz;
+       return 0;
 }

 static int hst_add_path(struct path_selector *ps, struct dm_path *path,
--
2.15.2
