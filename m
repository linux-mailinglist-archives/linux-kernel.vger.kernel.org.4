Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12786FB251
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjEHOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjEHOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:12:01 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E126774
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:12:00 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-54cac3ba705so2220024eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683555120; x=1686147120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h773zB7L3Z4YOeGFM9KPDGaeyVeWxA0sAUEnP9BjGoE=;
        b=CDLnus2hjYndcrrc2sdHBBtORtAE00i4C5k9ZdE25vTcxpQE/qmvJKLAo5/2eKGIzQ
         nTf/00fL9cwSjcgyl4FVTSr8S4A3l/Ep7dGPOi/3PFKt2Ur/cLxQuO1rMCjlRpD9cLHI
         3gSDkdSs9Ml3hwjSl2HHA9ogFj99yD9DaImMDi1rNMtBXH4/JUSCFmmOfWRcxtGj2TMi
         8Jy3rnzij55sda6h4wQvtX518daTYiCXJnZ4v9RRV3R70kuv0JY528eYyBMY8MwbAldB
         SS0cOSrLUniwLYSvhyRCLQd4L28jrW7xVFVXFaYDkbEhkDX1qyCpeumA5GfMqbFB/kX9
         c7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683555120; x=1686147120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h773zB7L3Z4YOeGFM9KPDGaeyVeWxA0sAUEnP9BjGoE=;
        b=N2/aEh73xcafSTxlQJK8d6WVaSE8Xk7W04bQnj7zG9BaTf7j5skBzs3G0MeyXLWWFH
         vuyCd78BrqQ150EfpcGiLhZeObifO9SGGHai08IN5SQNFQG6CR7uQouBm9LLSQS1pyNC
         zoi4cDzjVQj0luTggwUPn3qWA19QX7fbzNEVelJXHxEQ7QKqgrC4vKqLWM8VwHj6H9hk
         uIncvWYKi0KeC15oz5N7TiwoBSIAaE1OaTvarwNcWfcsddhQCEgOWjxbyDpb9j708cxE
         5FqHVA5E2fQeoM94EodlZXZp6rxmSgCqaAgaVv8sb1fkBwRuEcprl3ntLuDppJNonRct
         0RWg==
X-Gm-Message-State: AC+VfDw8PHzK5r+mAarUpa4j65+ZbbMomsQ7kCUdS4nxQ4dVWKKOeEVr
        zn8bmuEkfcG0IVXpwLsSEbrSRA==
X-Google-Smtp-Source: ACHHUZ67qRlkLtWr8G9OfppsLqQ2Ov1KWi2/SdSwXWbif3KYd1ifgeDUO4L40YRcsQ7oqc1CoQNPyg==
X-Received: by 2002:a05:6808:317:b0:386:a643:1576 with SMTP id i23-20020a056808031700b00386a6431576mr4903529oie.46.1683555120164;
        Mon, 08 May 2023 07:12:00 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:d672:f891:23e9:e156? ([2804:14d:5c5e:44fb:d672:f891:23e9:e156])
        by smtp.gmail.com with ESMTPSA id k203-20020aca3dd4000000b0039232a8a1a3sm30925oia.13.2023.05.08.07.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 07:11:59 -0700 (PDT)
Message-ID: <58261cfa-7cba-5cc6-92ac-de155a813df7@mojatatu.com>
Date:   Mon, 8 May 2023 11:11:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net 5/6] net/sched: Refactor qdisc_graft() for ingress and
 clsact Qdiscs
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
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
 <1cd15c879d51e38f6b189d41553e67a8a1de0250.1683326865.git.peilin.ye@bytedance.com>
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <1cd15c879d51e38f6b189d41553e67a8a1de0250.1683326865.git.peilin.ye@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 21:15, Peilin Ye wrote:
> Grafting ingress and clsact Qdiscs does not need a for-loop in
> qdisc_graft().  Refactor it.  No functional changes intended.
> 
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Just a FYI:
If you decide to keep this refactoring, it will need to be back ported
together with the subsequent fix.
I would personally leave it to net-next.

Thanks for chasing this!

Tested-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
>   net/sched/sch_api.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 49b9c1bbfdd9..f72a581666a2 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1073,12 +1073,12 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>   
>   	if (parent == NULL) {
>   		unsigned int i, num_q, ingress;
> +		struct netdev_queue *dev_queue;
>   
>   		ingress = 0;
>   		num_q = dev->num_tx_queues;
>   		if ((q && q->flags & TCQ_F_INGRESS) ||
>   		    (new && new->flags & TCQ_F_INGRESS)) {
> -			num_q = 1;
>   			ingress = 1;
>   			if (!dev_ingress_queue(dev)) {
>   				NL_SET_ERR_MSG(extack, "Device does not have an ingress queue");
> @@ -1094,18 +1094,18 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>   		if (new && new->ops->attach && !ingress)
>   			goto skip;
>   
> -		for (i = 0; i < num_q; i++) {
> -			struct netdev_queue *dev_queue = dev_ingress_queue(dev);
> -
> -			if (!ingress)
> +		if (!ingress) {
> +			for (i = 0; i < num_q; i++) {
>   				dev_queue = netdev_get_tx_queue(dev, i);
> +				old = dev_graft_qdisc(dev_queue, new);
>   
> -			old = dev_graft_qdisc(dev_queue, new);
> -			if (new && i > 0)
> -				qdisc_refcount_inc(new);
> -
> -			if (!ingress)
> +				if (new && i > 0)
> +					qdisc_refcount_inc(new);
>   				qdisc_put(old);
> +			}
> +		} else {
> +			dev_queue = dev_ingress_queue(dev);
> +			old = dev_graft_qdisc(dev_queue, new);
>   		}
>   
>   skip:

