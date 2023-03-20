Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8276C1117
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCTLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCTLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:45:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7D20050;
        Mon, 20 Mar 2023 04:45:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so16171365pjv.5;
        Mon, 20 Mar 2023 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i+gqxdM/y5BZO9g7s9aqMmU36osNc941oAXaTE2IFc=;
        b=FtT0atWMoBZ2Zmxoi0UplcYMfcOPvZB8ve7hACQTBebHSoYhsrMIvwaVUBIIqaquu3
         SEOR1+O6+bUwCTuAHDhRFj0Uj18Go+qY/yTtGxup7qyRq/1Liwa7WLU5Z3f/+Ur9+zpd
         ceKEULxJfYgYbQTaRTleVtHifUf7Glw7vSwINHaTKEKi5ZTQvD21lPZ9Uh6n7RGqja7j
         qoL4wrhlaK15hpZAR+2anK22lfZRTgxjjVFw0/soyys9WGEeIx8IGkWWztRWdgQArSU0
         FrY07hcbDP+OKhiXgPbdftrnA3xSWQ+OqqTyQ7mBxE4pvEiQ4pZ0ul4kXLv2GL85CdEG
         WO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i+gqxdM/y5BZO9g7s9aqMmU36osNc941oAXaTE2IFc=;
        b=A+Yqe784SvmdAn99JVFb3TRMvmozyuBJD8ZENbr4KLuvKuJGz+0Pd+3ENoIL//Xiih
         +gvL7xJLxfYCF8i20M+53fe2GOUPzo+ITBIXAJfDVGkHZtZHEQDnIeSP9tyPQ1CK+g/p
         J8pcu7Y0lAsLIRyHm1jdW8CPza+s51KRsdUTlDvmTmMTlVOboDoFdwF14CT2JJQfOTFB
         UqM8fRVusLTZGrBXienOB92OW9upcSgXkXYLxcCMLig7IexPqOn+JPqPgk5Mfh7fOG61
         2Q8AWohiOt65Ub0x3COJEonLJ2gRWdtIbCLSPGbSa0/2umaZNhgMXNfcG8puPpSD2ddB
         tzRg==
X-Gm-Message-State: AO0yUKVq/mCwT0DdaWnSADOkXJC0QMy1KnNR4zHbVZDr0w9Z9i5/hUM1
        m5DPTIMYwiWDnwaxAplfGm8=
X-Google-Smtp-Source: AK7set8azzlqz4uSwPpReCQKh/IjgkSweHSc7ScO5sPQkjTEURyTKyHR4Yz69DeJn5iA1VkI+D9p0w==
X-Received: by 2002:a17:902:c713:b0:1a1:8d4e:a71d with SMTP id p19-20020a170902c71300b001a18d4ea71dmr14373775plp.46.1679312734669;
        Mon, 20 Mar 2023 04:45:34 -0700 (PDT)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id r8-20020a1709028bc800b0019cad2de863sm6506109plo.176.2023.03.20.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:45:34 -0700 (PDT)
Date:   Mon, 20 Mar 2023 20:45:02 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: mmap: remove newline at the end of the trace
Message-ID: <ZBhHPsy8pOZ1Twds@minwoo-desktop>
References: <ZAu6qDsNPmk82UjV@minwoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAu6qDsNPmk82UjV@minwoo-desktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 23-03-11 08:18:00, Minwoo Im wrote:
> We already have newline in TP_printk so remove the redundant newline
> character at the end of the mmap trace.
> 
> <...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...
> 
> <...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...
> 
> to
> 
> <...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
> <...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  include/trace/events/mmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index 216de5f03621..f8d61485de16 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -35,7 +35,7 @@ TRACE_EVENT(vm_unmapped_area,
>  		__entry->align_offset = info->align_offset;
>  	),
>  
> -	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> +	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx",
>  		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>  		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
>  		__entry->total_vm, __entry->flags, __entry->length,
> @@ -110,7 +110,7 @@ TRACE_EVENT(exit_mmap,
>  		       __entry->mt		= &mm->mm_mt;
>  	),
>  
> -	TP_printk("mt_mod %p, DESTROY\n",
> +	TP_printk("mt_mod %p, DESTROY",
>  		  __entry->mt
>  	)
>  );
> -- 
> 2.34.1
> 
