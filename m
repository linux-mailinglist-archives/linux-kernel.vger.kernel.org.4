Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806060D361
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJYSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJYSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:17:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED65D4A0D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:17:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b12so37655924edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTST5ms0vQMpMFtPIEr66UbVA7v6kgRZj6GihvLVYic=;
        b=QM2u96RDtK4jQWsNmQ9ECcPcRRiFiX/RvYbsYSvwdUy4szE9F3Sql8mrNF2iDqKnz/
         nFG+hjDfh2LGNTZjm+9Q6h/fhAzt6LEPqnR8mCwpQdzE9VordmXL2oLVDhcniribdBst
         5o68jXSWyto2ah9hSCZB/cJBNNBqURz59KRSPSfPZaPvZNXqwQ4+7b06kokUc3N1rhEa
         JKdqNQAaus3CacMDJ12YTXFghIivgyPHou94MPY0CQOQ38DdNxB0uKeuFWSKqrz+CFd0
         1UWQk5lMks4uzQDZ0srK1LquG3NgXa866NpB3DnyAv6VOm8BBW8uRz5BEbvhaWXFYIrl
         DeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTST5ms0vQMpMFtPIEr66UbVA7v6kgRZj6GihvLVYic=;
        b=Kh2t2rXTzq9NlPeT7X4ZOvzo6o+RUSDxUEJbCWUBEaH8GXtcC3edEXW8Qx43tgtL+T
         78qDSUL/YSNX9I0tEMVMrCtc+cou+f4DB2+6WWu+DACiceaubNQMoP4dTsqlXAxFseQz
         AKw8nM4ssnv8RMlEicrHnuGw7Wto7JTNR0CQOIjQykeNseRiBotUIgCCvGnOKmOA6/RX
         x6vaQkVtZyBrO1Av0AkV50y0qXTUHWoD8xBWTO6CKfQds0v0lfH8xaPOtQbRT3O9lMqx
         jANJdwWmamRNLphtypsPVzGRyHeWm4IbNcCcgBuGRfR0gAsgZHfv97Ni7r20eIJmn3rg
         X/vA==
X-Gm-Message-State: ACrzQf0dy3TD9nvPg12WN34kmcxbjN0X4IcSyt9c3ootG0emrFJemmdF
        AyUUEzD0o7AubWbLrAJWDA+fjOM/7bk=
X-Google-Smtp-Source: AMsMyM6V6QYazO0iTWrCGNSweTtpFbl59MIwaCSB8EOPm2N2s5Dbqs8/T6hm+621jPytLiJHdMNR1w==
X-Received: by 2002:a05:6402:1e88:b0:461:a513:f543 with SMTP id f8-20020a0564021e8800b00461a513f543mr13964783edf.183.1666721842844;
        Tue, 25 Oct 2022 11:17:22 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id i4-20020a50fd04000000b0045d59e49acbsm2102287eds.7.2022.10.25.11.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:17:22 -0700 (PDT)
Message-ID: <d9909c60-e76b-c48b-ff0e-fa0b6e6322cf@gmail.com>
Date:   Tue, 25 Oct 2022 20:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove unused macros from wifi.h
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221025152722.14926-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221025152722.14926-1-straube.linux@gmail.com>
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

On 10/25/22 17:27, Michael Straube wrote:
> There are some unused macros in wifi.h. Remove them.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/wifi.h | 27 --------------------------
>   1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 381385a7e118..05f8b7e3ecb0 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -140,7 +140,6 @@ enum WIFI_REG_DOMAIN {
>   #define _PWRMGT_	BIT(12)
>   #define _MORE_DATA_	BIT(13)
>   #define _PRIVACY_	BIT(14)
> -#define _ORDER_		BIT(15)
>   
>   #define SetToDs(pbuf)	\
>   	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
> @@ -187,17 +186,6 @@ enum WIFI_REG_DOMAIN {
>   		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
>   	} while (0)
>   
> -#define GetTupleCache(pbuf)			\
> -	(cpu_to_le16(*(unsigned short *)((size_t)(pbuf) + 22)))
> -
> -#define SetFragNum(pbuf, num) \
> -	do {    \
> -		*(unsigned short *)((size_t)(pbuf) + 22) = \
> -			((*(unsigned short *)((size_t)(pbuf) + 22)) &	\
> -			le16_to_cpu(~(0x000f))) | \
> -			cpu_to_le16(0x0f & (num));     \
> -	} while (0)
> -
>   #define SetSeqNum(pbuf, num) \
>   	do {    \
>   		*(__le16 *)((size_t)(pbuf) + 22) = \
> @@ -221,13 +209,6 @@ enum WIFI_REG_DOMAIN {
>   
>   #define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
>   
> -#define SetAMsdu(pbuf, amsdu)	\
> -	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
> -
> -#define GetTid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) +	\
> -			(((GetToDs(pbuf)<<1) | GetFrDs(pbuf)) == 3 ?	\
> -			30 : 24))) & 0x000f)
> -
>   #define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
>   
>   #define GetAddr2Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
> @@ -415,14 +396,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
>   				Below is the definition for 802.11n
>   ------------------------------------------------------------------------------*/
>   
> -#define SetOrderBit(pbuf)	\
> -	do	{	\
> -		*(unsigned short *)(pbuf) |= cpu_to_le16(_ORDER_); \
> -	} while (0)
> -
> -#define GetOrderBit(pbuf)			\
> -	(((*(unsigned short *)(pbuf)) & le16_to_cpu(_ORDER_)) != 0)
> -
>   /**
>    * struct rtw_ieee80211_bar - HT Block Ack Request
>    *
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
