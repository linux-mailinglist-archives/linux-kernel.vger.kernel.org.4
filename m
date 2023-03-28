Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E06CB822
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1Hdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC1Hdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:33:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202FA3C1D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so11079976wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679988808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEALrOXc52gKsTn2OncrXyRPIgHxMGfS3XCj7g7S3bM=;
        b=FT1w0kRA2s5NiRw3V1gbTmpedbwG7mGzbgKKFn6qwNEataJGR/ZnyqxEqiFGsOf30i
         ML6F4XWW+Z7XpC31p3drbfyLZ51oau2ZlTz2nyF4iA47Txf3RvNExXlR8EkOvnNBj+UT
         SSsX+DBcogeqgimGK1GCrTXmKXnJgWMurj+9TyQG1NV5clg010f711tzm/gjQLUsJQO9
         s+K2eoP2rzo7Yg38G1bU2lXzzKTfZsEDdL9UbFtthDRPBf+j3Wx5bOTaCA/1M21TaY6X
         sd3qGnNJuQA6klpkwB+CPDfiZtzFrZSeg9xaXKJ3pRhf+3lSZipBPA9ztVC+1Oj1RP8b
         tIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEALrOXc52gKsTn2OncrXyRPIgHxMGfS3XCj7g7S3bM=;
        b=Nto1L1weA7Az7PA752XQD2GCL7lhCWMW178UI8lCdvaLM+zTcNTo9/bP011WRIwFIY
         D2Zsl+ynhHXQORc51psDQb7Socz2kWLQ6Hjzuq3Z6e+kWi9I9rKEGLGPiFlIB11My0PP
         6NKX4vFP9RnsO0m90U1fARuTmdY4d80aed1dHAIjwNUopY46V3cpF4kytD43HHfTx/Eo
         aMt8gBGjQTopS6G+Bq9AqBpPICWfANrH34o5Qo8DwKHUNMDi7Xq0LbQHFf+Fptg8puQw
         tsE5qGChcHfhI7uw2cqunI+IMiSqvsaIs7HRyWitqPp6+rg9wZsZGt7GhIPqIAQfyR5G
         P27Q==
X-Gm-Message-State: AAQBX9drIde798fh8nhP0PNZxSWwtWwv5QS/ntoG2ofD8i5c4nq47fZq
        /NH7E0/2XuGhmK61XZci46A=
X-Google-Smtp-Source: AKy350YCxr8JWSgxneY2UBQmYVK9P66v8ig5AVKhAHuMCqd5ytkA/+R4VcOWodKAgyKfJWfSS57Xjg==
X-Received: by 2002:a5d:6744:0:b0:2d0:d739:e37e with SMTP id l4-20020a5d6744000000b002d0d739e37emr12493068wrw.40.1679988808484;
        Tue, 28 Mar 2023 00:33:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm19812481wrf.70.2023.03.28.00.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:33:28 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:33:23 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: refactor arche_platform_wd_irq()
 function
Message-ID: <a64ad550-9991-4f54-8e09-735133422291@kili.mountain>
References: <ZCH6LV5XU0FBlW7Y@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCH6LV5XU0FBlW7Y@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:18:53AM +0500, Khadija Kamran wrote:
> Refactor function by adding goto statement. This reduces the
> indentation and fixes the issue reported by checkpatch.pl script.
> 
> "CHECK: line length of 101 exceeds 100 columns"
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index fcbd5f71eff2..c7d3b6f7368f 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -178,11 +178,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				 */
>  				if (arche_pdata->wake_detect_state !=
>  						WD_STATE_COLDBOOT_START) {
> -					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> -							       flags);
> -					return IRQ_WAKE_THREAD;
> +					goto out;

I don't like this goto.

It suggests that calling arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
is a part of a shared exit path when that is not true so it is sort of
lying to the reader and making things harder to understand.

Unlocking is shared.  goto unlock is fine.  But that doesn't help with
the very long lines.  (I am not saying that goto unlock is a worthwhile
patch to send but I would definitely have found it tolerable).

regards,
dan carpenter

>  				}
>  			}
>  		}
> @@ -205,6 +201,11 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>  
>  	return IRQ_HANDLED;
> +
> +out:
> +	arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
> +	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> +	return IRQ_WAKE_THREAD;
>  }
>  
>  /*
> -- 
> 2.34.1
> 
