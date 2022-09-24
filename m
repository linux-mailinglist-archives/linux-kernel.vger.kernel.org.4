Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251885E88FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiIXHOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIXHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:14:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18EE109B;
        Sat, 24 Sep 2022 00:14:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv3so1984758pjb.0;
        Sat, 24 Sep 2022 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zc39r/JUk5EXO1aNoPPyS+CIqOIgtl4S9VWPOk1JNao=;
        b=Ehi+afHuxdncG0EVs/whkNJ7qs3LYN5hnk51tmc+bGUYzoI1Mwu4LPafrpUY/wm+5d
         I6K8+h1FBwOuj7whpuDl+TGIywjop+57FeX/u/dHQ+2AK57D2EFxssv0SBTQQUmLkPCn
         3jfKnLC8lxEgUmRIK5wzoNKWx40TgCeywM/DBszC/OG/u+w/VVGJdgBz3DUMmDkYQg5L
         /yeG0l+wcz5qkaX0lmkr4G7Y02VXNhPw3jcwPHmwmLPEBbf5eWFCS7wpPiDMUySP4/5f
         WP/Z5Y02tTPi5gUxxPT8gBhi/V+QBAgLbHWAKIRnZjkkjJSKrBWNHaXhwYigH1lLXDwt
         i+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zc39r/JUk5EXO1aNoPPyS+CIqOIgtl4S9VWPOk1JNao=;
        b=vCxM4xkZRHl0suQ04oMOWdCPV1G3J+ivlf8nK2qWAlUcgR2TlM9EJtGNFilzLJvuug
         llKq5jefvFqhUHHBXOmeTgs7GTTFYUS9Dlln4nmrCGwhF2qp4Dn1m3gZqZxZ3DYr/2me
         qpTzhAFoXTnrttQe56DeXSSFoWnBagn4wfnBjfH0GuA+LswuOCHyc9RG9FZJMsNbOt5r
         OhsmTKwSa/0KfXB/Ytq9yrwCCSfG1pwlSvmiWleAQesSznZRAYkzGAXPCInZACReR165
         HwN/zPCopblrvX7s74AITACh39ROefqY2Pf8rJX+xM1Hv9bVqoz9t5aWhR0vy/PVciOD
         BpPQ==
X-Gm-Message-State: ACrzQf3cS/7PkVsOXKLoW27VH6eTjNIR7DyoU+kTM2zyHzUuSiIMqQt9
        b7zFgL+CXkXOoOEXYfSST0nf5wXcOmc=
X-Google-Smtp-Source: AMsMyM7jyKBnAPqZXemkkirmSaSEssiA5qljF9xjKhmEO/ZR4LstEalDQycc1WjYdl8e3XkC7vUtMQ==
X-Received: by 2002:a17:90a:4688:b0:1ef:a94:7048 with SMTP id z8-20020a17090a468800b001ef0a947048mr13679726pjf.244.1664003642010;
        Sat, 24 Sep 2022 00:14:02 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7956a000000b0053e439c08c1sm7586182pfq.74.2022.09.24.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 00:14:01 -0700 (PDT)
Message-ID: <9b0cf584-01b3-3013-b800-1ef59fe82476@gmail.com>
Date:   Sat, 24 Sep 2022 16:13:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] string: Rewrite and add more kern-doc for the str*()
 functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220922062817.2283352-1-keescook@chromium.org>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220922062817.2283352-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Kees,
Thank you for sharing your devel branch.

On Wed, 21 Sep 2022 23:28:17 -0700, Kees Cook wrote:
> While there were varying degrees of kern-doc for various str*()-family
> functions, many needed updating and clarification, or to just be
> entirely written. Update (and relocate) existing kern-doc and add missing
> functions, sadly shaking my head at how many times I have written "Do
> not use this function". Include the results in the core kernel API doc.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Follow up to https://lore.kernel.org/lkml/20220902223507.2537469-1-keescook@chromium.org
> Note that this is on top of my recent fortify-string.h series:
> https://lore.kernel.org/lkml/20220920192202.190793-1-keescook@chromium.org/
[...]
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 8bb89deb9a91..adbc4d307770 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1448,6 +1448,8 @@ sub create_parameterlist($$$$) {
>      foreach my $arg (split($splitter, $args)) {
>  	# strip comments
>  	$arg =~ s/\/\*.*\*\///;
> +	# ignore argument attributes
> +	$arg =~ s/\sPOS0?\s/ /;
>  	# strip leading/trailing spaces
>  	$arg =~ s/^\s*//;
>  	$arg =~ s/\s*$//;
> @@ -1657,6 +1659,7 @@ sub dump_function($$) {
>      $prototype =~ s/^__inline +//;
>      $prototype =~ s/^__always_inline +//;
>      $prototype =~ s/^noinline +//;
> +    $prototype =~ s/^__FORTIFY_INLINE +//;
>      $prototype =~ s/__init +//;
>      $prototype =~ s/__init_or_module +//;
>      $prototype =~ s/__deprecated +//;
> @@ -1667,6 +1670,7 @@ sub dump_function($$) {
>      $prototype =~ s/__sched +//;
>      $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
>      $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
> +    $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
>      my $define = $prototype =~ s/^#\s*define\s+//; #ak added
>      $prototype =~ s/__attribute_const__ +//;
>      $prototype =~ s/__attribute__\s*\(\(

This hunk in the corresponding commit 87cb97a66ae9 of your devel branch
looks a little different:

@@ -1666,7 +1669,8 @@ sub dump_function($$) {
     $prototype =~ s/__weak +//;
     $prototype =~ s/__sched +//;
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
-    $prototype =~ s/__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
+    $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
+    $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
     $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__attribute__\s*\(\(

This was what prevented me from applying the patch.

Anyway, "make htmldocs" works just fine now. FWIW,

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
