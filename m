Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51D65F32B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJCPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJCPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:37:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F71C264A5;
        Mon,  3 Oct 2022 08:37:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6064736wmb.0;
        Mon, 03 Oct 2022 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zDHcYPcOC2g3KclLx05LA/SZnsMR7jUou6D7oCqcQG4=;
        b=bqCG8C1gegQxpKi32inG/zloXBNcwnTao4VCmCc/6bOGoRbbkW3hVvXFz6jkbElbr1
         0W8s/AuBrC3vW1/EwRssE8RPMAOsUWWGpsiCjWNFM9eXSFU/x7vvwagT0jzbOPn6SS3G
         1GprrtxlUxD5KBawFvvbrsUf9LtEX9hd7IBwXdRah9l+8gjIgQrV7pG9RYYJ7a3XCaXV
         6Yw3S2zF8/sN8T8Q6/8ueeM2BBNMQSokr5GxDFeDIb6EdtshX9S0brOW+c+SbsiXxscs
         Fqxpky7EPB1bGFrhTkZnmEFjQ1K54UDbOL/sWLgnnrl7kbsn1MmihBwUd7v8l8Q9oXKB
         5Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zDHcYPcOC2g3KclLx05LA/SZnsMR7jUou6D7oCqcQG4=;
        b=h1nkR2n9MpZPqrzZ9gDQ2kFP7kOsCo5KjWBCk1tTEk+UrwLLe/4eeJF4WRKC4N4IsA
         7+flQTxLpj/61Iso/afregxKREdmg8f7ws+sbPiIL8SswOHZ/mor8I3PMYDBqfAzQhpR
         Xz6kVJ1vWFIEzQ84o2x99qU5ziJKcSNgqF475/qV+/vYrMdyCoPSSR1rSTK2TqgMS9IU
         itMFXGNkTk6ogwqJXxEkiS1079wAAHjWClYJYjHdxb4FG4SXLoWXbNkg5lilN/guyadk
         26/6U3Spl0EW830Hf2bGq5zmje+QHwp9jVocPiwEG+Vyyxn9aVSmL4kAhH11WN9TnUBe
         vE1w==
X-Gm-Message-State: ACrzQf1RCMu2IDJJx5QVbyZPOq85H2b/WDf/kWvGKdlFg8+11EDBWqiu
        xmbJyVfOmUDzktC+riS6aI0=
X-Google-Smtp-Source: AMsMyM45QL3qALRDKsu2WvfGfjxNqRla9U2vr20LwILz2wh5e+BUktInAYMCquTP+n+TW+60Shj4vg==
X-Received: by 2002:a1c:f008:0:b0:3b4:fd2e:3ede with SMTP id a8-20020a1cf008000000b003b4fd2e3edemr7386844wmb.133.1664811432876;
        Mon, 03 Oct 2022 08:37:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bs11-20020a056000070b00b0022a2bacabbasm10355788wrb.31.2022.10.03.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:37:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ds1685: Fix spelling of function name in comment block
Date:   Mon,  3 Oct 2022 16:37:11 +0100
Message-Id: <20221003153711.271630-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The function name is missing the letter 'd' in the comment block.
Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index a24331ba8a5f..5db9c737c022 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -132,7 +132,7 @@ ds1685_rtc_bin2bcd(struct ds1685_priv *rtc, u8 val, u8 bin_mask, u8 bcd_mask)
 }
 
 /**
- * s1685_rtc_check_mday - check validity of the day of month.
+ * ds1685_rtc_check_mday - check validity of the day of month.
  * @rtc: pointer to the ds1685 rtc structure.
  * @mday: day of month.
  *
-- 
2.37.1

