Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BF729A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjFIMbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFIMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:31:03 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260F3AA1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:30:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19f31d6b661so663471fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686313816; x=1688905816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhY9F426/XZBDfWDG79w1KFjKHgE+TlbQzvvhGcm+pE=;
        b=26w7TL8p4QsaCxqNELPKZl0nf/3DIA4tnu5Z8yBaaMHQs6nJdtoL1/IJwGh8Xnqrul
         ceyIop0m88PtIMieJZNuYYbD/f2aPr+QAgKlDI4QCHaqKwiuAJdXHnqdd/Y4WTeV0kFF
         +cy/Kl06Bx5/Zyi6ieZfFwUmWxzKs65SzA7ozL6+ye7vj6isA71BUY2ZZFcRKUgRZodv
         RI2o0K3tz9AhHI4WOGQfYmNOTK61fDf27e3WzQtyXXB2KJrclrxX2QPz5GKoP1ag2Isg
         Tu+rwCSeuKR7iKJdPxkioShwiSXaONWzCieOz4ysJSPBOlZBj3CblganCvCX44cWRMdj
         aV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313816; x=1688905816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhY9F426/XZBDfWDG79w1KFjKHgE+TlbQzvvhGcm+pE=;
        b=Ko7D7bZv5nedGiv32JWHjuv+a1/MOV4Ru/hMrrdSUhtU0aTRYm/e0oFNNW/gHXQIed
         sOPrkNrYxiXGLspjSjW9QCZzHqc7ZkcJphHXoqkLAuf+i3KtGqD0WGheBpPTDtUl8BW8
         tPpHKtGazBOduHOrojGsWBZA8RXQlRi9ZAayp0QAF3ce3THQhI4SyfEs1hqAb33ocARv
         RH3N2JxElY4wnlBYvNKgolVx2kJ0kjWe3Sg/gvEQBV45I1gnm+5xUbVWMy54GVCcdseQ
         sQW3g3EvxAYEtxggYQwoWuUbuPXCFkXt5CqtiGeWhKqlbgLOCzW0aZZGww/1U+5nGkBT
         VHLA==
X-Gm-Message-State: AC+VfDzyCl2uaswoVxDqhGGXWdmdaXkBdgeaEzUWI4gC+pGoR3W0meDm
        aqeIHn3LgBkW2dxmGkim1d2yyA==
X-Google-Smtp-Source: ACHHUZ5kvGC2hn93mlIb6ZW+E9FVsA6MSceqqKR66gjoxU7/dFds2zwbY1SlKYDD2PJoR8QyPj03Ww==
X-Received: by 2002:a05:6870:e282:b0:19f:5c37:ab9d with SMTP id v2-20020a056870e28200b0019f5c37ab9dmr1164399oad.43.1686313816386;
        Fri, 09 Jun 2023 05:30:16 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:643a:b27d:4a69:3b94? ([2804:14d:5c5e:44fb:643a:b27d:4a69:3b94])
        by smtp.gmail.com with ESMTPSA id p14-20020a056870a54e00b0017b21991355sm2052528oal.20.2023.06.09.05.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:30:16 -0700 (PDT)
Message-ID: <ce770d0f-20b4-8040-8625-365758351998@mojatatu.com>
Date:   Fri, 9 Jun 2023 09:30:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net/sched: act_pedit: Use kmemdup() to replace kmalloc +
 memcpy
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jhs@mojatatu.com
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230609070117.100507-1-jiapeng.chong@linux.alibaba.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230609070117.100507-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 04:01, Jiapeng Chong wrote:
> ./net/sched/act_pedit.c:245:21-28: WARNING opportunity for kmemdup.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5478
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

LGTM,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/act_pedit.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index fc945c7e4123..8c4e7fddddbf 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -242,14 +242,12 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
>   	nparms->tcfp_flags = parm->flags;
>   	nparms->tcfp_nkeys = parm->nkeys;
>   
> -	nparms->tcfp_keys = kmalloc(ksize, GFP_KERNEL);
> +	nparms->tcfp_keys = kmemdup(parm->keys, ksize, GFP_KERNEL);
>   	if (!nparms->tcfp_keys) {
>   		ret = -ENOMEM;
>   		goto put_chain;
>   	}
>   
> -	memcpy(nparms->tcfp_keys, parm->keys, ksize);
> -
>   	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
>   		u32 offmask = nparms->tcfp_keys[i].offmask;
>   		u32 cur = nparms->tcfp_keys[i].off;

