Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05170FAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjEXPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjEXPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:45:14 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB624122
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:44:43 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-19a1ac5e200so352205fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684942716; x=1687534716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/ppkpENWcAM2YaAiOwl78Q5PwDi6yPB7kGLx5lgWC0=;
        b=YKYNsFoG8Wit3uSQWCwDPTvtDyYSeIHUuTNLWxJRYwAXMA3aQHWLVXK+bvWRmBYq6i
         bFUG7MXoiV3IPyUFCQ5dHX1A7fseMjo+AjJpwSGMxFBsTzqu+GEVlcKPAHp0XfxSX/8X
         AwC/rbnk+/bhvdN8s2WMXeUX6pG+hhmmKUclkmtu/hp++WmWnGeZqjdAbrtPVBSl+Bb+
         b/4HjDySUxns7TyUwvgt45nbRfLnnzVqF6nBYerF2tHtCzA2mrmG18OXqcD3wRBoF6pF
         yevwkCsfL8FrJeLPOYSsa3HzxJ2A2tVO4w7mSSjrkVHL6WiDUN4nL7Jmka8LZ7ag2zXV
         v4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942716; x=1687534716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/ppkpENWcAM2YaAiOwl78Q5PwDi6yPB7kGLx5lgWC0=;
        b=d0/X4ZaPBT/fvdBZpxt8i83C3uCkIylguyKBqG+umHB0vKguKb+epCC/9b3WVdJgIv
         ZVe0uXJc016sEPQRq1JR6z7w0Do2UU4bcv6hKhtPZbHJaRCn1ln1xGAa41mGROGI4Hzo
         T6W1c+wzczfZ03YWCww3joEdrkmOrk2QAbY/kFjwYnYkZVz1Gi8JNIAezqOe9AXrJ9Hl
         LaU0YXntU3upal+oyQE5w2lVmAy1y2Ydwm/TVDiQjp8E1Tq/QpCxO6UEOXdOhWZmoKTh
         a+WZDQX35XF6uJ7FaJidGDXFqv1S8kU3+lCbvy6SAMzX0u7MeGtW7XI5gGIGgxIAHPCo
         RE5w==
X-Gm-Message-State: AC+VfDz+28SSM7iCMJl92XZHdLnsQratgVYYppoIheK+iQ0/S322aJ4b
        URBe8FP/pQAXvRVXwBgLjzJq4Q==
X-Google-Smtp-Source: ACHHUZ54hLmFKrmhtIqtP7jh0bDmCZ/yfLikTzhBiGoczpmAdK64KdP/f7xcb9EzxGChNgqdGZoVcw==
X-Received: by 2002:a05:6870:d07:b0:192:c5a5:ef44 with SMTP id mk7-20020a0568700d0700b00192c5a5ef44mr76357oab.45.1684942716636;
        Wed, 24 May 2023 08:38:36 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id y21-20020a056870429500b0019280078be5sm56596oah.6.2023.05.24.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:38:36 -0700 (PDT)
Message-ID: <2e52ec76-d5e2-b085-f8d6-79ed514f3709@mojatatu.com>
Date:   Wed, 24 May 2023 12:38:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 net 3/6] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT)
 for ingress (clsact) Qdiscs
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
 <9815766bb41f8413d90c14936974a528870044fa.1684887977.git.peilin.ye@bytedance.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <9815766bb41f8413d90c14936974a528870044fa.1684887977.git.peilin.ye@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 22:19, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> Currently it is possible to add e.g. an HTB Qdisc under ffff:fff1
> (TC_H_INGRESS, TC_H_CLSACT):
> 
>    $ ip link add name ifb0 type ifb
>    $ tc qdisc add dev ifb0 parent ffff:fff1 htb
>    $ tc qdisc add dev ifb0 clsact
>    Error: Exclusivity flag on, cannot modify.
>    $ drgn
>    ...
>    >>> ifb0 = netdev_get_by_name(prog, "ifb0")
>    >>> qdisc = ifb0.ingress_queue.qdisc_sleeping
>    >>> print(qdisc.ops.id.string_().decode())
>    htb
>    >>> qdisc.flags.value_() # TCQ_F_INGRESS
>    2
> 
> Only allow ingress and clsact Qdiscs under ffff:fff1.  Return -EINVAL
> for everything else.  Make TCQ_F_INGRESS a static flag of ingress and
> clsact Qdiscs.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Tested-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
> change in v3, v4:
>    - add in-body From: tag
> 
>   net/sched/sch_api.c     | 7 ++++++-
>   net/sched/sch_ingress.c | 4 ++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index fdb8f429333d..383195955b7d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1252,7 +1252,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>   	sch->parent = parent;
>   
>   	if (handle == TC_H_INGRESS) {
> -		sch->flags |= TCQ_F_INGRESS;
> +		if (!(sch->flags & TCQ_F_INGRESS)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Specified parent ID is reserved for ingress and clsact Qdiscs");
> +			err = -EINVAL;
> +			goto err_out3;
> +		}
>   		handle = TC_H_MAKE(TC_H_INGRESS, 0);
>   	} else {
>   		if (handle == 0) {
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index 35963929e117..e43a45499372 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -140,7 +140,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
>   	.cl_ops			=	&ingress_class_ops,
>   	.id			=	"ingress",
>   	.priv_size		=	sizeof(struct ingress_sched_data),
> -	.static_flags		=	TCQ_F_CPUSTATS,
> +	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
>   	.init			=	ingress_init,
>   	.destroy		=	ingress_destroy,
>   	.dump			=	ingress_dump,
> @@ -281,7 +281,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
>   	.cl_ops			=	&clsact_class_ops,
>   	.id			=	"clsact",
>   	.priv_size		=	sizeof(struct clsact_sched_data),
> -	.static_flags		=	TCQ_F_CPUSTATS,
> +	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
>   	.init			=	clsact_init,
>   	.destroy		=	clsact_destroy,
>   	.dump			=	ingress_dump,

