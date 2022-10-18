Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7796028F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJRKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJRKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:03:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0EB14E7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:03:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b2so21694075lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poXckQpsmoxwNoGHA5Pmt8l8Bzt77xEo7VBtN46YHYQ=;
        b=p7utgJyKryujBfOPEjv6vh8HH+AWAsC6LMzl8ki2a10z+rnLThEJcuJISSoritjCUh
         DfF078C190eRQSRgoF8aSWQjaxGm+b+EhPjVt8eBY57aPbdVpvnypKqGEmRGMjDozG0L
         vLgngsclSMyY67BYvfVGWkzOORHr2rkNkY5o25x9D/gzzkRtqv5UZsPbokoREXeGF4oT
         tuFH8qdrEuMZYippqqqs3jNTgTuikjg/mb0Q56AZpJJg3Tzm7cYvqptO1fmmKE7ult6F
         dWLQC+khsl8P+AF3RhtEwSwzzGplYjlY7O0Rq7dvcsQcLyqNdHjJzobHFV7tPxjZDRJX
         L71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poXckQpsmoxwNoGHA5Pmt8l8Bzt77xEo7VBtN46YHYQ=;
        b=uM4Uii52mtpA5wm1SghUukwtBifHo3d5nx6u4rvURy0lAJLlEkFXnZ6vZu+/NELDzI
         HT9FBVBHskvJQ1M7JjFM0eDuuqFcyqY6Co/920VyyGHpiYzoKHXPAzKZOAPzU/TLynxD
         J0kM8k5QC3wdSr4KpYftZiHOBFOP5LJ3iMbPO1LofRLOM7UrcIIJhhIR1XtwqO+oPEa5
         NKN07T/5UophG8Dr2Rc3yTxwAMyVukS0XIF4pygBp1EUqCrkGcNXL67EiSXmh8u3tivR
         Y74hD38+OPYc2tP/3Htz2o1HAVfmh+9rbGorsRWUXKJ4NhklgAVTALep+pkk5QhJ5fyn
         C0bg==
X-Gm-Message-State: ACrzQf2nMWV9+U7iBIPxBLO/asgYK+skBF/PtiESumimXu/OjBfsyRZ4
        k3FeXVVeFvf/pXQVH3ur+ZQ=
X-Google-Smtp-Source: AMsMyM56LVd0XFwiHiLjZI0E1QuNElsebCjqLZm/47q+GyjX2qlYoDQAkmI7lzrQdVoCKJEtiFcCrQ==
X-Received: by 2002:ac2:4c03:0:b0:4a2:2273:89c6 with SMTP id t3-20020ac24c03000000b004a2227389c6mr650293lfq.245.1666087378946;
        Tue, 18 Oct 2022 03:02:58 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id a11-20020a19f80b000000b004a45ed1ae21sm1789261lff.224.2022.10.18.03.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:02:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:02:57 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] [PATCH] staging: rts5208: merge unnecessary split line
Message-ID: <Y0550VcHI8NzFzzf@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

Fix checkpatch warning by merging unnecessary split line in order to
avoid ending a line of code with a "(". The resulting code does
not affect readability and is well within the code-style guidelines

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/rts5208/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index d1fafd530c80..4643127a87ca 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4501,8 +4501,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			sd_card->sd_lock_notify = 1;
 			if (sd_lock_state &&
 			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
-				sd_card->sd_lock_status |= (
-					SD_UNLOCK_POW_ON | SD_SDR_RST);
+				sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON | SD_SDR_RST);
 				if (CHK_SD(sd_card)) {
 					retval = reset_sd(chip);
 					if (retval != STATUS_SUCCESS) {
-- 
2.34.1

