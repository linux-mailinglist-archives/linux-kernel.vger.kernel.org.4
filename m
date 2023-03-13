Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88576B6E53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCMEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCMEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:14:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C02203B;
        Sun, 12 Mar 2023 21:14:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e11so4528582ioe.3;
        Sun, 12 Mar 2023 21:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678680846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XUhL8FFcNhP1iWeAiFBGkWuirlsQdIqQYoFoEIJuKs=;
        b=SUwtv8PubyTyqt86xU2y0a3JjevLFIWqH0BM9Zo2+N0D5TeCC/5Dl+89ooEFgx8ZlV
         ROwuuot4uXc8ZawFh89qWVw5l920E2Umz+F4oy8kaOL2FzXEmJpLPhC9JgdCgLMhijuQ
         IwdQFX68IMa6n/YhWYbi2OS+K1b61Bemj9t7XF9h0ifuHuyfyQKdX9wiSEU0WxWqEDqG
         EUUfCdCI3c1NOvXTA0UW3xnyJdMg0IcxUAHILw5HLEHbI3mElJF84nLm0okA+bpX/VNi
         Lrd1LHjZb2cdwfKojLlEcAH9jmpbC4p1ExN7uK46K6UIQKZEvjZivz6IUc42XmmUAcDp
         9Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678680846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XUhL8FFcNhP1iWeAiFBGkWuirlsQdIqQYoFoEIJuKs=;
        b=D+Cso6KheQRdIFzEAYkdlfhGZoMoBA+7A28HfuY7Tu/5icknmcn8FWeANjVVlgkuKX
         rNcuCGeKc/fJEpnksB8LdH2tKr95DcizKeMpy2R2ijDpPqslZrVjPF15IR9iDaIvllDl
         prNt7NJ5xrrhoeG4JmW8mwc/V6t8vdXWsQeGY3btnyAMJBnjwo/6yVwIg7bu71oPsr0T
         aZGif/NAYPOCY7iXEQdr4nSWltfnQE25m5ogAI3KpqmhLt5AL8dor+xrZ1l4ORtOcrdg
         5piVHX3CdQp6bHCSN/sWx9AAMzkfCkhmhVEvZGI4ehtwGHOMdjEAqOyso5FGfsH4Yxzr
         4CIg==
X-Gm-Message-State: AO0yUKXb4jZwwR+I54AoIwRVNFtpKvoFNoMrJfBnRurA7Tdgj6OE9TA6
        +MWkaK6Lcs0fFvICrv7q2wghByo7W4nIhA==
X-Google-Smtp-Source: AK7set8nuC3o2iqcZmK+SspoElhwJxaJ0cnSuWnz7DvEEZSLt3+M+jCQEdT+uiqu0U3a8rq+GCbpsA==
X-Received: by 2002:a5d:9297:0:b0:74c:99e8:7f44 with SMTP id s23-20020a5d9297000000b0074c99e87f44mr5152476iom.2.1678680846323;
        Sun, 12 Mar 2023 21:14:06 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id w12-20020a6b4a0c000000b0074e6f2c584dsm2186258iob.12.2023.03.12.21.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:14:05 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH] scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR
Date:   Sun, 12 Mar 2023 23:14:02 -0500
Message-Id: <20230313041402.39330-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Xiaomi Poco F1(qcom/sdm845-xiaomi-beryllium*.dts) comes with a SKhynix
H28U74301AMR UFS. The sd_read_cpr operation leads to a 120 seconds timeout
making the device bootup very slow. Like the following:

[  121.457736] sd 0:0:0:1: [sdb] tag#23 timing out command, waited 120s

Setting the BLIST_SKIP_VPD_PAGES allows the device to skip the failing
sd_read_cpr operation and boot normally.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 drivers/scsi/scsi_devinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index c7080454aea9..bd110a93d047 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -233,6 +233,7 @@ static struct {
 	{"SGI", "RAID5", "*", BLIST_SPARSELUN},
 	{"SGI", "TP9100", "*", BLIST_REPORTLUN2},
 	{"SGI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"SKhynix", "H28U74301AMR", NULL, BLIST_SKIP_VPD_PAGES},
 	{"IBM", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"SUN", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"DELL", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
-- 
2.39.2

