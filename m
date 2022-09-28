Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F85ED7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiI1IaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiI1IaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:30:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92253D04
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:30:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s6so19252287lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NCs5vawQU96pEooh4cqbFuck7uG4MvVs+nCclYJ20Lc=;
        b=izxF/Q1zZ+0VT46yoktPGdqNU3gKyH3DV0xGCXmhsQI0OCUsYpmvzfmNyAJFRYxGZX
         RtqorzvQxpeSVHRc+l2xzolAwvOj6Jbj8ClFbiPK/FBqZAgNr1s3SNNT73Y9T9eY8lzH
         f1nXlErTNLOzTL9g5uibixKpp47kKtcC/6hfSc63MBt6TT0ccyr6S+LAv5JORm4HarU+
         dGGcGX9ZZMHpwYrXS5uXTQLPP7Lxme25KN/AdH4Fml+pmPqJHK0J3s3wOsxJewRjZ3Sf
         3pQRnviXH/5+V4qAs3lZNJ8fTKaYitFjG4lcrHHxdFMn32dNrPF5XeKLSSn/GxZWwynf
         YSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NCs5vawQU96pEooh4cqbFuck7uG4MvVs+nCclYJ20Lc=;
        b=byP5OC/nkcHKRxlkWofA+Boy0ukNkFa/Okbr/BHbnHxF17TaFtcIYPovKmKnFneYw4
         J5pDgJjX8xXfoUpeWcM31WWNyvOrm+iYad+ckR0Ts3SXJIiPgWBKAigrqN7gr0WwHorw
         ipzFlOEojd/YCr1ZaL54DX8OBV9R+ZWri7oKtEP1aiOTiE3TEKXyXQrHQqjNpao+Focl
         gjuqW6a4+u2OJi7R6a77kl0GqFk0gjjROVAtZ/Djq+64V+EkAb1pkhvNfd+IsMDN1yzf
         ajDlQTs+CEpHqD4NgWlUU6P6zy2p8qby15nGDHAXVVoerrgBpjAVXZwCR425FzVLBJk5
         jZwg==
X-Gm-Message-State: ACrzQf3fupsfgyiILeDI5xa4bvslD3/ld+Be9r6kb0v0PchVs0dtf6II
        +RR7f0wzaISVId0RXBvvN2NdWw==
X-Google-Smtp-Source: AMsMyM7WVCkxYWM9czOkGqjZbJb1PFZ7Z6R2P1OEocB90/+Nr7YuvYckWdW0uC++w6j+Xcl1lkxb5Q==
X-Received: by 2002:a05:6512:798:b0:497:aa2b:8b10 with SMTP id x24-20020a056512079800b00497aa2b8b10mr13910475lfr.636.1664353804044;
        Wed, 28 Sep 2022 01:30:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k20-20020a05651c10b400b0026aba858fbfsm371190ljn.137.2022.09.28.01.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:30:02 -0700 (PDT)
Message-ID: <2bd60261-a977-3225-8d41-4987252e6abb@linaro.org>
Date:   Wed, 28 Sep 2022 10:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926190148.283805-1-marijn.suijten@somainline.org>
 <20220926190148.283805-2-marijn.suijten@somainline.org>
 <052630d0-299e-e468-b2dd-266d371e2b0f@linaro.org>
 <20220928081055.p66huqct2wnrsrdx@SoMainline.org>
 <3f2e62f5-a6e4-7011-3f5b-29a6657eae79@linaro.org>
 <20220928082340.mkn23ersrtzb5oth@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928082340.mkn23ersrtzb5oth@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 10:23, Marijn Suijten wrote:
>>
>>
>> This is a automated message, don't get it too personal. A lot of people
>> are not aware they have to do it, so I just one, same reply. I don't
>> know whether you are aware of the process and just forgot to include it.
>> If that's the case, just ignore the message.
> 
> That's useful, what software are you using for this?  Perhaps I can run
> it as well, both to preempt myself and others.

https://gitlab.com/robherring/pw-utils/-/blob/master/mail-add-acks-reply
https://gitlab.com/robherring/pw-utils/-/blob/master/pw-review#L97

> (Side-note: I should get accustomed to `b4 shazam` to automatically pick
>  this up from the list, instead of rebasing / re-applying local patches)

Would be nice if b4 could update patches in current branch adding the
tags... but git reset --hard && b4 shazam should work as well.

Best regards,
Krzysztof

