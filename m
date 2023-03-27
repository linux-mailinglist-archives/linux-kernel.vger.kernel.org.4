Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72E6CB051
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjC0VD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjC0VDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:21 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B71FE3;
        Mon, 27 Mar 2023 14:03:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z83so12484922ybb.2;
        Mon, 27 Mar 2023 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eco5b9MX5ijMYg1QKtG06cMKdPajE34qA3bf3aJ4dAA=;
        b=NyVHe8oA3ZLVbwoWRx9rf6XjR5/Q1rU27zX+uDFgL4OG3dqLxUE9nK3EvijqfyMxOo
         McNY49CuX52JU+gIs73d4q5uGJPhxbCx/oR/xDySVE385rETNJLJRnXpjlOSh1nwGnCL
         z3uWLP+0qTmZJixvs+PVZLxedn4AfW2mFDpNECf/fKK3g6EEotFVKjbcH1pcZ7j7DdbT
         VNGdW/6Q7TlGqoPl36YfsKcAo2LqN50qkQ7/5RgaAas1vaKq5oIlM5DSWREHkla9Zo90
         5SLxTeLkDqo6DuNGjC9wgB/818vq6pbINeLm7lXF0I28Ci18FZ94pKhZfhRGoby5M8fQ
         T8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eco5b9MX5ijMYg1QKtG06cMKdPajE34qA3bf3aJ4dAA=;
        b=ZJW+V2f61YD1Gk+ALXCoC3iLMu2ANzsINhaFjbcmL00W4roDvMCQzdhqA8Y+bZmf2w
         ikPvSa45PerIMz/Po/90N+wBvw8Ns7biSOuNmddoUlVX/7Vfj/Q9YQHA+yBkDY8geQzl
         Cm7APnsrxK21nlmPsYNIcJANocivpu+WIYBx0NVcYoxBEiFDTnzDL54DCio0iwzyLYda
         yWb9Fcf52ASbd47x9ewwy7Il+gGzK+37IjIio1ZqtG9sJW6S95/BEF39+jBjvCv9Ry6I
         dam9+KgzwaJctNaRVqzopm3SbLaLrQjiL4TKhJTQtllKMzaa4MGIW4JjqT1sh+n65L2X
         k85g==
X-Gm-Message-State: AAQBX9caR9mLJ0zSrfoZEhlmCHN7Amh5OoiGbPVmPICfszcX85WSBmdg
        Iy9Pld1KPuY0BUqK4Vfk0XrUiOasNP0=
X-Google-Smtp-Source: AKy350aNDjsGSL83wGRrChvZr/ieADtwRXeBM4lgWsian3xNGALsVEAKEy9xURewrQWRgPWF+XxE4w==
X-Received: by 2002:a25:ada0:0:b0:af9:1ec5:4f10 with SMTP id z32-20020a25ada0000000b00af91ec54f10mr12668031ybi.59.1679950984547;
        Mon, 27 Mar 2023 14:03:04 -0700 (PDT)
Received: from localhost ([2607:fea8:529d:4d00::9f37])
        by smtp.gmail.com with ESMTPSA id b125-20020a256783000000b00b7767ca748dsm2525176ybc.42.2023.03.27.14.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:03:04 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/2] misc: fastrpc: return -EPIPE to invocations on device removal
Date:   Mon, 27 Mar 2023 17:02:17 -0400
Message-Id: <20230327210217.60948-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327210217.60948-1-mailingradian@gmail.com>
References: <20230327210217.60948-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..20c035af373a 100644
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
2.40.0

