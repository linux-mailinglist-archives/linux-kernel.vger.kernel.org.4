Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093876F91A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjEFLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 07:42:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157D8A51
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 04:42:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso4192493a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683373346; x=1685965346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H75PoJkxbOlPB4LFyu3WB9LkrwkEzPSes0MNQZlIJVE=;
        b=FFG+JzBDXCE4V66Nq+Qs4CKHVBMKk1NeUkFlsWQzFBYEI1BfCDF7hlZ69+klwZRUW3
         ByDi9BLoTkFzpZOOM5siv4iDE0jHnwyXlGfyzeqTYqnlOdcBmIIBJ5gG2PYI1ymNy248
         Jx9//euPaVkE9mpmtGoS3k8rtGCLE6RBua3dY+eKzP18sKX/J/R8zv54tF92lsJI5Lqw
         p6Ns0KCOhUj5fO4OxBscUNT37ukZBWpjgWBUbBRh7QvUUqsj/ExRs6mDglkFUR6WB8HF
         +m7yUxSMPaArZ43pJ74gMISbxTVgUKHmaQ4ivoeLmZFyF4RsPWpip/YA7G6kCfwDbdOa
         lN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683373346; x=1685965346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H75PoJkxbOlPB4LFyu3WB9LkrwkEzPSes0MNQZlIJVE=;
        b=aksRyBtshFz87Lt+zDpgWYPCwjE1GfUE4SpyBXCYk+E4i0YMxEr6hVr4X5/fxGnG0h
         1gPBqMcILEpgAMurAc9usDkJ6dSrTxmSgUzqHKtqeHDQ9fBhhQA4LQl2N+QW5kLHE6AP
         JgrliOTXnLgrnCVhUcDGoiU0W4SB/1MQBqSYg8kzaiPiF9yqIvk9CWHX9zs8zfx2+sq2
         yBSjJtEkNT1FJqCxEV2CXk8o56QOwAtbmUWA3ROPbYK8lVnw1RPILysZzqxE3rJISTbU
         8n2anVbc6Owz/fGf827JdK021kDNyivwLUD35eo16mwRkim4/JCukO9v+Fo595ti3sYO
         jPWA==
X-Gm-Message-State: AC+VfDzkR380FeLMMjjtcNecAbYNdbm8DY6Bl6xmQ9xfVmQMa6PbT9Jq
        Z28N+0Ke3w5MEE7EH0NKez4=
X-Google-Smtp-Source: ACHHUZ4rCt2YIWM5HEzOyXxJ+Rl0PemqrqACUaPvPybqYObIDfli0GQUYQe9vH40kwydEojfmro0ZA==
X-Received: by 2002:a17:907:1c05:b0:930:f953:9608 with SMTP id nc5-20020a1709071c0500b00930f9539608mr4760174ejc.0.1683373346270;
        Sat, 06 May 2023 04:42:26 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b00965eb608a28sm1798783ejc.40.2023.05.06.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 04:42:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 6 May 2023 13:42:24 +0200
To:     liuwf <liuwf@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, joern@purestorage.com,
        torvalds@linux-foundation.org, urezki@gmail.com
Subject: Re: Library: [RFC PATCH] btree_blue - A simple btree with fast
 linear travesal and more. V4. and test data
Message-ID: <ZFY9IFM9zjFhvyPF@pc636>
References: <48d6f5a9788af056a212d0d5ba08219fdd592fbb.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d6f5a9788af056a212d0d5ba08219fdd592fbb.camel@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Liu.

Just one question. I tried to run your test-suite that compares
mapple_tree, btree, rb-tree and btree_blue. Also i wanted to have a
look at its performance in other workloads. Thus, i have one question:

>
> +void *btree_blue_remove(struct btree_blue_head *head, unsigned long *key)
> +{
> +	if (head->height == 0)
> +		return NULL;
> +
> +	return btree_blue_remove_level(head, key, 1);
> +}
> +EXPORT_SYMBOL_GPL(btree_blue_remove);
>
I added a small change:

<snip>
diff --git a/lib/btree_blue_test.c b/lib/btree_blue_test.c
index b0a73836523d..9dfbe9e6b8d5 100644
--- a/lib/btree_blue_test.c
+++ b/lib/btree_blue_test.c
@@ -530,6 +530,7 @@ static int btree_blue_test_init(void)
 
        t0 = ktime_get_ns();
        for (long i = 0; i < RANDOM_NR; i++) {
+               unsigned long *tmp_ptr;
                val_ptr =
                        btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
                if (!val_ptr) {
@@ -539,6 +540,14 @@ static int btree_blue_test_init(void)
                               i);
                        goto exit;
                }
+
+               tmp_ptr = btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
+               if (tmp_ptr) {
+                       err = -1;
+                       pr_err("btree_blue_remove %ld, val_ptr: 0x%lu, tmp_ptr: 0x%lu\n",
+                               i, (unsigned long) val_ptr, (unsigned long) tmp_ptr);
+                       goto exit;
+               }
        }
        t0 = ktime_get_ns() - t0;
        printk(KERN_EMERG "btree_blue %lu deletes use time: %lu ns\n",
<snip>

it removes two times same key. On a second removal i suspect
a ptr_val to be NULL but it is not:

<snip>
[   20.598023] btree 1000000 deletes use time: 251484314 ns
[   20.599360] btree_blue_remove 0, val_ptr: 0x17259549162592618731, tmp_ptr: 0x18273237390749509852
<snip>

Any thoughts?

Thanks!

--
Uladzislau Rezki
