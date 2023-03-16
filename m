Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140CE6BCF79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCPM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCPM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:28:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E99BE5DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:28:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so7003305edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678969700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuzDwg2lxu1rtYjhTSBJYtTkaTQvz0mwPxYBQwYy20g=;
        b=vxJm/pF8sewwUszKYiDSfHTVUwBSWICc5MH1RuCN+eYfHnhXBErovQZaEhRLWS2t0S
         oBnoKqECgFj7mYaG6pAolJe3JfDkDB8qgSMH5JXts1MtsUk9viXtPl9+co+SOTeSgADk
         FCOT+Dh4PTlzam28dIfSNtv0/5uEeIUZgLqeBoHLlcX0cBZ73lwHvyXp/6dx53dwvg3S
         hNaRx9B+h6dya1kb6FGh7wD4M3nwdX18E3bQlcBVHZyFqZyEzHuTVqp16BbQ+iAXxp20
         wuPhDagD3QqBtUJXlc7DgijZkhcoazfyQxfNDytWOUe2Wlpdu1zjgW18qED2nc7651ia
         WXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuzDwg2lxu1rtYjhTSBJYtTkaTQvz0mwPxYBQwYy20g=;
        b=4G5/JbHnGHU+jFFi6Hmq+L7CSnshqDfTRWF8biVLyEkHdTTumZJH3yDe0LzwrX/EI6
         0p8JIpsxNRYcvGMAlIR5Mxc67m+giFJZhD8FpmIvzClqvPHIJTEpLf0PVlxnPJWjG3gv
         k+nhsrWl6GqzlTFmDdrCDPv/xq+ih+vAhi0LOFQw6MhioeRvBT/YuVO3mNLF+Xm03VZc
         4hDTFxtcxtsM5nFvSP1Pb9nluQC6sF+aeyAS5wS+HIaDOe6nwyft10rpnWnBo4Vu0Kat
         7AlZUVuAuP3o7Zjsgrw99nm0/Qpjv0zfJ6rZExNqqFDR4b7p+2f0A2oRZLNOeAboUCou
         Lweg==
X-Gm-Message-State: AO0yUKWJLQOlvnzZcBbgpfwLuHDAn7kgZfVvFf/Hk5uNpWQwAZcHcKMe
        GaIHklrpmCjukDly6cqZHrNCkA==
X-Google-Smtp-Source: AK7set8sb9Pt47A8F5UHMhUTeEFJy8nZDAA2FIy5bTWmk2ssc26ydb1AH4xupqEGnvo0UKQ1P6AZIQ==
X-Received: by 2002:a17:906:4a09:b0:8b1:7de6:e292 with SMTP id w9-20020a1709064a0900b008b17de6e292mr9717493eju.9.1678969700160;
        Thu, 16 Mar 2023 05:28:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709063ed400b008d1693c212csm3762281ejj.8.2023.03.16.05.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 05:28:19 -0700 (PDT)
Message-ID: <01d18b05-238f-e938-9ad0-ff1956cb361d@linaro.org>
Date:   Thu, 16 Mar 2023 13:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/2023 17:49, Krzysztof Kozlowski wrote:
> Qualcomm cpufreq driver configures interrupts with affinity to each
> cluster, e.g.  dcvsh-irq-0, dcvsh-irq-4 and dcvsh-irq-7 on SM8250.
> Triggered interrupt will schedule delayed work, but, since workqueue
> prefers local CPUs, it might get executed on a CPU dedicated to realtime
> tasks causing unexpected latencies in realtime workload.
> 
> Use unbound workqueue for such case.  This might come with performance
> or energy penalty, e.g. because of cache miss or when other CPU is
> sleeping.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-

Let me also paste impact of this patch - rtla osnoise on entirely idle
system (cores 2-7 isolated for Realtime):

BEFORE:
       osnoise/7-2967    [007] d..h2..  3937.898311: irq_noise: dcvsh-irq-7:179 start 3937.898310871 duration 104 ns
 irq/179-dcvsh-i-343     [007] d..h2..  3937.898318: irq_noise: IPI:6 start 3937.898317537 duration 104 ns
 irq/179-dcvsh-i-343     [007] d...3..  3937.898321: thread_noise: irq/179-dcvsh-i:343 start 3937.898316287 duration 4740 ns
     kworker/7:0-85      [007] d..h2..  3937.898323: irq_noise: IPI:6 start 3937.898322381 duration 104 ns
     kworker/7:0-85      [007] d...3..  3937.898343: thread_noise: kworker/7:0:85 start 3937.898321339 duration 20990 ns
       osnoise/7-2967    [007] .......  3937.898343: sample_threshold: start 3937.898308475 duration 34531 ns interference 5

Noise duration: 34 us

AFTER:
       osnoise/7-2637    [007] d..h2..   530.563819: irq_noise: dcvsh-irq-7:178 start 530.563817139 duration 260 ns
       osnoise/7-2637    [007] d..h2..   530.563827: irq_noise: IPI:6 start 530.563826670 duration 156 ns
       osnoise/7-2637    [007] .......   530.563828: sample_threshold: start 530.563814587 duration 12864 ns interference 2

Noise duration: 13 us

Best regards,
Krzysztof

