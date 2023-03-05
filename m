Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD5F6AB276
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCEVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCEVZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:25:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758B144B0;
        Sun,  5 Mar 2023 13:25:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so7121955pja.5;
        Sun, 05 Mar 2023 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678051524;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5bVY5AKsD2jDpfgjiouyG6JQ3Zfu4HaN3C3NSFkRVc=;
        b=DcRA2tH6XQ7HDpAdBNRMWmMVowQla6nOvqO2vfHLXM2mzaHeB8xWxOb4daiTBp5tBJ
         rBONtrU9qXqF0tbu9vqtaxAAgL5KbUTyWIJ3xuMLY5ru1x1A2bHiwqujYB2MBpI1stAK
         U7MN0TygatY6t4OBX7e19ZRgbm2gXEaLdiVTdsRpxrhF5GlgAsqrgUT5GW722jco6aIW
         K9ao7FQyG0E7o6Sn3K9u/7l4Altxm1DjCg+4T7MqZ6ZnCYzWEUKSvOin+p8IRVLJJhTC
         xwH2xaWuFLO86p4l8e11I6FNUiNNnz6KJNwINTUofllRx1IBNEbSodS8+dswqHKNktlD
         yIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678051524;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5bVY5AKsD2jDpfgjiouyG6JQ3Zfu4HaN3C3NSFkRVc=;
        b=bTvKxiLrVo5iNJuK3NraQFH6Z9KNg5pnvgL7zXPkWaHVA+mDMPm/YVi+wqn8z+FPnB
         cajipsk4G2aV5b8JDYD+F+rTmeLvGWunO4rC/lpvC4zQaZJ7Zil2UqV9GKXTl3W0/6WW
         YWVRaL3NuFRUGjjL4dxu5aUUEy+wt864NUr+UuwXHP+g0VDWqjQ4CpkIR3rstmYHS7Xf
         2BzwN/BIvil2ZCAFQSyczcQDS9UCtz29LL1Oc8CeVd80m8uGIgpmyvhal7Kua17Vt+d7
         8aBPJVsPc9TpYmrHakW71P2OKCci1XQ4JrH+nsCvrU54FdvPAjER5ztZCsJj1oK9lHvB
         1Qeg==
X-Gm-Message-State: AO0yUKVkLAwbNAkhED4PTZKM8/3eMV1Og/VEr2HQWx63zp/sjKHcMk/7
        quuAz8HQ4cq419kFEKSaIH3B/3e+B321Og==
X-Google-Smtp-Source: AK7set/QfHJRz/4RFKWhQ8sfcRz1M2EgPi7nYGfVn8mhyfThY8CllX4L5l/f6fu4tmEq7N0VLi2i/A==
X-Received: by 2002:a05:6a20:7d9e:b0:cd:8ed8:8e1d with SMTP id v30-20020a056a207d9e00b000cd8ed88e1dmr9360037pzj.12.1678051524409;
        Sun, 05 Mar 2023 13:25:24 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-3-35-229-103.ap-northeast-2.compute.amazonaws.com. [3.35.229.103])
        by smtp.gmail.com with ESMTPSA id t13-20020a635f0d000000b00476d1385265sm4953397pgb.25.2023.03.05.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 13:25:23 -0800 (PST)
From:   yongsuyoo0215@gmail.com
To:     0215yys@hanmail.net, yongsu.yoo@lge.com, mchehab@kernel.org,
        tommaso.merciai@amarulasolutions.com, yongsuyoo0215@gmail.com,
        hverkuil-cisco@xs4all.nl, colin.i.king@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb_demux: Fix a bug for the continuity counter
Date:   Sun,  5 Mar 2023 21:25:19 +0000
Message-Id: <20230305212519.499-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YongSu Yoo <yongsuyoo0215@gmail.com>

Signed-off-by: Yongsu Yoo <yongsuyoo0215@gmail.com>

In dvb_demux.c, some logics exist which compare the expected
continuity counter and the real continuity counter. If they
are not matched each other, both of the expected continuity
counter and the real continuity counter should be printed.
But there exists a bug that the expected continuity counter
is not correctly printed. The expected continuity counter is
replaced with the real countinuity counter + 1 so that
the epected continuity counter is not correclty printed.
This is wrong. This bug is fixed.
---
 drivers/media/dvb-core/dvb_demux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 398c86279b5b..7c4d86bfdd6c 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -115,12 +115,12 @@ static inline int dvb_dmx_swfilter_payload(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 	if (!ccok) {
 		set_buf_flags(feed, DMX_BUFFER_FLAG_DISCONTINUITY_DETECTED);
 		dprintk_sect_loss("missed packet: %d instead of %d!\n",
 				  cc, (feed->cc + 1) & 0x0f);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40)	// PUSI ?
 		feed->peslen = 0xfffa;
@@ -300,7 +300,6 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 
 	if (buf[3] & 0x20) {
 		/* adaption field present, check for discontinuity_indicator */
@@ -336,6 +335,7 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 		feed->pusi_seen = false;
 		dvb_dmx_swfilter_section_new(feed);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40) {
 		/* PUSI=1 (is set), section boundary is here */
-- 
2.17.1

