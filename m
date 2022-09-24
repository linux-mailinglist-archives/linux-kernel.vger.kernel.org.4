Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF55E86F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiIXBMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIXBMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:12:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC00137921
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:12:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so7409951pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=klQs6tfhtrxGmSxDlE88a9pPaIjzAvztOQCzE3AsayE=;
        b=slZD1aGtjzVt63f1HI7bGOluY10Of0T+XT6GY2s9ohgxrqkT7h7nj3jKbPMzh2PDHT
         UAbVevspZYb2NuT5lnLA7qtx4oVqS92pJyjNGuScxLpW6/DhJya85H0wrFal+FmRL3PA
         PEQX82MgVKt7NW1VB2DSQoI/rLQJxGs7GfqtstlGceWXn3PbtfGiVAv+isv37l3T4y4Q
         s+gCjW5Yw05/9OKD4+1wOTgqHU2OBoAOa+X640gZ/nKpHKqmnD5DZGgRXDvvtXk740+X
         ksvpY0PUQR6/7DVpJ3Vwm0gme3bG225CuFhh8eYleXuRf8BTNSdy7Iwxa2RsM4ZlEpZK
         Xfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=klQs6tfhtrxGmSxDlE88a9pPaIjzAvztOQCzE3AsayE=;
        b=4U7wrqYbAFqFNNK8tuCVs4qTqmCW3iI+7WBbrZ788xUDZyPQaIPLK6BSYu2o7dP0UH
         lHPZDvMF3usORyvpLJE27PEPBFVQGfvn+eG+scJditH8Qz9MnqvBjFYLp1CY53R5tmJT
         5kqlVnRSpsXzPQQB69lDqgv0ZSpfp62CRBa2vIBiT3a9ZNV/HU+0GLNV+CYW7gGZWnH9
         lTQ6txsE9BfQmuuaoUf63houWjliO2vQtgZA9peuLSeRgfTwlJqxRAIrwW6JH3KuTt+i
         SC2IU8iMBIIXxRfWAxDP69hTQIID5rIekKJ5XTsRQ0EbVenyT7tU8BaLZOeMd3SPn1oH
         x39w==
X-Gm-Message-State: ACrzQf3HPJMXLtuLtBOkrS1+goip7n2JyPUwNA51AqBdUJfSHsdfiPSc
        njLI2AYGZsCF+AkdyL35nSTrag==
X-Google-Smtp-Source: AMsMyM4bHxUAXQWCFsOc+D6JYHNqkUF/vvw1/bpKMovRGnFt2RMV+DqsFQFMWNcFHIcc5f634xgc2w==
X-Received: by 2002:a17:903:1110:b0:178:9f67:b524 with SMTP id n16-20020a170903111000b001789f67b524mr11348631plh.50.1663981947751;
        Fri, 23 Sep 2022 18:12:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b0016c57657977sm6601304plb.41.2022.09.23.18.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 18:12:27 -0700 (PDT)
