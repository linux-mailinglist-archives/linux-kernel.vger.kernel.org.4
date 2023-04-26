Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F366EF333
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbjDZLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:17:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66904C2B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:17:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-956ff2399c9so1223114466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682507871; x=1685099871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxQuLZs6VUG8DpI09bWh9yeX27W6w8sopJ24aeCFPtU=;
        b=sUbXKGPBuQ7TNxlSfPQ2qLXwB7OG9Y/ejU9bAyJcr5M8DgbpPZ87sOuXqVrz/Ww5Ix
         qz9ttSD2HUMAuEUU1Acvs+bOyrFYBCj6wlBSE3ZWOD39ujYVyw4pITJNdGfyOuaQmCES
         AV5C+AzQA0Uf6HwZnVLPYj2KC3KolEVsuafk7BNrejhGznkd0CqhK7nZVu5pXeGUfldF
         bbQPodRskSysSrxha5b8HHdBTxzj7xoMY5bRFdqoKCW1sdmem23wYVTCfnF23SuGJ0Ac
         xtDUQ0TxiWSmrzPrpq0orw4RAxsDLFrH2awyUtbB4qbfxCXT/EX2aaiQ3VdRYmHQ4j6B
         iYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682507871; x=1685099871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxQuLZs6VUG8DpI09bWh9yeX27W6w8sopJ24aeCFPtU=;
        b=Wf1uQJVWgSCthGjc9ySQND+PffF/bJhfqUGTzO9Xi0j2Uq3/awuf9uQYpABr8sgYmI
         FcseLB1sj8bXqXU8ad2MDf7ctV4cbuEh9p8wOqSNl2ZtpX9QbYJoQb7eTzCHjdA4ZHDy
         8fsYT1/uftcvLk9f6C9QgWKQl1ZUmnCp3PCc+Gey4hzQMlmCmNN4HnDe35Zq6rnQMPhI
         M7XGo7VNVEn84vf5bidNm46tI+FkYTGHJw3CXPJe2H0F0cpknPewU0K6UFWHcF5xA/ha
         3WHfkktG0D+3NIxEHNZBbqPlIy30N03V5AXdSAilYD63UhLuWkZcvKukm9Q6gbYUhE3M
         aX0A==
X-Gm-Message-State: AAQBX9cO01PRjmR2TYejAgAu069By5UkjZM8oG5gyKNwqhHfWYraRJzI
        ljVQ4LbefRNSNrteufTxJluCHA==
X-Google-Smtp-Source: AKy350bHdtbyYsVxrV0qA41ej8FsxTx5Oc67PxlTzqY4bzA32VJFJTlvEAX3oGg5Fj38RO95mP5YLg==
X-Received: by 2002:a17:906:3086:b0:94a:8291:a1e3 with SMTP id 6-20020a170906308600b0094a8291a1e3mr14981919ejv.74.1682507871167;
        Wed, 26 Apr 2023 04:17:51 -0700 (PDT)
Received: from [172.23.3.48] ([195.167.132.10])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906054900b00923f05b2931sm8028431eja.118.2023.04.26.04.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 04:17:50 -0700 (PDT)
Message-ID: <e3efb318-2cf2-b73b-2f4d-7927a66b472c@linaro.org>
Date:   Wed, 26 Apr 2023 13:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [GIT PULL] timers material for v6.4-rc1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Qinrun Dai <flno@hust.edu.cn>
References: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
 <87fs8nyplm.ffs@tglx>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87fs8nyplm.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 11:12, Thomas Gleixner wrote:
> On Tue, Apr 25 2023 at 13:45, Daniel Lezcano wrote:
>> The following changes since commit f7abf14f0001a5a47539d9f60bbdca649e43536b:
>>
>>     posix-cpu-timers: Implement the missing timer_wait_running callback
>> (2023-04-21 15:34:33 +0200)
>>
>> are available in the Git repository at:
>>
>>     ssh://git@git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v6.4-rc1
> 
> git@git.linaro.org: Permission denied (publickey).
> 
> I used the https variant as usual ...

Oops :)

I'll see if I can do something to fix this in the future. May be migrate 
the tree at git.kernel.org so whatever ssh or https, that will work


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

