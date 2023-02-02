Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6E68884E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjBBUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:37:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B76D046
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:37:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e2so1221314iot.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PND6tJ30xomjHhkOnv/Xe9qzY0K4bBqbejKzGMhGcoo=;
        b=kRzYuM4S7y6/CPR+u2CWWsB4n+wjCWinpqVVMLCNcbPhfJgYqnVjJPAOwPP6A0RGT9
         wWt/wyZWU3XiID4ljBlAVIlnbfR2BBNBWlnPOe7e16lsxEbBcOkd/uRSgpqVQdZSeWM+
         OTgXVzzKMQstuSoGbzKdwm4Rn45Mx8jOMXosiNODDE7yUUTfow5zPCeSlvkgiE3soz1f
         NRdwnlxVWs82I1SlQngLJYjxi9EFKdZmb4aPumHB9CYce/A9XsLld3KnR/lcUS9GTNEM
         jmIrmkd1eqAQhd9pyC6lK5e9x/E7rZi6LLTk/bnnQ1h7cY0WjjK3vhTTi3s5oRszwhSi
         /0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PND6tJ30xomjHhkOnv/Xe9qzY0K4bBqbejKzGMhGcoo=;
        b=xedh5EXzXSjoqvs7xde/cda2jWix4VJC1sdtuxwjNx2f2efrhd5qOFFW4J1Ys8+f3D
         2zxDkj48nGUuw7cf47CFNV1oN0ukTo/OcI9rc0R0U3hTWQx3XSMYYDJlUytNfS80srZq
         +3Ha4jK8ui8PBGu5cVaXdpHncTcFJ8dNEXQSxfrlmjIHzH7zPB5E4oZpfEKRF1QunkX5
         y89ry9RYmsfduOkiqnO3ClHWjk+cLgHB95oK5lkBNnHM3fsTr5IiFFYmPfU6PsWK4+mX
         zceguXooyKJrpVSnJ0uie2SmlduFOB+LFEhyTd45qiBuD/3jvxMRLjVJcHk8nUI/Uaax
         LQtQ==
X-Gm-Message-State: AO0yUKUBqPFRix/U99hKswOvdvKrrL3KYm3Ml0QARM+wUkcOKfQXlfp2
        q297QWd9C41YPGeju5SrYwVY/w==
X-Google-Smtp-Source: AK7set/0RA2hHxJDFBTj3WuC1WAhxwOm4ROSwGb/sx2geOWiytHpkTgxz7rDkDcWOLkIbgUEhVnKzQ==
X-Received: by 2002:a5d:841a:0:b0:707:d0c0:1bd6 with SMTP id i26-20020a5d841a000000b00707d0c01bd6mr4536109ion.1.1675370264324;
        Thu, 02 Feb 2023 12:37:44 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a6bf203000000b00716eb44b97esm189012ioh.27.2023.02.02.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:37:43 -0800 (PST)
Message-ID: <affab34f-2b83-9158-5976-b224a4afce0d@kernel.dk>
Date:   Thu, 2 Feb 2023 13:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
 <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
 <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
 <Y9t6tflIcFPy84S5@xpf.sh.intel.com>
 <fb27661f-59dd-98cd-203a-8fa86dc209d4@kernel.dk>
In-Reply-To: <fb27661f-59dd-98cd-203a-8fa86dc209d4@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 12:44?PM, Jens Axboe wrote:
> On 2/2/23 1:56?AM, Pengfei Xu wrote:
>> Hi Pavel Begunkov,
>>
>> On 2023-02-01 at 15:52:47 +0000, Pavel Begunkov wrote:
>>> On 1/28/23 14:49, Pavel Begunkov wrote:
>>>> On 1/28/23 08:44, Pengfei Xu wrote:
>>>>> Hi Pavel Begunkov and kernel expert,
>>>>>
>>>>> Greeting!
>>>>>
>>>>> There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
>>>>> on Sapphire Rapids server.
>>>>
>>>> Thanks for the report, we'll take a look
>>>
>>> Not reproducible for me. Apparently, the repro creates a normal ring
>>> and immediately closes it, then io_ring_exit_work() hangs waiting to
>>> the task to execute task_work.
>>   Ah, I put the reproduced virtual machine in gitlab.
>>   git clone https://gitlab.com/xupengfe/repro_vm_env.git
>>   cd repro_vm_env
>>   tar -xvf repro_vm_env.tar.gz
>>   cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>>      //start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>>   In vm and login with root,  there is no password for root.
>>   After login vm successfully, ./repro   to reproduce this issue.
>>   It could be reproduced in about 6min.
>>
>>   If you already have qemu-system-x86_64, please ignore below info.
>>   If you want to install qemu v7.1.0 version,
>>   git clone https://github.com/qemu/qemu.git
>>   cd qemu
>>   git checkout -f v7.1.0
>>   mkdir build
>>   cd build
>>   yum install -y ninja-build.x86_64
>>   ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
>>   make
>>   make install
>>   Done.
> 
> Are you sure you attached the right kconfig in the initial report? It
> is from 5.18.x.

Looks like a bug in 9p, can you try this?


diff --git a/net/9p/client.c b/net/9p/client.c
index 622ec6a586ee..5756d812d3d4 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/task_work.h>
 #include <net/9p/9p.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
@@ -652,6 +653,24 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return ERR_PTR(err);
 }
 
+static int p9_sigpending(void)
+{
+	int sigpending = 0;
+
+	if (signal_pending(current)) {
+		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
+			clear_notify_signal();
+		if (task_work_pending(current))
+			task_work_run();
+		if (signal_pending(current)) {
+			sigpending = 1;
+			clear_thread_flag(TIF_SIGPENDING);
+		}
+	}
+
+	return sigpending;
+}
+
 /**
  * p9_client_rpc - issue a request and wait for a response
  * @c: client session
@@ -687,12 +706,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	req->tc.zc = false;
 	req->rc.zc = false;
 
-	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else {
-		sigpending = 0;
-	}
+	sigpending = p9_sigpending();
 
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
@@ -789,12 +803,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	req->tc.zc = true;
 	req->rc.zc = true;
 
-	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else {
-		sigpending = 0;
-	}
+	sigpending = p9_sigpending();
 
 	err = c->trans_mod->zc_request(c, req, uidata, uodata,
 				       inlen, olen, in_hdrlen);

-- 
Jens Axboe

