Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF5713438
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjE0LNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjE0LNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:13:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79838F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:13:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso998581f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685186009; x=1687778009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNj5xIx+BSwromsYm9ia1o7bUGDaZEteHL4lXB89T5Q=;
        b=bd1q/GQAB8FX8qvHFUw+YjkqOlULq8xcqP2lcTWb1p58RYfjHUYsGKk3kk+oaotI2n
         lHZR+aB3Tp/ih7l/pGnYlyTx37Du23/EGbtzp2NyVof1zUBStBhCnDLnUkhFh4IdHK5c
         qXOoqNHi5SRIEIYsRVa83OZ8lm+ZrmhCCsivO5olA1MEfzoEJMw/zewg8YWkj+15j3ez
         p/x/iKgFvF21KqBV41QGtYbWzeL/J25PGnhxw9c3PLfzaD712YtRN1FpO16yiUL73Viz
         UW/6MUFOverOsVy2rmy2dM5+YhZJSfvMH1wolbtkrllGe0IApaKplSaN9smjhWDV4QLV
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685186009; x=1687778009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNj5xIx+BSwromsYm9ia1o7bUGDaZEteHL4lXB89T5Q=;
        b=Yoq9m7RAKc1bzNKzpBdvhdAMnDIZGreekMjWl0+jLJsyCMyX9EbCqwZ7c/nDHLmjTw
         OAtR1dRw8yIS59acwaos4f8ZzM4JbDWwYDgER/mNjjzCOqNX68i0SSH9GRFSb1GUCP3Q
         jRosV5rDH4EBQuiWio7+FtLMI4by9Ri3Eaq5UvL6AmvzyUBTZcjQDMeGkQ6si4ownPCw
         QkEd5UYhGLEAa2MwQzMBkb7IpoCnZcOVXnrEzKQb0cuUk/L9BLPE1FR1a72kzLVkN27U
         BjiUwM/zvDkOHWVpJooCM1pRmHUTDEk4+52T9WL+GcZkOuBFbAIEEWEriiTtUCshHzln
         xLRg==
X-Gm-Message-State: AC+VfDyj7b2Or5Rk9BxLzB0WgNsNA7ufWBmsh4iRvyAkFZoEKcnK3OqV
        GcFRPJzP0SDQo3lLPM2bSXGaFA==
X-Google-Smtp-Source: ACHHUZ656fhr7DfHYJLwVSn2SwLz4g3oSOi/Ftp4RjGh8gxHDAYhYorAxyhtTTTIga2lJwEcdRK2Ow==
X-Received: by 2002:a5d:4911:0:b0:309:535c:c236 with SMTP id x17-20020a5d4911000000b00309535cc236mr3971606wrq.36.1685186008870;
        Sat, 27 May 2023 04:13:28 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b003063a1cdaf2sm7695793wri.48.2023.05.27.04.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 04:13:28 -0700 (PDT)
Message-ID: <b7e1d035-ee79-77c9-e81f-56fa8c2cf1df@linaro.org>
Date:   Sat, 27 May 2023 12:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-4-y.oudjana@protonmail.com>
 <fa395680-0e6c-3eb0-9d5a-f90a95c394b8@linaro.org>
 <GFZAVR.8RI43MBQZ4HN3@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <GFZAVR.8RI43MBQZ4HN3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2023 07:02, Yassine Oudjana wrote:
>> Konrad pointed this out.
>>
>> Are you 100% sure you want to do this. We already have a way to count 
>> the # of power-domains in camss_configure_pd().
>>
>> Your series is now adding a dependency on power-domain-names.
>>
>> Is there a good reason to add that dependency ? If not, then lets just 
>> take the code from camss_configure_pd() and make it so that it can be 
>> used/reused here.
> 
> Is there a good reason not to?I found that using the existing 
> index-based method would unnecessarily complicate things since an extra 
> layer of checks would be needed to differentiate between MSM8996 and 
> TITAN SoCs, since those have the TITAN GDSC at the same index where the 
> CAMSS GDSC is now added for MSM8996. The same checks will also have to 
> be repeated in error paths and during cleanup.
> 
> I guessed the only reason we were still using this method for the 
> existing PDs was to remain compatible with old DT as Konrad mentioned, 
> and since this CAMSS PD is only added now, I thought it'd be a good 
> opportunity to introduce power-domain-names and simplify things a bit.

I think actually I agree with you but, I don't think you've gone far 
enough with this patch.

Now that I look at this code a bit more, it looks like we need to place 
the TITAN/CAMSS GDSC last in the list of power-domains or the magic 
indices won't work. So my suggestion to you to place the CAMSS_GDSC in 
the power-domain list wouldn't work, unless it was the last entry,..

Having magic indices doesn't make much sense to me. Aside from anything 
else we don't document or require that indexing behavior in our 
Documentation.

In fact, I'm wondering what is the use case of a vfe_lite on its own - 
without the TITAN_TOP GDSC switched on ? I'm looking at the block 
diagram of the clocks for the sm8250 the IFE_LITE is buried well inside 
of a series of other components..

The reverse OTOH holds. Full fat VFE can be collapsed individually, 
which is why they have their own GDSCs...

OK, we should get away from magic indices ASAP.

This is a good find, thank you for bringing it up.

Could you take a named pointer for the CAMSS/TITAN instead of an index ?

camss->genpd_camss_top * =
camss->genpd_vfe[] =

These have a very obvious meaning. We can read a top-level struct camss 
{} and immediately understand what is meant, whereas index = 0 doesn't 
mean anything and isn't obvious from the code anyway.

1. You're right we should introduce some kind of naming to
    break the bonds of magic indices.

    So lets do as you suggest and name the power-domains.

    However we should refactor the code to drop magic indices.

2. If and only if named power-domains are absent, fall back on
    legacy indexing. In this case we will assume legacy indexing
    assigns to our new named pointers.

3. New CAMSS dts will need to have named power-domains as a result.

---
bod
