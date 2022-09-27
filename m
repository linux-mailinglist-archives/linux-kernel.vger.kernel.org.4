Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B25ECB77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiI0RmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiI0RlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:41:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6BCE20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f193so10078349pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wDmTvGv4ZnvDqV/mCRqm8p4rxm0Bhm32Y+RrK0L0+VQ=;
        b=skqIHHF+YE/+jFT5L9Tf8nNPPtVbhM9q/DAlWu3l5PM87eyBomiPBzZdyrPhzSOviN
         2Er4O4WvTqhBS/ihxOgPTb3cLuI/uX91TfTQY+vdzu8Yrl4oXnKdgZaT3334BnU96t/0
         AYhvWUEptv8WIdSmORT2CObdmrBJg3IQzqN36i5W9ui2Gqn+Vq4HawhKoTAcuhUOwJJA
         9IYl00QdDQlIRcaHcPIwsb5o5zhFcCnGmIXH3vxf5nZSRLG0snrNkPGT3RzX2YKSo2is
         jXH9ttDg7AsciVoJp6XoP2cL/KMDKAc43aQHzAsVq+fbNUWlNJQlZJXGmF3tRMUEwsn7
         aGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wDmTvGv4ZnvDqV/mCRqm8p4rxm0Bhm32Y+RrK0L0+VQ=;
        b=e6wa3Y5nwIsiTlrSgATyIVspuqU361Ib76Tpuer6T0sbxyN4njyUoyS1Zm/Xu7g9t3
         4iv9+K4gGnDzc6F2nmA3CUN0Mq4BDZ7qZ8ZkLOkJ1uzzWfqStzoLKAzExBi7TR8fajpU
         /mGyxt3RrFoLOVV/cXw5xEI6jeBgw2RC74xS5wpjmjH813hlKVY0qoEDPQt/PFAD7t7M
         jMRAOSOE0KkNw6x5gLFMPIZU901vJEetrH9K3vb/WlCQcYI2hinzSzeGYNfZcM5OzeVA
         adak6q0cLPEWAMR9nk6EBAhZuFTKucI2s53Gr3h1jVllqZAiDalQcMZY33E9YzZbRszf
         aNkA==
X-Gm-Message-State: ACrzQf2xCABcVlvDC0MDMdpBSaUMvAsjfYVCSQ1yK2O1c5bks39JGovV
        Fv3UfVDbgp7ZwE7OlAtJgk2qHQ==
X-Google-Smtp-Source: AMsMyM7NYwu05epX7pt0by+sremox+/P/kFLI2ZxmKtDveMgDBPP3pT8c23ZpZJSiOiP6NmVB83nyg==
X-Received: by 2002:a63:6b83:0:b0:43c:17e8:c2a5 with SMTP id g125-20020a636b83000000b0043c17e8c2a5mr24383683pgc.457.1664300358553;
        Tue, 27 Sep 2022 10:39:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b0016bf5557690sm1885199plg.4.2022.09.27.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:39:18 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:39:14 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] android: binder: Remove comments about tsk fields
Message-ID: <YzM1QkafOVNuNLkp@google.com>
References: <20220928004610.58756-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928004610.58756-1-zhangqiao22@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:46:10AM +0800, Zhang Qiao wrote:
> Commit a0c2baaf81bd ("android: binder: Don't get mm
> from task") remove the binder_alloc struct's tsk, but
> didn't remove the header commment about '@tsk'.
> So this patch remove it.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  drivers/android/binder_alloc.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 1e4fd37af5e0..fe0738fb9c8c 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -76,8 +76,6 @@ struct binder_lru_page {
>   * struct binder_alloc - per-binder proc state for binder allocator
>   * @vma:                vm_area_struct passed to mmap_handler
>   *                      (invarient after mmap)
> - * @tsk:                tid for task that called init for this proc
> - *                      (invariant after init)
>   * @vma_vm_mm:          copy of vma->vm_mm (invarient after mmap)
>   * @buffer:             base of per-proc address space mapped via mmap
>   * @buffers:            list of all buffers for this proc
> -- 
> 2.17.1
> 

Thanks but this has already been addressed here:
https://git.kernel.org/next/linux-next/c/7b0dbd940765
--
Carlos Llamas
