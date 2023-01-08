Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE36616D0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjAHQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjAHQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:43:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E851092
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 08:43:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u19so14558582ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qSYeheKKTbQuWeKS3E1J2NUuqVJNCq9nE1pOULvlwM=;
        b=aNuD7uCbHuJoZneb2RVkRnwWJdXhlI73o+lHiIYSEpgau+fmrV7l0Sdtmx3XqXRvav
         bUhaxz1I4RFj9RCWNR9DKnybIi1XI/Dq5YPVQ0FoWwBUr2sgl/GSd9+f/5VqHjmBveiI
         dE1ImhM0gY5IORmeyQX7F+BKSXp5sXhwCwdsaZse7TI8awAzR0vteiVE+w8FNn1big+t
         9Z7sZR8WWcwYRMqMoc52AFAKeTt4ByAAH5ix84hoRVF92+6f5h7ZorjbJaicBaTsm+tx
         errbaMIxMGeFEJ5sjyI0PgWqBgds0rpk/1ti3TXoydmnGS73SS/F3xdoEw9S8ne3/h/c
         xrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qSYeheKKTbQuWeKS3E1J2NUuqVJNCq9nE1pOULvlwM=;
        b=4s3Z1zyJwCXi2uD1mYS/NR7U/8Uj1fERyg/jK9Z+DzXNxZqSgjjE7Y1gI73Lnee1sL
         Zjy7S981RscZe6Rodu0Wtv8+n9cyRMBe8w0MhyfTe0FOpJ0zRANCtaQcnRFdlHGlJdBG
         NpAxBA9sfDugjYFVAKID4q2iyKYZFP2vjsxlF/qINxVLslipcgPLXrzzb1jKIohTFPuh
         NE18WoBjikaS1P7XU53pQp04KyETP4y20AzE1jY8Sa4Emg5wZ2Wrv0067E1aRFTt9i4/
         rB4kpf+4gl6OicrBq8dOoKoNAqdaKNtRvneS8Gxgy0ZCmf8MA9B5QehG+Tlyp3sJUYEC
         kEWQ==
X-Gm-Message-State: AFqh2kpaAhOdzwzotVhkZCcaKAH97qSqZ6iCBj5A53Dv6rF/OHFf6UqU
        RjJsUdgCswqRD+BPaabzdAU=
X-Google-Smtp-Source: AMrXdXuDaO6OKioHRedbTGXTeBvgg0JrRgP7fUZfb/Z6HiTyvxSnxUj7oQ5cRRAARl9Q4AZpcU1AAA==
X-Received: by 2002:a17:907:9d0e:b0:7c1:6433:90ab with SMTP id kt14-20020a1709079d0e00b007c1643390abmr12791367ejc.5.1673196228600;
        Sun, 08 Jan 2023 08:43:48 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ja25-20020a170907989900b0084d1160a19dsm2701040ejc.98.2023.01.08.08.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 08:43:48 -0800 (PST)
Message-ID: <47aa174f-d284-6dad-c684-5ee42c736ada@gmail.com>
Date:   Sun, 8 Jan 2023 17:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: r8188eu: convert rtw_writeN() to common error
 logic
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230108123804.3754-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230108123804.3754-1-straube.linux@gmail.com>
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

On 1/8/23 13:38, Michael Straube wrote:
> Convert the function rtw_writeN() away from returning _FAIL or
> _SUCCESS which uses inverted error logic. Use the common error logic
> instead. Return 0 for success and negative values for failure.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> Tested on x86_64 with Inter-Tech DMG-02.
> 
>   drivers/staging/r8188eu/core/rtw_fw.c       | 10 ++++------
>   drivers/staging/r8188eu/hal/usb_ops_linux.c |  7 ++-----
>   2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index 682c65b1e04c..1e4baf74ecd5 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -89,9 +89,8 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
>   		addr = FW_8188E_START_ADDRESS + i * block_size;
>   		data = buffer + i * block_size;
>   
> -		ret = rtw_writeN(padapter, addr, block_size, data);
> -		if (ret == _FAIL)
> -			goto exit;
> +		if (rtw_writeN(padapter, addr, block_size, data))
> +			return _FAIL;
>   	}
>   
>   	if (remain) {
> @@ -105,9 +104,8 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
>   			addr = FW_8188E_START_ADDRESS + offset + i * block_size;
>   			data = buffer + offset + i * block_size;
>   
> -			ret = rtw_writeN(padapter, addr, block_size, data);
> -			if (ret == _FAIL)
> -				goto exit;
> +			if (rtw_writeN(padapter, addr, block_size, data))
> +				return _FAIL;
>   		}
>   	}
>   
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 7c72f5e04d9b..f02f8568cdcf 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -179,14 +179,11 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
>   	struct io_priv *io_priv = &adapter->iopriv;
>   	struct intf_hdl *intf = &io_priv->intf;
>   	u16 value = addr & 0xffff;
> -	int ret;
>   
>   	if (length > VENDOR_CMD_MAX_DATA_LEN)
> -		return _FAIL;
> +		return -EINVAL;
>   
> -	ret = usb_write(intf, value, data, length);
> -
> -	return RTW_STATUS_CODE(ret);
> +	return usb_write(intf, value, data, length);
>   }
>   
>   static void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
