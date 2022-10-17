Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F56005AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiJQDVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiJQDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:21:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4914D824;
        Sun, 16 Oct 2022 20:21:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h185so9320388pgc.10;
        Sun, 16 Oct 2022 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PP+1cbg4L/UF66s7dEMZWnWvJnKFlmZOm7ZgoIz7bQ0=;
        b=ahzWSTKDshbBVp9oJGUAYvKuPbFdCNjbOj3snzuAAMlzMXaZixfCOlfMkGUu+n4Ibb
         Q8/A2Aorpgy2ZoJ3Zb4wVMeacCujoZjv4TODpZQRBjrmFdapLigam4RJQeHmVfFW4ZRR
         2uoSQIMcFvS7IuEodUfaxcTnkF9FHIGoyVPf5G+A3Mz8dTd+WkdP/3jmukEbkiCCBXBq
         ewLd0zfKDi36ZRFVUA8a8ZcqjuR5fqfitKw2jWSKATTlZS+mXjXQuJCQbn28FsDygjL2
         fE/ZFruyiyVxhwbjQFPeR/7DozxZd9BSv3mW8W4gErZg4XO+slWZH3UMrV3lhLtjVywi
         ljFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP+1cbg4L/UF66s7dEMZWnWvJnKFlmZOm7ZgoIz7bQ0=;
        b=DOv/jmnLou3t0M8EdRB891Zc6azXxZ7pA1vfgVSAEEmJykPC/PBQCsfdhPO0LFsL20
         0eDPNalr6GXHubMzDtQqRYAxheJaRq6EFSmqPNq4Tf2L0DDxjw9A3DZpgDHBlOhyi64A
         iwgfNSz5uv2uj06Bb9hVW+gNHd7sDF4QuuE+Cz7WyFiNCh7smVry8zT9NT0QIdtyF49g
         CoYNSzmViEgQW6E7+0XGNQnB9dqxbwYlYY4J1QeYGzk7CnzfECjadaf3ha57AGTw/Vk6
         pcAV1zf6xD/yTHh49AclwH24keUuuqe/ODGhOiq9GS29OQm/iGLozJCD+n6G6mbpoyCq
         F20A==
X-Gm-Message-State: ACrzQf0FlwcO0LvGARO6j3cHmjty062W4w5+5bhIVvWtvt6UJUrGUo+s
        YyMIWexxJKVhQpozN/tZDB8iE9M2qwyvl9IE
X-Google-Smtp-Source: AMsMyM5+ThMBl3h7Om47Gznbrx7PnyU6RdbZOnZIJQigSIzZz5AjG7ZgKC1JNfBYm5sHRJeSQnqzCQ==
X-Received: by 2002:a05:6a00:1a8e:b0:565:b185:cc10 with SMTP id e14-20020a056a001a8e00b00565b185cc10mr10188743pfv.71.1665976899129;
        Sun, 16 Oct 2022 20:21:39 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b005377c74c409sm5733459pfq.4.2022.10.16.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 20:21:38 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
Date:   Mon, 17 Oct 2022 11:20:19 +0800
Message-Id: <20221017032019.101-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

it defined in d0edc2473be9d, but there's nowhere to use it,
so remove it.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 64ee618064ba..6bcef8e5871a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -369,11 +369,8 @@ struct bfq_queue {
 	unsigned long split_time; /* time of last split */
 
 	unsigned long first_IO_time; /* time of first I/O for this queue */
-
 	unsigned long creation_time; /* when this queue is created */
 
-	/* max service rate measured so far */
-	u32 max_service_rate;
 
 	/*
 	 * Pointer to the waker queue for this queue, i.e., to the
-- 
2.34.1

