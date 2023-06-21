Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB3737D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFUIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFUITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:19:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E504E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:19:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b52bf6e669so44734945ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687335560; x=1689927560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+CYALYzQDXvqMPvtw6uPuTYLekByerqiSVSktdHeb4=;
        b=izyOLaM9zix678sSQEOewGPNpBh15GH9Jx+6vtxpEAOmSFNGNl3jXVJjU8mfPTADmW
         aVEEhJbSvB4AQaqZeOrlBIG/XCy3uByhm2Lpo0F+DWElJvOdm1FxsKt60Irt+iyEnwmw
         kKaTdsSl35RSMUlL7q5oZ4VfkLSsuNAwz1iGvu3ARYLHLM8VNAx3IYLd+grEZnCNQN18
         k119nJ9JWtjfSeUtuXtsqRbYLzSAaLRxe0wxI3ThHzXLU8Ck5K9AP2UKjgrB5KC00HBr
         M6CFD8zQoUfd2aofaLuRojX+1Db0Uonjxj7cfixNqgWL00WMOi3DXpURDSNmU9UEevUU
         JZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335560; x=1689927560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+CYALYzQDXvqMPvtw6uPuTYLekByerqiSVSktdHeb4=;
        b=FriHeBJkThxvuCjVhlgg3amrHCURYmN0Kupqe2DAlFr3roRXP3aJ/+foT9+G+rzKyN
         MoPE3EDRcNQ3ywjSEF/CH/o1Os/qgEFW1RsAft1TMP8AfQacQqFyKrxKVLM/IVLEu0T5
         v1szsx4g0BHskYO/xCFszvfeEKYXrfpuo3L415NVqRqO3KkLpioqp36CEpSoIee8MevK
         i8mINYMfqTExdZL+3mEfy7/095lRNsBNE8ASnQT8h/U/mQGefZx9sQratjePnTWve+NC
         bj4qjk4qcGTLBygn+nSNvsenSzSKMsPVUAZvqbeN3xarqTW2Ka3PcL2pMUcLEzE0xDTm
         GLXg==
X-Gm-Message-State: AC+VfDybjS+Szxro6xb8SbHS+fyNhw9XPYJQ6zXSJLFaeMU/d/OZmkjg
        9QsNuqh44O3B28O57Eqjv8kk4w==
X-Google-Smtp-Source: ACHHUZ6aF94ZxWAXdZiGX6W4CoYZts6f4sdsu+CqWgVSXvnhIg6xloBKnzgyp5x1u6c8P03ww6yNbg==
X-Received: by 2002:a17:902:ea01:b0:1b5:2ca9:f714 with SMTP id s1-20020a170902ea0100b001b52ca9f714mr18932770plg.6.1687335559798;
        Wed, 21 Jun 2023 01:19:19 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11bb:1457:9302:1528:c8f4? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001b19d14a3d5sm2878600plb.68.2023.06.21.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:19:19 -0700 (PDT)
Message-ID: <7233c25b-d20c-2c65-295e-ebfc5520fda4@bytedance.com>
Date:   Wed, 21 Jun 2023 16:19:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] sched/topology: fix potential memoryleak in
 sched_init_numa()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230621063817.3753617-1-linmiaohe@huawei.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230621063817.3753617-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 2:38 PM, Miaohe Lin wrote:
> When sched_init_numa() fails to allocate enough memory for sched domains
> numa masks, it forgot to free the allocated memory leading to memoryleak.
> Add a helper to help release the resource.
> 
> Fixes: cb83b629bae0 ("sched/numa: Rewrite the CONFIG_NUMA sched domain support")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/sched/topology.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 290509383419..dcec4d653ae3 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1807,6 +1807,20 @@ static void init_numa_topology_type(int offline_node)
>   
>   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>   
> +static void sched_free_numa_mask(struct cpumask ***masks, int nr_levels)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < nr_levels; i++) {
> +		if (!masks[i])
> +			continue;
> +		for_each_node(j)
> +			kfree(masks[i][j]);
> +		kfree(masks[i]);
> +	}
> +	kfree(masks);
> +}
> +
>   void sched_init_numa(int offline_node)
>   {
>   	struct sched_domain_topology_level *tl;
> @@ -1886,15 +1900,19 @@ void sched_init_numa(int offline_node)
>   	 */
>   	for (i = 0; i < nr_levels; i++) {
>   		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
> -		if (!masks[i])
> +		if (!masks[i]) {
> +			sched_free_numa_mask(masks, nr_levels);
>   			return;
> +		}
>   
>   		for_each_cpu_node_but(j, offline_node) {
>   			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
>   			int k;
>   
> -			if (!mask)
> +			if (!mask) {
> +				sched_free_numa_mask(masks, nr_levels);
>   				return;
> +			}
>   
>   			masks[i][j] = mask;
>   

Allocation can also fail in @tl (topology level), and if that is the
case, masks[][] IMHO also needs be freed. So I think it might be better
if call sched_reset_numa() at proper place.
