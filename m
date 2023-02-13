Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE22694025
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBMI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBMI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:57:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EE613DEB;
        Mon, 13 Feb 2023 00:57:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8397622wms.4;
        Mon, 13 Feb 2023 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2v1+wAQIxuDwwfxKBOXSuMRM+HP0P5i3QqMWmALdpg=;
        b=E7xg3B5eff3XtQGugwQOH4Lg08fyzJ6jm39iQ3rGjFHGXCUFDCHlRJaRLAPObm2rJN
         GY3i0iY7i6rrDz5daOFJc2/8Vd7UdmTk9A4rY6UOKc13xVByDW70ll2m8d6A0v1XyOmB
         wpM3wx6DKfW9W2Yr0l5YLv6mknvUJ5WX2ma358/n4tAlAAh09BXV9djARLTxN29ZBS+h
         rRR1P8ZUxAG3Vj5/c/8gXOYQiUy06jA8quctDib4upMtmNGhzb6GzoJEjIRh0r50a9AD
         dduQ+EfgPutdM7VAbGTJhJTb22+8U1gk+KfJ2vZaySI3UIMTyd3sk1xOA4iiuircIU0i
         DFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2v1+wAQIxuDwwfxKBOXSuMRM+HP0P5i3QqMWmALdpg=;
        b=H6Ar/zFfkA3orbj5b8d8VX8rQ8DfhLRxwnAnnjLjw2QxXqLihTHX/bpqg0T6x68Zy3
         RIH2WifWAT/W9rtGaHfstjJoaFxFCr93vYoXMimIJis4yY3SDRlePo2DBkcyNSD6yRvN
         h5bt9VU8zupyNwhirEHTSvhStsgf2gPGiEenZanIPg8FM0thtEgBpRySMCQjq56l7mOV
         MlqUhIfyBa8/+BkKH1TCF6fAmICjuutcHhYeCT6v7L6KwhDyVMLGzJxl8Ifpf4Grsj7F
         uOaNlU8OEKb1ymXVxwXIA1ZkkR1sxtvfQ+yabtelo5BipJoZPgf5LDm0LilBr7ANh+ZD
         4HgA==
X-Gm-Message-State: AO0yUKUKCY8u9MbLBDcCi5nGuuzr31PzzQ2NF8AZm+ZevHoTnOyuucT1
        KHBCWElTstIqBPXf0oNqritH3Vu+/XWa6g==
X-Google-Smtp-Source: AK7set8U0uKqML9KE2p+Jse1vuLMJiY1RtQBjS2ARR+GJhqbCyI4NylHOGp73+YufJis9gr9tB5/8w==
X-Received: by 2002:a05:600c:4b1d:b0:3de:3ee3:4f6f with SMTP id i29-20020a05600c4b1d00b003de3ee34f6fmr18753551wmp.8.1676278620730;
        Mon, 13 Feb 2023 00:57:00 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003db0ad636d1sm18005330wmq.28.2023.02.13.00.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:57:00 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] habanalabs: Fix spelling mistake "offest" -> "offset"
Date:   Mon, 13 Feb 2023 08:56:58 +0000
Message-Id: <20230213085658.96918-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accel/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 6c4d9b1aa5de..74ccafeb38dc 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -3199,7 +3199,7 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 			usleep_range(100, 1000);
 			if (++iter_counter == MAX_TS_ITER_NUM) {
 				dev_err(buf->mmg->dev,
-					"Timestamp offest processing reached timeout of %lld ms\n",
+					"Timestamp offset processing reached timeout of %lld ms\n",
 					ktime_ms_delta(ktime_get(), timestamp));
 				return -EAGAIN;
 			}
-- 
2.30.2

