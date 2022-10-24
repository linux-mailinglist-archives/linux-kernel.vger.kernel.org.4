Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5F60B558
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJXSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiJXSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:20:52 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B928DC28
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:01:59 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3928981pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ1MvqKl8OJpbhgbIibjbk9PHInp1edXysudMf00tqg=;
        b=MMo+8j32ng1bIYdTutm2P57C1qCWMV+0RUaTdwA4BloACG+z8RSw5pU14f4W+1VIuC
         Z3yxeE+PPVb1mmBpM5RhGNDfv4Jhtf9wQ5SmDYxL/ONi+wiLf/lwIDEe5Rtr8gc/F5/+
         9TfPcFyHTGZIA5lLzf17gf8Ip2oERPjYwUA/HQuKuFcfM2xhR3MgdzgTHWTFS6mmcvia
         TWXDhc+pXr80z2gem/ktD2+P0zE5CAXYBuKzZrSsg/JDcrUm1vYVTBHDWqkkNAqm0Jg8
         M/PQarvrsJlOdEwIGC/Sk6LoAqt621TiEkoAT+UylLkCfzpBSIlTnvsikwNRRsjQjPqW
         EWog==
X-Gm-Message-State: ACrzQf0Nny40UtxTeLH7NCawpU8vB8Qev25dcmGeYgQ4icH5SzThHKKV
        qItzCHasU0o4g4KZs+RboYCIPic8tX8=
X-Google-Smtp-Source: AMsMyM4TX/82XqJXbiqPvbCx+bfYEe10I9WGngZiGPkVARxBKebsrl3O/O/2gEaRg7KNHJBnmWuntQ==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr35150825pfh.15.1666630299453;
        Mon, 24 Oct 2022 09:51:39 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b001769cfa5cd4sm2372plk.49.2022.10.24.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:51:38 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:51:36 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/percpu: remove unused pcpu_map_extend_chunks
Message-ID: <Y1bCmEhJZNZbwZxf@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-2-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:28PM +0800, Baoquan He wrote:
> Since commit 40064aeca35c ("percpu: replace area map allocator with
> bitmap"), it is unneeded.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 27697b2429c2..26d8cd2ca323 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -174,9 +174,6 @@ static DEFINE_MUTEX(pcpu_alloc_mutex);	/* chunk create/destroy, [de]pop, map ext
>  
>  struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
>  
> -/* chunks which need their map areas extended, protected by pcpu_lock */
> -static LIST_HEAD(pcpu_map_extend_chunks);
> -
>  /*
>   * The number of empty populated pages, protected by pcpu_lock.
>   * The reserved chunk doesn't contribute to the count.
> -- 
> 2.34.1
> 
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
