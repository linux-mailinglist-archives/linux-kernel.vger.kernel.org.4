Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477BF65E362
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjAEDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjAEDWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:22:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991814880C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:22:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n4so38126583plp.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 19:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjE8Jrzs3CyahbQ+pkRTwbZkkd7aMOxenEm7ldYUYYU=;
        b=M3oOkTeHv/Ujn7El7RdRok0mJBZr84O2/ZXgbDFSqxLYVw45AOkuPhroOUVy2X6Fwo
         9ZCILlfADVG8Fdr1Xi2FkyyLZz6oYe69hI4QW884wW0Euyfxrw9G6G7nocwlzd7sIvQK
         SFwezBf0LP+foygTzdIA6L4h4mrhOh0DMO3U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjE8Jrzs3CyahbQ+pkRTwbZkkd7aMOxenEm7ldYUYYU=;
        b=QbZVXFZOK2sQwf6mU273ax47OaJpKwwXSIP2laHOEyXGimG/7Th27ROX8yIv96OzZQ
         praGuD7DoQRNc5lbqPsqCoqxiv/C5ncaBSGJa7qDKzWP80ROhwTVVKHZf/x4HvJF8VPX
         +gI3m+YMtAuMxpHL7qPioexZKn5V4OMbMfAVm6NeORlW7mPLI+FvgIg7TfjFwDvqroVY
         m2PihtSmGKrLq5YCeFCMGAFwttFz8zSqwdvM7g0nZkjfkyiAqZ1Z8azRuyfOC/PEk7h1
         LpNjVVdT3tpjwrS+nMuviRFMyvoy8YFolDnK9+RjwdcBB3qv9mvN1lSgD4cmHiBgRuhW
         Bi/w==
X-Gm-Message-State: AFqh2ko9RCrPgB4pOwAfqFCc4BFdQz4bDp9DWz1NwqtbTKeZB9p69+pz
        M2glv3UMt5FmpCtlczU0i0DqOg==
X-Google-Smtp-Source: AMrXdXssDcRe2ldkM5bg4xpA/sZY7bwpxNExHtBib1JrST5N22zxQRN0rJDAJFL92MC5qTQh730EsQ==
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr93873232plg.46.1672888936103;
        Wed, 04 Jan 2023 19:22:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902cf0e00b00186a2444a43sm24838115plg.27.2023.01.04.19.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 19:22:15 -0800 (PST)
Date:   Wed, 4 Jan 2023 19:22:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202301041920.74A1232709@keescook>
References: <20230105132535.0d65378f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105132535.0d65378f@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:25:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/string.h:253,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/paravirt.h:17,
>                  from arch/x86/include/asm/cpuid.h:62,
>                  from arch/x86/include/asm/processor.h:19,
>                  from arch/x86/include/asm/cpufeature.h:5,
>                  from arch/x86/include/asm/thread_info.h:53,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:9,
>                  from include/linux/preempt.h:78,
>                  from include/linux/percpu.h:6,
>                  from include/linux/prandom.h:13,
>                  from include/linux/random.h:153,
>                  from include/linux/net.h:18,
>                  from net/rxrpc/output.c:10:
> In function 'fortify_memcpy_chk',
>     inlined from 'rxrpc_fill_out_ack' at net/rxrpc/output.c:158:2:
> include/linux/fortify-string.h:520:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   520 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Exposed by commit
> 
>   f7cd05c76c70 ("fortify: Use __builtin_dynamic_object_size() when available")

Oh! I'm not sure how I missed that in test builds.

> I applied the following patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 5 Jan 2023 12:56:39 +1100
> Subject: [PATCH] rxrpc: replace zero-lenth array with DECLARE_FLEX_ARRAY() helper
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  net/rxrpc/ar-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 18092526d3c8..c7186484fc5f 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -783,7 +783,7 @@ struct rxrpc_txbuf {
>  			u8	data[RXRPC_JUMBO_DATALEN]; /* Data packet */
>  			struct {
>  				struct rxrpc_ackpacket ack;
> -				u8 acks[0];
> +				DECLARE_FLEX_ARRAY(u8, acks);
>  			};
>  		};
>  	} __aligned(64);

Yes, that looks entirely correct. Are you sending that separately, or
should I carry it in my tree?

Thanks!

-Kees

-- 
Kees Cook
