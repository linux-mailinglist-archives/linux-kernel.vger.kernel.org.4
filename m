Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209260E229
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiJZN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiJZN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:28:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC680DB779
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:28:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w14so2056097wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQjuqzUbSlDqvGhbLmWueKhvNccMA5rF1ebwhNIRC8o=;
        b=G1//KcT6j5z5YfC3wUevGXsdon0yVPojTloeyZWcGQUIBIpxrMzrrmxlKdUMgcoZCC
         Vzjun/6shaKnwzglVWT5DQi/RVTo0SXYUWk165DbwchhlZtG2EvVyC1aOY8hJeIqoWnt
         5dbY0P199x+Dg8MlAcNsjsZFpyvpkuQ2yMUlMEp7FMZaRw+drjxs+/DDwmBTek/dpYQ7
         T+q4dVQXQ7SfjsX19UaZLQt1ZRGkq0mhQiQrRRvOI0ZT2n/Ia9SuW0k/gnxhNKdEs70u
         KKk03DLDus9d0JECKciycUKSEw1dP94wsoJ6Dw2+/HVFhj7eDLfckwDW03CRjrdDvbFE
         UbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQjuqzUbSlDqvGhbLmWueKhvNccMA5rF1ebwhNIRC8o=;
        b=xs5plmqTa2H+uQj6+GjnBw8RHMbmgytQTXCm9/jX0YNufrKdhpuEOULOXVo4Ikomwz
         BEeTlaTKfjDSzmglWUNQ9eBYULFhfxgAqOH+HxVfduhgdzqkJ8WBsTmL9e+Lm2UJRX7i
         TAPb57ymtGXdt1tYpxddizaZ3a71JKPU6jyVny7iFG+/LVA+dDXRtJUzGDQrnN7q3Nws
         Lp0Q/RnLUr5zCV7Eya2/Kl2VN2uepP+LXcOfw/U/Kf8wNAZwZKTu+v0Q8fHUTBAcYRv/
         Xym4I2DoB81TxQvqMnbAFk4wsmk9pM+UllnwJ8GAeNMChTPh3JB/ytEdBZw/0/qOiMu3
         lzmQ==
X-Gm-Message-State: ACrzQf28DXRT2mn90GdtYTCzM8sadRu+JpBpo1+wPPW5pYZpYTEVJY9w
        14s782eKoHu6+rzjHXKInGk=
X-Google-Smtp-Source: AMsMyM78UzBXXIbb9unvFZjujdL/F1OC0cQ2qXXhpRfAXkOjGjJNAIPF9DIUo7PeTAW2K3bTJo03Hw==
X-Received: by 2002:a5d:42c6:0:b0:235:1b3a:8d2e with SMTP id t6-20020a5d42c6000000b002351b3a8d2emr23154184wrr.689.1666790930423;
        Wed, 26 Oct 2022 06:28:50 -0700 (PDT)
Received: from rdm ([41.75.188.129])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003c6c2ff7f25sm1842410wmi.15.2022.10.26.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:28:50 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:28:38 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] Fixed[ERROR:trailing whitespace and braces around scalar
 initializer]
Message-ID: <20221026132838.GA44037@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the checkpatch.pl script, found the below errors and  fixed
ERROR: trailing whitespace
CHECK: Please don't use multiple blank lines
warning: braces around scalar initializer

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---
 drivers/staging/most/dim2/dim2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 7a5f80e637a0..28259ce05024 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -987,7 +987,6 @@ static int rcar_gen2_enable(struct platform_device *pdev)
 		writel(0x04, dev->io_base + 0x600);
 	}
 
-
 	/* BBCR = 0b11 */
 	writel(0x03, dev->io_base + 0x500);
 	writel(0x0002FF02, dev->io_base + 0x508);
@@ -1084,7 +1083,6 @@ static const struct of_device_id dim2_of_match[] = {
 	{
 		.compatible = "xlnx,axi4-os62420_6pin-1.00.a",
 	},
-	{},
 };
 
 MODULE_DEVICE_TABLE(of, dim2_of_match);
-- 
2.25.1

