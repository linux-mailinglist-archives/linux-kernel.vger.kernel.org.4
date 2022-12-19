Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FED6512C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiLSTT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiLSTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94012AD7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso11760571ybx.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2p26kH68+WgnYwnXdelBfFnvRqAaD40WaeHNedYNHU=;
        b=QurtRDMPyKpTVAoluohEB6g89BkGj8nHIYN7x9twKCAjVVb7Z46MJGnl+S3vvpr5+j
         6yQN6KoZRmWqvR+PQICSzwW0SIBq3vnWF1bdtSxg0ys/WHdrLRqBWqz3I6gskka/ncN7
         ScbBIuOIZKjYiKW7knbqHoPeksu80g8Y+4f1ucjpYcoYrWkEpD2pDXM/JSeg+IOGBRMO
         RldP9MyuMDt10ZAp4YzpM0wjcHF2Z2jCGkHh0o38Xi3o6kxazRqNxbhrGscrszWsCaQh
         TgaXJR6YHRbmbYjmKo/3iT5ZpLG3wTcyfvBmqcWd5P5SbAC4Aw76h4FgbU9zdffjfhR4
         3A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2p26kH68+WgnYwnXdelBfFnvRqAaD40WaeHNedYNHU=;
        b=tSwPKZzAWb1g+weGep5/WJ7U8j1K57d8GF9rdwyRvLsvQaRW9wNRWK3szxqIDkmpgy
         Jw9G5rdP2Lbo/YSqerauwV4AhX0I55bPj02WduvMQadh0WXdlfTYG5goJ1rAir22die/
         nHUlU5zhnXGzQ1qQ1Zw6hTfzgeOnviVB3NrlhAM9Y0K/SRPNwzZgT6N7qh/3HqrbwUS6
         ybPdV2DvcZLGGgRy+RomrdCm0a7bGiME5Jc1QQMKvzT+SAJJ+qpNC7gTiMhQat2zReas
         tA+A9c4d321KdgxoJ24DLOSb8ki/ekvPXCkth19mp/FJB53kUZfkyOAfaE8ZgNw1AHBc
         ficw==
X-Gm-Message-State: ANoB5pknmk3YTrHtIeRHsj2grK8qrlHtteu0/ApPQhxW0VPxEeK4olLm
        HfV0m9EZUbpGI+KLb1lKtw1hwD1kZtSTIz4=
X-Google-Smtp-Source: AA0mqf6dX4h6UF+praOlBe6Ty1rhwe854U2JXGDWpDmBDTz0mT+rdaatesm+Zwdhvx8UPT5OVavHDrHoykap2zU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:690c:f8a:b0:3b4:8af5:48e with SMTP
 id df10-20020a05690c0f8a00b003b48af5048emr3893210ywb.383.1671477542998; Mon,
 19 Dec 2022 11:19:02 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:50 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-5-allenwebb@google.com>
Subject: [PATCH v8 4/9] stmpe-spi: Fix typo
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mfd/stmpe-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index ad8055a0e2869..6791a53689777 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,7 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
+MODULE_DEVICE_TABLE(spi, stmpe_spi_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
-- 
2.37.3

