Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD95EE834
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiI1VUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1VTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:19:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69785582;
        Wed, 28 Sep 2022 14:16:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so21678191wrm.2;
        Wed, 28 Sep 2022 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KbUksbEUwkdX2NhnUCKgEZ96/Pa9xod4mMzph0sIkew=;
        b=MB6DUE6Z1pbZBZQWRg12iw7/eJH0afuIVeJG/Vomrhz6Cw2CNSBCYK01OEAVCr821v
         447MW6Q6wCY4WpDNfp1l3oEyV7b4EMlQLfk8c0iBsW0Ym78AcwqonPjD+l7hhVZgxPKl
         MK8pTyreW5jX1ZSzWhq4f2pvyO+ybEw1Uhg65Q+mWqglBTCx8k8as0V8QV4trxkB9Wlj
         XGIOGwhN5rlEwOH9B4VnQZF9VbMOLnnUMtIVLnYXdARTyTfKiAvs6/MjEkJ2h8qB8Cyx
         dsmNvMEIEH8OPR59OXRETpBBFXZsr4Lniq0Rim535RKUKvD4KJvgaWoKxiCp5DSLlf6S
         oLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KbUksbEUwkdX2NhnUCKgEZ96/Pa9xod4mMzph0sIkew=;
        b=zKnJxOD6vVzhuUxgu5rCYESFBsSIi2GU35J8Q33u62kdSDS7USzogzNC1U+Uk7OQR+
         bVxQSSmj9SL12GLkGZJHdLKeJrOel+1rHwL4JoQ4KqvVKYnloSaWW2X5hFto3B2w+Jx5
         hWlabLBuHN3Y8Q1Bm/GtZ5Zn+9EQlw2PE6jbqhJq2F7itDndxRJOM3iQpL6CyOCs9CTb
         V8O6+fSnkvmKvP9COnJIhht64+R5NmXDght+TfXVM4hZNOreVnp+WCvseD/iAq/aniFF
         eGHgqz+XmGCPiPH4o1dQwuLrBjhu/isnUklGN5CQWC3uV+Zdkq9wTza33ShVf5AONdvx
         4DcA==
X-Gm-Message-State: ACrzQf3mVSzPlmQyzTau+ihdYjcIJRY7y4BOij/bVVYtOGDFcWu4NWFB
        fNUvqvtjMB3Y2YdBz6dSkDPTpC5vdthWMQ==
X-Google-Smtp-Source: AMsMyM5e2z6OYNLnDKUfR1SLlvL8nt9nVFKr/qZxSeIi2L4QFKABeJYl/tRmTBN6qVT75OzCxeP5aA==
X-Received: by 2002:a5d:4610:0:b0:22c:c2c9:bb33 with SMTP id t16-20020a5d4610000000b0022cc2c9bb33mr6486428wrq.355.1664399798960;
        Wed, 28 Sep 2022 14:16:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm5191622wrb.31.2022.09.28.14.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:16:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] test_firmware: Fix spelling mistake "EMTPY" -> "EMPTY"
Date:   Wed, 28 Sep 2022 22:16:37 +0100
Message-Id: <20220928211637.62529-1-colin.i.king@gmail.com>
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

There are spelling mistakes in config show text. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/test_firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index c82b65947ce6..0c714cdd51ef 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -284,7 +284,7 @@ static ssize_t config_show(struct device *dev,
 				test_fw_config->name);
 	else
 		len += scnprintf(buf + len, PAGE_SIZE - len,
-				"name:\tEMTPY\n");
+				"name:\tEMPTY\n");
 
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"num_requests:\t%u\n", test_fw_config->num_requests);
@@ -315,7 +315,7 @@ static ssize_t config_show(struct device *dev,
 				test_fw_config->upload_name);
 	else
 		len += scnprintf(buf + len, PAGE_SIZE - len,
-				"upload_name:\tEMTPY\n");
+				"upload_name:\tEMPTY\n");
 
 	mutex_unlock(&test_fw_mutex);
 
-- 
2.37.1

