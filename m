Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17B5FE52A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJMWTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJMWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:19:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43A18BE2C;
        Thu, 13 Oct 2022 15:19:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so4903577wrp.10;
        Thu, 13 Oct 2022 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWZO5WnwoOpM53BSawLAhm+17muuf4rDOcrXPg61DsU=;
        b=Qqwxjd5fM+3Tl0CF42MlCBv0ZHKMLr4H3dDBr2R4Uddzo1fu8IfPXR4d6RY639jn3L
         UniozUcSUa0tomcaB8rHCRSmxz0guNaLDq8DE0b5768+4vELuZ1a2VKZJoY7RwWdDsYp
         /UebX1fyTIQqlc/Iohw0TjOVFZC9drQN6XQA0buhzGyZAI3orie0NR0eDS8olkWF39Zr
         nQCk8kURKIwFN8sz8Il6nvX4hOpUdAX6Nk6FweV9BtWr5CNY1xdIGPgo4RWeF/9cFycB
         8WM+cbV92versPcs9jGVGUwz7i6/ihDZpUYmT1TM7GehTtVtve8tRbkCe92scsTj+6Mx
         PdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWZO5WnwoOpM53BSawLAhm+17muuf4rDOcrXPg61DsU=;
        b=JCNzeudFJb2MtC6cqxq7ngJfDXyigoyljovCoJYecjxqN7P3/YMWnSszwujHdpG95h
         cte+he0wh+OxnVAWE2R6YW+s5s+fMnDKH+GSuS00GgXKqIfkMo9akLfJQ5vld9c8fzvy
         5kVC8RIF/h9Go1P4nHL9I6oW+RqDCyZzrGVIc/r3WfaWOiBsHLVHJkQVMBS2vRcJdHLY
         yvmu7uX4/TmLcclMyiUrJsOxT7giCiHaaZn1xyooudNmYX1WIqD/M65s1UcisQULJhIk
         oDOaFAdYJFqP7t6Qjq+DjBb04tF4x3xOMF07FyBFAUO8Vd4ZBNm0UGteKjfkxSQMSYdB
         5wlQ==
X-Gm-Message-State: ACrzQf36M+XAwu9Fv8c+K6TazYvpfKrRXQTPBJrhsb60puDDQqc7NJ56
        sIMognxAuWh5gXa/xiOy2YE=
X-Google-Smtp-Source: AMsMyM5T/Y1MImg0a4Kir6/WdNfneT469otZ9Tn10qUf9O79uLuYlnTv8o1gAsdrZYyo8Rc7pQ150g==
X-Received: by 2002:adf:fd04:0:b0:22e:4bf6:4a08 with SMTP id e4-20020adffd04000000b0022e4bf64a08mr1402434wrr.619.1665699556688;
        Thu, 13 Oct 2022 15:19:16 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4cd0000000b002302dc43d77sm478674wrt.115.2022.10.13.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:19:16 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: Fix spelling mistake "mis-match" -> "mismatch"
Date:   Thu, 13 Oct 2022 23:19:15 +0100
Message-Id: <20221013221915.128286-1-colin.i.king@gmail.com>
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

There are several spelling mistakes in kernel error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/parisc/eisa_enumerator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/eisa_enumerator.c b/drivers/parisc/eisa_enumerator.c
index f54a6f450391..f0cb31198a8f 100644
--- a/drivers/parisc/eisa_enumerator.c
+++ b/drivers/parisc/eisa_enumerator.c
@@ -393,7 +393,7 @@ static int parse_slot_config(int slot,
 		}
 		
 		if (p0 + function_len < pos) {
-			printk(KERN_ERR "eisa_enumerator: function %d length mis-match "
+			printk(KERN_ERR "eisa_enumerator: function %d length mismatch "
 			       "got %d, expected %d\n",
 			       num_func, pos-p0, function_len);
 			res=-1;
@@ -407,13 +407,13 @@ static int parse_slot_config(int slot,
 	}
 	
 	if (pos != es->config_data_length) {
-		printk(KERN_ERR "eisa_enumerator: config data length mis-match got %d, expected %d\n",
+		printk(KERN_ERR "eisa_enumerator: config data length mismatch got %d, expected %d\n",
 			pos, es->config_data_length);
 		res=-1;
 	}
 	
 	if (num_func != es->num_functions) {
-		printk(KERN_ERR "eisa_enumerator: number of functions mis-match got %d, expected %d\n",
+		printk(KERN_ERR "eisa_enumerator: number of functions mismatch got %d, expected %d\n",
 			num_func, es->num_functions);
 		res=-2;
 	}
@@ -451,7 +451,7 @@ static int init_slot(int slot, struct eeprom_eisa_slot_info *es)
 		}
 		if (es->eisa_slot_id != id) {
 			print_eisa_id(id_string, id);
-			printk(KERN_ERR "EISA slot %d id mis-match: got %s", 
+			printk(KERN_ERR "EISA slot %d id mismatch: got %s",
 			       slot, id_string);
 			
 			print_eisa_id(id_string, es->eisa_slot_id);
-- 
2.37.3

