Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55460D263
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiJYRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiJYRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:22:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9FE197E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:22:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f27so3828655eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7hk24JV5lro82ACGBjAyUKW4BHMyYNrXH2HtmsPxHk=;
        b=bVhy8PRQzalraPznINqxS6p6aolGcRu3S9+inSpdrUI5yMHu0Zty2+32Wxg6bz4aeG
         NGaBbqk753GAdzecPgJCXUKBjr1LE5y2Ah6bXIiBCHVSqzEI/X+hzyF0ZFxdY4ouDo/f
         p6slYL+bHkekzrMRpmScEx76YxZX1yxMg7VFc/5gPIV0cIwUuxQZHrrdYHhN0jVyiSBn
         GW82d4DvJ0LeI1Jxkx1qz698jjfe1eZJCoocn4CiMbnfSZmnhjCIP3c/DjLbpUY7dXHH
         aevNTAekpISXqtP/rezlclzEmYSdZdQBf/navT4qa+XEtLCdMJbUDkvyaka0y8GmkLYv
         v+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7hk24JV5lro82ACGBjAyUKW4BHMyYNrXH2HtmsPxHk=;
        b=k+1cYVyq2D7BJ3iS2lxvmoTivOqRXbekTnRVfPZZ/Liu2QgAsF9EnEwJIMixA+S43R
         zsO17Y1RFNT1/eIxhg/36ldLjqx3yQB9gKfj4fGHtFIC4Rmz6JGehNbYedXU+NbGL09Q
         UVLFmvHbqQGRPdgTEPkGHH4R0NnJajL5nXqlwk8r8bb6FtOEnYfjYpdl8BllEPGaAjRx
         uYb0jV3psJ3abp13hWU0BvOXxVOHQgd3eayse87rGM+2ymvm0c95HRXOUPZFE4u2gOvl
         sOA8aUg6nENt3gCPBj3JbW33qbsS6vk5Yhxpcp3rHDcYhrT0/QNLz9nHp3v5KulLVQZs
         S8fw==
X-Gm-Message-State: ACrzQf1zzcqrw0HDzYRWaRL0WMzKzwziV/QA/WuG/OaHuyXZJ/dTHgLi
        OJtEFWjbLpT4AhlBFcrB0MU=
X-Google-Smtp-Source: AMsMyM5ImPW1+mYblkMY3S0q2dB2daen+x7cZADSV+ZDCxsOUTPYQ1/NGHVWypUeXWup848c11MeVg==
X-Received: by 2002:a17:907:1c17:b0:78d:df89:26c6 with SMTP id nc23-20020a1709071c1700b0078ddf8926c6mr35514089ejc.20.1666718560491;
        Tue, 25 Oct 2022 10:22:40 -0700 (PDT)
Received: from [192.168.1.100] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090685c900b0078ae0fb3d11sm1711492ejy.54.2022.10.25.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 10:22:40 -0700 (PDT)
Message-ID: <1d88a899-614c-06c5-5dc8-9a9a7e58dc47@gmail.com>
Date:   Tue, 25 Oct 2022 19:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: use explicitly signed char
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
References: <20221024163005.536097-1-Jason@zx2c4.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221024163005.536097-1-Jason@zx2c4.com>
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

On 10/24/22 18:30, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. In this case, passing `char *extra` is part of the
> iw API, and that extra is mostly intended to be somewhat opaque. So just
> cast to `s8 *` for the sign test. This fixes warnings like:
> 
> drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f9589c5b62ba..4563e3b5bd47 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -456,7 +456,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>   	}
>   
>   	for (i = 0; i < len; i++) {
> -		if (extra[i] < 0) {
> +		if (((s8 *)extra)[i] < 0) {
>   			ret = -1;
>   			goto out;
>   		}

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
