Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146376C205C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCTSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCTSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA639CEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so13459086pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=gF5NDLxTZFXke8hSgMnfu0Pbm1112P62xvUyToPgUAJz2vruhG1MiASgF9EuFYDC7k
         3ox1bTSf3Jplqm+oc3GSDb3ch6/a5gIwHXAG/LYWHqKCYCP6vbuVWTIDWFqEcZPtM2A9
         zmondetemix4W3B67x8WOYIxRXAcD9giadSVwfc1czpMETvwbZiFZwFLPnWPY5nX1pUq
         G3s/kNWOyktAzX8bN9t3znCg8oj+ztcs2PqBSR+OAbrYsrbDREpAFxTbMrr3M0IOXVpc
         fO1sIOu2/OC7JcuTwTeSz80pDKYaBeCF96K/koyvGavf+gXe3L+FRWt00cVaW8VvLSPD
         +7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orHz49MEtEREu43pkNm/tKqUuGAbP6UFRUzWf1lMbKM=;
        b=PR54RzssAyIfRvk810QYMO4DzLNEvl9U97SZ+GZ/XXbXpXKAelYqwx4V6C5LhaPqUL
         TP8l4LFlMlTXRW5J75DCGsJelogyAb2YojDslC3rU1lflmeCMarSk0YbxPuaPVWgNKz2
         noOe7LnPvBHUC2+Ta3+Bge1ShgeAr6bErfxsk91pnyIFKgHCGzguZLjudn8g39lR4PZX
         b9w/VrA0Vu3H/DLAAdGalSUIZeId6VOyMvtMtTbVEe5s/FyF5mzt6yksNeX/8icH/SAp
         RqBCe3Et4NjFiJqnVpSVsOwdKKmyoz/Fbs4v7vIR2jRwB6j0Dg7KajR67//T6VT3KXPH
         iGqg==
X-Gm-Message-State: AO0yUKXMr0m8OycvCWDjrEqV0qtp1SVJ6LwxOUlgfT1IXYBX/lRVOwvR
        ZDmjhKzgs/FNTz7ZbRkeGIQ=
X-Google-Smtp-Source: AK7set9YrszS017QFtyjFIxegLQGTZ7/uatJHaeUATD5gvyNsmbkLfIlwPsfSL31tt7fDFWgMHGzfw==
X-Received: by 2002:a05:6a20:6da7:b0:da:7036:dfa7 with SMTP id gl39-20020a056a206da700b000da7036dfa7mr355315pzb.19.1679337838702;
        Mon, 20 Mar 2023 11:43:58 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:58 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 7/7] sign-file: fix do while styling issue
Date:   Tue, 21 Mar 2023 00:13:45 +0530
Message-Id: <20230320184345.80166-8-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
References: <20230320184345.80166-1-sshedi@vmware.com>
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

From: Shreenidhi Shedi <yesshedi@gmail.com>

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index e8dfbdd3eea3..0c95275c4564 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -147,7 +147,7 @@ static void drain_openssl_errors(void)
 		if (__cond) {				\
 			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
-	} while(0)
+	} while (0)
 
 static const char *key_pass;
 
-- 
2.39.2

