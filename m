Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C06D949C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjDFLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjDFLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:02:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79057A97
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:02:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so394232ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680778966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN0OWf//Z3RaQ4PbapSW+hfWfT9/2ODhlOs9zD/jp+4=;
        b=bN1Djfwr4R5Ksf/VBsNRueEse4FjoXdaZZ/Z4rgj2s11YX9dfsQEjL7PkriW+4Lx6w
         g5xTbzmxhpT6nn8M9XcvYdu7QB0oftJ+knVLAxJ5+dp4aTaur37dui5Ys5dhmLkokb/g
         dvRhOgQgL/M9To6tvkbvBytcGHVFGnVqF0VJC9lL0bR3HyfRrJQypVWnkGTLIMrzA7iW
         R6Kpv+yGBjl56gI1s3v26aurz6k7xuEWZ1+HDr3kjZra1jaMkORkFh7idyj796Owv/NO
         0T8vUXNtIishxwmEAALqpsWdJL6+C5luW48nvsyoSjiL1L/ZinISl4RrAEQvsnRLCEN8
         r3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN0OWf//Z3RaQ4PbapSW+hfWfT9/2ODhlOs9zD/jp+4=;
        b=c9AjZVOhGimzER74BOh88p8ZxFKWxiVKH1wA8yHPnE3+6SNtRCl+9QB1tCkQd6sdVg
         KZoXVe2UKP+/u9wdxj7W0cUSjGD4oSYCaIfEc/IywTkOD6rzstdhObqSgG6kv0HVKY3B
         8n58teYaKlDwvIeZtOAvcKUPPdZ6f5unQpCwtvsrGZ/EvKUUyBcbpOdZcLDEK6Pc/cm9
         lbXS/z35CNfhW35mgpJisbDgxAkRQCUudzbJ2jQh+w04BRcVxFNGYPlVqYOuV/+7bwCh
         v1crej8hZEwAWKUsCOD1CK6/GqPONbLFemuBrsuwj0M8eurkf9jvCjoX71PUBl5NQAmi
         agUQ==
X-Gm-Message-State: AAQBX9fm4cGdEsqOo3+rVAVN3bdlquWo7srrp3d5Nj1Y9y+svytnv0G9
        gWuoYUU+lbanQGtcgT1fRCqlPg==
X-Google-Smtp-Source: AKy350YQPdIYKnjdyZIJQaSFGHLBoDkWVJChEHBifaKzvwtbGI6HtMQaw1reHUZmC3yS8DuswmXt5A==
X-Received: by 2002:a17:906:95c1:b0:8f6:dc49:337f with SMTP id n1-20020a17090695c100b008f6dc49337fmr5525355ejy.43.1680778966362;
        Thu, 06 Apr 2023 04:02:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id hx23-20020a170906847700b0094928b18886sm673428ejc.52.2023.04.06.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 04:02:46 -0700 (PDT)
Message-ID: <0f671b8a-fbc4-a7c0-1469-a9e3f180e776@linaro.org>
Date:   Thu, 6 Apr 2023 13:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <20230404145350.45388-2-sebastian.reichel@collabora.com>
 <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
 <20230406105129.nuv3jcmwl7ugql3q@mercury.elektranox.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406105129.nuv3jcmwl7ugql3q@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:51, Sebastian Reichel wrote:
> Hi Krzysztof,
> 
> On Thu, Apr 06, 2023 at 09:45:11AM +0200, Krzysztof Kozlowski wrote:
>> On 04/04/2023 16:53, Sebastian Reichel wrote:
>>> Add compatible for RK3588 OHCI. As far as I know it's fully
>>> compatible with generic-ohci.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>  .../devicetree/bindings/usb/generic-ohci.yaml  | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
>>> index a9ba7257b884..d84732a100ba 100644
>>> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
>>> @@ -44,6 +44,7 @@ properties:
>>>                - hpe,gxp-ohci
>>>                - ibm,476gtr-ohci
>>>                - ingenic,jz4740-ohci
>>> +              - rockchip,rk3588-ohci
>>>                - snps,hsdk-v1.0-ohci
>>>            - const: generic-ohci
>>>        - enum:
>>> @@ -68,8 +69,6 @@ properties:
>>>      maxItems: 2
>>>  
>>>    clocks:
>>> -    minItems: 1
>>> -    maxItems: 3
>>
>> The constraints here should stay.
> 
> dtbs_check complained about the 4 RK3588 clock entries if this
> stays. That's why I moved them to the condition down below into
> the else branch.

Which is not what we want. We want the constraints here (the widest).

Best regards,
Krzysztof

