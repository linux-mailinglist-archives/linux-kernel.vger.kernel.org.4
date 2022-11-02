Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D4617063
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiKBWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKBWJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC4DB4AA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:09:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n12so670725eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoYpqeiAYf2r3EAW7pQ60Og7hl59Eb2xrTJIoY03XVc=;
        b=boJl3z2xKdtqkQHOvzR9lNThkR//L7oV5BDNrvQASEJfMj9BIpacq+ZZdBeyycCNQS
         rfwZq0+48LKMjb23+ZxaGK+SnRfjNrk/dDCwA5VWZIDAdowOkqShT2+8Csy4wJh6EgEI
         Z/uIzUvpvwIdVbzjl5K456QSF9VyoS6s8HO3kb4oGJt4I2v89hKZxiexmeNEUsRxK/Yb
         JIowOj1XBS+oEugeVnv018PfV7feQzGTsPs+FrMuP3UMSogBozIVDVujqPUyJ8jfdodC
         GxGgs+CESQ5ASQjSZB85Pp9MkOng8cojIwxICXobHbLqWmJHAZM6tUsLfcK1BDbn8R/1
         9wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoYpqeiAYf2r3EAW7pQ60Og7hl59Eb2xrTJIoY03XVc=;
        b=tJZ7JQu74oH8t0k7JYbF8o7pIZ7QWNju+2mcB3DFUl7G2KW2MfGY+X9v96Q/32JsE1
         2oVL7LNCnCjwlDsqmkpQ+Kkm4QHw/oCLUs2s+Fu1l0iX7D+JieBefoh1DCcsK3LnFKXf
         tBOiSnEsb8eVkrlVvxe5VAlKRYFFL508MI7I8QVKA8yrvLKjx4ho0Zf75MX7z4Jl6uCA
         umIQbuCphTlo0KGpcq3omJ+cl1M1BxotA+VgL6Uo71p0a6zD9ILhzMSef+ZNkPlLr5aS
         rVeu/m7vB3PcuIbXhEeqD9ebsC9sb4sh1tJTH3Auw/pg0FhbK5mLFMzUEuih/moOZ+qn
         CSOw==
X-Gm-Message-State: ACrzQf3CMppargMF3Wa8zLuuy8bXzKlRjqheMBqkEQJvI1zMVh+vQuQx
        ES4J6P0aqibqnT/PSofvK+E=
X-Google-Smtp-Source: AMsMyM71hD5jObLhyGqJQEZ/ylIuDkz+8GnztQMXvhlo9FmCurZT07qGrMa5/yvokp7tcQLpnnlbMQ==
X-Received: by 2002:a17:906:8473:b0:77b:efa8:50e4 with SMTP id hx19-20020a170906847300b0077befa850e4mr25707689ejc.250.1667426989048;
        Wed, 02 Nov 2022 15:09:49 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm5936115ejb.35.2022.11.02.15.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:09:48 -0700 (PDT)
Message-ID: <e76c5fd4-442b-0f0e-73e8-c17acf11b471@gmail.com>
Date:   Wed, 2 Nov 2022 23:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove unused struct declarations
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y2LYvhr74ng+xFbz@qemulion>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2LYvhr74ng+xFbz@qemulion>
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

On 11/2/22 21:53, Deepak R Varma wrote:
> Some structures are only declared but have not been used anywhere
> in the code. Remove such unused structs. Issue identified as part
> of coccicheck report driven code investigation.
> 
> 
> Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/staging/r8188eu/include/wlan_bssdef.h | 42 -------------------
>   1 file changed, 42 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
> index 831c465df500..ffeafa19ef26 100644
> --- a/drivers/staging/r8188eu/include/wlan_bssdef.h
> +++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
> @@ -177,20 +177,6 @@ struct ndis_802_11_status_ind {
>   /*  MIC check time, 60 seconds. */
>   #define MIC_CHECK_TIME	60000000
> 
> -struct ndis_802_11_auth_evt {
> -	struct ndis_802_11_status_ind       Status;
> -	struct ndis_802_11_auth_req  Request[1];
> -};
> -
> -struct ndis_802_11_test {
> -	u32 Length;
> -	u32 Type;
> -	union {
> -		struct ndis_802_11_auth_evt AuthenticationEvent;
> -		NDIS_802_11_RSSI RssiTrigger;
> -	} tt;
> -};
> -
>   #ifndef Ndis802_11APMode
>   #define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
>   #endif
> @@ -279,34 +265,6 @@ enum UAPSD_MAX_SP {
>   #define NUM_PRE_AUTH_KEY 16
>   #define NUM_PMKID_CACHE NUM_PRE_AUTH_KEY
> 
> -/*
> -*	WPA2
> -*/
> -
> -struct pmkid_candidate {
> -	unsigned char BSSID[ETH_ALEN];
> -	u32 Flags;
> -};
> -
> -struct ndis_802_11_pmkid_list {
> -	u32 Version;       /*  Version of the structure */
> -	u32 NumCandidates; /*  No. of pmkid candidates */
> -	struct pmkid_candidate CandidateList[1];
> -};
> -
> -struct ndis_802_11_auth_encrypt {
> -	enum ndis_802_11_auth_mode AuthModeSupported;
> -	enum ndis_802_11_wep_status EncryptStatusSupported;
> -};
> -
> -struct ndis_802_11_cap {
> -	u32  Length;
> -	u32  Version;
> -	u32  NoOfPMKIDs;
> -	u32  NoOfAuthEncryptPairsSupported;
> -	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[1];
> -};
> -
>   u8 key_2char2num(u8 hch, u8 lch);
>   u8 key_char2num(u8 ch);
>   u8 str_2char2num(u8 hch, u8 lch);
> --
> 2.34.1
> 
> 
> 
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
