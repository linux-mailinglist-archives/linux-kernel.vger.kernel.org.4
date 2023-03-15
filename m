Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB96BAAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjCOIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCOIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:33:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C047437;
        Wed, 15 Mar 2023 01:33:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rj10so7435403pjb.4;
        Wed, 15 Mar 2023 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678869226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+Hh4NEFdu23NPkrKY/S6kujZJVpr7cH2s1IcB94ZS8=;
        b=DFJfdO3xq/W/yhPfb2XHJPh5VTmDSx3Wp2/N/1oGzZbkyZESpMb4x4mISadDh9qgYC
         pLs6QDSRoJrQf2LJzVLda7ARDZKqQD/sn3iP9IucvWpUD+15vPJ1tOLBxQlA1fcUmTD/
         Oy5OlP1WAS74Mopi2HB78Oh05Mz/+2D7YIEsQqp+ZofN83afLT7empxbHKHstl5PRL/0
         iYxkRSsURsZRQBefpCG2tFXwV0bUDTDgsVnyk2hCnwfpAxsREH5mFXbbM3siAYwZJh2s
         BgiZiJ7XN7p/ZXHtwXgfDfBG3eLFKrsxceq/kZS5dmaSX8NMldS6QCH+RANLPhI8FWFv
         WpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Hh4NEFdu23NPkrKY/S6kujZJVpr7cH2s1IcB94ZS8=;
        b=s0jTyH/BzbQ5lrk9kYtxowKDWc77Lg+kfWtSqm/oITw/AXS5DuD4CGq+yGdZn7554Z
         vbFqlIyOsPz5yojMEXujPqvFsHpgCq/SvfBxaahukTW5VhyVQ06kbRstRvHuWpTc5IDC
         Da7Tt8Xn3umnad3BO8Iu8LdORYzaJeqS0pN+VtJvxNiObRC+qwUv2ro48Svf5Dys6hiZ
         lxUmC6vphWG10T8vDWs4Q+QSbU0CMtIbgaJGwGS2gPqocTHhla29u1/1PtiNFlhqQoU3
         c8SbDxxnsZGbDQiuum5zlmmEjm+Dd7zC+D9xuRwbQwJaFG8j+w+fjEwEakSpzF1GU9uy
         6cRg==
X-Gm-Message-State: AO0yUKVcyS71wakckLfsTDuxe37Dx/caKSVV58jco6ttXa06XSUV+y8A
        yi+9DP8cEzltqjSesvYUhf8=
X-Google-Smtp-Source: AK7set/wEiuyevyaiw6M5NAEko33WKy2otbz/it60gU93sXh4o7D/snZwnz9Lw3Rgy6sxGqUcDRXNQ==
X-Received: by 2002:a05:6a20:431a:b0:cb:aacb:312c with SMTP id h26-20020a056a20431a00b000cbaacb312cmr45612179pzk.27.1678869226123;
        Wed, 15 Mar 2023 01:33:46 -0700 (PDT)
Received: from [192.168.50.71] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id r3-20020a654983000000b004f27761a9e7sm2795426pgs.12.2023.03.15.01.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:33:45 -0700 (PDT)
Message-ID: <4f536461-ee2c-73a0-9d28-668a99f8a027@gmail.com>
Date:   Wed, 15 Mar 2023 17:33:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH] perf tools: Add levenshtein ENOMEM check
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315061132.25165-1-p4ranlee@gmail.com>
From:   Paran Lee <p4ranlee@gmail.com>
In-Reply-To: <20230315061132.25165-1-p4ranlee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



23. 3. 15. 15:11에 Paran Lee 이(가) 쓴 글:
> The levenshtein algorithm requires exception handling
> when making dynamic allocations strings.

Sorry about that. I modified the code to make it behave incorrectly.

>  	int len1 = strlen(string1), len2 = strlen(string2);
> -	int *row0 = malloc(sizeof(int) * (len2 + 1));
> -	int *row1 = malloc(sizeof(int) * (len2 + 1));
> -	int *row2 = malloc(sizeof(int) * (len2 + 1));
> +	int *rows, *row0, *row1, *row2;
>  	int i, j;
>  
> +	rows = malloc(3 * sizeof(int) * (len2 + 1));
> +	if(!rows)
> +		return -ENOMEM;
> +
> +	row0 = &rows[0];
> +	row1 = &rows[1];
> +	row2 = &rows[2];
> +
>  	for (j = 0; j <= len2; j++)
>  		row1[j] = j * a;
>  	for (i = 0; i < len1; i++) {
> @@ -79,9 +85,7 @@ int levenshtein(const char *string1, const char *string2,
>  	}
>  
>  	i = row1[len2];
> -	free(row0);
> -	free(row1);
> -	free(row2);
> +	free(rows);
>  
>  	return i;
>  }

I'll think about it a bit more and figure out how to patch it up to make
it look better.

BR
Paran Lee
