Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6911D701827
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEMQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEMQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:15:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D451736
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:15:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaec6f189cso76048985ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683994512; x=1686586512;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIARmc/3jMT7VMszHPbPt+ELYJo3JIIVzFYjHzZqyr0=;
        b=TDt3Qs033CyzG8GpZk6Tc3alYkd9YpQe+b5zT9FcUxq7d7V8FgUoTK4TwZfgpXJH27
         MDTsq9dXPSPVl4DS0PqXPOSKsmcAzaRSkT87VFoenJSQ2jI9cDTrpFBezl1Y9XAcCJlY
         MSKBm+7tFfyO0aKG8oieYaUJXeleKmeEJ9h4hdUTZe7EBpXlhOJ/jAnSDyilU5PG30CU
         BOK6/0++LHDZi5R2m8HETUk6zKxm5fGOYdtGPTztMAlZGjTgiv9ZnzIJLSvHMOJlaKX6
         gg4VXpLgO8bYhp/QbRA8WAr66g/fUjYh0DkR60UPqBMyWRLOspzxbgS0QdhDrV1VFP9f
         mUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683994512; x=1686586512;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIARmc/3jMT7VMszHPbPt+ELYJo3JIIVzFYjHzZqyr0=;
        b=NgUNHuSFpWHgPhYu9DLt1Lrw2AcBF+DEaOF4fedmv6VEo4N3GSkXQNX3qSPG6zx4gm
         amc4SaoupqZcCysntiTRytDJ+d1ZksYrzSXDBsJ5ihU1f6vXoxK9bLwmCeuAn4xJsKAN
         c3ZYITALFnI57pyxfXsdnoI2bTe02BKU3GdFpODFYn9M/UQyJNuvkdDYTiSll8WTgi6E
         y/fp+bN8zUBJxNTIIEoGiojt5P5X8ggdrIw8mghkWzQb4E/nKKGsiObVPZUGPf50zwlL
         5SzMz9ffdz5Y+KBMO4Q2FG2HIQNZ9FQzt66EPp6GKgtX3SHQj7nhfUZywK3rCOkSPxfF
         mUvA==
X-Gm-Message-State: AC+VfDzWSVgbiZBr4KtkSiCZWJAk0GGmToa9iKw32WJIzWAxB9PCjVcw
        Gr+dU0SPyV+B8OZ44ID2NtA4szdpKy8=
X-Google-Smtp-Source: ACHHUZ5RRW0MyrtGqW9Nl8ZfKssw4taQ4qQ2UI6PXnONSjbEuq+j3+CYMIkore48gBQn2ncnLgSwUQ==
X-Received: by 2002:a17:903:264b:b0:1ad:dd1a:6415 with SMTP id je11-20020a170903264b00b001addd1a6415mr6264714plb.11.1683994511936;
        Sat, 13 May 2023 09:15:11 -0700 (PDT)
Received: from [10.12.176.11] ([143.92.127.236])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001a687c505e6sm10058905plc.232.2023.05.13.09.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 09:15:11 -0700 (PDT)
Message-ID: <2e4eb5c2-5fa5-a3c3-8933-c4fa5ae440e0@gmail.com>
Date:   Sun, 14 May 2023 00:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme: donot try to resubmit a canceled IO
From:   brookxu <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230511102003.398070-1-chunguang.xu@shopee.com>
In-Reply-To: <20230511102003.398070-1-chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

Sorry to make noise, please ignore this patch.

Thanks.

在 2023/5/11 18:20, Chunguang Xu 写道:
> From: "chunguang.xu" <chunguang.xu@shopee.com>
>
> Now if NVMe over rdma and NVMe over TCP module detected
> controller is INACTIVE on the IO timeout path, it will
> try to call nvmf_complete_timed_out_request() to
> terminated this IO. But nvme_complete_rq() will continue
> to retry this IO, as the request_queue is quiescing at
> this time, if the target cannot connected or the host
> actively executes disconnect, it will cause this IO hang
> in the hctx dispatch queue and cannot be processed,
> resulting in hung task, the calltrace as followed:
>
> [ 1575.570245] INFO: task kworker/u129:6:758 blocked for more than 966 seconds.
> [ 1575.577829]       Tainted: G           OE     5.4.0-77-shopee-generic #86+5
> [ 1575.585323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1575.593670] kworker/u129:6  D    0   758      2 0x80004000
> [ 1575.593681] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [ 1575.593683] Call Trace:
> [ 1575.593689]  __schedule+0x2ee/0x750
> [ 1575.593691]  schedule+0x42/0xb0
> [ 1575.593693]  io_schedule+0x16/0x40
> [ 1575.593696]  do_read_cache_page+0x438/0x840
> [ 1575.593698]  ? __switch_to_asm+0x40/0x70
> [ 1575.593700]  ? file_fdatawait_range+0x30/0x30
> [ 1575.593702]  read_cache_page+0x12/0x20
> [ 1575.593704]  read_dev_sector+0x27/0xd0
> [ 1575.593705]  read_lba+0xbd/0x220
> [ 1575.593707]  ? kmem_cache_alloc_trace+0x1b0/0x240
> [ 1575.593708]  efi_partition+0x1e0/0x700
> [ 1575.593710]  ? vsnprintf+0x39e/0x4e0
> [ 1575.593712]  ? snprintf+0x49/0x60
> [ 1575.593714]  check_partition+0x154/0x250
> [ 1575.593715]  rescan_partitions+0xae/0x280
> [ 1575.593718]  bdev_disk_changed+0x5f/0x70
> [ 1575.593719]  __blkdev_get+0x3e3/0x550
> [ 1575.593720]  blkdev_get+0x3d/0x150
> [ 1575.593722]  __device_add_disk+0x329/0x480
> [ 1575.593723]  device_add_disk+0x13/0x20
> [ 1575.593727]  nvme_mpath_set_live+0x125/0x130 [nvme_core]
> [ 1575.593731]  nvme_mpath_add_disk+0x11e/0x130 [nvme_core]
> [ 1575.593734]  nvme_validate_ns+0x6a8/0x9d0 [nvme_core]
> [ 1575.593736]  ? __switch_to_asm+0x40/0x70
> [ 1575.593739]  nvme_scan_work+0x1e0/0x350 [nvme_core]
> [ 1575.593743]  process_one_work+0x1eb/0x3b0
> [ 1575.593745]  worker_thread+0x4d/0x400
> [ 1575.593747]  kthread+0x104/0x140
> [ 1575.593748]  ? process_one_work+0x3b0/0x3b0
> [ 1575.593750]  ? kthread_park+0x90/0x90
> [ 1575.593751]  ret_from_fork+0x1f/0x40
>
> This issue seems not fixed on lastes kernel, try to fix it here.
>
> Signed-off-by: chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/core.c    | 3 +++
>   drivers/nvme/host/fabrics.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ccb6eb1282f8..bf9273081595 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -349,6 +349,9 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   	if (likely(nvme_req(req)->status == 0))
>   		return COMPLETE;
>   
> +	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +		return COMPLETE;
> +
>   	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>   		return AUTHENTICATE;
>   
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f7..40a5d6659af0 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -199,6 +199,7 @@ static inline void nvmf_complete_timed_out_request(struct request *rq)
>   {
>   	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +		nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
>   		blk_mq_complete_request(rq);
>   	}
>   }
