Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908106C00EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCSLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCSLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:42:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B620D3F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:42:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so36654933edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679226122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=etS4Y9P+MAqZ3qeshJXE0XPH+xaAZBuPj4c71JZtAato2AI3nreH1nf4wnA0tNb+xw
         gVHys/1ORXAAjsH+xlz+Dcspth2rhy9K2CosWWypIh1Y+hdgjATjQHqbNPl1E/dF2gLZ
         aTks6NhBVYWrNEUoDnAfoG+LDzXhEGXOEvOz7aL/pOvDHUZUpFR557fkXs4F2/WTBLXw
         np7hqqyascOpbq+ULLutE58tkJriUC3SR1jFYFDFZD2eWkSKwupDep5tRPUNMeYS2OPv
         f4G5jgXfWyFanrEVYy8TWL5cFsboV5qlxZh6U4pqRMRb6SCqqyJzEJh/5xbgtIo4unHs
         VeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679226122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZHVKRyqUkVQgHIPcnrjM4VftHtoW1MPmlfE9Rq46vI=;
        b=QvtVgddFJR4lQsxPt0IpAV7oGgzTouUK3V7OQdm58OR+WCkkGgM4xOiDwVxtHrYmWY
         vehixg0Kb2IcVR1OCLH0S4k7g1MfnDdJBWdwBN+bnanj0vgKdliPgAjzNwNmRlB3oVsb
         +Xuuh6XxgXwy7GY4X3f3lETFcKbxQG1NDj+qMLPcxRoKMM93kMm1ZSz8FQWcZNwSJE+Y
         vUVWZt6Al2mb+AdjgwG67IsVa4yziz30W28PgLsfHyu8PP7Az6dgmNDpcV5V+dKEy5aS
         Fu+CsAt9kLx054TC7i2tZ1ltEpOwvcRq+qsr0rlxgjP80pKkza4RIuDf+LPOxOqma/Te
         5u+A==
X-Gm-Message-State: AO0yUKUkEgBSUzguHmJksuAjNJhx0SlHst9q2qJ51w1ScUkY3G3YboIa
        lz3JEz4Kq2eSk5xPmrWK0xY=
X-Google-Smtp-Source: AK7set8+73Y1DR8RnHNNwoEuwKsFRyWb+UaHr5kq7a7sMnBvoZ80trvGxqWUKIIEcGTvSQ2sdd3A1Q==
X-Received: by 2002:a17:907:7642:b0:8f3:8bfd:a8e with SMTP id kj2-20020a170907764200b008f38bfd0a8emr5351877ejc.26.1679226122490;
        Sun, 19 Mar 2023 04:42:02 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709063f8700b008eddbd46d7esm3180681ejj.31.2023.03.19.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 04:42:02 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: remove unnecessary blank line
Date:   Sun, 19 Mar 2023 13:41:55 +0200
Message-Id: <20230319114155.42148-2-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319114155.42148-1-eng.mennamahmoud.mm@gmail.com>
References: <20230319114155.42148-1-eng.mennamahmoud.mm@gmail.com>
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

Remove unnecessary blank line before struct as reported
by checkpatch:

" CHECK: Please don't use multiple blank lines "

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/greybus_authentication.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 7edc7295b7ab..48b4a9794d3c 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -41,7 +41,6 @@
 #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
 #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
 
-
 /* IOCTL support */
 struct cap_ioc_get_endpoint_uid {
 	__u8			uid[8];
-- 
2.34.1

