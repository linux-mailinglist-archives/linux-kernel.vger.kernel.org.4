Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C16C2E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:45:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D02F06C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:45:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so57134301edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679391934;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvHJKDHY8iATaKDHrW52pjTQ08nKOuxTNUz703I9tcI=;
        b=QF1em8XfANrrX2hd0qUpb9+biEigvVdSjSiMZ1s4tBHGBwvYHECk1p3p97LYvFK2F9
         CIYIW2mA1NCiIkNkIGqezcyFktlqynC7ybw2T2fUtrcjOioHVNLr5sPyuzD46G+tyY10
         +5hBFbZgzQUblxiRP+PBZihqp4v0GOImKvBPxsRf2iPJuJOPM31IR/GyQGJKY6L2agk1
         bmb6AGFXQAuNhAlxTKoWRvtV8Xd7TcodxOBjpQwVKlHVFl4G63GuyIf5SoE3SMHD5IoF
         JMMvK343iL12tIkMm1KrOXRVFaAdr429SylUvi+J2dCRPxqV5LEw97Jf+18toonQUxDu
         weng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391934;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvHJKDHY8iATaKDHrW52pjTQ08nKOuxTNUz703I9tcI=;
        b=SAlpIkzSn4K68bqpyJCEzPVgEXOfkLktxr3GmUDUXKyFfqbbK6jgqkNSyEgO7BM6yt
         1KX9ON3xV3J8op+3BPVYtiqInlpC7lvp8Q2phux3IrZ/ypoik9D9EGPXq8vcru80v5gy
         2WF147lAjS+iEABJFtyN96MGm58xEySjRcp9V0Q00upv4hrhn15tW8viRWvwzqtiegbN
         aviIZoSXWiip9/aQSyDSi4Lw08Bss2cpwVrPySVGhQoLiVg6afIH+Nw+Fgc1QKUxofmc
         xP6L+eEgzZ+fAoe+SuHcqVbt26oXmWLe5v7FUg4WslXst+EDjgLZEjdq1Z8D7VHiNTgQ
         gTlQ==
X-Gm-Message-State: AO0yUKVnhzWP60HyjVz2g+ee8pfcZ4Bk9J3AoPeqazgj2HVDagT45zUT
        +qX0kCsEPCxZklmN1UBmmon7Kw==
X-Google-Smtp-Source: AK7set+UvWU6OCYe+wROsnxPFIUDBtUafE9x7WbzBRosjBUR7fMgUbvdG6+1FyRd/dRlmhtgpyT0+Q==
X-Received: by 2002:aa7:d38e:0:b0:4a3:43c1:8430 with SMTP id x14-20020aa7d38e000000b004a343c18430mr15479165edq.4.1679391934324;
        Tue, 21 Mar 2023 02:45:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm6002460edf.30.2023.03.21.02.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:45:33 -0700 (PDT)
Message-ID: <5687e3a0-ed1b-be16-f8f6-5c77a8787c50@linaro.org>
Date:   Tue, 21 Mar 2023 09:45:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] misc: fastrpc: reject new invocations during device
 removal
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230130222716.7016-1-mailingradian@gmail.com>
 <20230130222716.7016-3-mailingradian@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230130222716.7016-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 22:27, Richard Acayan wrote:
> The channel's rpmsg object allows new invocations to be made. After old
> invocations are already interrupted, the driver shouldn't try to invoke
> anymore. Invalidating the rpmsg at the end of the driver removal
> function makes it easy to cause a race condition in userspace. Even
> closing a file descriptor before the driver finishes its cleanup can
> cause an invocation via fastrpc_release_current_dsp_process() and
> subsequent timeout.
> 
> Invalidate the channel before the invocations are interrupted to make
> sure that no invocations can be created to hang after the device closes.
> 

