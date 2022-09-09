Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956DC5B40C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIIUgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIIUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:36:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43084B4E87;
        Fri,  9 Sep 2022 13:36:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e5so2724624pfl.2;
        Fri, 09 Sep 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=snOvLccxPnDxfhbHH4+Bi4URb7HhD6z7h8GUX4GdKTA=;
        b=HUY1NpdXKTUuJM4Vj7EXU5C0IV+5K20CkSDLiru/+yucQywnMU4lu8Epm0TEjxGUmh
         FuKoTVsRvc7w2gO5KxU7hm+KKH8IbCO++6q9mz0qmRIUp7R9HcwLT7nWHGdfdqxNgD7w
         htKtxjkWS2q4yQ8qH4BR6M7rv59bIrqJFjZ8eGisUCwBXXLsYB8eyi+3prttSEF4znWo
         JhFhVlESRKg9yddZOej9oCSuORbugC5vxV1hCeOD23ApFd3Gy2am6QW7q+ozQhmYO0xy
         kSzqpZI/6AkdKTSoq5JWI8mtAXYNdFX/bk1gCBccdQxgaO3xDKeGU/zqAAbmEuxmbN3c
         c29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=snOvLccxPnDxfhbHH4+Bi4URb7HhD6z7h8GUX4GdKTA=;
        b=gzG6q98kGHjMgCQfakjQ8rvYYe8/J9UVLLSeGS4ZQYE0tlg6Ks6nKRCC0erEYlfreM
         PLUNDGNsTbG8OfQmijn/Nyo6/9qRe/ymFAI350pHDwdp+EH/O0/7lbX00kP8eLL78sR3
         SQ0SUjinUOmrh+YsN9+ye6gez0nYUncPTaMEbXvqjRzXTPZmeONsb9GTqAIykl4oV9UF
         XZXwc49BcFm/ljf5Jr4/KG4LlV0P+PttODnIMuuPpf3k3U5UmepScJzqM2QJCl1+bFN5
         jHLSi8KUifhiZ9YnPJijHwdH4bpTlSo4l2Uim+ceBXXHyg4/ZpMSuQ7esPz4NJh9PCAQ
         rwpA==
X-Gm-Message-State: ACgBeo0b1VhetVfJDHsQOIvaaHXTLl4yfoRSFEhEirwYtdTVMvB66214
        q/zVarU4faGSi5fRhVwvm1w=
X-Google-Smtp-Source: AA6agR7PLQK/YFcjhqAsDqXHyHHu/FUmquz65Cp/kj0/77tFdMdOYzK/zfwJewGVjzuZc8mtive7qQ==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr16503124pfb.49.1662755787647;
        Fri, 09 Sep 2022 13:36:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b005361f6a0573sm162945pfl.44.2022.09.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 13:36:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ec092d7-6a51-04cc-bd70-12462524fda0@roeck-us.net>
Date:   Fri, 9 Sep 2022 13:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 12:19, Serge Semin wrote:
> Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
> a regression on our platform. It turned out that the nvme_get_log() method
> invocation caused the nvme_hwmon_data structure instance corruption. In
> particular the nvme_hwmon_data.ctrl pointer was overwritten either with
> zeros or with garbage. After some researches we discovered that the
> problem happened even before the actual NVME DMA execution, but during the
> buffer mapping. Since our platform was DMA-noncoherent the mapping implied
> the cache-lines invalidations or write-backs depending on the
> DMA-direction parameter. In case of the NVME SMART log getting the DMA
> was performed from-device-to-memory, thus the cache-invalidation was
> activated during the buffer mapping. Since the log-buffer wasn't
> cache-line aligned the cache-invalidation caused the neighbour data
> discard. The neighbouring data turned to be the data surrounding the
> buffer in the framework of the nvme_hwmon_data structure.
> 
> In order to fix that we need to make sure that the whole log-buffer is
> defined within the cache-line-aligned memory region so the
> cache-invalidation procedure wouldn't involve the adjacent data. By doing
> so we not only get rid from the denoted problem but also fulfill the
> requirement explicitly described in [1].
> 
> After a deeper researches we found out that the denoted commit wasn't a
> root cause of the problem. It just revealed the invalidity by activating
> the DMA-based NVME SMART log getting performed in the framework of the
> NVME hwmon driver. The problem was here since the initial commit of the
> driver.
> 
> [1] Documentation/core-api/dma-api.rst
> 
> Fixes: 400b6a7b13a3 ("nvme: Add hardware monitoring support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Thanks for tracking this down and for the fix.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
> ---
> 
> Folks, I've thoroughly studied the whole NVME subsystem looking for
> similar problems. Turned out there is one more place which may cause the
> same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
> the nvme_sec_submit() method. The rest of the buffers involved in the NVME
> DMA are either allocated by kmalloc (must be cache-line-aligned by design)
> or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
> method implementation).
> ---
>   drivers/nvme/host/hwmon.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d712920..94192ab7a02d 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -10,9 +10,10 @@
>   
>   #include "nvme.h"
>   
> +/* DMA-noncoherent platforms require the cache-aligned buffers */
>   struct nvme_hwmon_data {
> +	struct nvme_smart_log log ____cacheline_aligned;
>   	struct nvme_ctrl *ctrl;
> -	struct nvme_smart_log log;
>   	struct mutex read_lock;
>   };
>   

