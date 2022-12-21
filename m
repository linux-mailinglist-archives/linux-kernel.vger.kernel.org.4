Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A186652EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiLUJhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiLUJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:36:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D21869D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:36:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y4so15023128ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfew9wJ0oRi5oX+KFDxohLP0QngFqNUymSxspt40HIs=;
        b=GwqduvWfwfh66g5ezo8U34l72xvIPaGCvMTRu9wchEopW4pLBCFv3qilVFtSaJGnNp
         NBubi4F/fq2ST2DAdg95tZLsfoDTmC7WmrbclkKVXdO5EgjWu2yjGxy6qayTXhHUc090
         g/jE4U6lduuKJAyVJIZAruS0szB71nqwjN//zSIOMIY8hDTnZJjKyZOOQU4DmGfHIHMw
         ObrzYar87lC+f7re0mkd3pnLbwUW1l65Wbv80V01sgh4sAhUCELUuvUZoH2XqyA9ad6T
         X4/hFuAGkbUUqRJmcLg+fCL/VlkaICnGvSa7nL/mYM9JtqB+fPwwZHU9THMwB5X8KOu2
         EBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfew9wJ0oRi5oX+KFDxohLP0QngFqNUymSxspt40HIs=;
        b=sLuj04erTsqjMIcfbJgx9GyE+yYrgLjmHYrLR1AJrpid3pse5dqwtq7gW6/uwpen4g
         gBzkdeYamimOSwMRDhXOtoH+iL+pFyaI2lyiugG7hsh1aUcbx1+LVCJzI+cl8/rfC5tD
         OZ3MExHtrE3EVXNrt086TFCLHUFYb1qPe36WO8J1PFT8WUHog3oQInAMm/C/DOvE8vwy
         h2NtoLDQ8lno7TGOm1s7earuFCtCgPwcAecs2rySdPGbsUXQP28Q7ggN/OKQPsPzCjTt
         8TdPJ1ta3QyJh+GIrm1edlDpkigqKvAnz3guXGRzkqNXyRb/RfGj2bD0DSMA0BUz1gmr
         GXjg==
X-Gm-Message-State: AFqh2kqUmmta7kSUAl5zaT4YPHlm2OlI2jXDjGVdhbBIUaltmkeS+L1s
        6Y1LJEC+rYLuvx+SwBLGnCTGeQ==
X-Google-Smtp-Source: AMrXdXtQuZJNcV1LmALPRvX6mBpvq5V5jt1kqL+XjtL6N/6kIwfc+JdfHMLzYaACOJrzxL3mqWkQEA==
X-Received: by 2002:a2e:8191:0:b0:277:77e:6027 with SMTP id e17-20020a2e8191000000b00277077e6027mr269589ljg.12.1671615411145;
        Wed, 21 Dec 2022 01:36:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f10-20020a2eb5aa000000b0027a0ec1f01asm1265959ljn.56.2022.12.21.01.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:36:50 -0800 (PST)
Message-ID: <12010f8f-d1d2-be18-8d4e-e1d282cb1670@linaro.org>
Date:   Wed, 21 Dec 2022 10:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new
 compatible for AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221130134052.7513-1-devarsht@ti.com>
 <20221130134052.7513-2-devarsht@ti.com>
 <b4b608bf-e347-5500-eb94-bec3611f6a56@linaro.org>
 <645aca4d-b19c-390d-b899-fd40a924a096@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <645aca4d-b19c-390d-b899-fd40a924a096@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 08:42, Devarsh Thakkar wrote:
