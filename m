Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC02168A16E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjBCSRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjBCSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:17:33 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4B530F1;
        Fri,  3 Feb 2023 10:17:30 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso1617121otq.0;
        Fri, 03 Feb 2023 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dv4klRM8tNSfefu2k3P3n9JnaGoeMZey+8BmiGtUivQ=;
        b=UIa2Vo+DG7fLDFII32hth2L7I3nWGjrqQdGtT52JVd8EK2oqc2bITXNhOElPH2YKBA
         i77853KDXISnHDWK+vwkb3ptx+ZtHEzb8m4dh2RiZ5gAkiN9x64HiOz3RLf/67CwXe9h
         YOmcv1+I6FtVn2PSHgTgkP+CKIqD4CL9+RQTy+AdODPG45l1vPn9cNx2oa26hwxz6uVa
         hLQd0EDwKZCEHMz+zuSZB+H8smdBYKI8C9A+GR5ZZtNxtXiDlt/auBgwCB9icye1onY9
         nDlCwWAVCLGOD5Dd0ijpVPm1yDcxIGt1Otwb35F7jOmfyD2MYKOLGMo42yPFVKqa3Nm1
         fQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dv4klRM8tNSfefu2k3P3n9JnaGoeMZey+8BmiGtUivQ=;
        b=EAdaU0ENK16oHi0WwHlZCAXvHiDsOiiAWHKpX2Io6zhnoHqfXLx2iQ9ww14j1qYXfr
         6lh+zLjueb5snmO9cyifou+uAcdJ+hAbhyzrp782UM4KTb6WPs996aCJHNHtXyN3uRMy
         lyA+pieTXAXUKvzKiBp1z3/6pJnkDdAmyJsbzmvNLmjiv2wONt44XehQKS/XDUKx0x++
         NWYMvzSf91uSB0ldA/u7WeK/00r+oArCF4/CPaR5IU1/vqyvhr9IH9bWuztpiPjuFwAI
         sLPrwlT7hqxXGumnzT1GEgqseAYzUClp7U0jH/+4MuoUfHEtpgYVveoKk9UtFDagRLLT
         62rg==
X-Gm-Message-State: AO0yUKXko2mLngRBt8QQfScFzmvR2ODq90UusUDy/tyuiPuvwfIwHche
        1sHGPw3rAWB3Ewafi141v31CajV6RKI=
X-Google-Smtp-Source: AK7set97S7wey76rFNA2rA5qRQqdiNWG9btq33wqDpmva7ZCY0SJU9ZD46yrbNCtCEf3Np2p00ctJg==
X-Received: by 2002:a05:6830:4786:b0:684:9b6c:c341 with SMTP id df6-20020a056830478600b006849b6cc341mr2212300otb.31.1675448249986;
        Fri, 03 Feb 2023 10:17:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d7114000000b0068d3ec1427bsm1371599otj.69.2023.02.03.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:17:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Feb 2023 10:17:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 1/5] watchdog: diag288_wdt: get rid of register asm
Message-ID: <20230203181728.GA3172478@roeck-us.net>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <20230203073958.1585738-2-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203073958.1585738-2-egorenar@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:39:54AM +0100, Alexander Egorenkov wrote:
> Using register asm statements has been proven to be very error prone,
> especially when using code instrumentation where gcc may add function
> calls, which clobbers register contents in an unexpected way.
> 
> Therefore, get rid of register asm statements in watchdog code, and make
> sure this bug class cannot happen.
> 
> Moreover, remove the register r1 from the clobber list because this
> register is not changed by DIAG 288.
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/diag288_wdt.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 6ca5d9515d85..07ebbb709af4 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -73,20 +73,19 @@ MODULE_ALIAS("vmwatchdog");
>  static int __diag288(unsigned int func, unsigned int timeout,
>  		     unsigned long action, unsigned int len)
>  {
> -	register unsigned long __func asm("2") = func;
> -	register unsigned long __timeout asm("3") = timeout;
> -	register unsigned long __action asm("4") = action;
> -	register unsigned long __len asm("5") = len;
> +	union register_pair r1 = { .even = func, .odd = timeout, };
> +	union register_pair r3 = { .even = action, .odd = len, };
>  	int err;
>  
>  	err = -EINVAL;
>  	asm volatile(
> -		"	diag	%1, %3, 0x288\n"
> -		"0:	la	%0, 0\n"
> +		"	diag	%[r1],%[r3],0x288\n"
> +		"0:	la	%[err],0\n"
>  		"1:\n"
>  		EX_TABLE(0b, 1b)
> -		: "+d" (err) : "d"(__func), "d"(__timeout),
> -		  "d"(__action), "d"(__len) : "1", "cc", "memory");
> +		: [err] "+d" (err)
> +		: [r1] "d" (r1.pair), [r3] "d" (r3.pair)
> +		: "cc", "memory");
>  	return err;
>  }
>  
