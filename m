Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F8970FA96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjEXPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjEXPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:40:40 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA31B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:40:00 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-54f5fdaa693so3908578eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684942670; x=1687534670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiwwEzM2zwzPOa0pdz6xPz0Iuhy4Xj5GAVQ6YsEKRa0=;
        b=SvfQUi+wwYC8xlmq/aEKWGu0h1p5eNZtxMaLUMAJoBAyvl3VgLXiZyUIbQoa4FU3rB
         eFZaU8tUJnggJoWG2AGPlmZz3SR+M7jXynI1vK5xY6XWDBU0uytWAM/jLY8hwdfos96p
         WYmrGcmKaBmVrfklw1Q4Bkp3+IJu4ukX3ZkOgv/iQt68GNqHRaes2eHiaFHPAo1KfU8Z
         xUtgpB6lleE3fp1gLwMUHxvjEygoINNdQyJroJ3Q14rYMuRT0DKBhkFZkv9aPhK3I6gI
         rRV+xIkTpgHxvrP37o37QvPBBJWbO3dqRJk6QhZPerXgzlB/qwJWtkKOaTXIVBvXOoIs
         UODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942670; x=1687534670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiwwEzM2zwzPOa0pdz6xPz0Iuhy4Xj5GAVQ6YsEKRa0=;
        b=FgYOqI3RctCJb8cW4E5Mo+gghsC2KC1DRyLoFF/MloDfuDNM9RIU/vjC+Af8tiIUjX
         q8CdCgFNde9UxBvIb/vIaiUnsZfj5m0YfCCkHnhPPgCROcM1/0dCR2qRsPo3z8VAACI1
         CU9oiFJIj3wNH6yqJUah9AN7bUA6GTaL5wemGusxlJiIn9vOcU6Ayb0QSM51W/xEc2LM
         IAobOy0UcY9PNAcAQWdGkxcHO2YTPMdYMmdhYq1wj7Cr6HvnE9XjZQRpoPA92q8jYTfw
         lauOB74of8MB/LC1e4UBVpAeR+gnkOSHdziT/f8PE+xiVcVYm0uPMizE9jdx2QGJt1nH
         yhqw==
X-Gm-Message-State: AC+VfDxWuvwzUuRnUHsk1HwR9xjne9HdYxW9CTyugAzlNkvgj+cIXWfP
        pXk9NR95QVO1HbXuecGUkP7oyQ==
X-Google-Smtp-Source: ACHHUZ7lQhfwy/GTTooW+vutbJghj2N0BwAcdPNN2blNsQcLRkIgxuJpMGelWZNCNZSVpSGxVD9rXg==
X-Received: by 2002:a05:6808:5da:b0:398:1304:5bf0 with SMTP id d26-20020a05680805da00b0039813045bf0mr4328839oij.10.1684942670007;
        Wed, 24 May 2023 08:37:50 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id bh24-20020a056808181800b0038eeba6fce1sm5003983oib.55.2023.05.24.08.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:37:49 -0700 (PDT)
Message-ID: <f261171c-7915-fc0d-84f1-4d7827c43119@mojatatu.com>
Date:   Wed, 24 May 2023 12:37:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 net 1/6] net/sched: sch_ingress: Only create under
 TC_H_INGRESS
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
 <b0dcc6677248210348f08d9cb4e93013e7c95262.1684887977.git.peilin.ye@bytedance.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <b0dcc6677248210348f08d9cb4e93013e7c95262.1684887977.git.peilin.ye@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 22:17, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> ingress Qdiscs are only supposed to be created under TC_H_INGRESS.
> Return -EOPNOTSUPP if 'parent' is not TC_H_INGRESS, similar to
> mq_init().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/0000000000006cf87705f79acf1a@google.com/
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Tested-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
> change in v5:
>    - avoid underflowing @ingress_needed_key in ->destroy(), reported by
>      Pedro
> 
> change in v3, v4:
>    - add in-body From: tag
> 
>   net/sched/sch_ingress.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index 84838128b9c5..f9ef6deb2770 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -80,6 +80,9 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
>   	struct net_device *dev = qdisc_dev(sch);
>   	int err;
>   
> +	if (sch->parent != TC_H_INGRESS)
> +		return -EOPNOTSUPP;
> +
>   	net_inc_ingress_queue();
>   
>   	mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
> @@ -101,6 +104,9 @@ static void ingress_destroy(struct Qdisc *sch)
>   {
>   	struct ingress_sched_data *q = qdisc_priv(sch);
>   
> +	if (sch->parent != TC_H_INGRESS)
> +		return;
> +
>   	tcf_block_put_ext(q->block, sch, &q->block_info);
>   	net_dec_ingress_queue();
>   }

