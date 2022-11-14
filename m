Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2948627690
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiKNHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiKNHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:45:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0932AE5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:45:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s24so12049056ljs.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RThUDKfaIW0h3m+CPW+odfwhZdY9NoazLhG6pvsOy0A=;
        b=CoOlY/JyiNs3rBh4briKTbLMg62G/yRn3DUkMDJzget5JbFD8S18U9q/bf7kLwdCgA
         H3WNJ8E68XjGyJt6t/VX9NRljtJ/StNuprqE8a+BwtF+G5u+qwj02RRjSu7dyKQA3qPp
         zO6eg8WjvAkD5HHTbYyjnYAL0M+YeYyobzzX6BqqVdCZD5Qkwotvga0tUWQGssdtOaYL
         GHL97W+2ldZtctrLynDhXX4MiYSYtXgORw8klZwSedUBxZzwifo/qk4IkbwZbUxMQCCe
         V3smUKYYzFPsX1I8CJCdOuBMLOdXt0LHAgEhcpvx6YsaXCanmx6EuwYd5xit9wZR+8yN
         Ktew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RThUDKfaIW0h3m+CPW+odfwhZdY9NoazLhG6pvsOy0A=;
        b=ReTzvh3iSMPi140OpCw0wjacMxQ8Ec/fj+s5Fx2BqEhh0cB3c9QI0LDOofcKBQKyk9
         hMNbqn/StDTMQj7IFYcyLwJ69dHnIqYNg3eNn/3slG9IdR6gOATAoLUH+FgxQY8mJDxV
         8f9S1MWa7PZR/+crexCQj1y93+wwfht7jA7FRJFGL4k7T49UJMH9YGvJDKL4l3unyCOv
         gOMo6/mX1MGhTbwsP07nOgPyD/NKGxjxz1JjeaBH7/Oe4lv+ahDXgFyvU3t7+0IKv9UC
         WH/KZ+BeRn4+PO09YwHs/96XkobEoFDR8NF4qcH+5EMQ0f4knQ/UISoUxabesDVhEsdq
         xoDw==
X-Gm-Message-State: ANoB5plTorKHd0JK3DmVNwKtcaictNB71/iVghMEsN9L6Mw8dkIO/O+J
        vclm4Yo9B071YeVu8rUySNwLOg==
X-Google-Smtp-Source: AA0mqf6Je7SzJ0/6XL2Blpt4CrFzA9c9QJH8q3G+IlddOO2mBMpg0spYsMrpNNrOy4sFVty13KIf3Q==
X-Received: by 2002:a05:651c:12c9:b0:26f:c03d:f99b with SMTP id 9-20020a05651c12c900b0026fc03df99bmr3814983lje.190.1668411912583;
        Sun, 13 Nov 2022 23:45:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b00492ca820e15sm1711964lfb.270.2022.11.13.23.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:45:12 -0800 (PST)
Message-ID: <6df681b1-318c-ea0a-8add-e0a18302eaf7@linaro.org>
Date:   Mon, 14 Nov 2022 08:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/10] ASoC: dt-bindings: qcom,apr: Split services to
 shared schema
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
 <5207a28b-9c8c-5014-28c1-15635ad30143@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5207a28b-9c8c-5014-28c1-15635ad30143@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 17:35, Srinivas Kandagatla wrote:
> 
> 
> On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
>> The APR/GPR nodes are organized like:
>>
>>    apr-or-gpr-device-node <- qcom,apr.yaml
>>      apr-gpr-service@[0-9] <- qcom,apr.yaml
>>        service-specific-components <- /schemas/sound/qcom,q6*.yaml
>>
>> The schema for services (apr-gpr-service@[0-9]) already grows
> 
> I have not seen these grow or change alteast in the past 9 years.

You added GPR to services in 2021, so it grew past 9 years. Then it grew
in 2022 when I started adding missing pieces - missing compatibles and
properties.

> 
> Old APR (Elite f/w) and new GPR (AudioReach) interface provides access 
> to static services on the DSP.
> 
>> considerably and is still quite not specific.  It allows several
>> incorrect combinations, like adding a clock-controller to a APM device.
> 
> This should be fixed for sure for validation.

This cannot be fixed without making schema over-complicated. It includes
six different compatibles. Except few of them - these compatibles
represent different devices.

> 
> We had dedicated bindings per service before.

Where?

> 
> As the service has changed as part of new AudioReach Firmware, we could 
> have added new bindings for these services again. But as we are dealing 
> with the same audio hardware and clock resources a new bindings per 
> service did not make sense. Since then we moved all the lpass audio 
> ports and clocks related bindings to qcom,q6dsp-lpass-clocks.yaml and 
> qcom,q6dsp-lpass-ports.yaml.

These are not bindings for services but bindings for their devices.

Best regards,
Krzysztof

