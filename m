Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AA648B61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLIXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIXcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:32:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5837866CBF;
        Fri,  9 Dec 2022 15:32:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so6715361wrr.8;
        Fri, 09 Dec 2022 15:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8W71q9LELQYCpcjWYqNiTXMd9NVyi7pMCWA3gVwKHyI=;
        b=oehfC2AMuozA5HHZ2FNgIr+aTNRZIXIezkB8wWW/j8Pfezq5ulL0OeDJ+YkOgv5OJx
         /UDSh7XAfJ7ekEOe5+3kFQLVcYGqn323kFhDPa4B/TiZl8zg/w4UrZcXXpKXZikcYCFI
         IGZzRQvjHmKeAlwQoMKiqKPMxMbrKQIUH2lrXbdDeKnvF0IMhn4oZIBwbRpzub7GOyGm
         5Xpo+DqgKMoGtjM3MT/JFDk/haRvr9YzxOdWdO3UHqEMdm3EBWepPqaF9XJNCndyZtbb
         qIKhx2dGTI7xsRl6t+QIBBmf/CRbibAUjV9cUXQV3+xFD3N5TTQ4BtQAqa+m8fL4paXJ
         qX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W71q9LELQYCpcjWYqNiTXMd9NVyi7pMCWA3gVwKHyI=;
        b=EIIZmEA0r5+zpFjxGy0NuEMBnBjedyYsasMIIg8+/jkER4+T4RIYE+Bg2W9jd02gTu
         4d2jNz238D5B1DZVWprDXam8tT54iv5FOY4Wg8bLH+VzEEI8TaMIoyPtqKAHY4P0K7bb
         /R3BuHtGtMKv3Fr3h93OuL8v07vLkq4RUIkzJ7qj6Fd2ZThDGM9iQLWKTZvIFGxq/swM
         +KdPkQzwym7dHfecw3Mf8NhRobdEXJK9T6V4rCzCdKA5hg/AjEic1GZQLrdwXPUUPpl7
         jjJbG41Eg5qAc1z6z82HrnOa/6ws8SfLfA/5jb2XOKOPz8Sw+6vO77xD58Xl3ap/I4Zz
         7Ekg==
X-Gm-Message-State: ANoB5pkYoLp919VdtTNr873buGDyjkIx5RHyspVYQmTSFI7lnRI+KYBX
        1xlSwnRVoyfnkNp4TURcgw9+qW4Qhou+WQ==
X-Google-Smtp-Source: AA0mqf4qXzfvOfLq+euSh8QvD6nEIapNpwbG3YjI1LX4qjiPcIWEAotmn74Hzln8zQnM3N5802G3gg==
X-Received: by 2002:a5d:4d0f:0:b0:242:2eae:2ae4 with SMTP id z15-20020a5d4d0f000000b002422eae2ae4mr5161447wrt.62.1670628724805;
        Fri, 09 Dec 2022 15:32:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id cl6-20020a5d5f06000000b0024274a5db0asm2564975wrb.2.2022.12.09.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:32:03 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: kmx61: Fix spelling mistake "Errow" -> "Error"
Date:   Fri,  9 Dec 2022 23:32:02 +0000
Message-Id: <20221209233202.222083-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e692dfeeda44..53ba020fa5d0 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -649,7 +649,7 @@ static int kmx61_chip_update_thresholds(struct kmx61_data *data)
 					KMX61_REG_WUF_TIMER,
 					data->wake_duration);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Errow writing reg_wuf_timer\n");
+		dev_err(&data->client->dev, "Error writing reg_wuf_timer\n");
 		return ret;
 	}
 
-- 
2.38.1

