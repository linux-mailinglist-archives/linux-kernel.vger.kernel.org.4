Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE46681E09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjA3W1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3W1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:27:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31961F4B4;
        Mon, 30 Jan 2023 14:27:33 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id b4so3400166ioj.0;
        Mon, 30 Jan 2023 14:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBDPnxYSUfrgiKj2KMKkACqLWIz+4lF8zwzbQUTMXqY=;
        b=NviNuGt3il7xmstfEMv2zmdDte/GIs933d6FuffEQ6x+qBpvNU2cFze32sFvYnLVOy
         128Z367Dg/BTLaPh3A7VAwQigFjoLmpkXtikBvcEokAiWnRKA8ZO3tte12VYEKOlGf3f
         ZiUOOhgerUEhOJ7RoGQzgRwuJZ0C0iqX7rzgelFODRoaVVvUwKMHl1RBHOw+RmJphBdL
         08L2bhbe0fvXg4CIywRzn5BUPffR6mCysDv8/z4UQwgDmeYa4Hpn5f3Q0IQyLV141+yd
         m+mVZas2xy3mGZUXn9DIdH6Uaa/LEMsnuVyTbxqYsDHzJTuyN8DLORYGdNzKELNOZ5cT
         a9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBDPnxYSUfrgiKj2KMKkACqLWIz+4lF8zwzbQUTMXqY=;
        b=zhYp9ArZWsFrmXwmVTkY5ESaf3wB6rf5Adqlc/5BNqAlvTuTSF1SdIKnHUUt7tk8dG
         HRxDbdYDVzwK6vX2qgCYQeglKwaYUWkN75bo+EFwGedehYb39cLRaW3I9HTqqTbZq8V6
         1EojslD0PJaQgFTQ4VfOa/SQ6Yc7iCt+FpIL8BLdN55kDSlNJS4LLx8DAgmkoWhqm+P+
         iZQLuSlZFmjlfvs7pfShWZmHnb1Ey49GhvpYExAXj8A2E3tT8HR5nbxCGTxGCm8x4s79
         pbAra4hI8NuM3oZic08hQzqugMLzbhlpTKRB0MfvGH8c+40sP1gSE6v3/CvMOgl3vXDo
         d0eg==
X-Gm-Message-State: AO0yUKV9eXuUttvb7ww8sbJpij1nRcwdXQayHWaOmOUYOFhuVlxB6+iG
        8VW9dX8EnuorVypotTpH9V8Ws0maNFCmvg==
X-Google-Smtp-Source: AK7set+oCdscayHGv0+JxNg85OIUfKxsr+c1taK3ZxmdpYN8KHa+xfEyrGEK/5txXwX6X4LM+Wkugw==
X-Received: by 2002:a6b:e402:0:b0:707:dcd8:2aea with SMTP id u2-20020a6be402000000b00707dcd82aeamr7151526iog.19.1675117653238;
        Mon, 30 Jan 2023 14:27:33 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id c62-20020a029644000000b003a96cc2bbdesm4535426jai.85.2023.01.30.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:27:32 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/2] misc: fastrpc: return -EPIPE to invocations on device removal
Date:   Mon, 30 Jan 2023 17:27:15 -0500
Message-Id: <20230130222716.7016-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130222716.7016-1-mailingradian@gmail.com>
References: <20230130222716.7016-1-mailingradian@gmail.com>
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

The return value is initialized as -1, or -EPERM. The completion of an
invocation implies that the return value is set appropriately, but
"Permission denied" does not accurately describe the outcome of the
invocation. Set the invocation's return value to a more appropriate
"Broken pipe", as the cleanup breaks the driver's connection with rpmsg.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7ccaca1b7cb8..2334a4fd5869 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2337,8 +2337,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	struct fastrpc_invoke_ctx *ctx;
 
 	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node)
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
-- 
2.39.1

