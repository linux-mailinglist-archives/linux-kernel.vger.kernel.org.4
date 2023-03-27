Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657636CB053
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC0VDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjC0VDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B96271C;
        Mon, 27 Mar 2023 14:03:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id cf7so12485360ybb.5;
        Mon, 27 Mar 2023 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSzUASJDqmk05kc24FOpZeQYr3X2iF7C+bvKtga/9zY=;
        b=DuVyGK5jAPiKnMlo3gU6hpcJlp8HDMLAP1nJQQjmnCqbJFOW1gNNxBNc0OLl/GN71Q
         evi/fD/5bdtx/GSM/0P1o0pMiEfjk85bs8fcCmsOeM6fbxCkKCQysa6Uy1HX8sejUyoN
         so/PsIzzOIOTQOr+mJ+SglXLD40pJ3h5Qy4ms/eZnuorA8hHlTeTl0g+69ujzt0BgpX+
         7vXFCuoXpj/MCa1Qh1KZSvW1XLrEy7ujo82qdjfirrpSZGlV6TEmLbseGogGAeW4atYK
         7qIFAP7tkD8m76YoVEobhtU5PDbTNRHiwiCRCxvXTNyNtbzBOtEDq10vj5bIIU2L6Pjo
         1ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSzUASJDqmk05kc24FOpZeQYr3X2iF7C+bvKtga/9zY=;
        b=h7RlxtIQCrRDtwtbAr8UyxvLE78LUNva1YU4KOKfTFjywFyp2hOu0V82ZOZBQ9VvHI
         0M6mTAsyKtE7BmkY6wpxfpkO/Curl7ykpPzYTFj7Itqs0mvqgsaZ9Q3/wcJvVUWVuiPm
         7ddCef+vz7XfszeTzzg6TpLTr+KKx1sKwvXrLzesBRhha+RXMizp2hULm/MMhUmTgoZP
         BZE0TXRNqGgIWHfGaWFbRe80p/TyHLCyFQb12jdQWsSOZo0pvMVyT/Ng100d/pGWGWEu
         X6bdR42EqxWfOY2tRgJb3O4iiQNMBSKMVyLv/G3nvElj2SLCj+YCn0xXoZYk+iBahtPC
         cKJA==
X-Gm-Message-State: AAQBX9esc/JCMfmZI9TZK7w5N1Lba9MKCCyObgXu3Atd1y56EADN0iEo
        BL23F1+/SFYo/lG9PfVaqPc=
X-Google-Smtp-Source: AKy350b6hIWzNa11aqhiXM04lQXVpTScEhhafaJJz9+qWPhPN8ftANifZPQ7/9ZhMvQBPXP3vzOTRA==
X-Received: by 2002:a25:24a:0:b0:b48:e4e:eddd with SMTP id 71-20020a25024a000000b00b480e4eedddmr13151269ybc.25.1679950986253;
        Mon, 27 Mar 2023 14:03:06 -0700 (PDT)
Received: from localhost ([2607:fea8:529d:4d00::9f37])
        by smtp.gmail.com with ESMTPSA id p8-20020a254208000000b00b7767ca7476sm2511400yba.19.2023.03.27.14.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:03:05 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/2] misc: fastrpc: reject new invocations during device removal
Date:   Mon, 27 Mar 2023 17:02:18 -0400
Message-Id: <20230327210217.60948-3-mailingradian@gmail.com>
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

The channel's rpmsg object allows new invocations to be made. After old
invocations are already interrupted, the driver shouldn't try to invoke
anymore. Invalidating the rpmsg at the end of the driver removal
function makes it easy to cause a race condition in userspace. Even
closing a file descriptor before the driver finishes its cleanup can
cause an invocation via fastrpc_release_current_dsp_process() and
subsequent timeout.

Invalidate the channel before the invocations are interrupted to make
sure that no invocations can be created to hang after the device closes.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
Demonstration of the bug as performed on a Google Pixel 3a with
devicetree patches:

	#include <fcntl.h>
	#include <misc/fastrpc.h>
	#include <stdint.h>
	#include <stdio.h>
	#include <string.h>
	#include <sys/ioctl.h>
	#include <unistd.h>

	static int remotectl_open(int fd,
				  const char *name,
				  uint32_t *handle)
	{
		struct fastrpc_invoke invoke;
		struct fastrpc_invoke_args args[4];
		struct {
			uint32_t namelen;
			uint32_t errlen;
		} in;
		struct {
			uint32_t handle;
			uint32_t err;
		} out;
		char errstr[256];
		int ret;

		// Remoteproc expects to receive a null terminator
		in.namelen = strlen(name) + 1;
		in.errlen = 256;

		args[0].ptr = (__u64) &in;
		args[0].length = sizeof(in);
		args[0].fd = -1;

		args[1].ptr = (__u64) name;
		args[1].length = in.namelen;
		args[1].fd = -1;

		args[2].ptr = (__u64) &out;
		args[2].length = sizeof(out);
		args[2].fd = -1;

		args[3].ptr = (__u64) errstr;
		args[3].length = 256;
		args[3].fd = -1;

		invoke.handle = 0;
		invoke.sc = 0x00020200;
		invoke.args = (__u64) args;

		ret = ioctl(fd, FASTRPC_IOCTL_INVOKE, (__u64) &invoke);

		if (!ret)
			*handle = out.handle;

		return ret;
	}

	int main()
	{
		struct fastrpc_init_create_static create;
		uint32_t handle;
		int fd, ret;

		fd = open("/dev/fastrpc-adsp", O_RDWR);
		if (fd == -1) {
			perror("Could not open /dev/fastrpc-adsp");
			return 1;
		}

		ret = ioctl(fd, FASTRPC_IOCTL_INIT_ATTACH_SNS, NULL);
		if (ret) {
			perror("Could not attach to sensorspd");
			goto close_dev;
		}

		/*
		 * Under normal circumstances, the remote processor
		 * would request a file from a different client, and
		 * quickly find out that there is no such file. When
		 * this other client is not running, this procedure call
		 * conveniently waits for the ADSP to crash.
		 */
		ret = remotectl_open(fd, "a", &handle);
		if (ret == -1)
			perror("Could not open CHRE interface");

	close_dev:
		// This takes 10 seconds
		printf("Closing file descriptor\n");
		close(fd);
		printf("Closed file descriptor\n");

		return 0;
	}
---
 drivers/misc/fastrpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 20c035af373a..f4116ce7805a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2351,7 +2351,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2370,7 +2372,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
-- 
2.40.0

