Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206495FC0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJLGfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJLGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:35:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D5481FF;
        Tue, 11 Oct 2022 23:35:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f140so15664158pfa.1;
        Tue, 11 Oct 2022 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UQnkMXwyxVQogDtNelDtTOOBNOEp5pQlgWybNCBtvM=;
        b=SMGdNLxMn+aL3HJ35F+yBAVTjBucxlDC0FmNVcdxdT73OTtO1iMm59m8yv6YNbrFDw
         ZCfyzfyjVrfz1zgWQxaWHTCqVAcMGyCU0Nq8QngmmHmtczoKCh4CaAM0AoCOQ2J3RVkn
         CaBDSXH2pqsqYxWRjrdYKDavtEwfLXdkbd4rcaDqw48OiwjskXKPWakkf3jklcCii/sp
         II5n6oEBRU1NCbsFYSngT921tSEy6hs/ezT9FhJ/e3sWQ8GPApwfRkxyxvVk2CCaxYCW
         radMf/wZFprB0t2Ed28KB5YWA/egveLR8PXT4AEHjm1NKZ5abAvzPwuf0jp9wLdSGali
         wnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UQnkMXwyxVQogDtNelDtTOOBNOEp5pQlgWybNCBtvM=;
        b=CqRC1yK+PHe1B83IVdQyLGgbyzHdLBwkXgvIbJTToU6siBDxBHOYNWYgF5mNH0lpLU
         16W0OGW7Sc/GMi7PbTHrPYssnNhIQSviuX5NkpUAiICc3+G0ij9T8xwmxTgty1DwqR9x
         aN84FTc7pUiMO7EHqW1J+speRw/f/T2tlbQZVxWLLo3OZn9uv6a5syrcPj1WYWvRsCmq
         +Wq6OFLda+RmEHMBZVb4KLgLiwxcmOKmCqGcpE2j1MCPVuy3Y7pb/p9EuBn7VIljkzUZ
         e5PtXWgWs9sms/9igwz+vvQQ/ZyleapHyrdNuJYruHte1l+tusSDN2Eu89VN+G+nCxRg
         PBNA==
X-Gm-Message-State: ACrzQf1UBC8ETWGbCiAZ/hErcQ14veuNJFDI+aWX2ZAh5vD6/ZXIUqHA
        WxlaiJdA4iNlmCDH0zdXauo=
X-Google-Smtp-Source: AMsMyM6EQf8gdkpEXrDIlF3gSKpnu+PCerw953ixic+puLItEt8AO0aKVpgxedc06FDOLHrm5Orw9g==
X-Received: by 2002:aa7:8e8c:0:b0:562:a549:efc5 with SMTP id a12-20020aa78e8c000000b00562a549efc5mr28646199pfr.20.1665556532091;
        Tue, 11 Oct 2022 23:35:32 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00174c0dd29f0sm9796491plh.144.2022.10.11.23.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:35:31 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
Date:   Wed, 12 Oct 2022 14:34:48 +0800
Message-Id: <20221012063448.248-1-Yuwei.Guan@zeekrlife.com>
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

