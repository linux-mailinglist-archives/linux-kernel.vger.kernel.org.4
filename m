Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B906EC951
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDXJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjDXJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:46:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4C3C27;
        Mon, 24 Apr 2023 02:45:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso18526465e9.3;
        Mon, 24 Apr 2023 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329543; x=1684921543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=duHeMOPaquEbxpvw/UJxFgzwcL0EWnQUhJm+862ifh4=;
        b=XoWZSvbbZP6HP8sjR3e73o2+4zC7Glzq8vNFrSUPHO8LgJHIjXNfR19KpEpUxV+q/Y
         wqenBxHq0v8mFInIeb87EySmlLrvbsHuQzW9eOw28EHYldGKVAM87f4+kuM9Hyvxt+uf
         s2Tg+WNFuMcxTudO12uiY+XNQ1jkQU1ZCnGWfgFIbSdAmPddP+l/pw03OzjjSN5CEzBq
         RpZLNFuOtEgFvikU3AOod1ZG/S2NzV9UpBhZcC7p2vXEkb1t0n5mdtwcp7c7hp4bwU/B
         WrdtXAnBTA8hh11S0kzwvyLC4VYeGJ2gmBxrACVHjYD307YpsLKyPuvsLm/cywmnsDPB
         oKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329543; x=1684921543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duHeMOPaquEbxpvw/UJxFgzwcL0EWnQUhJm+862ifh4=;
        b=kFvsETr9wG/gnQ5VqREeZjMzKqH1+zLTDrnGwX57YBrcazpOhwPqYouZAXy8WlRGcn
         f3CuQ/zOjK0mVSprxMAWH4ERKZzQDQEGtdhXDcRnumkffFrZ3TnwriC6YhLaxtqYOT/P
         oWbFTgMDSaS09FYB24CykM+JvsKXAbHkS4us8qHJyJBVIl8jU+D00qy52jyh5AZU2/iZ
         6jvxXjQE6P7vO4uLaP9/xOtcU0/9RlGdYGurMhnzbHsaSUCDAGQbzj7nNe/3uHTxNE7z
         Uw3KTqCElx1KPYi/NoGBAiyjZfNFEEDrIFBRrtJ+Awbv9HnEjx/5qvBOdG2H8OqpcWdi
         uckg==
X-Gm-Message-State: AAQBX9d32mshmFhYHM99uTLFG6D32xLqcz/aAQTIiNUH/IEKCNJkO/iS
        mluVxkd71wox3pF/PgvSdIGY1IFvBGc=
X-Google-Smtp-Source: AKy350b8JOCi4aFVszwnNNOtBs79KkORvtY9v75q+pYAGo2XBZ1tU1Uatf1o7f3joLKuJGlp+zIXkg==
X-Received: by 2002:a7b:ca47:0:b0:3f1:9acf:8670 with SMTP id m7-20020a7bca47000000b003f19acf8670mr4476299wml.22.1682329542994;
        Mon, 24 Apr 2023 02:45:42 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id m36-20020a05600c3b2400b003edc4788fa0sm15275083wms.2.2023.04.24.02.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:45:42 -0700 (PDT)
Message-ID: <a9396dbe-08aa-620c-cb08-7ea9943e1561@gmail.com>
Date:   Mon, 24 Apr 2023 10:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] rv: Fix addition on an uninitialized variable 'run'
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424094446.105133-1-colin.i.king@gmail.com>
Content-Language: en-US
In-Reply-To: <20230424094446.105133-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 10:44, Colin Ian King wrote:
> The variable run is not initialized however it is being accumulated
> by the return value from the call to ikm_run_monitor.  Fix this by
> initializing run to zero at the start of the function.
> 
> Fixes: 4bc4b131d44c ("rv: Add rv tool")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/verification/rv/src/rv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
> index e601cd9c411e..1ddb85532816 100644
> --- a/tools/verification/rv/src/rv.c
> +++ b/tools/verification/rv/src/rv.c
> @@ -74,7 +74,7 @@ static void rv_list(int argc, char **argv)
>   static void rv_mon(int argc, char **argv)
>   {
>   	char *monitor_name;
> -	int i, run;
> +	int i, run = 0;
>   
>   	static const char *const usage[] = {
>   		"",

Oops, I forgot the V2, will re-send as a V3. My bad.
