Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAB269D3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjBTTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBTTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:14:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9F199CC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:14:13 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g26so2424897qts.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676920406;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2x/ZnGEIutJz/ohk0y7JjrYHPKC556kirwfWjoI34Jw=;
        b=PzQ0DM3wYomL4jJe/hIApWXOa3Q9wtEiApGNHzzkVKHcOG4soR2g0iUSfZLxWwmDcK
         IpA4AB14pGwBJ08ikH29yzkR1Kic6KBXMrI7HecxJjuB6DcpGG47wfUCTP/tOqpGG2sT
         3m9MSm8E0yMIRW3OSR/HCSawaP5S+PTdzCkf8Oe5j53X5bjlOfJ6zkyXOaeeNzCIM69L
         P16o/5zY0mB1r1mBOTKbMhO5T/u9PgpMq9tyO+GbnKDdEQqgaUl/CYOrLjbHwrVpCPqA
         pdDbh3iFgIv9E/TuxdskMr8Tju8nW/1B093t4NtTWERkHCtaZEA1YprYaZQIWQ/LIMxh
         yjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676920406;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x/ZnGEIutJz/ohk0y7JjrYHPKC556kirwfWjoI34Jw=;
        b=c4ODisRkq8B8WL9tt5BhE8fOw3pgCQaRptJby02BSmc5OI+bbYhbZjOgTcWIXbXHIj
         rZ1QwVENI+dCaJ1W8roiBLf1UPsXhxkvMT51mAxris3ZpLZ1InejtydyFJrGAU4hkAYH
         4d1Ovofno0XUdDzcw4DVdp7hM3uoOiLKtc4I4hAfGmwIuQk//mDq9wuKJmcLGYL0fUm4
         UyMBBUC7GQhM5cYXXkrwIBEgVkIXMup1sna/0RAnwlomIsZseAJiaT+lQFpV5FtT25eq
         rtWWKFal1A4X9T53OXNtC+poJjJDI8RfAU7CDi/HkgbAs/mPctzH3uq//GB9nQ3l2Cxe
         p3kg==
X-Gm-Message-State: AO0yUKVgRfdvCJAU+eWD/FzZy8i7ciMTm+RAHZ1DJUg5STlGZQwbnPM4
        rVvbYpga6vCdVEYXCmVIED5X809AdFg=
X-Google-Smtp-Source: AK7set9gipoyr+L5ZQ3MNWg6+3BKYxxqXVC+zmWaQRvfllT7fSoIriCXX8+Vvh80eIJfNBEnSFOJ+Q==
X-Received: by 2002:a05:622a:2c2:b0:3b8:5dfe:c3dc with SMTP id a2-20020a05622a02c200b003b85dfec3dcmr4042525qtx.3.1676920406371;
        Mon, 20 Feb 2023 11:13:26 -0800 (PST)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y6-20020ac87086000000b003be56bdd3b1sm924231qto.92.2023.02.20.11.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 11:13:25 -0800 (PST)
Message-ID: <2d045c1a-5947-1ce4-b5cd-a1684761a812@gmail.com>
Date:   Mon, 20 Feb 2023 20:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: rtl8712: Fix multiple line dereference
Content-Language: en-US
To:     Shibo Li <zzutcyha@163.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230220084050.18459-1-zzutcyha@163.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230220084050.18459-1-zzutcyha@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 09:40, Shibo Li wrote:
> This patch fixes the following warning in rtl871x_mlme.c
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.PrivacyAlgrthm'
> 
> Signed-off-by: Shibo Li <zzutcyha@163.com>
> ---
>   drivers/staging/rtl8712/rtl871x_mlme.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
> index 63e12b157001..cc47c1cedd4e 100644
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ b/drivers/staging/rtl8712/rtl871x_mlme.c
> @@ -773,8 +773,8 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
>   						adapter->securitypriv.busetkipkey = false;
>   						adapter->securitypriv.bgrpkey_handshake = false;
>   						ptarget_sta->ieee8021x_blocked = true;
> -						ptarget_sta->XPrivacy = adapter->
> -						securitypriv.PrivacyAlgrthm;
> +						ptarget_sta->XPrivacy =
> +							adapter->securitypriv.PrivacyAlgrthm;
>   						memset((u8 *)&ptarget_sta->x_UncstKey,
>   							 0,
>   							 sizeof(union Keytype));

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120