Message-ID: <88fb97a1-23a1-9f75-a9fa-54b233e0a39e@kernel.dk>
Date:   Fri, 23 Sep 2022 19:12:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V6 0/7] ublk_drv: add USER_RECOVERY support
Content-Language: en-US
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220923153919.44078-1-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 9:39 AM, ZiyangZhang wrote:
> ublk_drv is a driver simply passes all blk-mq rqs to userspace
> target(such as ublksrv[1]). For each ublk queue, there is one
> ubq_daemon(pthread). All ubq_daemons share the same process
> which opens /dev/ublkcX. The ubq_daemon code infinitely loops on
> io_uring_enter() to send/receive io_uring cmds which pass
> information of blk-mq rqs.
> 
> Since the real IO handler(the process/thread opening /dev/ublkcX) is
> in userspace, it could crash if:
> (1) the user kills -9 it because of IO hang on backend, system
>     reboot, etc...
> (2) the process/thread catches a exception(segfault, divisor error,
> oom...) Therefore, the kernel driver has to deal with a dying
> ubq_daemon or the process.
> 
> Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
> must abort the dying ubq, stop the device and delete everything.
> This is not a good choice in practice because users do not expect
> aborted requests, I/O errors and a deleted device. They may want
> a recovery machenism so that no requests are aborted and no I/O
> error occurs. Anyway, users just want everything works as usual.
> 
> This patchset implements USER_RECOVERY support. If the process
> or any ubq_daemon(pthread) crashes(exits accidentally), we allow
> user to provide new process and ubq_daemons.
> 
> Note: The responsibility of recovery belongs to the user who opens
> /dev/ublkcX. After a crash, the kernel driver only switch the
> device's state to be ready for recovery(START_USER_RECOVERY) or
> termination(STOP_DEV). The state is defined as UBLK_S_DEV_QUIESCED.
> This patchset does not provide how to detect such a crash in userspace.
> The user has may ways to do so. For example, user may:
> (1) send GET_DEV_INFO on specific dev_id and check if its state is
>     UBLK_S_DEV_QUIESCED.
> (2) 'ps' on ublksrv_pid.
> 
> Recovery feature is quite useful for real products. In detail,
> we support this scenario:
> (1) The /dev/ublkc0 is opened by process 0.
> (2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
>     rqs are handled by process 0.
> (3) Process 0 suddenly crashes(e.g. segfault);
> (4) Fio is still running and submit IOs(but these IOs cannot
>     be dispatched now)
> (5) User starts process 1 and attach it to /dev/ublkc0
> (6) All rqs are handled by process 1 now and IOs can be
>     completed now.
> 
> Note: The backend must tolerate double-write because we re-issue
> a rq sent to the old process 0 before.
> 
> We provide a sample script here to simulate the above steps:
> 
> ***************************script***************************
> LOOPS=10
> 
> __ublk_get_pid() {
> 	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
> 	echo $pid
> }
> 
> ublk_recover_kill()
> {
> 	for CNT in `seq $LOOPS`; do
> 		dmesg -C
>                 pid=`__ublk_get_pid`
>                 echo -e "*** kill $pid now ***"
> 		kill -9 $pid
> 		sleep 6
>                 echo -e "*** recover now ***"
>                 ./ublk recover -n 0
> 		sleep 6
> 	done
> }
> 
> ublk_test()
> {
>         echo -e "*** add ublk device ***"
>         ./ublk add -t null -d 4 -i 1
>         sleep 2
>         echo -e "*** start fio ***"
>         fio --bs=4k \
>             --filename=/dev/ublkb0 \
>             --runtime=140s \
>             --rw=read &
>         sleep 4
>         ublk_recover_kill
>         wait
>         echo -e "*** delete ublk device ***"
>         ./ublk del -n 0
> }
> 
> for CNT in `seq 4`; do
>         modprobe -rv ublk_drv
>         modprobe ublk_drv
>         echo -e "************ round $CNT ************"
>         ublk_test
>         sleep 5
> done
> ***************************script***************************
> 
> You may run it with our modified ublksrv[2] which supports
> recovery feature. No I/O error occurs and you can verify it
> by typing
>     $ perf-tools/bin/tpoint block:block_rq_error
> 
> The basic idea of USER_RECOVERY is quite straightfoward:
> (1) quiesce ublk queues and requeue/abort rqs.
> (2) release/free everything belongs to the dying process.
>     Note: Since ublk_drv does save information about user process,
>     this work is important because we don't expect any resource
>     lekage. Particularly, ioucmds from the dying ubq_daemons
>     need to be completed(freed).
> (3) allow new ubq_daemons issue FETCH_REQ.
>     Note: ublk_ch_uring_cmd() checks some states and flags. We
>     have to set them to a correct value.
> 
> Here is steps to reocver:
> (0) requests dispatched after the corresponding ubq_daemon is dying 
>     are requeued.
> (1) monitor_work finds one dying ubq_daemon, and it should
>     schedule quiesce_work and requeue/abort requests issued to
>     userspace before the ubq_daemon is dying.
> (2) quiesce_work must (a)quiesce request queue to ban any incoming
>     ublk_queue_rq(), (b)wait unitl all rqs are IDLE, (c)complete old
> 	  ioucmds. Then the ublk device is ready for recovery or stop.
> (3) The user sends START_USER_RECOVERY ctrl-cmd to /dev/ublk-control
>     with a dev_id X (such as 3 for /dev/ublkc3).
> (4) Then ublk_drv should perpare for a new process to attach /dev/ublkcX.
>     All ublk_io structures are cleared and ubq_daemons are reset.
> (5) Then, user should start a new process and ubq_daemons(pthreads) and
>     send FETCH_REQ by io_uring_enter() to make all ubqs be ready. The
>     user must correctly setup queues, flags and so on(how to persist
>     user's information is not related to this patchset).
> (6) The user sends END_USER_RECOVERY ctrl-cmd to /dev/ublk-control with a
>     dev_id X.
> (7) After receiving END_USER_RECOVERY, ublk_drv waits for all ubq_daemons
>     getting ready. Then it unquiesces request queue and new rqs are
>     allowed.
> 
> You should use ublksrv[2] and tests[3] provided by us. We add 3 additional
> tests to verify that recovery feature works. Our code will be PR-ed to
> Ming's repo soon.

I'm going to apply 1-6 for 6.1, applying the doc patch is difficult as
it only went into 6.0 past forking off the 6.1 block branch. Would you
mind resending the 7/7 patch once the merge window opens and I've pushed
the previous bits? I may forget otherwise...

-- 
Jens Axboe


