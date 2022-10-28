Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDC6113E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJ1ODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJ1ODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:03:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FD1DEC3B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:03:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k19so8141394lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJs9/ylITivpEH1zK/iAiHT0oINqbTDSjSRxLxJdcQw=;
        b=Pu0ACCUhlEwq57fIuR45XKIffhHuGtFwRY3kjjOiQri3BIIoAHZxvVzQv1LvYsWzlj
         JbfRSf876t2kARp2YzW6SHv5+Hv8F0Ahb4bMqpQa02H0Id2xa6MdsgfoxwLmsrF2PhSR
         kA9bcxCbG49WW9qSx0LYHnblj5MZmVmaKaEAAilUP2mMsQZ7TBQeBYqFZs4uA0Ano2CZ
         uB65+nByzfvk5EcUHC4FlZPyT7hNbDdzpfIrfRNVvP8mN3yq6PC4Yk2ZHrtN5ofB4VLg
         jwIx75KHBuL/z3/EIimjaqehiC0g8eNH66POMt1jUd6wwMh29i4fKkcdvgbGVYUiQPed
         hNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJs9/ylITivpEH1zK/iAiHT0oINqbTDSjSRxLxJdcQw=;
        b=D5fCO+UXqcT1/Ei8C6sUaARG85HhPWQHm3PvlZoYTeWrWXYBEvQzTf7hkQ2eYlhPgt
         CcsAppR/cysUtIt0zvAuOTEXE4B5YBWxclgEj+I8/Lh3cOiKXP4rLRHngdFde3+Z4BUK
         UgVs0F3QrfBtPT+qj1VuT/1ZddHawE7l1EYZc6DogK/6eYJB1t3vheay6disGZzwoRTq
         LNQ+4IwFaZf3xO3geNkP3MZnt0GHN1NkyCNHnaG3xuB4xzsPNmC4h3cSqYwhMPlWNWsb
         oaIXJHAKINmYiUV/iUF1vVGScmVdE1SIQqi3OrlVF/Gj3ex6/c2JjsCP4AH2ZC0jTwCa
         vFDg==
X-Gm-Message-State: ACrzQf2kjTGbWjz7loU+U53ldYIMe8m3uW8pviIXxHNUZWNypGSKcG7N
        reKSIrSfUJ3rm9oH4fL+I6cu0Bl+aRU=
X-Google-Smtp-Source: AMsMyM7XaoXvu5ZCen9f8QZ6699xYWIRVpbsXgv0d/Na6IjNonVqHqkrFSItkuSBhDQZNcYdAqOSww==
X-Received: by 2002:a2e:b8ca:0:b0:26f:ebb8:79d6 with SMTP id s10-20020a2eb8ca000000b0026febb879d6mr19844395ljp.331.1666965807471;
        Fri, 28 Oct 2022 07:03:27 -0700 (PDT)
Received: from [192.168.0.252] ([94.103.229.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512070e00b0049876c1bb24sm574561lfs.225.2022.10.28.07.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:03:27 -0700 (PDT)
Message-ID: <642519a2-664d-d837-983a-1d5bbc72a25e@gmail.com>
Date:   Fri, 28 Oct 2022 17:03:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] staging: r8188eu: Use flexible-array for one length array
 member
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y1vRivFfRD6VoBt/@ubunlion>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Y1vRivFfRD6VoBt/@ubunlion>
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

Hi Deepak R,

Deepak R Varma <drv@mailo.com> says:
> Flexible-array member should be used instead of one or zero member to
> meet the need for having a dynamically sized trailing elements in a
> structure. Refer to links [1] and [2] for detailed guidance on this
> suggestion.
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Issue identified using coccicheck.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/staging/r8188eu/include/odm.h         | 2 +-
>   drivers/staging/r8188eu/include/wlan_bssdef.h | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index 89b01dd614ba..e2a9de5b9323 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -166,7 +166,7 @@ struct odm_ra_info {
> 
>   struct ijk_matrix_regs_set {
>   	bool	bIQKDone;
> -	s32	Value[1][IQK_Matrix_REG_NUM];
> +	s32	Value[][IQK_Matrix_REG_NUM];
>   };
> 

you are changing the actual size of the struct. Wondering if you have 
tested this patch somehow

>   struct odm_rf_cal {
> diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
> index 831c465df500..33177de194eb 100644
> --- a/drivers/staging/r8188eu/include/wlan_bssdef.h
> +++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
> @@ -179,7 +179,7 @@ struct ndis_802_11_status_ind {
> 
>   struct ndis_802_11_auth_evt {
>   	struct ndis_802_11_status_ind       Status;
> -	struct ndis_802_11_auth_req  Request[1];
> +	struct ndis_802_11_auth_req  Request[];
>   };
> 

this structure seems to be unused. Better to remove it instead of 
maintaining the old code

>   struct ndis_802_11_test {
> @@ -291,7 +291,7 @@ struct pmkid_candidate {
>   struct ndis_802_11_pmkid_list {
>   	u32 Version;       /*  Version of the structure */
>   	u32 NumCandidates; /*  No. of pmkid candidates */
> -	struct pmkid_candidate CandidateList[1];
> +	struct pmkid_candidate CandidateList[];
>   };

this one as well

> 
>   struct ndis_802_11_auth_encrypt {
> @@ -304,7 +304,7 @@ struct ndis_802_11_cap {
>   	u32  Version;
>   	u32  NoOfPMKIDs;
>   	u32  NoOfAuthEncryptPairsSupported;
> -	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[1];
> +	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[];
>   };
> 
>   u8 key_2char2num(u8 hch, u8 lch);
> --
> 2.34.1
> 

and this one as well

> 
> 





With regards,
Pavel Skripkin