------------->cut<-------------
> Demonstration of the bug as performed on a Google Pixel 3a with
> devicetree patches:
> 
> 	#include <fcntl.h>
> 	#include <misc/fastrpc.h>
> 	#include <stdint.h>
> 	#include <stdio.h>
> 	#include <string.h>
> 	#include <sys/ioctl.h>
> 	#include <unistd.h>
> 
> 	static int remotectl_open(int fd,
> 				  const char *name,
> 				  uint32_t *handle)
> 	{
> 		struct fastrpc_invoke invoke;
> 		struct fastrpc_invoke_args args[4];
> 		struct {
> 			uint32_t namelen;
> 			uint32_t errlen;
> 		} in;
> 		struct {
> 			uint32_t handle;
> 			uint32_t err;
> 		} out;
> 		char errstr[256];
> 		int ret;
> 
> 		// Remoteproc expects to receive a null terminator
> 		in.namelen = strlen(name) + 1;
> 		in.errlen = 256;
> 
> 		args[0].ptr = (__u64) &in;
> 		args[0].length = sizeof(in);
> 		args[0].fd = -1;
> 
> 		args[1].ptr = (__u64) name;
> 		args[1].length = in.namelen;
> 		args[1].fd = -1;
> 
> 		args[2].ptr = (__u64) &out;
> 		args[2].length = sizeof(out);
> 		args[2].fd = -1;
> 
> 		args[3].ptr = (__u64) errstr;
> 		args[3].length = 256;
> 		args[3].fd = -1;
> 
> 		invoke.handle = 0;
> 		invoke.sc = 0x00020200;
> 		invoke.args = (__u64) args;
> 
> 		ret = ioctl(fd, FASTRPC_IOCTL_INVOKE, (__u64) &invoke);
> 
> 		if (!ret)
> 			*handle = out.handle;
> 
> 		return ret;
> 	}
> 
> 	int main()
> 	{
> 		struct fastrpc_init_create_static create;
> 		uint32_t handle;
> 		int fd, ret;
> 
> 		fd = open("/dev/fastrpc-adsp", O_RDWR);
> 		if (fd == -1) {
> 			perror("Could not open /dev/fastrpc-adsp");
> 			return 1;
> 		}
> 
> 		ret = ioctl(fd, FASTRPC_IOCTL_INIT_ATTACH_SNS, NULL);
> 		if (ret) {
> 			perror("Could not attach to sensorspd");
> 			goto close_dev;
> 		}
> 
> 		/*
> 		 * Under normal circumstances, the remote processor
> 		 * would request a file from a different client, and
> 		 * quickly find out that there is no such file. When
> 		 * this other client is not running, this procedure call
> 		 * conveniently waits for the ADSP to crash.
> 		 */
> 		ret = remotectl_open(fd, "a", &handle);
> 		if (ret == -1)
> 			perror("Could not open CHRE interface");
> 
> 	close_dev:
> 		// This takes 10 seconds
> 		printf("Closing file descriptor\n");
> 		close(fd);
> 		printf("Closed file descriptor\n");
> 
> 		return 0;
> 	}
> 
------------->cut<-------------

move this after --- in commit log so that this is not part of commit log.

> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>   drivers/misc/fastrpc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 2334a4fd5869..c8a36b9cf4fe 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2351,7 +2351,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	struct fastrpc_user *user;
>   	unsigned long flags;
>   
> +	// No invocations past this point
use /* */ style commenting, as its preferred one.

Once these are fixed


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   	spin_lock_irqsave(&cctx->lock, flags);
> +	cctx->rpdev = NULL;
>   	list_for_each_entry(user, &cctx->users, user)
>   		fastrpc_notify_users(user);
>   	spin_unlock_irqrestore(&cctx->lock, flags);
> @@ -2370,7 +2372,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   
>   	of_platform_depopulate(&rpdev->dev);
>   
> -	cctx->rpdev = NULL;
>   	fastrpc_channel_ctx_put(cctx);
>   }
>   