> Hi Krzysztof,
> 
> Thanks for the review. Please find my response inline.
> 
> On 30/11/22 20:33, Krzysztof Kozlowski wrote:
>> On 30/11/2022 14:40, Devarsh Thakkar wrote:
>>> AM62 family of devices don't have a R5F cluster, instead
>>> they have single core DM R5F.
>>> Add new compatible string ti,am62-r5fss to support this scenario.
>>>
>>> When this new compatible is used don't allow cluster-mode
>>> property usage in device-tree as this implies that there
>>> is no R5F cluster available and only single R5F core
>>> is present.
>>>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>> V2: Avoid acronyms, use "Device Manager" instead of "DM"
>>
>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> Agreed, I will update the prefix as dt-bindings: remoteproc: k3-r5f: in V3.
>>
>>> ---
>>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
>>>  1 file changed, 34 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> index fb9605f0655b..91357635025a 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>> @@ -21,6 +21,9 @@ description: |
>>>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>>>    Core1's TCMs as well.
>>>  
>>> +  AM62 SoC family support a single R5F core only which runs Device Manager
>>> +  firmware and can also be used as a remote processor with IPC communication.
>>> +
>>>    Each Dual-Core R5F sub-system is represented as a single DTS node
>>>    representing the cluster, with a pair of child DT nodes representing
>>>    the individual R5F cores. Each node has a number of required or optional
>>> @@ -28,6 +31,9 @@ description: |
>>>    the device management of the remote processor and to communicate with the
>>>    remote processor.
>>>  
>>> +  Since AM62 SoC family only support a single core, there is no cluster-mode
>>> +  property setting required for it.
>>> +
>>>  properties:
>>>    $nodename:
>>>      pattern: "^r5fss(@.*)?"
>>> @@ -38,6 +44,7 @@ properties:
>>>        - ti,j721e-r5fss
>>>        - ti,j7200-r5fss
>>>        - ti,am64-r5fss
>>> +      - ti,am62-r5fss
>>
>> Some order? Alphabetical, so before am64? Same in other places.
> Agreed, I will update in V3 accordingly.
>>
>>
>>>        - ti,j721s2-r5fss
>>>  
>>>    power-domains:
>>> @@ -80,7 +87,8 @@ patternProperties:
>>>        node representing a TI instantiation of the Arm Cortex R5F core. There
>>>        are some specific integration differences for the IP like the usage of
>>>        a Region Address Translator (RAT) for translating the larger SoC bus
>>> -      addresses into a 32-bit address space for the processor.
>>> +      addresses into a 32-bit address space for the processor. For AM62x,
>>> +      should only define one R5F child node as it has only one core available.
>>>  
>>>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>>>        internal memories split between two banks - TCMA and TCMB (further
>>> @@ -104,6 +112,7 @@ patternProperties:
>>>            - ti,j721e-r5f
>>>            - ti,j7200-r5f
>>>            - ti,am64-r5f
>>> +          - ti,am62-r5f
>>>            - ti,j721s2-r5f
>>>  
>>>        reg:
>>> @@ -207,20 +216,31 @@ patternProperties:
>>>        - firmware-name
>>>  
>>>      unevaluatedProperties: false
>>
>> Blank line.
> Agreed, I will remove it in V3.
>>
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - ti,am64-r5fss
>>> +    then:
>>> +      properties:
>>> +        ti,cluster-mode:
>>> +          enum: [0, 2]
>>> +
>>> +    else:
>>> +      properties:
>>> +        ti,cluster-mode:
>>
>> It's not really valid anymore for ti,am62-r5fss, so this cannot be
>> simple "else".  Instead you need to list all compatibles.
> I agree that the else block is not valid for am62x, but my understanding is that since all the blocks under allOf are checked for validity,
> I thought to add a separate if block only for am62x to set cluster-mode to false [1], which I believe would negate the effect of above else condition for am62x,
> so that we don't have to list all compatibles under separate if blocks.
> 
> Just to verify this, I deliberately set cluster-mode=1 in am62x devicetree and then ran a dtbs-check and got below log : 
> "linux-next/arch/arm64/boot/dts/ti/k3-am625-sk.dtb: r5fss@78000000: ti,cluster-mode: False schema does not allow [[1]]"
> 
> and above warning log goes away when i remove the cluster-mode node in am62x devicetree.
> But please do let me know if I am missing something here or there is a better/more proper way to do this.

This was three weeks ago, so hundreds of patches ago, I don't remember
anymore.

Just look at your patch - it is clearly incorrect. You said in the patch
that for compatibles other than ti,am64-r5fss cluster mode is BOTH [0,
1] AND false.

I gave you the way to fix it. Feel free to fix it other ways if it gives
correct result.

Best regards,
Krzysztof

