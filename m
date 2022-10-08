Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331E5F83F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJHHJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJHHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:09:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8443BB043
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:09:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 3so5150480pfw.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwgE5luutAnRT+PkK5v8g5jEsmfaMaq0PpMbhLvP0lE=;
        b=KJH9tcBDp0sap3/a+uZB7MoB+le+Hj9E/RTZw8cXEhbev7uOO9m7VY6/LSqyjHSoWi
         vXFWcFDRVI4HnN2FfCyepXKx7Mm91gWvEe+682mOpaoxrqv2PHpP81rIZORMZACTcD2J
         88NwHLa/ZTvZQcaMOoR4VA70825G9cVEGkPTfXkSf659eBsxTRT7WO0kYuEEd2PsBDUB
         hIJSykq3f1G2O0UB8I3QSl7do5Os+9lJAnvlS+GdJqi6yrk/pm3SLlFDeyugOo+MEngk
         s7/ahbIa17kdYFWZdMuq0F7DRE82lOWFnfoEBNSX3HpZBeLG1uTSPYPEAsOYCF9WKTsu
         OCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwgE5luutAnRT+PkK5v8g5jEsmfaMaq0PpMbhLvP0lE=;
        b=hh/e+RUZB01KFtQjcXLiikzcv7Gye2UeEfa2EvQkvJNqS2/EvEvFyFwfdZe0nNmkGh
         Ro2TJKI7bXkUq8uZQZRSDBYq7+KdoWKb99wJUPVamIhd20rb/F8lrWaS5A57jnQa3+ZN
         ErYCDZJDVxSQYZ5FtBDZMqj0g7mA3dslIcvkESFClh6BdNfNwYnlllCJzwPLNcaV03H4
         sB1TZfu/9jMHVmKYjhiDM0Tn4wT0bsOYE5RcJ0x32/KCgAxg+KwT82te+zr1UVe8/eqQ
         npVAL43NrHR/8jVm6c8+T0JzEKyDxGgsGlQEVYZqqcXf7AbE7n8ixzFKNVShFFzKw086
         aOPw==
X-Gm-Message-State: ACrzQf3r3paDRS17aR3xxDAj4avOL/uPFHye5JKrFhgf06jsDOTmyQpI
        VI9BcuctvLFEvAEj+Nb5J1I=
X-Google-Smtp-Source: AMsMyM7XNpyJYi8+xXQI7TAFwE3wq3DKHhs27o0T2vzkkVChvR32huCVWy4yr1IJOdVca1qkQz1HwQ==
X-Received: by 2002:a05:6a00:2c98:b0:553:e926:c47a with SMTP id ef24-20020a056a002c9800b00553e926c47amr8991912pfb.14.1665212942508;
        Sat, 08 Oct 2022 00:09:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b0017f49b41c12sm2593722plb.173.2022.10.08.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:09:01 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH 1/5] ksm: abstract the function try_to_get_old_rmap_item
Date:   Sat,  8 Oct 2022 07:08:53 +0000
Message-Id: <20221008070854.308851-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221008070156.308465-1-xu.xin16@zte.com.cn>
References: <20221008070156.308465-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

A new function try_to_get_old_rmap_item is abstracted from
get_next_rmap_item. This function will be reused by the subsequent
patches about counting ksm_zero_pages.

The patch improves the readability and reusability of KSM code.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03..5b68482d2b3b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2187,14 +2187,11 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 }
 
-static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
-					    struct ksm_rmap_item **rmap_list,
-					    unsigned long addr)
+static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
+					 struct ksm_rmap_item **rmap_list)
 {
-	struct ksm_rmap_item *rmap_item;
-
 	while (*rmap_list) {
-		rmap_item = *rmap_list;
+		struct ksm_rmap_item *rmap_item = *rmap_list;
 		if ((rmap_item->address & PAGE_MASK) == addr)
 			return rmap_item;
 		if (rmap_item->address > addr)
@@ -2204,6 +2201,21 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 		free_rmap_item(rmap_item);
 	}
 
+	return NULL;
+}
+
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+					    struct ksm_rmap_item **rmap_list,
+					    unsigned long addr)
+{
+	struct ksm_rmap_item *rmap_item;
+
+	/* lookup if we have a old rmap_item matching the addr*/
+	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
+	if (rmap_item)
+		return rmap_item;
+
+	/* Need to allocate a new rmap_item */
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-- 
2.25.1

