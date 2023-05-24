Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A770FA94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjEXPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjEXPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:40:11 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4A1701
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:39:23 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1967cd396a1so295725fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684942693; x=1687534693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vr8uCO2pIAbrA9U96g+r92G07hF9QBrSlMFZYQ43XME=;
        b=EoSFSw98b231ljQgiJ350x5qoL4tRR/YjcUt1vm/e6JJOgrc8OAR9KPrRJhsG0z7rV
         D+8Ah+Yv+ZiXsqdYEECXbtkOqp76fxMokSrGJndjuEzOvHwrNyRtX/js3AdC45D7Axit
         CncXKIz9ayB3x5kN7iWzN+wDhlyn2jlefIoDh41qwjc4Ss1pAW4lpTcMzf+bxXNKwJpV
         lgdg9RfHJEaZvFwjH02Lbjr9adVpftXXjFTLR1WklJNxLXtBd31rzQG+69zB2f5ttF/d
         UQ9kh4foQhkPvjTK4RsyhLP7AN4J48hi2U61Gem2C7NM4uckXLQ0QDmoNdFDbrXYTo3f
         ERAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942693; x=1687534693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr8uCO2pIAbrA9U96g+r92G07hF9QBrSlMFZYQ43XME=;
        b=RiTDwj5vubjMfKZ+BYd5vQX3xVydW/mfxx9Ml71TRKGLaX0qCkDCeN3KqZ7gbCMbKk
         KpSppOvkvfr2wlVgtZ9YHOH7Ncsz7ZbTJM9Oh9y0tr5uCDFCqjxOxYh8ZvfeTVWlGMvK
         XwpOXb9sLSItXKP33Y5sEUgieBZBvE7RQX83YB6Uf3d5WX3z/QvmwiuOLYuLg1YKjdha
         xwQMC8E1kUKRJbXzVI4k6s1bk8cPRD4YvO8SfmYkKN5gLUno/b+o1HxbHqM/BRXeq4+x
         W4JFNd7KNifjEBaGXSMP0+tSrKCbiyiI4w7fl1eAeVR/g5ykOtf2bsX/RFesUFXB5Oju
         o8/A==
X-Gm-Message-State: AC+VfDzK9Wbluy1Ff9UU7ebfrn19Rbf5rgOEOXaKIrspc9FdRtnWAoTj
        8zwOnAtEJShRe4Ufrr5MlEpsPg==
X-Google-Smtp-Source: ACHHUZ7YzpgA/A3liP5vN/6UOehV4zB4M/eC5z+Tuzi8pVtI0+XkBPw4wgNkU6jAyL8f9PHw+1saTg==
X-Received: by 2002:a05:6870:7343:b0:192:597c:1c17 with SMTP id r3-20020a056870734300b00192597c1c17mr162453oal.7.1684942693571;
        Wed, 24 May 2023 08:38:13 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id r18-20020a05683001d200b006af7580c84csm3599958ota.60.2023.05.24.08.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:38:13 -0700 (PDT)
Message-ID: <5fda8703-9220-4abd-7859-0af973d0d1d7@mojatatu.com>
Date:   Wed, 24 May 2023 12:38:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 net 2/6] net/sched: sch_clsact: Only create under
 TC_H_CLSACT
Content-Language: en-US
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
References: <cover.1684887977.git.peilin.ye@bytedance.com>
 <0c07bd5b72c67a2edf126cd2c6a9daadddb3ca95.1684887977.git.peilin.ye@bytedance.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <0c07bd5b72c67a2edf126cd2c6a9daadddb3ca95.1684887977.git.peilin.ye@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 22:18, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> clsact Qdiscs are only supposed to be created under TC_H_CLSACT (which
> equals TC_H_INGRESS).  Return -EOPNOTSUPP if 'parent' is not
> TC_H_CLSACT.
> 
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Tested-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
> change in v5:
>    - avoid underflowing @egress_needed_key in ->destroy(), reported by
>      Pedro
> 
> change in v3, v4:
>    - add in-body From: tag
> 
>   net/sched/sch_ingress.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index f9ef6deb2770..35963929e117 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -225,6 +225,9 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
>   	struct net_device *dev = qdisc_dev(sch);
>   	int err;
>   
> +	if (sch->parent != TC_H_CLSACT)
> +		return -EOPNOTSUPP;
> +
>   	net_inc_ingress_queue();
>   	net_inc_egress_queue();
>   
> @@ -254,6 +257,9 @@ static void clsact_destroy(struct Qdisc *sch)
>   {
>   	struct clsact_sched_data *q = qdisc_priv(sch);
>   
> +	if (sch->parent != TC_H_CLSACT)
> +		return;
> +
>   	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
>   	tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
>   

