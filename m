Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7102C61938F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiKDJby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:31:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E726AD7;
        Fri,  4 Nov 2022 02:31:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w14so6209253wru.8;
        Fri, 04 Nov 2022 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fQB8IWbk7Zpl1UHmIGadV3eZG5ePRYU+GVM8Es32sA=;
        b=ftcCzy4fM3tZjnDEYhaJCVDpM/iESIxsd/rY6lUJ8PN8t5LRaHRl6TUqEGrl0FHci2
         4hbHLqjDa6yIijEB93ZGzTu+ehlSKYGNsc1ozZGXF3BgyQoRMZqpEsiIvPIPOjqg0SYE
         3+lsoelIiVbYAwlGtuyVascnWEEcWhB+7PyKLZh4HWrlQzCtok8uiyzs/5q9dHt9sql3
         dFVIuJI8leukf7z3vaiY+XAZip/hU74Su2Z4ZK5SCKkK6zmlWi3MkXsdEYgXvkoiRuPL
         0vRJ6xpX8xcC07jSI22tzoVCpSCQ6gj+XieKvjaPt4bHPw9fNKzV6acOWqN1tppPTvhf
         sAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fQB8IWbk7Zpl1UHmIGadV3eZG5ePRYU+GVM8Es32sA=;
        b=fcTNjL/WnatT8GMDmQAOufJ8tmyd0uzGChbmvxBJTOLgIZ5OHXIU/6njASp4dp5e2c
         WvW5obLTzHN7ABmYbgYZ/9UBurB63GHfpZDNCEaejxDmGGEkGjBXidZZkHWLPiGjxXgN
         hyygnWJ0eSoH0bU2L5vFs2elnwLb6N0NYosrkb0AR+D49sSuC49lJRa8r+nvAvlhYCgl
         y3XVZRfCMZXXoQgM3pQNdkXfwUT5UdXGQTqEDV2NvKSmKdyzwjb+iQ/Hy5maNTOIH2NG
         bbVLWrFyVN0+aztJKROgLaYNHmclLvcV/KFkZgQpEr+Q/VYifHEj37H1Lo9a+W9jJQTH
         yeFA==
X-Gm-Message-State: ACrzQf0a1bOLhZMpYhCwaBgbk3w9KEiD6cMMoilo1Y4q1lKQav6c3a2m
        z9J6Tj14BzreP3wUQZDLJ54=
X-Google-Smtp-Source: AMsMyM4kiDlP+Q/7u/Qj4FQMBakY1QAx2Ub4arviqJD402JdlSCoRJU73pEnW7T1wUE5DI9KR1YoFg==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr21283958wre.237.1667554309206;
        Fri, 04 Nov 2022 02:31:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b003b50428cf66sm2250031wma.33.2022.11.04.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:31:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: ad4130: Fix spelling mistake "diffreential" -> "differential"
Date:   Fri,  4 Nov 2022 09:31:48 +0000
Message-Id: <20221104093148.167765-1-colin.i.king@gmail.com>
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

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/ad4130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 9a4d0043d797..ae1a4dd5c40a 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1480,7 +1480,7 @@ static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
 
 	if (pin >= AD4130_MAX_DIFF_INPUTS)
 		return dev_err_probe(dev, -EINVAL,
-				     "Invalid diffreential channel %u\n", pin);
+				     "Invalid differential channel %u\n", pin);
 
 	if (pin >= AD4130_MAX_ANALOG_PINS)
 		return 0;
-- 
2.38.1

