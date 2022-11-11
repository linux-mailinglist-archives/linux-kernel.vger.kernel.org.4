Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CACC625D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiKKOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiKKOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:33:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302C59FF1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:33:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g7so8598608lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZCkL39tKR5ttW+qJKB2t3gyWuB8VcBN7GauxzyOgrI=;
        b=lHZh8n8x55B+MzDCbf2ins/MECWR60E/rKGiejeepH0pN88FyN8fHkxVTrJxJ8yJHM
         THuEk4207LGGUNZtQuiVxSzPt1cV4QKnFht4q/VcPgJGxXskMUdmPVy1cMVfpbdOXXMD
         +urR1Qdlbs5RFmiuNZdCVxYlTYimLtJgw/xIJ2wzbLNmH3VTGzAgLm43CfNYLHNByxdi
         W4kDlknlDAwTicdt2b0bEo0K3R5SJ8qXw8RH78yv9YGPGBdd9JtyQ1jX0lsQjgMv82sD
         uUpS27x1/VfBKy0yT21pNyygyL2kOTEQi2t+s3Uz8CVsazG/7o8oNRWM+J3ASMuLAAjI
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZCkL39tKR5ttW+qJKB2t3gyWuB8VcBN7GauxzyOgrI=;
        b=i4ypGI5Ieu2mT/pGGSA8LFKR5y4nmdJyJ71cp2I7y8qczrag0Wl2D6u5ukncYVfmGZ
         B/bdyiecpty8rDRJFDVQkVxnwxilomJ3HpKwHZwhQF/rNcMJUJ0V8DLxqv+iTqqKOCaA
         k5eSj//Mo92UupFqm9g8W2BFoNCEcqZ44Bml0kWnEXnjj/kLe9N+3IC2juzBZvW6SWoO
         vt2a5vhvBIZ9xJmNSQVeKbMA7yGymOYrW563KGq1pb+9YM94/P6bsu5wR5Ya2M0RmEQd
         AvTN2SPU+dPznKb8RwJkFrbx2L92qm9IvbTwYfFg9IkSO0ArIhteFUGaKuKN0BsmQG0Y
         8O1Q==
X-Gm-Message-State: ANoB5pkeRLlmDNz+V/meTI7RSVYw1OmwgrNdoNSHpmba6IuBa6FTCPFj
        SYxPyJt1AvrKqikC/O6E739yMA==
X-Google-Smtp-Source: AA0mqf6/tmoTby061FizYgM0U//KfujjSuy0T07o4ZCbezgv/mR+qfC2CRHGEa+Wtd41eGEj+SQQQg==
X-Received: by 2002:ac2:5095:0:b0:4a2:ec0:c4bf with SMTP id f21-20020ac25095000000b004a20ec0c4bfmr856566lfm.164.1668177192404;
        Fri, 11 Nov 2022 06:33:12 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512046500b004a2386b8cf4sm351025lfd.258.2022.11.11.06.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 06:33:11 -0800 (PST)
Message-ID: <29620da4-fda7-eb71-d9de-599e3bbd2de7@linaro.org>
Date:   Fri, 11 Nov 2022 15:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,wsa883x: Add sound-name-prefix
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111091738.34290-1-krzysztof.kozlowski@linaro.org>
 <Y246wC8zEGJp9SmC@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y246wC8zEGJp9SmC@sirena.org.uk>
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

On 11/11/2022 13:06, Mark Brown wrote:
> On Fri, Nov 11, 2022 at 10:17:38AM +0100, Krzysztof Kozlowski wrote:
> 
>> For multiple speakers attached, it's useful to give them some name.
>> Sound core already supports this, so reference name-prefix.yaml.
> 
> If we need to manually extend the schema like this it should probably be
> done for all the CODEC devices.

Several files already do it:

  git grep name-prefix.yaml

The trouble for me would be here to identify which devices qualify from
bindings/sound.... everything having #sound-dai-cells?

Best regards,
Krzysztof

