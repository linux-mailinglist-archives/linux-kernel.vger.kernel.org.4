Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A505B69B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIMIkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIMIjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:39:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D224388B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:39:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so19515524wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uXn2kJmSnOy/skqD13Z6q/Bm/edUDnU+xZ+VxBn/tq8=;
        b=IqhQhQ7VlpeOfvp3Gjx1Jcswtb9IN9La2TCB/B6Ps/qALDH7gISIMKnvskAfLI6vKi
         LazyuZYo/rapSrf/MnH4Y69v24Q/3UV0iGMxpkZ/l3zAk/93Z+yzUXuuAfW5M49dLXzy
         d1mGbjxif3uXKOQHxc/+jzCkFYEyHe+NZzH4QkloJgVHyLM4FKs509jw+v+ZMQCWUQ+h
         5w5RGsYJ1FQZVJN8aQ294C4SafBWv037zj2MISDbzb27woZbF8Cv9Q24HHFWL+HW3HHf
         uIIThnOhiNcpve3kl0zOCN41VN386ct5qS1YBOg1y//Jr+C0JfQvcft31yY29yGv/9LG
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uXn2kJmSnOy/skqD13Z6q/Bm/edUDnU+xZ+VxBn/tq8=;
        b=06gI9X0EGninFV0JNayQ03LtcBaSYmYYB+8EFweB5HBeujskSUKqzbkorL3d73dDG7
         J2KbXHKoC9oItkf6bw2Snz0HcRGh/ObAC6gRc0g8woVHocHYvtDbH6XzYpRQHN/je9oc
         7jEEDnuCgFP058Rr/xszoAgtgW6HLmiyRhtdXjpooxKGIoqocfYAValr/e/8ksDWpLa9
         RdwefqTojotPpq62XFMHqGq2267BibOALgbW5CBSrMs0F0SvZZIfpkOfZeT0rIf8TPZw
         P7bdcK9b1Gt+V3mgFY9lo1wdpjL+QobgaEW28Yz23OSaGYk6mpTJsai4hl1g94PTDDoA
         OQrg==
X-Gm-Message-State: ACgBeo3zPw57MEwud68YPtDUc9VLmi3/QwkQp0TZLmLcPY/8hoRSXiuu
        DF8mWv/Th03J4TMfDbKqeCUZrg==
X-Google-Smtp-Source: AA6agR6xDP8YhUAqPRV2B1RS5sMRp8HTP1cLkkOYlHerD1lbSH3yDIQOMd8tXRMgT1B4nqloLOQuGw==
X-Received: by 2002:a05:6000:2a6:b0:22a:baa9:3103 with SMTP id l6-20020a05600002a600b0022abaa93103mr2430328wry.376.1663058375003;
        Tue, 13 Sep 2022 01:39:35 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5085000000b002253d865715sm9870008wrt.87.2022.09.13.01.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 01:39:34 -0700 (PDT)
Message-ID: <e160baf1-cca9-46b6-eaf7-129b1b1eb9c3@linaro.org>
Date:   Tue, 13 Sep 2022 10:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/5] ASoC: dt-bindings: fsl_rpmsg: Add a property to
 assign platform driver name
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <VI1PR04MB4222EAA244F7A7F179E85500E3479@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB4222EAA244F7A7F179E85500E3479@VI1PR04MB4222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 09:14, Chancel Liu wrote:
>>> Add a string property to assign ASoC platform driver name. It also
>>> represents the rpmsg channel this sound card sits on. This property
>>> can be omitted if there is only one sound card and it sits on
>>> "rpmsg-audio-channel".
>>>
>>> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
>>> ---
>>>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 34 +++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>> b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> index d370c98a62c7..35e3cb9f768b 100644
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
>>> @@ -85,6 +88,14 @@ properties:
>>>        This is a boolean property. If present, the receiving function
>>>        will be enabled.
>>>
>>> +  fsl,platform:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      A string property to assign ASoC platform driver name.
>>
>> No, this is not a property of hardware. Naming of some drivers in some
>> systems does not fit DTS and bindings.
>>
> 
> This property aims to tell the ASoC driver which rpmsg channel the
> sound card depends on. If there are several sound cards sit on rpmsg,
> we should pass correct information in dts node to specify the name of
> rpmsg channel. That is why I meant to add this property. I just want to
> use a string property to distinguish different names of rpmsg channel.
> 
> Actually this property is hardware-related. As we discussed before,
> this kind of sound card based on rpmsg works under this mechanism
> Cortex-A core tells the Cortex-M core configuration of the PCM
> parameters then Cortex-M controls real hardware devices. This property
> specifying rpmsg channel represents the real hardware audio controller.
> 
> That's my idea adding this property. Do you have any better suggestion?

Any reason why not using phandle to sound card node? If your property is
about rpmsg channel name, use something like that, e.g.
"fsl,rpmsg-channel-name" or What you wrote in property description and
here are quite different things...

Best regards,
Krzysztof
