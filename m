Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AE67B905
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjAYSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:08:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEFF2884B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:08:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b10so19393711pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+j6xELBma/Vt7bs5cvsSQdXphFYWcrFj3VJj5t06H8=;
        b=Xf47nUe+ZSt1VTdvNDT8Pja4OEaChAWZsf5V6Gn+UonA9iVabOzfPFuiyCf54VQiha
         kqBvhFS6FqVJIXe8pGofn/RpWHfrDcDyVRL3aQIeGT9sXgZ3im3QATsyMMj2mYxu/lnu
         I9nvGeBxNaaY3n7BtejRlhmYGFwofz0rKwb8ULSKfDH50IRcHZLQuicHsHm3uflYViza
         d/VrJ6r2AZFbaC+A2O8CNAMt25iCDk4md4G9dW4Z7DFqRkjLGkruVQhofizJdk6giDGW
         XhyVtbFz/gPqCkyVsPKXRagAwfWSEl1I9Pyq7xq2NKcaYJACV3GzN1VQLLE5JE2gJIFB
         9ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+j6xELBma/Vt7bs5cvsSQdXphFYWcrFj3VJj5t06H8=;
        b=YcJXb3kjg2oonwgCdkIeU21HOUkLrZ15h6lggCzVhnculIOKYlQEYhKSRvt70Qr/x9
         LxgAQefpKkj1HS7whU9Ny0v9z6KsX2eP77X2e8CJZIhe9IgFFzQQnCgij37ilbjsjdQ+
         +MPVEuBKHDNxvyAnnMzM8OaNYLge6Zdc4n2omXgFQNzoa4c67jCkWfSKMSxLCPgjlo9Z
         QNp+y6LZzjeLXOZXfmX+FED8FoqQ7Lbd6RONXKVcLfsWQ5OE1/rVYarebxXV+5uMpT/Y
         ZCzva3gRSDpisC0L8ngCqwYfY0jgbi042F79sAP4wuF085qKTVubCmomihqzJTGXBT53
         1Cgg==
X-Gm-Message-State: AFqh2koWxvCjDyQdbKVrQzbmVQq61rPv7FoV83fbfvE19SVbMbuXy0gj
        NlrOP8CUJ4AU1/8vP0QwxGk=
X-Google-Smtp-Source: AMrXdXv6P75aLYzVdE5wVJfWdx90cQh0gq/L/qeXhN3IS34xJOTnlUxL+8TifWHWX3te5G7i8fA4Ow==
X-Received: by 2002:a05:6a20:428b:b0:a5:798c:f929 with SMTP id o11-20020a056a20428b00b000a5798cf929mr43850572pzj.10.1674670134033;
        Wed, 25 Jan 2023 10:08:54 -0800 (PST)
Received: from ubuntu.. ([112.212.226.173])
        by smtp.gmail.com with ESMTPSA id q141-20020a632a93000000b004da5d3a8023sm1070557pgq.79.2023.01.25.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:08:53 -0800 (PST)
From:   Jongwoo Han <jongwooo.han@gmail.com>
To:     akpm@linux-foundation.org, jongwooo.han@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix typo in comments
Date:   Thu, 26 Jan 2023 03:08:47 +0900
Message-Id: <20230125180847.4542-1-jongwooo.han@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be..01298e887 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1055,7 +1055,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * This does not guarantee that the page exists in the user mappings when
  * __get_user_pages returns, and there may even be a completely different
  * page there in some cases (eg. if mmapped pagecache has been invalidated
- * and subsequently re faulted). However it does guarantee that the page
+ * and subsequently re-faulted). However it does guarantee that the page
  * won't be freed completely. And mostly callers simply care that the page
  * contains data that was valid *at some point in time*. Typically, an IO
  * or similar operation cannot guarantee anything stronger anyway because
-- 
2.37.2

