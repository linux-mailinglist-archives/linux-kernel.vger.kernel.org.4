Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45867EABD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjA0QWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjA0QV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:21:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CB113F2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:21:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mg12so15113050ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSNW9eDCc8qC28SnczcwrmjDfHdMbiyLyRXKQWjQyVI=;
        b=YnklbmeC7xhmg2DUPNwdKFRzl+4vG/QS2ZTEP4GXswUv1LK3rOxd9PB3uDhoPNlOQL
         m5CpIXMOYvLuwJWV3QhvA1NDwFpkgcI1YXgMtNoKWEtcHV+VS9iEPsDtjUUKyhVwtvUU
         1G0mkvghMm54BeLGx0dikLkNtOp3qKe4Ub9N6nXWrYcqc/E2QvYivhh6qWl1uMsDcxHx
         XV/ORE+O8U1fufY3olMFiOzr+uFcUBYFDdYWVYFm0Hmukj08rP5+4wz7W2/l4K8VwkMx
         PXx2juheT9QURmAcD9sztPVPrsxSN2PlJSYNvOmTY631qpVOu6MCPiikcKLgO1xpb3/p
         8w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSNW9eDCc8qC28SnczcwrmjDfHdMbiyLyRXKQWjQyVI=;
        b=f2UeLAjUpuy7xe4Bh/tv//zOB+RC3peV4e0y0N2pKB77voCA7cYRXJwsK7QzJmcdSu
         8+WcPgtKyZcz4b9VA1ZjyxsPQ/2sW93HS9j3HlveXOOgQgwYYiGM5Sp0t6oRyP5WYd6H
         Rres3cakeBw7tYT/08QBPqWIQ7ex72l2V+j2WthPmO5m0gpkAa8XNWKLZT1sK8Vte4hr
         x0gieyb2UPOASOJ4DGjQiO3x9GalHXopiiTnWFemULQ3lvdIz9/En1IfeEWiOlZaE/eA
         4Wd7HimEuIrVaotKrupVlO2JApZD1q6vR92Ful0FSOZ08iGpoPTigeFJvGnuxF6KyrlJ
         p/sg==
X-Gm-Message-State: AO0yUKXwrKGrouegYOfbWCswPq6LcX0l60Z0hhJGiPbWu7aA+BfKyCJD
        IX4KYqcAMmJYd4OrsJIya8z0RQ==
X-Google-Smtp-Source: AK7set8W8aeDEdCFLfwaUEgFyL/5MHo0l2bEdR11o4KmIXuxIeXDmcn7ffdEYzbaB/xVmHJEA5H3Qw==
X-Received: by 2002:a17:906:d1d0:b0:878:6df7:ce74 with SMTP id bs16-20020a170906d1d000b008786df7ce74mr6111842ejb.23.1674836512256;
        Fri, 27 Jan 2023 08:21:52 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id hd16-20020a170907969000b0087854d35687sm2538205ejc.172.2023.01.27.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:21:51 -0800 (PST)
Message-ID: <9174ce77-f891-8428-6c36-6b8b4a21cd26@tessares.net>
Date:   Fri, 27 Jan 2023 17:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 17/34] selftests: net: Fix incorrect kernel headers search
 path
Content-Language: en-GB
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-18-mathieu.desnoyers@efficios.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230127135755.79929-18-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 27/01/2023 14:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
> building against kernel headers from the build environment in scenarios
> where kernel headers are installed into a specific output directory
> (O=...).

Thank you for the patch!

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <stable@vger.kernel.org>    [5.18+]

(It might be useful to add a "Fixes" tag as well to clearly indicate the
dependence with a specific commit and better understand the fix.)

(and add all the individual maintainers of the files you modify -- feel
free to use 'b4' to help you for this task ;-) )

(...)

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 43a723626126..06bba013bcef 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
>  
>  top_srcdir = ../../../../..
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g $(KHDR_INCLUDES)

I only looked at the modification here with MPTCP selftests and it looks
good to me. It makes sense because if KHDR_INCLUDES is not set, it will
be set later by lib.mk I suppose.

Just one small thing: I guess you can also remove "top_srcdir" variable
that is no longer used, right? I see that "lib.mk" uses a variable with
the same name but it overrides its value anyway. But it is likely I
missed something there :)

If indeed it is no longer needed, I guess a few Makefile can be adapted
according to:

  git grep top_srcdir -- tools/testing/selftests/*/

I guess most of these Makefile are very similar, no? For MPTCP, we
simply looked at what was done elsewhere :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
