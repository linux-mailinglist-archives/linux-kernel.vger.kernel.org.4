Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704073BAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFWOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjFWOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536412957
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5577905ef38so193517a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532056; x=1690124056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=faPqmSp2y0syyRHOzB6aLt2UxcsCZv1TVjqArdfyvzlGx6oAUCo0ANvMefRfXlEK3/
         d8+tEwslPCEXpokhZQTtTUFU0g6WfloriqKlK9DULrdXPuhzwuHIZWlCZ3Bx7GvPpzSY
         l5yVW7+szniHuTyrleFYuMsEXeAX/AAjaSq/U63aln0FgcbC2qODOhLxgJDJe7fMHwad
         KYdrQ9ybu/GPKivmdgd0S9lB8SsfkbnkiDDRDeJ7uWb6iTssMwVIjWZAox+9Z8PBeHzy
         i2zi77QLoDncYIhOxCp6ynVTorFTSB9k7pfyKZUKJRON0jvs8BsY53WpatviqJH5HhyE
         IF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532056; x=1690124056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=YFkQ/aUk4tiTFN8W1WWfzQidJsZilCOa22uMx02BKZa2AFG2iJtR4v6d5EduASf8Kw
         12pknNH8yhFbqL64ahGnxxEt/+sgdWhaAO5/5BUPyjM1sZoauDAkdaaCacnGhADc7bsl
         WmD9SuWeFfzOezRHlT8DlH20flbspIFViqsrf10oSDrkweQpSXExJKBWyr+xViddBpWW
         apUEIiQWuU0JLlV4WBNsW1MMXnw1BHd10RtjVY9bCnZC9NqXf0xaqG8txZQ++JKzLVak
         L7NkEVRRtwpF5Pb9CYSGpL/6Y0Of4xbaZKTvqSvW0fwJEQ40zTBguISOcft2iZYBJklC
         jQJw==
X-Gm-Message-State: AC+VfDw2tSp4uIMhUJIINs4vlasNM2V2anu99ZX/XIApKoc+M9OEY1yW
        4VakSLY24pLqLIc/Q1MkoDI=
X-Google-Smtp-Source: ACHHUZ6WcZy3z60QTnLB/vtAVmfSySeh9XfBxqfQ9zP7rKPbwTmfTNFx/x0XbHo1KVeZKABjCTkh0Q==
X-Received: by 2002:a17:90b:3eca:b0:260:d265:2743 with SMTP id rm10-20020a17090b3eca00b00260d2652743mr9803117pjb.28.1687532056536;
        Fri, 23 Jun 2023 07:54:16 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:16 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 6/8] sign-file: use const with a global string constant
Date:   Fri, 23 Jun 2023 20:23:56 +0530
Message-ID: <20230623145358.568971-7-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623145358.568971-1-yesshedi@gmail.com>
References: <20230623145358.568971-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.41.0

