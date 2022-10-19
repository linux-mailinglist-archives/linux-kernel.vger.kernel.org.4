Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983DF605241
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJSVwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:52:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51B317ED;
        Wed, 19 Oct 2022 14:52:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so31270858wrm.6;
        Wed, 19 Oct 2022 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eApXCcN6gbSeEBoZawynJhdcd3WZewwA9ECGhchf8gc=;
        b=TJOqUaTZM1yxHvki48bMZ1o3xH5Cycg7ZoYpjkLoeg90ylQ61Z2xKLLRYQBRqRV8nC
         lbt9H9cj8Q5PS+IxezJUgpsownODsx547LaWqwR8mlX9fAnTuJ3qhrcW9QUbhozcbD0A
         Vn2nMR+U3EShmMbN8ip7gUX4Xo0eFoDCzaLXCvD9XSIU5nJAFvYgkEcznIsKcVsMeUyZ
         cCXznc/UNUCFHxOPx5Gs+9GUJEiOxg6ucydsDphfjjtuUTSa6GZzPYZVzqVW4LiktPaT
         +3UvEIIaLXS1JkeqPXRW9lHL8DMpE+bEggBQXeSBEKjQe4QzJcGBKiRd4otwV3RcHJKT
         BOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eApXCcN6gbSeEBoZawynJhdcd3WZewwA9ECGhchf8gc=;
        b=AyxlmG4OenlhY7UjBMlXYEqxUlKe0XdNIZOjo2j8blo73sz5vUBhwBa/j5VUABnMry
         E0W/lK4bOWvyjI1ECTGaqNkvNDyh+tjJ7S3KdPaLd5nuXBPwseLD5O2721AJoAatCYXw
         lQCl4BcXIxS0C5vbQHEPbrt+t3HWyO4vzm8Lvm8D9WGidQ1KKJ86n2u3s0HnGfX847gv
         PEIv/vGvHdwdiCGiwbb8ReN60JTIcFn4CgEQpKbYgvbr+k5Ba1dI6uwE4Klpr8Zg0uZ4
         /ESDZiivPEZhLKxIJLOBbyWJcshNa/wl9pZdPurnpAQ/vgb7SwVHFwuuUXkroCbWTTMx
         3bOQ==
X-Gm-Message-State: ACrzQf3vDD1VvhJYG3grWG3dTCnx689ktSVOuj2RS05pem9Q16i/wcG8
        13PVFejbljGeyMCB/prb6QMDCK3QxuV2+mln
X-Google-Smtp-Source: AMsMyM57RpsQoDL6fsHYnO9NGHs0ib7Ga/t0MaIomoZ6IXPHYz4JSXpitGHlsS1wZsMj2/d9xGTHzQ==
X-Received: by 2002:a5d:428c:0:b0:22e:5d4e:c71e with SMTP id k12-20020a5d428c000000b0022e5d4ec71emr6271418wrq.19.1666216333341;
        Wed, 19 Oct 2022 14:52:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c545a000000b003c6c5a5a651sm1046313wmi.28.2022.10.19.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:52:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: test_drivers: remove redundant assignment to variable checksum
Date:   Wed, 19 Oct 2022 22:52:12 +0100
Message-Id: <20221019215212.1434808-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Variable checksum is assigned a value that is never read, it is assigned
a new value in a following for-loop. The assignment is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/media/test-drivers/vivid/vivid-vbi-gen.c:197:2: warning: Value
stored to 'checksum' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
index a141369a7a63..70a4024d461e 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
@@ -194,7 +194,6 @@ static void vivid_vbi_gen_set_time_of_day(u8 *packet)
 	for (checksum = i = 0; i <= 8; i++)
 		checksum += packet[i] & 0x7f;
 	packet[9] = calc_parity(0x100 - checksum);
-	checksum = 0;
 	packet[10] = calc_parity(0x07);
 	packet[11] = calc_parity(0x04);
 	if (sys_tz.tz_minuteswest >= 0)
-- 
2.37.3

