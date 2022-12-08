Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2C646B80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiLHJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiLHJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:08:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB74B775
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:07:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4037346pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAAXRXPDf8By1YBPFI9GoJQjrKKS1JFL4TS12ITW2AA=;
        b=L2aZ681VQn0PT/5g4s+wvARgOx7f69+jSd9jFqblkrKTpSc6ASwygnzE1TpNCW4jEd
         a0alh9tWpcWx9x83KWAAxkftHfzQv2p8ggpRJZKI/nnStWMj2muCaAa3lTL2Wibx4a1L
         PKmX0djGN/IWzPWiMnNdtc5wD6w5Rl8RK+uG4F0FB5splcZwj2STOehPRQmvWUDmBoGF
         WLk+1O+FHTFyu7RWcUrart1iPs1VwxZr9MAMN4U5T5IGxKdYaDmvz1urxm8U48JbawDK
         u/Hr1FxsUc6EITZkU+OG2IBh9oYIUxk78bvuPQMmAad60nCzoxEFA5dBHbRQTkKnIzW/
         WfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAAXRXPDf8By1YBPFI9GoJQjrKKS1JFL4TS12ITW2AA=;
        b=3NO4avuxH936mwxxWNPfn0A6hn9sF842T1oI0gp1n6Td3U9sk/2zlquyP5H74AQwSF
         pr2AV7wfnTOjuGHggXBqRZEXjZn3Gd/rV2YjiPnYMxoI3sge72hmpK4qI41oP/PWRxSQ
         na6cJ/vmxYekUqYptL6EWY1bS5snm5RAjt0dfIU7Uod2LpPRnXhUCNF2m741CHalAW8P
         EMiG7ppD9J9PGnxxztWlur9FxZhTrv8DVa0CF5OJYFYJMDARLzjh0MmDWYHaXLenkSVE
         cvHUjSL7RDDo7aUFm8j4JyrqfS9zTt8VZlMKMYzkD0nxw79yeE+5NM705NMQSyx+n9At
         OYXQ==
X-Gm-Message-State: ANoB5pknU8XMoiAAbe6i3vVfm70/1lB44K1RItBVdcPwz44sy5jmkrCG
        VFwmDDA1QcU2S+XzFCB10mnWPQ==
X-Google-Smtp-Source: AA0mqf4XnDelqKwHk+AlhrqP3sZga8kbmJgxknbqEAaViROY98UPY+OA9VhA/lfjDQYc47g2y2ik4Q==
X-Received: by 2002:a17:90b:19c2:b0:21c:6ee5:3b83 with SMTP id nm2-20020a17090b19c200b0021c6ee53b83mr573445pjb.93.1670490477947;
        Thu, 08 Dec 2022 01:07:57 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b00189947bd9f7sm16152303plg.50.2022.12.08.01.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:07:57 -0800 (PST)
Message-ID: <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
Date:   Thu, 8 Dec 2022 17:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] Reduce rq lock contention in load_balance()
To:     chenying <chenying.kernel@bytedance.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On 11/24/22 5:07 PM, chenying wrote:
> ...
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a4a20046e586..384690bda8c3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -954,6 +954,7 @@ struct balance_callback {
>   struct rq {
>       /* runqueue lock: */
>       raw_spinlock_t        __lock;
> +    raw_spinlock_t          lb_lock;

Do we really need a new lock for doing this? I may suggest the
following:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 87522c3de7b2..30d84e066a9a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1048,6 +1048,7 @@ struct rq {

         struct balance_callback *balance_callback;

+       unsigned char           balancing;
         unsigned char           nohz_idle_balance;
         unsigned char           idle_balance;

and skip in-balancing runqueues early when find_busiest_queue().

Thanks,
	Abel

> 
>       /*
>        * nr_running and cpu_load should be in the same cacheline because
