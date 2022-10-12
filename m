Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2125FC6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLNmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJLNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:42:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABFCF840;
        Wed, 12 Oct 2022 06:42:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so1228316wma.3;
        Wed, 12 Oct 2022 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjMwxO2ttET/k2mjc9FVTHy1myqG3lEVWgLpdfrfxrw=;
        b=QYRWwt2fBEopyPIg16PTiZkfIjXfhIfuNpYq+Hq3C3uTPRNV4Hf/iFmnuVn5kuUmrT
         8bQmV53q2pKi5lNnsKqTIUmxHHyxseKFALyvRgWrXM3YNP39FRaN+A2xyhBcJB/YPq4L
         Z0k1YbQ3RfkR3kWHTUNUkz4/H58OSB4hXnkHHJunLYEC1mBYJPOj8CCirkZyJNEn9cJz
         dohpMkuetNIRysqsO4ih/VFP0lStRArbEY4Rg6bA/qb1lunRzhGm47efZ7TVWAb+gTOw
         EzSRGBZX6OOdyImRFPLwVkG0uVq8y5ZzjJKA2K7rDIIdePKyLPQbDmlG/iwFDwgqBvwm
         Qk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjMwxO2ttET/k2mjc9FVTHy1myqG3lEVWgLpdfrfxrw=;
        b=PRTS2hqoJ8ugSYu9AJT+9rEayMQlfJkpoYe+qGl2icgF/aBM4YENckzaicJJZJMko4
         UA3Vhlb/+0XQiN3nsdZGCrHfUloi1qbaVJK2I8MQ6hjPTajaZFr1EP6uEruYszwwjvzz
         aAZlrredXlxwfbCL2/voOs3S1fVEVUg/FKsf3PIiKEWD/fthIRthoy50JUgy8xQywQMl
         0TRzAqh5DbwRgjm6wsKY8is/9SX3AmToeguqPCe9q92p6HIHi7VDWw9qZxW2fKZCkVKH
         8TCFpi5EuzAo8Wd96vtJ2T5+D6Kl2Dlfl/HLegQbegZCnkgzJ3xNuXcsCuJy26aVaVju
         Rocw==
X-Gm-Message-State: ACrzQf0zRni2UB02CYv2txy+XQ2zVJC+ywg3/uaEimY30pyYZ2qe9vYt
        M1Xe0eZaOaZEWiJxemXJqT2y/anatCY/xTAr
X-Google-Smtp-Source: AMsMyM4Xsv+D5FOPwtZLeNd44KTSrQIiig6fL9DAADtD1DAivKJfz2c9aoGaFtSkyTgYLR1oFO23mA==
X-Received: by 2002:a05:600c:35c8:b0:3b4:bf50:f844 with SMTP id r8-20020a05600c35c800b003b4bf50f844mr2979332wmq.192.1665582166710;
        Wed, 12 Oct 2022 06:42:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003c6b70a4d69sm1738310wmb.42.2022.10.12.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:42:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3911: Fix out of bounds access of array mcp3911_osr_table
Date:   Wed, 12 Oct 2022 14:42:45 +0100
Message-Id: <20221012134245.5345-1-colin.i.king@gmail.com>
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

Currently the for-loop is using the size of the array mcp3911_osr_table
as the upper bounds which is 0..31 which is causing an out of bounds
access to the array at indexes 8..31. Fix this using the ARRAY_SIZE
macro to get the size of the array in elements rather than bytes.

Fixes: 6d965885f4ea ("iio: adc: mcp3911: add support for oversampling ratio")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b35fd2c9c3c0..015a9ffdb26a 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -248,7 +248,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
 				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
 				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-- 
2.37.3

