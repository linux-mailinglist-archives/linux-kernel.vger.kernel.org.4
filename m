Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4B6A1520
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBXC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXC7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:59:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B734C1C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:59:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bh1so15317655plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olcrIqQ1kcdORE8YSdofInUE8Giqmr98V0FTtToLK3Q=;
        b=oBtVtGGMvwYGsPiarTyZq8pAS9V9wstWveoDqHJ+uHVqiPns2BtbqP1r1K0I4X+/Qa
         l+wen/XjskpouTDP+vlvn6ZlgRrsAJkS0q7H0dWsC46se4Z4rESF1srb3ym3njkTbHPD
         v0y7GP6K/ofsz5GOMLeIuumcou80wQppgyxsmaiLpWwlYR6+5imUelS5L8XzZQTX+5j9
         oiG9OCVNsC4xXvJxrR9g3wv3A/982mJamEsq8Jz0VH/+mFxF8NQBstht9aE+7QWOyTih
         0jLVBbQw7jtXX9qJZ8aC2LXReOVCnsTtzwIObFkmxWb5XKwqRkyb1PsrGtqWL1HY8lU0
         kWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olcrIqQ1kcdORE8YSdofInUE8Giqmr98V0FTtToLK3Q=;
        b=Pt1nXS6LEgoqeb2kNJzUBmDa0mzj0MJeoTJ0bldsBvnSNaRgwDDuLSJQGqat3OllbK
         iBpH7Hl+iiiPJb1Oc0VyCLbfx6uU/GpLMUHlJIXqSCb6OJG4gOX7hL4dmkA9Uglm3prc
         Gd0hGyT+4O98tDkqO9uQc5ceLd1qIeE36O+XaoZoqsy0HdrZMkOWETtGikODYpnjnrh4
         L2DrhqaFCHb7cxKfYIxTxYVa8gqQsjAlnp4OJfG/sPerkbhDTjIMq/XyXL4c0pmArFLl
         1vjufCGTcHoOyT8YUYmbZHJ7nyi17aDQbBNk1mLF9W4x37W92TIWYIPsdf3O1P63f/qG
         ZGkQ==
X-Gm-Message-State: AO0yUKWWyp60tcGIUspEjmE64FJpTBVGeTYGIT2Kj6VMwQPpg+4QZgcS
        tQtZg2Hn/Ny4ePpAyCUqpA0=
X-Google-Smtp-Source: AK7set9wYFsB+BIzXV73mluUbX97fHOvfLEjTot0EG/s7aF02WW65cROEWnsf6fM2zwCWQTtRWJ2wA==
X-Received: by 2002:a17:902:ee91:b0:19a:b302:5158 with SMTP id a17-20020a170902ee9100b0019ab3025158mr12310051pld.29.1677207576106;
        Thu, 23 Feb 2023 18:59:36 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902788f00b0019ac9c9ce16sm5106771pll.138.2023.02.23.18.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 18:59:35 -0800 (PST)
Message-ID: <f41176a6-173b-7b20-c287-f49a503fb0f9@gmail.com>
Date:   Fri, 24 Feb 2023 11:59:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230224014731.ECB6DC433EF@smtp.kernel.org>
Subject: Re: [patch 1/1] submitting-patches.rst: suggest a Link: after
 Reported-by:
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230224014731.ECB6DC433EF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, 23 Feb 2023 17:47:31 -0800, Andrew Morton wrote:
> It seems to be the new way and I find it super useful.
> 
> Cc: Joe Perches <joe@perches.com>
> Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

JFYI, Jon has just applied a similar patch from Thorsten:

    https://lore.kernel.org/lkml/87ttzc40y9.fsf@meer.lwn.net/T/#t

    "Re: [PATCH v1] docs: recommend using Link: whenever using Reported-by:"

        Thanks, Akira

> ---
> 
> 
> --- a/Documentation/process/submitting-patches.rst~submitting-patchesrst-suggest-a-link-after-reported-by
> +++ a/Documentation/process/submitting-patches.rst
> @@ -501,6 +501,12 @@ the bug was reported in private, then as
>  Reported-by tag. The tag is intended for bugs; please do not use it to credit
>  feature requests.
>  
> +Where possible, please include a Link: to the report on the line
> +immediately following the Reported-by:.  For example,
> +
> +Reported-by: John Doe <john.doe@gmail.com>
> +  Link: https://lkml.kernel.org/r/02f796c7@gmail.com
> +
>  A Tested-by: tag indicates that the patch has been successfully tested (in
>  some environment) by the person named.  This tag informs maintainers that
>  some testing has been performed, provides a means to locate testers for
> _
