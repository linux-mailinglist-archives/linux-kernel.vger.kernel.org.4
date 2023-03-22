Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061ED6C50BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCVQaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCVQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:30:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB755943C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so75265215edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679502592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDObnHO7h3AiOsFiaQoPm27eyvHc0YyhrJfDEIOmUpo=;
        b=n7uTvip5e/M2Hue27wbFjuRarurQDkaEUYYqFgrs+QnGMmIDuZ0OToVqPahHQXOdEr
         rebttzx6dP5uYC1EwTiQdyCC0Pm5b4RNv+RZGzFBqKuQadZ206vswqOI29jehPMnA7Jj
         qDWy+dbOObf724XS7V9vuO96KmuWzUI94xNgPrvrhtZEwKmlKQRaHLrwOk8LETfa0tuN
         gDPeCj/9vfP1nbIPYVorPPO43ugqJBRc0kw9cC/EZPK4R3HBhiUo6YXbhbHO3LCwblAw
         4w3fnQI/XneXV80Wxs6vXRCKabym27x2lflCaoq6Y6dckX1XyJ5z1lJLcUMhUgNpMMkf
         tLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDObnHO7h3AiOsFiaQoPm27eyvHc0YyhrJfDEIOmUpo=;
        b=0VislniLVphbY+MdQTcbfuFuktHzAzGcIDL8DJOdr71lshbMd89tD9FPWwtBY8/HRW
         qSYhXBLrefYpcchnLFvFsC+LMWOg1shprzxj+GmB7GyDnVJV7Sm2W+yeB9bDWkrZjanY
         EGCimnBQnWRowiNEN2M6it/k9mR+hQxZLOYLFeosb252WBPzO5dnD4/c27+j1Wt17oSZ
         ffhH96/uLviE4I5BAsNZDUkyN47no1QcmqnBEb0nL6Rd7Z5iHd2RyxbRSaQysZJ7izch
         YHesfbepGQUEtF+V4Ha4h9gc9WlAw3cTT8Yvp2GR/YUNOid0BWXk405Di56eozYkOnPW
         Z5vA==
X-Gm-Message-State: AO0yUKWm9cLHZtcwZ5Fc2TM8p70o54ol1enuU1QhuvSoCoyZjX5CVtyj
        TopboeNtBFFFcGLtJQI2dYliFw==
X-Google-Smtp-Source: AK7set/W5evUo2fY+lfa5NF96ktGzqiypbNLTYZMft3KXV3dKNOTAbvReEReqHIOweAoFSEYXNavIA==
X-Received: by 2002:a17:907:c306:b0:930:800b:2803 with SMTP id tl6-20020a170907c30600b00930800b2803mr7154912ejc.76.1679502592667;
        Wed, 22 Mar 2023 09:29:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b00930c6c01c9esm7611132ejk.143.2023.03.22.09.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:29:52 -0700 (PDT)
Message-ID: <859ec5d4-4cb6-1d8a-33b6-91df071e07a1@linaro.org>
Date:   Wed, 22 Mar 2023 17:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
 <fc46c48d-2de0-ba3a-08b0-a09526bd9e26@linaro.org>
 <e88d9482-4858-7042-7148-142ed9ebb6ad@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e88d9482-4858-7042-7148-142ed9ebb6ad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 14:46, Souradeep Chowdhury wrote:
>>> +      - const: qcom,mpm2-sleep-counter
>>
>> SoC specific compatible.
>>
> 
> This is a generic Module Power Manager Sleep Counter which is present in 
> all Qcom Socs, so SoC specific compatible is not given here.

Not really a good reason and it is actually very difficult to verify
this. If I understand correctly any moment FW can change and this will
stop being valid, so no.

> 
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: MPM Sleep Counter Base
>>
>> just maxItems: 1
>>
> 
> Ack
>>> +
>>> +  clock-frequency:
>>> +    description: Frequency for the sleep counter
>>
>> Since this does not have clocks, what frequency you are setting here?
> 
> Module Power Manager(MPM) Sleep Counter is a clock that starts ticking 
> from Primary Boot Loader(PBL) Stage. This is usually a 32 Khz clock and 
> the frequency for the same is stored here.

You just said all devices have the same MPM, so I would argue that all
devices have the same clock.

Anyway, this is a legacy property.

Best regards,
Krzysztof

