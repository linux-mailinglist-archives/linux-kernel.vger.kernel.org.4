Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90AD61710B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKBW4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBW43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:56:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBDF2BF5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:56:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y69so567189ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvHltcSmK4KB84UjgoRavJNl81LE4r8A3c+x/iev4MA=;
        b=GGAex3CI7HG5F0f46SDhbIa74JgV50de0+Qc8WZMJHFXAt//qMhC7JCLq9iHR2Hg9T
         fno+KA0jY6Jft4HLv53ZdqOyImOjFBRal2NEFMuXXF9JsNzfmWSJSLb+b6iZa2uBEelf
         NyE7K66vR5r7QGFagRa99NXTK/1yxR+OTK+MgdFNe0p8bWU0xxVlDqg7MA31GdAOfPe/
         lN9AfRIz1ESKJ8pWmdXdbJ/S0xMkri7MC6UxKcGPw7ITo+uOG/UaDYrqb9okfSAn8w46
         42U6UgzltIqKu+Xtig1R1BzNiHo+pCErmAh3QYM9c3bh4XMeHIZTIOs3mE43+04JNaWY
         6P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvHltcSmK4KB84UjgoRavJNl81LE4r8A3c+x/iev4MA=;
        b=ub40Lg93ChCdFMAOFKu5Qc7AohkC9MgFmspPD+SzdUmQ4iDaMSnEGIGKkMFljSGrgU
         26LcQ0eLnnYMCzgh6c+/m74tAsrm+HspHrAmtt4N/KRIvSqMEHx0eGhXzXZQlS0xTgXK
         lYFQtYrFfGaXrUOgbV33HS2ZMkV9EcbkkfI1WIzRtGKIk0IX7aUi4wsjrx10e3GYOSzn
         rMUTKBMZgOqRY6OrORTK4lHOAEMb1aLePkqmsPDlSV27AXX6JkN/7DvDKEqB3tMb9Eh6
         JTRB3gFO1a1xaA6Z7ol6yrgSfwQiLya2YdMV3vc71vIWTzgJpB049O2ICBcKqUdeRF3J
         SWTA==
X-Gm-Message-State: ACrzQf2U22zx8BB5nTl/Gxz7D9nfxRtZOXxNHLKgcdGpsvX3ae61ZQGq
        fvRurvRAtCW2y5Lnt2wFaN4=
X-Google-Smtp-Source: AMsMyM7AsyW0ijpFauuTaWekHGQ3xgTxJ1jYaN1OW6eR4n2or7ItpJKxllFbvFndEIAa6d3qAHX0AQ==
X-Received: by 2002:a50:d0c4:0:b0:464:14ed:834 with SMTP id g4-20020a50d0c4000000b0046414ed0834mr3871229edf.174.1667429787244;
        Wed, 02 Nov 2022 15:56:27 -0700 (PDT)
Received: from [192.168.1.100] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id ee13-20020a056402290d00b0046267f8150csm6284073edb.19.2022.11.02.15.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:56:26 -0700 (PDT)
Message-ID: <4c2497a4-cf86-af1a-5a0b-0d980f02f152@gmail.com>
Date:   Wed, 2 Nov 2022 23:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y2LxC2kziM1TznhO@qemulion>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2LxC2kziM1TznhO@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/2/22 23:36, Deepak R Varma wrote:
> Simplify code by using min_t and max_t helper macros in place of lengthy
> if/else block oriented logical evaluation and value assignment. This
> issue is identified by coccicheck using the minmax.cocci file.
> 
> Use the *_t variants of min/max macros to avoid compiler warnings about
> data typecast.
> Also, use u32 as type for min_t macro to avoid any truncation of data
> associated with enum constant HT_AGG_SIZE_32K.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 62aa8e893c34..ccb86660ab48 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -587,17 +587,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
>   			else
>   				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
>   		} else {
> -			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
> -				pHTInfo->CurrentAMPDUFactor =
> -						 pPeerHTCap->MaxRxAMPDUFactor;
> -			else
> -				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
> +			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
> +							    HT_AGG_SIZE_32K);
>   		}
>   	}
> -	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
> -		pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
> -	else
> -		pHTInfo->current_mpdu_density = pPeerHTCap->MPDUDensity;
> +	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
> +					      pPeerHTCap->MPDUDensity);
>   	if (pHTInfo->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
>   		pHTInfo->bCurrentAMPDUEnable = false;
>   		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
> --
> 2.34.1
> 
> 
> 
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
