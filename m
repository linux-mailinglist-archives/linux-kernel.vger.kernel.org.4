Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25185720CCD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjFCBH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjFCBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:07:24 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A583E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:07:23 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19f268b1d83so2369344fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685754443; x=1688346443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rk7MwmJT/RKA/8bT+bq8NZnYWiepDXUZ2WOSbM/67Kc=;
        b=ADa1mYnLZvLryRogdbm5xyDYJs2pS+VRy56cK1FxOIKK+fBdvPkKqg8vexxL+PScO9
         QgYXX86s8PyQoOt0tPg2a9JvNESv/Gm0NnrbngpRSpWS3Ggn/Se4k6+WYvOGtppz9q8T
         CBw0Y1m2Kf/2NbCtO93ERx0/U2t9k20iN7LjT/fcQhiFRotb0wWznGHqPlPiy2yyiBsd
         CpgNepcR5OGfydVYh+pketrWFwCO3Xp4AHArCad7FyhNoRu2QW2h4mw3YSpAKZe79a2b
         8vuwiMYH7pkAqUzywPz8qFY+H8ArljV91J9MuL09DCpP6GxsIuKpYsVH172Dc39rY2T8
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754443; x=1688346443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk7MwmJT/RKA/8bT+bq8NZnYWiepDXUZ2WOSbM/67Kc=;
        b=QFdxM2ytpqMWM8ynnNhSds0Y3MCQ/9mE89hvAPU0c22ozlGi3uh+SdWyDrOGvXqmka
         YvLDhK1aOueW2FInkOrg/A7r/qvHJclVDzUXHWENlVZXjeuoHUxWSQxdoXNOSgTMe+7B
         Z0MoWicLkkIawMrxYZSxnryGCN21N5wUpbkCawlL1iZXM3MJNysXn5EVgSxehYsbFLOm
         xtOaZh+xE3UcGQIv3stt9s767nZI8EYhznpq66DBb78tuyV+g4LrAFnS0IA0Wbdc6odI
         0NmBQRlxxM8n/EB+Ah2Z4xAXo/BSM05N4POEQLXTf9NJtmxs8bF5szVJNnr4BJ80z9CJ
         kdtw==
X-Gm-Message-State: AC+VfDxw+WOWzrQozZswElmB66zPaJEFVjNOKa5E5IVBxIFydJtYo7Je
        El7S2UEYfSeDY6UGiubdtPRNkQ==
X-Google-Smtp-Source: ACHHUZ6Yvio28iRnqPnF69blx9B4/zfV/5T1FwL2B2HB6lmmwNJlkz1rTQ2cVgloksdkBkeYyNzpEg==
X-Received: by 2002:a05:6808:298:b0:398:41b4:5b2 with SMTP id z24-20020a056808029800b0039841b405b2mr1316618oic.23.1685754442897;
        Fri, 02 Jun 2023 18:07:22 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:643c:5e1a:4c7c:c5cd? ([2804:14d:5c5e:44fb:643c:5e1a:4c7c:c5cd])
        by smtp.gmail.com with ESMTPSA id s4-20020acadb04000000b003982a8a1e3fsm1151483oig.51.2023.06.02.18.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 18:07:22 -0700 (PDT)
Message-ID: <28802979-d237-1c9c-ad05-10aaa8f46b48@mojatatu.com>
Date:   Fri, 2 Jun 2023 22:07:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602235210.91262-1-minhuadotchen@gmail.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230602235210.91262-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 20:52, Min-Hua Chen wrote:
> This patch fixes the following sparse warning:
> 
> net/sched/sch_api.c:2305:1: sparse: warning: symbol 'tc_skip_wrapper' was not declared. Should it be static?
> 
> No functional change intended.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

LGTM,

Acked-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/sch_api.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 014209b1dd58..9ea51812b9cf 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -2302,7 +2302,9 @@ static struct pernet_operations psched_net_ops = {
>   	.exit = psched_net_exit,
>   };
>   
> +#if IS_ENABLED(CONFIG_RETPOLINE)
>   DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
> +#endif
>   
>   static int __init pktsched_init(void)
>   {

