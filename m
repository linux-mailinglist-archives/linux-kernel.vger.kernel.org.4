Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39E8695092
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjBMTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjBMTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:24:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00AA5D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:24:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12049609wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giaTZq0NaOaNOl2aSl9czKmCDdpgl0ipMUFPJdDsfD0=;
        b=eJxNiyetSpwV4i4BzQT0Z7fTmw+eR8zrNDZNR+eVkHEFQnwFAwHuLHDAxtmGhfaXFQ
         Ux1bFF/zSAuPco4jUolNTS/mCIUzFQg3pA4yulxGrrR14jPOKlFgjg5bgico/jDlNKaK
         Qcyhgh8myRp1YYih3mnEo+/EEC05HvipHRF73k1UMLbnRWW6KliiGguzyzhiS03/56Yi
         DtSRjnaVivvpsWHvrNxhGtG8lb1B+0NtrT9hWwCUri/MqRqJ0DbL4pAhmbGm5qLSo3pt
         zj3IbWhz0ioLMHaB0dWQ18d6KqfMSk6ChCGE9B1SmUArplrZsw833dBAUIBV8LGcr3Hw
         Ec/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giaTZq0NaOaNOl2aSl9czKmCDdpgl0ipMUFPJdDsfD0=;
        b=VfH9sgt3IGVrXQXif/sj0Lmwa3/0kHaVtGN0Moh+3i6nzwkKSzu+6+Q1xhD/HdsHwV
         ln/QYR18mlkAxEALaDd9+x1BZjAFWNekH8QgC1UVCl+82DinVWoNLtip7rtynQuwAabI
         AAbCQ29uqminP1s4UlauErAX0qdF3CzO12fGtzfSKLafd+hcPPI7dZzpQbzInWpA9b5h
         c+YvbzHsxenblCKh7+GrDyipiQFIjIJ9pBxATaIZ9YdDU3lQcp8tMRxMRL9L3MYYAmi/
         bk0XFnXvhj5ElPcKVVgTq++uZ7Rx7sAIPA7fFTrw4kmF7Q+h64RVk/3hQU2R2RT9BdwE
         tN1Q==
X-Gm-Message-State: AO0yUKU+QS5VNQnYuui954aApIsjx3qBAMB4d04AbEh0ymZTbQh/FnGc
        VUzZ6ahSOwbOqO+tM+ZFQvQ=
X-Google-Smtp-Source: AK7set/sfNCJMFJ9KYqNr06VgWPzHPVjoTvQKi8HTzrwfvg8+4IPoLRKOOFhuvTVIPGWyGDOcGF8XQ==
X-Received: by 2002:a05:600c:4f8e:b0:3dc:5032:2895 with SMTP id n14-20020a05600c4f8e00b003dc50322895mr24283274wmq.0.1676316241813;
        Mon, 13 Feb 2023 11:24:01 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b002c5465f7da8sm9539493wrx.102.2023.02.13.11.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:24:01 -0800 (PST)
Message-ID: <d463a482-03c8-db3b-e3ac-935eb12c82bf@gmail.com>
Date:   Mon, 13 Feb 2023 20:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: r8188eu: replace hand coded loop with
 list_for_each_entry
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230211170223.419205-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230211170223.419205-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 18:02, Martin Kaiser wrote:
> In function rtw_get_stainfo, we can use list_for_each_entry to iterate
> over the list of stations and make the code a bit simpler.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> index a9c29b2bf230..e1ae1859686e 100644
> --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> @@ -391,8 +391,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
>   /* any station allocated can be searched by hash list */
>   struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
>   {
> -	struct list_head *plist, *phead;
> -	struct sta_info *psta = NULL;
> +	struct sta_info *ploop, *psta = NULL;
>   	u32	index;
>   	u8 *addr;
>   	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> @@ -409,18 +408,11 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
>   
>   	spin_lock_bh(&pstapriv->sta_hash_lock);
>   
> -	phead = &pstapriv->sta_hash[index];
> -	plist = phead->next;
> -
> -	while (phead != plist) {
> -		psta = container_of(plist, struct sta_info, hash_list);
> -
> -		if ((!memcmp(psta->hwaddr, addr, ETH_ALEN))) {
> -			/*  if found the matched address */
> +	list_for_each_entry(ploop, &pstapriv->sta_hash[index], hash_list) {
> +		if (!memcmp(ploop->hwaddr, addr, ETH_ALEN)) {
> +			psta = ploop;
>   			break;
>   		}
> -		psta = NULL;
> -		plist = plist->next;
>   	}
>   
>   	spin_unlock_bh(&pstapriv->sta_hash_lock);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
