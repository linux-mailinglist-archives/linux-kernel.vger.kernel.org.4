Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D16E9AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjDTR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjDTR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:27:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430549C7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:27:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95316faa3a8so97039666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682011666; x=1684603666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qs3hS1zEcbd6LvW4gA839iJscm7oDwTflWd6VJTMIkA=;
        b=LQ92EKM0FhI2a7WhS8KC2S2HlkKIfkw4TWDVyq4861pzjOA3488Sb2Jm9+FJFTSDfd
         vO4WIDkoHElxe4j9hWc4dgkfd0wocJjCUoH8KLEZdL64v+BAxCo6SQZURV4Xx1STy7Wz
         VkOYdPU54A0vrdCRPzGP6/ZVCVc4VV4O2dRhOxe46kd3JLC8Io5w1UcqgRUhOpA9JHJD
         tYDLXvpnCCtEuJK/kz935CIr6N+r90q2bO0DG1oDrHYhffo53xdtbHHAp4f/tXgZlFnn
         QxqA3UFM1nVZf2abwDMejQ/G0xeSA95ZRG6N9NpcvziK/H9r9EJzR9MUZylimVb5X5SV
         C9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011666; x=1684603666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qs3hS1zEcbd6LvW4gA839iJscm7oDwTflWd6VJTMIkA=;
        b=I9XYCZegxO0hRs3tlncjRiWBNgNyJK2xSMjcnhoDGwuIRsdftr7g7Kivlm8QlAoDQB
         O1lNAblqy9ZLRcBxxmRUyZt3Rf4x6ld5BB/+pZyTJSRz1cZByNaNzGOCnEF94rmIMSub
         VnYv0H2NuRAKcQ0RT7DdqnXhVZezTt+47RDBjV5PIfyjAeteUm60NH+Kp1j8yyZi1GbN
         BPBANmclUUpXGjJ4HjjGVFFLED2A47DDy1SZGlX+WrCLg9TezO1hyc1s58O9Wu8rRBCh
         zvfag8n5zXYowQlZXIbtAhu6oPYF9SUIGzTx05Z1JOKZoG+EP3yJdJCY/FhDlUuDlKsA
         iatw==
X-Gm-Message-State: AAQBX9eSbksiI3fFwlzNn+4iMjhSDU7VkIXKGYlEq0vbZmqlshx1Jsag
        hR5PwXo8E30ayJYzR+bH2cAtwQ==
X-Google-Smtp-Source: AKy350YOpwmLNpt73flS8U2L5sl5fGklkf6iG6tZDTuKotTJFGawChDefw8Dm8dZ67D8xoCc5A+Ozw==
X-Received: by 2002:a50:fa89:0:b0:4fa:b302:84d4 with SMTP id w9-20020a50fa89000000b004fab30284d4mr2418861edr.13.1682011666275;
        Thu, 20 Apr 2023 10:27:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7d50a000000b00506a5606343sm963515edq.14.2023.04.20.10.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:27:45 -0700 (PDT)
Message-ID: <beaec77b-9a61-6afd-59fa-fa726cae7a54@linaro.org>
Date:   Thu, 20 Apr 2023 19:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/6] soudnwire: master: protect concurrecnt check for
 bus->md
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-6-krzysztof.kozlowski@linaro.org>
 <7ee41bcb-8656-49ec-40b6-15072c080d08@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7ee41bcb-8656-49ec-40b6-15072c080d08@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 18:42, Pierre-Louis Bossart wrote:
> typos in commit title...
> 
> On 4/20/23 05:16, Krzysztof Kozlowski wrote:
>> The Soundwire master controllers might want to check for bus->md
> 
> Apologies for being pedantic but 'manager' and 'controller' are
> different concepts in SoundWire, see DisCo spec.
> It's not a 1:1 mapping, a controller can rely on M managers

I wrote master, not manager. For the Qualcomm case one controller is one
master, but in general I try to avoid the master/slave terminology.

> 
>> initialization to avoid race between early interrupt and finish of
>> sdw_bus_master_add()/sdw_master_device_add().  Such early interrupt can
>> happen if Soundwire devices are not powered off during their probe.
>>
>> Add a store release barrier, so the Soundwire controllers can safely
>> check it in concurrent (e.g. in interrupt) way.
> 
> Can you elaborate on the race condition? I am not following what breaks,
> and what entity generates the 'early interrupt'.

The condition is explained in next patch. If you think it's better, I
can squash it with next.

If the condition is still not clear, drop a note in next patch, so I
will elaborate there.

> 
> I am specifically concerned about adding this in common code without any
> matching smp_load_acquire() - which is only added in the following patch
> for the Qualcomm manager only, but not added for Intel/AMD managers. Is
> this not a problem?

Shouldn't be. The barrier just won't be effective for these drivers, but
that should not be a problem, because I also did not add to these
checking bus->md in a concurrent path.

Basically the barrier here is necessary because I want to check bus->md
in Qualcomm master interrupt handler.

Best regards,
Krzysztof

