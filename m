Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A4605F24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiJTLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:43:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4686A52A;
        Thu, 20 Oct 2022 04:43:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2827390pjl.0;
        Thu, 20 Oct 2022 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHyL+iSo35ah0e/V8okK2n5oGkX8sOLEw6ihIICz6Vk=;
        b=CaxvdnB3D34/mdfSTiomzd6dmlCvR1jIRM2sEYc77uhFp3yfqOsUi/+znPLDKURq+D
         N8TnBDQ53BfqpOCym+Ed/KoCzh/SJHYXIyM3d+D32y5N+kgMbJ0U11WIRe8147poGaNm
         ASWFeNQeTXz/O9tZ3ruLsNTXa5tkD6us8+CguOJXzJamJozDp1yUB1NGAosP1D7Hvb5i
         GcIJ/8ZLrErCJF+PaNDX6bmonXSFL1HQZlkq2AuVh7jki1WRyLhwPWTsx0zwpf8pMtjL
         f/U0tMgiyCDDdVgDIy1nKmyD93BzzlHVlbgEnDuiNtnRu5YBOEqIzd1FlS8M47CrACvd
         qEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHyL+iSo35ah0e/V8okK2n5oGkX8sOLEw6ihIICz6Vk=;
        b=0fYrFYhu1vblpLO5ejLPf1yFtiOOAxT9Ho4O+p3FDn8HTWS+KM1ex88L+vwwEsTO5w
         7Co9wOJhn1v/Sm03/s9zM4RovO/KST1wnRGkCM3mEN7mk3EHJyETLzjHT/eM/dOJP9KH
         PyFhw1tFiBxTwR6YbJPa20NDYqyksL+jzi4HKlBMcH1eq/Cycte+Jn/GnsB7W9SoL2e3
         purIe+WNzFTpQKB78Wh/K9tYOC1nkWx0AcFqZTVksF9zQZhnYnXnpzPJfaOIfjZK5v4N
         MT88449v3yPDI3FWV3ROHW6epMIv4UQAKas/vJBGYcA/hG5ipBeZRr1NE9IOJ7+/cbjp
         FU/g==
X-Gm-Message-State: ACrzQf2G/ENpm7CKI3w6rV7/wKX+T5wCTEnqaxPUF8CJyhCXGZm60SZy
        eAbEIo5vx/QKQ3CNUC6ZATg=
X-Google-Smtp-Source: AMsMyM6U0+WqwhwwNRAzULYRnlQT5X0Wjjw8Jf46FlP/uwvT28jGG0i30ZT7HgxIxUtigv77DfWdzQ==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr49904954pjs.222.1666266219347;
        Thu, 20 Oct 2022 04:43:39 -0700 (PDT)
Received: from [10.114.96.15] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b0016dc6279ab7sm1394637plk.149.2022.10.20.04.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:43:38 -0700 (PDT)
Message-ID: <9906b1bf-c938-e918-62bc-0c7118e954a9@gmail.com>
Date:   Thu, 20 Oct 2022 19:43:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
From:   Yuwei Guan <ssawgyw@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
References: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
In-Reply-To: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 2022/10/18 11:01, Yuwei Guan wrote:
> it defined in d0edc2473be9d, but there's nowhere to use it,
> so remove it.
>
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>   block/bfq-iosched.h | 4 ----
>   1 file changed, 4 deletions(-)

Can you help to check this patch again?

Thanks

> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 64ee618064ba..71f721670ab6 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -369,12 +369,8 @@ struct bfq_queue {
>   	unsigned long split_time; /* time of last split */
>   
>   	unsigned long first_IO_time; /* time of first I/O for this queue */
> -
>   	unsigned long creation_time; /* when this queue is created */
>   
> -	/* max service rate measured so far */
> -	u32 max_service_rate;
> -
>   	/*
>   	 * Pointer to the waker queue for this queue, i.e., to the
>   	 * queue Q such that this queue happens to get new I/O right
