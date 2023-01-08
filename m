Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4696615BE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjAHONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjAHONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:13:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC8DFB2;
        Sun,  8 Jan 2023 06:13:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i9so8906855edj.4;
        Sun, 08 Jan 2023 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrbqCrEQg21nkq8Yyz5Fr5Sfv2oN6ivy3M6K8VJvciM=;
        b=exCDx1jnXH5u/B+L4J0whChijivpRrjtq58V04wHvUHbYUwKVEldSqGell8h6lCNHk
         cek/aHqMPQtX78RZJaAZ/r161+BLhg/B8DjQN151tTt098KeNAsQ4EYZxQLJUqr5igmr
         CyV+MuFpkFUPYKi+QFsmsriInLigbfmEqigFAnrRYUrGGruUhQdlHpj7lGmVvdVVq/tk
         8RaN5kUDIeJSw2Va+ZzP9r+05OfbEEV4anVC3CpUMuKr8i7kUIhnUBUO+tRRlE8eTyaC
         DP0zKnwIYySxZTrSEBujCo8n0ELDYhuUdTZmcat5286zEjprG6vPeb9lBk0VXsT+X7kI
         tmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrbqCrEQg21nkq8Yyz5Fr5Sfv2oN6ivy3M6K8VJvciM=;
        b=3bIjY/yQpLfOvy6plb561jSTvdBbT+j+QRglg21PpV2RyN0ZZMN0499e/cG5uAqwx9
         eGnDHPxSrxILARhUlS1luBwRAkGia88bkgXzdsIn2cahrXrRCZn7kSdISns6MvQKNj/5
         hR/XxR5vhkRS4AIKNYgjBvtwqxMGzIha+8xZdSguhH4THsYRo5sU86pkmmRutjw5f44x
         UoJAAPFh1rdNvp2gWSG4KsGPy2mmVu2/YS5H8DmnDkPf+0Zwq7ssBkF+dZ88gYpTghPo
         QE+Xdx9rGZhWz8SWz9T82u1hWBdBGs7yyg7yvi9PPW5UmNOmVucg5/BVMHIJYySH95kM
         KkfA==
X-Gm-Message-State: AFqh2krnlX5mncH4rYBBXIie5MN02f9S5OyELe2na+rixVJkHDThlIH+
        msBYjn8FQ3tAiOcvH2hk0ngLMHX5KwA=
X-Google-Smtp-Source: AMrXdXu2zIzl2KwrBE8X16Uqk95LlkTXLaFHcY2YaAdjHDjnpjt5mM0cPMcf5IkA6WY7c+EFOPcQ2A==
X-Received: by 2002:a05:6402:501f:b0:461:5e1b:85b5 with SMTP id p31-20020a056402501f00b004615e1b85b5mr64736007eda.2.1673187179092;
        Sun, 08 Jan 2023 06:12:59 -0800 (PST)
Received: from krava ([83.240.63.181])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm2603184edr.32.2023.01.08.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 06:12:58 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 8 Jan 2023 15:12:55 +0100
To:     Sohom Datta <sohomdatta1@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sohom Datta <sohomdatta1+git@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent normalize() from reading into undefined memory
Message-ID: <Y7rPZ21J2mnWiIcx@krava>
References: <20221204105836.1012885-1-sohomdatta1+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204105836.1012885-1-sohomdatta1+git@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 04:28:35PM +0530, Sohom Datta wrote:
> The current implementation does not account for a
> trailing backslash followed by a null-byte. If a
> null-byte is encountered following a backslash,
> normalize() will continue reading (and potentially
> writing) into garbage memory ignoring the EOS
> null-byte.
> 
> Signed-off-by: Sohom Datta <sohomdatta1+git@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/expr.l | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 0168a9637330..d47de5f270a8 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -42,8 +42,11 @@ static char *normalize(char *str, int runtime)
>  	char *dst = str;
>  
>  	while (*str) {
> -		if (*str == '\\')
> +		if (*str == '\\') {
>  			*dst++ = *++str;
> +			if (!*str)
> +				break;
> +		}
>  		else if (*str == '?') {
>  			char *paramval;
>  			int i = 0;
> -- 
> 2.38.1
> 
