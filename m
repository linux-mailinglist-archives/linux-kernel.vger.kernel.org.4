Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138F6E3B53
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDPSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPSvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:51:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B5EE7E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:51:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy21so15729183ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681671075; x=1684263075;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKImHCjHVF5MZ/4M5IREBVMKJU5wQfIJuuJriWo9vEM=;
        b=s7Cy79OQkVoSUqwpUIa4AWNao0LwkjducBmRn/xrDI3YTfRKfxsy1NdT1DhklolWHz
         agVFkH2SM+Sev/Pxi0yBokTO67lNPQ9po7rxIguvFpXX2W7KmgH+oeAL+/LwwUaC8onn
         VGSaYCt3Fse06Zn83FmefE6gCa7XKwlMEDqUUnSe52G30qUOGjrTIokO+NItSxS4m9/j
         QuA66PMKS7ihuYAPnxjgGViptkmwGlEnnmkZtbho2JULPMs8zDUH171k61GpvaaXyGE+
         vsV3D7krkyEgfKiA3L+stcOe1IjYFjZml6jhGqjWyGQh6wJv88PTBbXDsO781DjJjz19
         kjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671075; x=1684263075;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKImHCjHVF5MZ/4M5IREBVMKJU5wQfIJuuJriWo9vEM=;
        b=MVjsm4xvwBoGhwxoSs+XjoDOU3zb6gJQ82PIum/hvhq1fzHpB0I52S+v2C0WjaThLB
         zVcHqO4pdmgRiuY7jWoxHv/jAsNMLs6/5nnWUia1s+wlF1UPmATo/uzZLvK8paaFLm7r
         UuEEtfK/n03XFvPgd1oP/l42j+jjKPJMXusau4rp7/m1PlxUEryy05lwViCPnxX49oG0
         lmonsO9IeHFSZzLztpEUq+eB5N49qZ48Hj1ec5EnrA9dfhj/RrSgzzAoUt4gqNsnMONV
         +Lwspw+Hvr1xuYyOrMPMLy11s/x96/6/EFR63CEv2/oGJgWHlrkDzf+u1lYSAgi7Aj7l
         L+gw==
X-Gm-Message-State: AAQBX9enHPmimoLegvSEV1GZG/AqV7cqgehYeuyDuBEQOiNGKYwHw1Uz
        wqGos94LMqcYTKr4GEueFoKYzg==
X-Google-Smtp-Source: AKy350ZUnlsLiqcJGll/ROJIUcU/VJ4V8dQbWggjC/n4kdtez0qynFD8+ZslbYFgDYYJPL4FJM4PFw==
X-Received: by 2002:a17:906:fc0e:b0:94f:317f:6a58 with SMTP id ov14-20020a170906fc0e00b0094f317f6a58mr3656389ejb.35.1681671075214;
        Sun, 16 Apr 2023 11:51:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b0094efcc4a076sm3253368eju.164.2023.04.16.11.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:51:14 -0700 (PDT)
Message-ID: <98da9a32-9771-1002-f323-909e8b49a536@linaro.org>
Date:   Sun, 16 Apr 2023 20:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        robh+dt@kernel.org
References: <5d629ff3-c5ae-bd00-e70d-8c0d58365ce3@linaro.org>
 <20230415201246.1200683-1-danascape@gmail.com>
 <92d0f4c7-ed53-5d84-3955-08d1ab8bbd98@linaro.org>
In-Reply-To: <92d0f4c7-ed53-5d84-3955-08d1ab8bbd98@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 09:35, Krzysztof Kozlowski wrote:
> On 15/04/2023 22:12, Saalim Quadri wrote:
>>> You choose unusual bindings to convert to DT schema. It is fine but
>>> honestly, less useful, with limited impact. This is an old, 12 year old
>>> binding without users. Maybe it would be even removed by now...
>>> I suggest converting ones which have a real impact - have users in DTS.
>>> Otherwise you will be putting quite a lot of effort for no real gains...
>>> because what is the difference between this binding being TXT and DT schema?
>>
>> I am converting these bindings as part of my GSoC project where I need to convert
>> as many files as possible during the given tenure, I am slowly trying to read files
>> in other subsystems too and will push patches for other subsystems too.
>> Is it fine?
> 
> In general it is fine. I wonder if we can change the goal of GSoC? I am
> surprised that such goal was chosen in the first place. Converting old,
> unused bindings to DT schema is okay, but it would be much better to do
> this for the bindings which are actually used.
> 
> Because I still wonder - what is the difference between this binding
> being TXT and DT schema?

BTW,

If you want to find used bindings and tasks to do, check Rob's bot output:

https://gitlab.com/robherring/linux-dt/-/jobs/4118960859
https://gitlab.com/robherring/linux-dt/-/jobs/4118960858

I pointed to these jobs two months ago when Daniel was looking for some
feedback.

Best regards,
Krzysztof

