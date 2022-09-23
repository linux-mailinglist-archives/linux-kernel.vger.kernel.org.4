Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC74C5E7860
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiIWKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIWKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:30:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF13F1CA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:30:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a10so14210090ljq.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I7e7inRGZJBBrCxWPf4VaG+f6kEpOQsdfxaR6MXxAk4=;
        b=PiyEHGgCKoygApaBJYQHYg/kBKkhs9/+zycl/WsVJbpxF9ZqAtwPwgNbbc8rir7qvc
         S2EQXUP0LwJVFyS/1ewNiUVYBwQJPeNlmWq7XUp74KDxEiJ3ZMqUciOiFX4dqVFPjvPZ
         0kPJnpgaECDcVhKiRpzU2qcIan4qzQ8a/cUdm5m2mGzvungWfpPllAtMfQ8fgKUeyVj0
         OU0rpxHHtmuUfMqvx/C1mJ2vZz4+nEzDKXFx9G9TqfZVoP4ZdZoiGHPq2VTpgrIIdhV0
         gB8LUCZlYZIBQxyOi2dYxTx96QfoVomXj6Ul83rLvBCCBiyaDss3j3GmVRguX68z+By5
         RvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I7e7inRGZJBBrCxWPf4VaG+f6kEpOQsdfxaR6MXxAk4=;
        b=yiV1GSpx4d096Y5OUbtskW6hxp0369DtjSnCRcRaJW8+YRlf4ggRIRFUoG5/mNesKF
         wAMXwFdUrnEOJEEEaG/BDuh4aAJU3x9K42jMaJcD7wTf7qtPfPmmooTy8I4wG+ch/HZF
         vcc+rRz73i+rlNkH+7Yghl9F8bapmlt/r/YuMBAOBsqTfIgdcazQV9JW6QBhL+wtd72u
         pjFG2TCiV9kRgXIjt17naZqUoEm6PQZRH+u1p7VyQzAbBLwUsoOHTp0hIZdDXf9K+fQV
         ACqPdIi4nvjQuA2CqhYBFjy4z5ljg7dH/tXX4zabo/nm/HPydc4vMt1fP907cAS5dh2I
         nZ2w==
X-Gm-Message-State: ACrzQf3RCM6Gl9E+Sx2CcKdqqBKeH1tGwrRV6rLd+lpgsB+CQur2pgjG
        Tn9Mco5Xl3bY9tjrMTsw3lfiVw==
X-Google-Smtp-Source: AMsMyM4qX9eM1McoAFz/vkeBKtYPlXtNk3BWIHaS4QHrJQN/+tsnpIR0MUKpVPKb4Wfv3WTnHNtCjQ==
X-Received: by 2002:a05:651c:a05:b0:26c:5010:39d1 with SMTP id k5-20020a05651c0a0500b0026c501039d1mr2768953ljq.115.1663929029776;
        Fri, 23 Sep 2022 03:30:29 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f16-20020a2ea0d0000000b00268335eaa8asm1317133ljm.51.2022.09.23.03.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 03:30:29 -0700 (PDT)
Message-ID: <eba9df27-cf91-b20d-bdc1-5acc5f02753a@linaro.org>
Date:   Fri, 23 Sep 2022 12:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: fsl_rpmsg: Add a property to
 assign the rpmsg channel
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20220914105145.2543646-1-chancel.liu@nxp.com>
 <20220914105145.2543646-2-chancel.liu@nxp.com>
 <20220916185048.GA1061412-robh@kernel.org>
 <VI1PR04MB4222BDB1378A01E99DFC6211E3519@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB4222BDB1378A01E99DFC6211E3519@VI1PR04MB4222.eurprd04.prod.outlook.com>
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

On 23/09/2022 11:56, Chancel Liu wrote:
>>> Add a string property to assign the rpmsg channel this sound card sits
>>> on. It also represents the name of ASoC platform driver. This property
>>> can be omitted if there is only one sound card and it sits on
>>> "rpmsg-audio-channel".
>>>
>>> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
>>> ---
>>>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 37 ++++++++++++++++++-
>>>  1 file changed, 35 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>> b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> index d370c98a62c7..3744ae794c00 100644
>>> --- a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> @@ -11,8 +11,11 @@ maintainers:
>>>
>>>  description: |
>>>    fsl_rpmsg is a virtual audio device. Mapping to real hardware devices
>>> -  are SAI, DMA controlled by Cortex M core. What we see from Linux
>>> -  side is a device which provides audio service by rpmsg channel.
>>> +  are SAI, MICFIL, DMA controlled by Cortex M core. What we see from
>>> +  Linux side is a device which provides audio service by rpmsg channel.
>>> +  We can create different sound cards which access different hardwares
>>> +  such as SAI, MICFIL, .etc through building rpmsg channels between
>>> +  Cortex-A and Cortex-M.
>>>
>>>  properties:
>>>    compatible:
>>> @@ -85,6 +88,17 @@ properties:
>>>        This is a boolean property. If present, the receiving function
>>>        will be enabled.
>>>
>>> +  fsl,rpmsg-channel-name:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      A string property to assign rpmsg channel this sound card sits on.
>>> +      It also represents the name of ASoC platform driver. This property
>>
>> That's a Linux detail which doesn't belong in DT.
>>
> 
> We pass hardware parameters in dts node to set up clocks or other
> configurations. These configurations are finally sent to Cortex-M by
> rpmsg channel because Cortex-M actually controls real hardware devices.
> If there's only one sound card sits on one rpmsg channel we will not
> need this property. But if there are several sound cards we need to
> specify correct rpmsg channel. Thus hardware configurations can be
> properly sent to Cortex-M. From this level to speak, this property is
> hardware-related since rpmsg channel represents the real hardware audio
> controller.
> 
> Here I attach the discussion in version 1 patches for your information:
> ---
> This property aims to tell the ASoC driver which rpmsg channel the
> sound card depends on. If there are several sound cards sit on rpmsg,
> we should pass correct information in dts node to specify the name of
> rpmsg channel. That is why I meant to add this property. 
> 
> Actually this property is hardware-related. As we discussed before,
> this kind of sound card based on rpmsg works under this mechanism
> Cortex-A core tells the Cortex-M core configuration of the PCM
> parameters then Cortex-M controls real hardware devices. This property
> specifying rpmsg channel represents the real hardware audio controller.
> ---
> 
> That's my idea adding this property. Do you have any suggstion?

I think you misunderstood the comment. Rob's comment was directly below
a line which he referred to. That line contained a statement referring
to Linux drivers. Anything related to Linux drivers does not belong to DT.


Best regards,
Krzysztof

