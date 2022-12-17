Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5464F87D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLQJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:36:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807E6547
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:36:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i9so6725966edj.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEPCT4FJ6pAWdhKShStAS/tGijfNEuYVpX12bBpatgQ=;
        b=pY/RV03V0hPP5Pc6uzfBFPHJF5Opsaj8c5CI349870eDQrgeO9up1Y4vajrbVtvPzw
         y+Cj5ndo5h9DR3sMmSjqSwEkUITb5GwKWlzFJzbpm00t4jjF7MKh9Y3kjMS5Rz4Sq4Da
         ybl5pK5wOV1ORIJN7V+AbLcaF4ND8hcgrfRCbEQmwMOeBiFJv4wjd0kA331fnLoea8kr
         kLCKehlWbb37BVAAiF0VgfsnVvrmTffXqsQkRsISv5+hGOMBdS5ZaKaZ+zo8F+oznDbd
         3CE85DH1WoRAnmP1NCDVVWbMVtxXxah710WXf3f5D1XMSuMdlzqPyKDHOgWFvuZ3refi
         XcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEPCT4FJ6pAWdhKShStAS/tGijfNEuYVpX12bBpatgQ=;
        b=PJY6c8ieVdgF4AYW7qgVyOdzaSeRW1vatbOo7kczFvgSZQ0eeeD74KV0VY5CkgnIxl
         EixGCUfGPWtLHArGJG9RKiUASEi48vPgrp7D82uKETHIsgQHJLVrOCTjmdiyMtARJe0m
         /VPi/Y/T093guiBjkOxleTjNQfKunth9hWVhygJMJf/Q5MfRKryTl5cawsq5olAS2Coq
         60FQ2n2GgqLkyOKCgEMEYOsi0OOcQgQbUOtM6tv4a0ErLzyEKH2H5JVbrgojPQ5Yt5Cr
         wPrqdVS9hvWfVtMYJYfcQ8vl0odznSAN8k8ca6rC3rEcM3xCdfb2CgO6jsJwWEEKPI8q
         XpEw==
X-Gm-Message-State: ANoB5pn/Ieka2SzMJEgL1xmm2YVwrJeXzSjmGrovpVTCApTBLGax0W93
        Cz0Y/tMx/0ghIGNZsC6KY3Q=
X-Google-Smtp-Source: AA0mqf5qnLChFrLKh4m4JvtCg1Pr2jVj/JbQ0OvS72KJ/OCiaYIaCeVXhBCa1ueeDQqbX2KC+J3KOg==
X-Received: by 2002:aa7:cdd6:0:b0:46d:6f14:aed with SMTP id h22-20020aa7cdd6000000b0046d6f140aedmr7559693edw.0.1671269759412;
        Sat, 17 Dec 2022 01:35:59 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id d30-20020a056402401e00b0046b25b93451sm1759478eda.85.2022.12.17.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 01:35:58 -0800 (PST)
Message-ID: <81feafc6-d070-e551-6f85-73073238b511@gmail.com>
Date:   Sat, 17 Dec 2022 10:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: r8188eu: Prefer kcalloc over kzalloc
To:     Kang Minchul <tegongkang@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221216223942.334221-1-tegongkang@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221216223942.334221-1-tegongkang@gmail.com>
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

On 12/16/22 23:39, Kang Minchul wrote:
> Fixed following checkpatch.pl warning:
>   * WARNING: Prefer kcalloc over kzalloc with multiply
> 
> Instead of specifying (number of bytes) * (size) as arugment
> in kzalloc, prefer kcalloc.
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 34494f08c0cd..36ce1e3f9c81 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -1564,7 +1564,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
>   
>   	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
>   
> -	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
> +	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry, sizeof(struct hw_xmit), GFP_KERNEL);
>   	if (!pxmitpriv->hwxmits)
>   		return -ENOMEM;
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
