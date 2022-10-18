Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA1602B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJRMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJRMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F7BEAEB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h8so17568848lja.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvxU4ugiDB9i9W3RROc9iPCBryTiL0PvkD1UBcy4cHI=;
        b=iPn87NIhldfLkfiaF6SVQJAWDZTTh1bIweq0mv6fPPctMfPkKYDf4aX/g3NRSj3y5p
         MjCHUkeZun1xUI1L87J+qSiuiKR21im4D850OkgMboXJBHVB9Zr4qwYqGngKK9CkRe+W
         jicTpMgaIOjXxNngXj3B4aBfNit05i65sCt6E0BWrMmybzgDZAfaCWKTDESlKWxYt+QA
         VuVKd1qaqhYz/ey75LSVp60emL/kivRkxumMR/lqWKrB+5anzxwEyIPC0KpNwwCRF/cQ
         XKRIiCM8+cJx9DbEBCGOZQcQUgkOF2pP7M+iWrNQdDEtlIsi1QLzYrJKcrp9p/EnKApJ
         uZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvxU4ugiDB9i9W3RROc9iPCBryTiL0PvkD1UBcy4cHI=;
        b=4ni8zimerYHhzZ9cHXVQSik6poHnSGy2UV/zpMkmkvlDBsQrdretlg+CDpEk7JyBCS
         wsgDHDra9pHczrI4XekbhQRpIzFEkDinilBYovT9OdQypnBIgamfMnN8m3TZnPKuu6NI
         Yu0CQzpeLWiDqtS+VltkOBYqslw9aHN2eZKr0lSMnJUdMd9hOU/iM8+IjAInyTDdgl8C
         YnNt5Nabo6Sg5gxNxW3byDlqGGuHrNUed7KI6GPsLYK7yMQTMYelnD6lR+2JtfbroZon
         m577H6R6Fefm6fVr1hps6TskYDN+Sx92NjNNz9SQUvgXqzw3sKRSg7ujWsseljJz+cM2
         dL8Q==
X-Gm-Message-State: ACrzQf0037KzBDF1w3y7FCYmtfwsq77qsEL+LaejPk5cedwzIlj1Y/nE
        w7y3Z+cBGU5DxH9rM97brHO38Q3YNs7sSHUs
X-Google-Smtp-Source: AMsMyM5kdffvyHlBhzC6ymjj4wVkAhTHiczvVJ8cIYJVaGiRP5i36+37riToyxj9Hs5wpq9rv+b3TA==
X-Received: by 2002:a2e:a7ce:0:b0:26f:dd59:7762 with SMTP id x14-20020a2ea7ce000000b0026fdd597762mr960516ljp.476.1666094515168;
        Tue, 18 Oct 2022 05:01:55 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id j14-20020a2e6e0e000000b0026dee5476d5sm1929851ljc.113.2022.10.18.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:01:54 -0700 (PDT)
Date:   Tue, 18 Oct 2022 12:01:54 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rts5208: split long line of code
Message-ID: <Y06Vsr7JVvpPem5T@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning by splitting up a long line of code, improving
code readability

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---

v2: Reorganized the line of code by splitting it where it does not break
the parenthesis as recommended by Julia Lawall

 drivers/staging/rts5208/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index 4643127a87ca..74c4f476b3a4 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4505,7 +4505,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				if (CHK_SD(sd_card)) {
 					retval = reset_sd(chip);
 					if (retval != STATUS_SUCCESS) {
-						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
+						sd_card->sd_lock_status &=
+							~(SD_UNLOCK_POW_ON | SD_SDR_RST);
 						goto sd_execute_write_cmd_failed;
 					}
 				}
-- 
2.34.1

