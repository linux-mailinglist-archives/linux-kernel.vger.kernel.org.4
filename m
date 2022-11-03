Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0581618B08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiKCWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:02:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BA22B0D;
        Thu,  3 Nov 2022 15:02:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso583074wms.4;
        Thu, 03 Nov 2022 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baYbNDVgL1/4As3xdLgF9MW4MrHr71vL82GF0ZTz74Y=;
        b=d3pI+FbfiZ6ZZxbbXjqC4fZZb541u7ezWW5QbfEC/S/XVTqO7Q/2qizWJhrxvZDjJx
         LB0j7/MYYslYRLrz4AW69Cfi/M/IEVKmI30ZX1DkleTCMm9WQcj+uRpKP4vD7AHwgNXT
         78PQbsaHzC1hVmYRr4h8GvUHYQjkNVTw+5bbZKUvu2Mmw0ciPl8Ll01ZBXkfBy7NSaS+
         +crdVPWf1pkiNrcJSFRW78nWtGS1eJZkWMRwwQxkA0iDbGksDSyZq6MGhPe9f97HEeoI
         LNHNZTkyuACvAvcGDCDq2eL5giPKEsmDnCPI2NVMnu8qB/hsAcBGWTDit0HpplTS0Yym
         U6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baYbNDVgL1/4As3xdLgF9MW4MrHr71vL82GF0ZTz74Y=;
        b=jd1ysUxWURerQeHNcJHFb/xGsSt6jy0bQzOL6F6EXD9+HUVD/3TakD1ftOoxkyFQRo
         m2nVJhEg1TGtPyA6N/SMbsSMB9ncBpBfVhDPQAcoK+STqe8GOswUJ3MP36S8gnYXQZP2
         +5S4olArssgY2wwZrM+P2d/1h1xggix/Ie/rzcJels0uOMBj8AuA/wFzHpYosAzhs1sL
         9dCue0oDkVbvGft7y+ijTTD4M7HhCQQL7itsN6Hp2+gLm1Cni7wximDkt1smiH0O3n8g
         exySHdjPiUtMk1TmWHvW//c6Uze80UFh5XnzEJn8FkzWcsZ3Kx8yiOjl9WMyhPD7e3by
         XSmA==
X-Gm-Message-State: ACrzQf0+I24MRkZMdBnJ3Uu+3J6BSdjipXlqDPxLfS/JqDXIjUSlnqbt
        ThStcZU+n/ue5u+zeJt7bO13dJfnL80=
X-Google-Smtp-Source: AMsMyM5uqc/izvH4hvGJUqx1Cm1f3/I59CQRLO6OVDyZTDg08OAK/Z61zynh0VcBmPWAGqJ79HljQw==
X-Received: by 2002:a05:600c:4588:b0:3c6:f645:dad0 with SMTP id r8-20020a05600c458800b003c6f645dad0mr22077696wmo.114.1667512940198;
        Thu, 03 Nov 2022 15:02:20 -0700 (PDT)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003a83ca67f73sm1094209wml.3.2022.11.03.15.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:02:19 -0700 (PDT)
Message-ID: <a497e930-00d5-b830-b29c-531c18da800a@gmail.com>
Date:   Thu, 3 Nov 2022 23:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] staging: rtl8192e: rtl819x_HTProc: make arrays
 const and one static
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaron Lawrence <t4rmin@zohomail.com>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103130619.78413-1-colin.i.king@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221103130619.78413-1-colin.i.king@gmail.com>
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

On 11/3/22 14:06, Colin Ian King wrote:
> Make two dead-only arrays const. Make array EWC11NHTCap static const
> so it is not populated on the stack, makes the code smaller too.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 62aa8e893c34..84ec8df047d7 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -282,7 +282,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
>   	memset(posHTCap, 0, *len);
>   
>   	if ((bAssoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
> -		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
> +		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
>   
>   		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
>   		pCapELE = (struct ht_capab_ele *)&posHTCap[4];
> @@ -515,8 +515,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
>   	u16 nMaxAMSDUSize = 0;
>   	u8 *pMcsFilter = NULL;
>   
> -	static u8 EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
> -	static u8 EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};
> +	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
> +	static const u8 EWC11NHTInfo[] = { 0x00, 0x90, 0x4c, 0x34 };
>   
>   	if (!pHTInfo->bCurrentHTSupport) {
>   		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
