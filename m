Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE25647F72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLIImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:42:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE474FF83;
        Fri,  9 Dec 2022 00:42:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b2so9846537eja.7;
        Fri, 09 Dec 2022 00:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYgdzP39Mql0zjvJT+T/NeOtFYXDAl47Xpm4LtbcItg=;
        b=g/c0JYB7XkFF+GPMps2pIh6aCduU1FOs8Az9gcNRxtlJDgVcTjMfFLg5IEiryJoWtK
         slkV5q+0/knYk50p+xc5idAR2CDh0p1d1G6kKqiqNiA58aybFkaVipw1GxZ2OSq05lAn
         a3JHUqYXPX0JHDfHstM9qKUCJg4RTtUN6aiqSKizybxO0m+yclacQowBaiU7i27yNX72
         voIxUd/54XDaklL89+1PrrT2zYp058WfP9HkrRiO5EEPJw2XPf1D0A/BsbOTK4e3Cywb
         PJg3oAc+Q6Cb54G2N9ThaUHsbDI3vPWyYHajl8MI743T15yUxYPPVp9B2U0N9qpDmFii
         ZsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYgdzP39Mql0zjvJT+T/NeOtFYXDAl47Xpm4LtbcItg=;
        b=5c0x+zrNa7CIURUBEU7pFRHcYd8wGcQhT+Mka9u3ohZZYZnGsUsiiBXfDVUW3jYxFB
         pXilKoK56gzVwTmnoXCUn1AbdhaOwDTp6rI2bmDgohyMf9ieW4NGu2gMhU/ZMcwM+g1k
         4GlWNt/2xVyLLUrvRCwN5iAmNxC7q5DRjwtnFS8MpqfnxP8ePmTt+0a9vT1RHcqTxlcz
         z+5AOqLAHoGXKGWQMSh3UaTQUtkVAmTOTzU8yEXQrUh4tVKMdQeYKhaVtZ9+AQYIFns+
         FOr/I9bYlchYmYLNOraQdTHo5ynRf8MmiyQW0aXKAJ/s64qst1d0fj7dyjvNqPEDkhwL
         ON6A==
X-Gm-Message-State: ANoB5pkH1trNjZHFG68o4yxEf+e6436xostu/NHjc9N8+jeOypGEVeLg
        uRVg8QAGMzOoSboPLnrJMWFk+TxNmlQ=
X-Google-Smtp-Source: AA0mqf5ewuouv8EP9cLW/LG0cxjIuHRygwr6AHGS92mdxUGzIaJbFrbZd3uZAxOpnlESdfzHTIpybA==
X-Received: by 2002:a17:906:174f:b0:7b9:8678:50a5 with SMTP id d15-20020a170906174f00b007b9867850a5mr3942066eje.32.1670575336246;
        Fri, 09 Dec 2022 00:42:16 -0800 (PST)
Received: from felia.fritz.box (200116b826756500611a29889499a521.dip.versatel-1u1.de. [2001:16b8:2675:6500:611a:2988:9499:a521])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906938200b007bf5250b515sm305611ejx.29.2022.12.09.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 00:42:15 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: remove left-over due to now gone pktcdvd shortcomings
Date:   Fri,  9 Dec 2022 09:41:30 +0100
Message-Id: <20221209084130.31805-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f40eb99897af ("pktcdvd: remove driver.") removes the pktcdvd driver,
including the config CDROM_PKTCDVD and CDROM_PKTCDVD_WCACHE, and the uapi
header file.

Remove some further unneeded left-over due to now gone pktcdvd shortcomings
in the scsi library.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/scsi/scsi_lib.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9ed1ebcb7443..d74536d4cc94 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2018,14 +2018,6 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
-/*
- * pktcdvd should have been integrated into the SCSI layers, but for historical
- * reasons like the old IDE driver it isn't.  This export allows it to safely
- * probe if a given device is a SCSI one and only attach to that.
- */
-#ifdef CONFIG_CDROM_PKTCDVD_MODULE
-EXPORT_SYMBOL_GPL(scsi_device_from_queue);
-#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent
-- 
2.17.1

