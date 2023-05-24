Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B470FA98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjEXPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbjEXPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:40:53 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4671B8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:40:10 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19a13476ffeso352298fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684942737; x=1687534737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXUt/ydD2q4pGzaniA+mmW+0t+wCIp9nemsCnmX6WJM=;
        b=ApkFE7FQIqtU+VA+oa0mvicWOFz/g4CGP4NH6NMNWbCDVr+9O9kRrzWFriVrJd7zN4
         IAa/GNxjZY9eimkVY+MHM1PnSo0NYuYj7N2udCRiav67WP4FdDNlkvCZTHnJ9pwW4ONr
         3Rbhx2fO7KadJ/BY1wPyOJ+NtdL1nhNNvdlR/JUeCbfrYPdfuEwNXOc3AyHB/Gi+qAIP
         yZFv3tPh7JpGq+SiUkoshP/k1qT+sOEUBPdUb/nRS8FK21d4zv4SiF6GHknM1Z+ZyRf8
         GBER3kRXY6k/leyJslNXHqViYQsPmyEcF/PHZHPy+9/MitL6NfOcQc9iaA61ThziQS6G
         MDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942737; x=1687534737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXUt/ydD2q4pGzaniA+mmW+0t+wCIp9nemsCnmX6WJM=;
        b=T+CzBtmeVKYh8W5zNhUqh9+AtD/7hfd76p/dHy5xZ0CW/jq22M9Ppi9BXL/U+aP5/d
         UCdYwI4yIlsrZSPTVLfKU2912FnyFnZvq8DyAS6nAAt8R8JdhlMvNAgxufhBOgdW0q7U
         TxQZ/6++oId0/a25DpVqhn+Sh/Uphw2XfUOVPUqnGA8N/rHePZxpNxw18+Qa4htwL8pt
         BjgOfxvrre1ZToN1pRPvQAD9Nd5lJfdldpzFMXYuixFmk8AidjPiWq0+4u0i2YMG2mpT
         UTXyO76Cb33h8YjIIii/QFSjfsFI5uuI80awlPxdpkN0JDxwpYaFzEXyEWoLb86ZNC2Z
         8S/Q==
X-Gm-Message-State: AC+VfDyYBAHQC8E/F9eHgX2FMjn+YeUDX2pebAPt/d/EdDsdCsnlE2VY
        gxoLvIReunxasP8BbJOPvtb78Q==
X-Google-Smtp-Source: ACHHUZ5qtv6wn5gvW7KsUlCuOFdPOiCezYd0GSkwBzr7dnEIQHsZczZ1YnlS7/iO4LKIicpwTG9ygQ==
X-Received: by 2002:a05:6870:c803:b0:196:7dec:dbd7 with SMTP id ee3-20020a056870c80300b001967decdbd7mr116390oab.3.1684942737273;
        Wed, 24 May 2023 08:38:57 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id e21-20020a056871045500b0017243edbe5bsm23381oag.58.2023.05.24.08.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:38:57 -0700 (PDT)
Message-ID: <9b58d882-743a-c392-0407-17bb0b075516@mojatatu.com>
Date:   Wed, 24 May 2023 12:38:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 net 4/6] net/sched: Prohibit regrafting ingress or
 clsact Qdiscs
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
 <81628172b6ffe1dee6dbe4a829753e0d97f61a48.1684887977.git.peilin.ye@bytedance.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <81628172b6ffe1dee6dbe4a829753e0d97f61a48.1684887977.git.peilin.ye@bytedance.com>
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

On 23/05/2023 22:19, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> Currently, after creating an ingress (or clsact) Qdisc and grafting it
> under TC_H_INGRESS (TC_H_CLSACT), it is possible to graft it again under
> e.g. a TBF Qdisc:
> 
>    $ ip link add ifb0 type ifb
>    $ tc qdisc add dev ifb0 handle 1: root tbf rate 20kbit buffer 1600 limit 3000
>    $ tc qdisc add dev ifb0 clsact
>    $ tc qdisc link dev ifb0 handle ffff: parent 1:1
>    $ tc qdisc show dev ifb0
>    qdisc tbf 1: root refcnt 2 rate 20Kbit burst 1600b lat 560.0ms
>    qdisc clsact ffff: parent ffff:fff1 refcnt 2
>                                        ^^^^^^^^
> 
> clsact's refcount has increased: it is now grafted under both
> TC_H_CLSACT and 1:1.
> 
> ingress and clsact Qdiscs should only be used under TC_H_INGRESS
> (TC_H_CLSACT).  Prohibit regrafting them.
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
>   net/sched/sch_api.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 383195955b7d..49b9c1bbfdd9 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1596,6 +1596,11 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>   					NL_SET_ERR_MSG(extack, "Invalid qdisc name");
>   					return -EINVAL;
>   				}
> +				if (q->flags & TCQ_F_INGRESS) {
> +					NL_SET_ERR_MSG(extack,
> +						       "Cannot regraft ingress or clsact Qdiscs");
> +					return -EINVAL;
> +				}
>   				if (q == p ||
>   				    (p && check_loop(q, p, 0))) {
>   					NL_SET_ERR_MSG(extack, "Qdisc parent/child loop detected");

