Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB064E7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLPHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:36:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F22F02E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:36:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 21so1231792pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2wKHpQ7c6hNVkovO1LmRMdhScVIoAvdc/k0vJiCuUk=;
        b=yMqPMtx3PVSGLA21KWpsgB8BSHlPoqh6lsBn41pwKJzdiVcBP15tfCHmJdezly9wPV
         SOQHYuhZa8o6QafHaZE6olSxTI3qkbBP4TfGS8EOjDJdNwP6o5x7o8cUbO5cciiytbLT
         m36S4AqYN2Rj+XnLHKJwxlMEoHEL5owpZ1D0UtD5KLrPD/cWOX2cJvT2AkzYCCeTdVyi
         AjL09lXXNFMtphTsH/QxEScObbf3fvEC3N299uKynWQSvdxMBbReaZbNlDxx2KLyrSXQ
         1SdOzSW0FIxlpSjyrBOZxKtpb7tLf2HsTqY+mwv04cS0iQcQ1FreQ6iFGSvo1TxWqlNx
         zgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2wKHpQ7c6hNVkovO1LmRMdhScVIoAvdc/k0vJiCuUk=;
        b=5RrijZaOc93vnPNGNgLywsVH6ZLKe3OlwI7pfWiRszlp1jNcSPiXtoRNmSdX4lH6mp
         yY43aM7BtXamO6Dc7OF8bfs8cacI1DFemIUR7oYNsmn5WY+1/Q3kIKu6yY0mGllhq4Gx
         1yvbruPTNWzR1cWOQCjXts957/Qj5K1oJJTmn/HR21n1O8FQPV9UmrTtXO1XYQfePXiE
         OcoH4ScTe84cKvWVHQqLrNAgIdq2+PDY9WXeB58x+D63OM3316r9cEZzg28HfUnwaFVi
         dmkCdCFs9KAtAHdOhtpnfdIWurwEVH9GGV41XlaFRmEu+Iu/gnsMKz0kjzp9gilP8OmR
         dGtQ==
X-Gm-Message-State: ANoB5plMTP8+vY5clr9B0N3yA4fs3B2206HJDlOw5YzJ0CsOgefo4ICP
        lUk+p11YimgwICXGbvF5nyPHiQ==
X-Google-Smtp-Source: AA0mqf7rtgCByp5qACHEz0RzQhRR7ZPXInH+r36E6VXFuicML8kyFnh5B1xi8ZkKS/oT5EuoPhJE/Q==
X-Received: by 2002:a05:6a00:2787:b0:578:8864:7b24 with SMTP id bd7-20020a056a00278700b0057888647b24mr19161121pfb.12.1671176201438;
        Thu, 15 Dec 2022 23:36:41 -0800 (PST)
Received: from [10.255.23.40] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id 84-20020a621757000000b005743cdde1a7sm803264pfx.82.2022.12.15.23.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:36:40 -0800 (PST)
Message-ID: <3ccd31d4-ecb5-16fa-40c0-f7cc2fb9f9f2@bytedance.com>
Date:   Fri, 16 Dec 2022 15:36:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] sched: Reduce rq lock contention in load_balance()
Content-Language: en-US
To:     chenying <chenying.kernel@bytedance.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
 <c086b5fb-681e-d104-1e11-873ed5444c5c@bytedance.com>
 <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <11222824-9a23-0766-70f3-709ab2fc6cc0@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 11:13 AM, chenying wrote:
> [nit]
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..aeb4fa9ac93a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10295,6 +10295,7 @@ static int load_balance(int this_cpu, struct rq 
> *this_rq,
>                  goto out_balanced;
>          }
> 
> +refind:
>          busiest = find_busiest_queue(&env, group);
>          if (!busiest) {
>                  schedstat_inc(sd->lb_nobusyq[idle]);
> @@ -10303,6 +10304,14 @@ static int load_balance(int this_cpu, struct rq 
> *this_rq,
> 
>          WARN_ON_ONCE(busiest == env.dst_rq);
> 
> +       if (READ_ONCE(busiest->balancing)) {
> +               __cpumask_clear_cpu(cpu_of(busiest), cpus);
> +               if (cpumask_intersects(sched_group_span(group), cpus))
> +                       goto refind;
> +
> +               goto out_balanced;
> +       }
> +

Here removing the cpu from @cpus will prevent it being selected once
a redo is triggered due to all tasks on the busiest cpu pinned by cpu
affinity. If that is the case, the removed cpu can still be the busiest
but not in balancing at that moment.

IMHO it'd be better skip the in-balancing cpus in find_busiest_queue()
without modifying @cpus to keep consistence among the redos.

Thanks & Best,
	Abel
