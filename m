Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0F63AEC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiK1RWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiK1RWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:22:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BC13F95
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:22:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r12so18522674lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz4U6bCcuLMHM0gxhrz3UTExymkQ4wMjpOMjt2Gnk3o=;
        b=cDEVfOtMsw5+cBdeT5f2U0xt5Q5Qq9JJjtVwaMDPKoq8bAQA45U5FTp8/EHYJ1nx6k
         HmIoefEQnHDpr95DbFb5TitZX68ZGCNmiZsJ0B6rEl1C4EtD4+6wmUbE71keg1yNWXqL
         xS7qK15rPSqM+pWB5vI2xaJJlE2PED3+3RJ2OHz0YarzWy790va3TqTcIzcuSJ7mGgiQ
         XKLuRiPAJrKUcl67KrQl/KSAzt95Mt8msWNlzBAztUz6qShXciN7NU0pr0NDfk6N3shc
         B39QegxWPWfS0MAzeOP0YlZurpqJ9ufeu5SMYGmIKH0hJPaxaCN54iQbJvdD+PLAOHwY
         cS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz4U6bCcuLMHM0gxhrz3UTExymkQ4wMjpOMjt2Gnk3o=;
        b=gYA1XdVOyHdyGZiiHUz0z20af9TSWkqPqM0AhgiFa3OO5g8m00CQ9YcnXE1j8g7Wv0
         uQ+uqfVMcD5k0F1fHRKDmgt7OoS+rR5fHeYrQQijoKHX28F+L49KYXh/Qw4WX3wzWJJl
         TPKdCFqINv8IFFUP1Zi+uutU7ZjWQDHpQJfaDiAR1JOC9FZUertImwCChPRE5apFaVbf
         yJNCAdpNLq4KspqevAVHzooWh+wIDJwWzkn8fmRZQbXsiplP6H+zY14xu8f0Ry5K4x0T
         0mlCs2Cr9JydZa/8p+LkuRm+vbqwaoivpdcnS/FLqouwnVreyy8Z8dF7uErBbvW3zNlR
         bKDw==
X-Gm-Message-State: ANoB5pmTEQpS93yLQDMVcGO5pI/i4Ba842HTP2iUg6+UKJkDnzrL455F
        Cad4rUSn3vCKSk4ecsS5zcRymQ==
X-Google-Smtp-Source: AA0mqf59Rbo4KloFyD/kj44brirbxRCq9gQk//PvegW0EMtEhJC5wO4P8buRkfyKiQI8/XEo5m+lPg==
X-Received: by 2002:ac2:5236:0:b0:4af:eabe:dbf5 with SMTP id i22-20020ac25236000000b004afeabedbf5mr16951016lfl.668.1669656161399;
        Mon, 28 Nov 2022 09:22:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b00493014c3d7csm1791916lfr.309.2022.11.28.09.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:22:40 -0800 (PST)
Message-ID: <f92ce2ed-80b5-eb26-36a4-2384a7a8510f@linaro.org>
Date:   Mon, 28 Nov 2022 18:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add zombie
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     =?UTF-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Gavin.Lee@ecs.com.tw,
        Darren.Chen@ecs.com.tw, Abner.Yen@ecs.com.tw, Vicy.Lee@ecs.com.tw,
        Jason.Huang@ecs.com.tw
References: <20221124115712.v4.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <CAPao8GK93KMrtaXw7mNWOCE60zk=uCENLfBXhNRVxJXEnnaGFg@mail.gmail.com>
 <f58866c8-0164-2e59-4ff3-f9a4f9334e49@linaro.org>
 <CAPao8GKbdK79Z7w91x0T6JW9v6VFoeYSaXGGAuzB_=ukR9g0_w@mail.gmail.com>
 <b54cd0a4-7ee8-e8c0-ceda-18b29588d535@linaro.org>
 <CAD=FV=X9C8nLDrEpZE2tLtq6Brn9cd-15+1JWFOL4cPYdJs5Dg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=X9C8nLDrEpZE2tLtq6Brn9cd-15+1JWFOL4cPYdJs5Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 16:56, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 24, 2022 at 3:27 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/11/2022 12:20, 楊宗翰 wrote:
>>> Hi Krzysztof, Matthias,
>>>
>>> How to use "get_maintainers.pl"?
>>>
>>> I find this script in path "<MyCodebase>/kernel/v5.15/script", and output
>>
>> This looks like v5.15 kernel which is heavily outdated. Please never
>> work on such kernels when interacting with upstream. The rule is you
>> work on either last mainline kernel (v6.1-rc6), maintainers for-next
>> branch (you should know who is the maintainer of subsystem you submit
>> to, get_maintainers.pl gives this information) or on moderately recent
>> linux-next. For bigger patchsets there might be exceptions for these
>> rules, but it's not the case here.
> 
> Just to add context here, it's a fairly standard workflow for ChromeOS
> kernel engineers to work in a "versioned" kernel directory but still
> checkout and work with the upstream kernel. I'm sure it's confusing to
> anyone not used to working with the ChromeOS source tree and build
> system. Sorry! :( So the fact that Owen is in a directory called
> "v5.15" doesn't mean that he's actually working with the v5.15 kernel.
> The fact that Bjorn's address is correct in his CC list implies to me
> that he's actually got a proper upstream kernel.
> 
> I had previously [0] instructed Owen to send against Bjorn's tree, so
> hopefully it's correct.

If it was on Bjorn's tree, get_maintainers.pl would not produce such result:

---
Series-to: LKML <linux-kernel@vger.kernel.org>
Series-cc: Douglas Anderson <dianders@chromium.org>
Series-cc: Bob Moragues <moragues@chromium.org>
Series-cc: Harvey <hunge@google.com>
Series-cc: Stephen Boyd <swboyd@chromium.org>
Series-cc: Matthias Kaehlcke <mka@chromium.org>
Series-cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

or this:

---
owen@buildsvr-HP-ProDesk-600-G4-MT:~/chromebook_zombie_os/src/third_party/kernel/v5.15$
perl scripts/get_maintainer.pl -f MAINTAINERS --email
linux-kernel@vger.kernel.org (open list)
---

as Owen indicated earlier. They are either incomplete or not correct.

Of course I don't know whether the base tree is the problem or usage of
get_maintainers.pl...

Best regards,
Krzysztof

