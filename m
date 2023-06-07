Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59E7257B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjFGIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjFGIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:33:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E991BC0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:32:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9768fd99c0cso73899166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126771; x=1688718771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpDlHcbJHZOABsdriUz666FY8BvXiLezgu9TZBcdDW0=;
        b=Z1hrcn2+9k8mdcJGNulQyrHTib3Jub4YR0mKlny3Id6a1OXFE9BP7pMFkNLDEp1Tv2
         YFgLrXeGbXHrawhMOh2rg66aumYEfqpYfwUET+Y6ZntmDcc5M2ZNqbqPF4jZ5lKVM3UI
         5wO4entR+bZP2kyULUo6tFtG4ZOJOylz2psszOCMmoHib/wv+NMUsj5AU8/46Y3aEFj1
         Toq3ERthwgpbSLdLazVHWo0iIoJNpr8JvHxrP4mC///jxUwXoxz6cIWGjD+ZjBIFnvto
         gijTiDdcv6/dv9xyOQAFvU9Njg50qDaheBIPwYzs2XEpQzyoueLlVbCWdwPTYqfAsKhA
         /HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126771; x=1688718771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpDlHcbJHZOABsdriUz666FY8BvXiLezgu9TZBcdDW0=;
        b=QZc6kwH42bHBuk3QY1iDFYlMjC07bCvFI5gZjhU6WmoLi5K104PD6+GUQynepahU3L
         51aAgiT4PKfkMivl/1kAfOoK5bx92RgsiK6dxgsyALu4j75iNTzX18W/1fw6sMsgm0tc
         fv5Zjeffzm/eIjtRgjinPxPuyP0cli26GiQrZVzwxnqTtJ4L0eICKRTCCCc7aqf5x0En
         MzUq6jbDCV7RnRJPm9Wx7rN+GFCLxrLv1t30HpRZBOEMBNMN3ohVb7vnhzcoD2BZ5rpg
         9+nmzmNXu0brb3nLuD5vNspJyMjNR2v6KkID3GFMBzWWC0O8Ak4y+jXRG4inGT6Kg87U
         i4jg==
X-Gm-Message-State: AC+VfDzhNyAbBrUDITYr1MmfCCGCaZ83tvJ/yAcTcTcaDjv4Idit94XV
        pukXaNGFOmohU2c6bpGRssDfYQ==
X-Google-Smtp-Source: ACHHUZ7qbhYEELIkl8PU+xJK7pmozB76YjFukm/6sZ20WJhT59r/Ca58CM+5eYyWywDbQimr6aSSjA==
X-Received: by 2002:a17:907:6e8d:b0:973:84b0:b077 with SMTP id sh13-20020a1709076e8d00b0097384b0b077mr5090140ejc.33.1686126770705;
        Wed, 07 Jun 2023 01:32:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lu26-20020a170906fada00b009663115c8f8sm6580507ejb.152.2023.06.07.01.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:32:50 -0700 (PDT)
Message-ID: <60acd90c-95d0-0cd6-34ec-2ed09c8e610a@linaro.org>
Date:   Wed, 7 Jun 2023 10:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
 <2a479fd0-1d3c-2c28-d2fd-86a8cf610cf9@linaro.org>
 <ZH70kG7jZZgd9Esi@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZH70kG7jZZgd9Esi@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 10:55, Stephan Gerhold wrote:
> <On Tue, Jun 06, 2023 at 08:36:10AM +0200, Krzysztof Kozlowski wrote:
>> On 05/06/2023 09:08, Stephan Gerhold wrote:
>>> On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
>>> described as remote processors in the device tree, with a dedicated
>>> node where properties and services related to them can be described.
>>>
>>> The Resource Power Manager (RPM) is also such a subsystem, with a
>>> remote processor that is running a special firmware. Unfortunately,
>>> the RPM never got a dedicated node representing it properly in the
>>> device tree. Most of the RPM services are described below a top-level
>>> /smd or /rpm-glink node.
>>
>> Then what is rpm-requests? This is the true RPM. It looks like you now
>> duplicate half of it in a node above. Unless you want here to describe
>> ways to communicate with the RPM, not the RPM itself.
>>
> 
> I think you're confusing hardware and firmware here. The rpm-proc node
> represents the RPM hardware block (or perhaps the RPM firmware overall),
> while rpm-requests is just *one* communication interface provided by the
> RPM firmware. Here is a rough picture of the RPM "subsystem" I'm trying
> to describe:
> 
>                 +--------------------------------------------+      
>                 |       RPM subsystem (qcom,rpm-proc)        |      
>                 |                                            |      
>           reset | +---------------+     +-----+  +-----+     |      
>         --------->|               |     | MPM |  | CPR | ... |      
>  IPC interrupts | | ARM Cortex-M3 |     +-----+  +-----+     |      
> ----------------->|               |---     |        |        |      
>                 | +---------------+  |---------------------- |      
>                 | +---------------+  |                       |      
>                 | |   Code RAM    |--|  +------------------+ |      
>                 | +---------------+  |  |                  | |      
>                 | +---------------+  |  |   Message RAM    | |      
>                 | |   Data RAM    |--|--|                  | |      
>                 | +---------------+  |  +------------------+ |      
>                 +--------------------|-----------------------+      
>                                      v                              
>                                     NoC                             
> 
> (Somewhat adapted from Figure 8-1 RPM overview in the APQ8016E Technical
>  Reference Manual, but I added some extra stuff.)
> 
> As you can see neither "SMD" nor "rpm-requests" exist in hardware.
> Again, it's just one communication protocol implemented by the RPM
> firmware running on the Cortex-M3 processor, much like a webserver
> running on a PC.
> 
> When the SoC is started only the hardware block exists. Usually a
> component in the boot chain loads firmware into the code/data RAM and
> then de-asserts the reset line to start the Cortex-M3 processor.
> 
> This is not guaranteed to happen. For example, I have a special firmware
> version where the firmware is only loaded but not brought out of reset.
> In this case Linux is responsible to de-assert the reset line.
> In follow-up patches I add that to the outer qcom,rpm-proc node:
> 
> 	remoteproc {
> 		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
> 		resets = <&gcc GCC_RPM_RESET>;
> 		iommus = <&apps_smmu 0x0040>;
> 
> 		smd-edge {
> 			/* ... */
> 			rpm-requests {
> 				qcom,smd-channels = "rpm_requests";
> 			};
> 		};
> 	};
> 
> This reset line cannot be described on the rpm-requests node. Until the
> firmware is started there is no such thing as "SMD" or "rpm-requests".

OK, that makes sense, thank you for clarifying. It would be nice to
include it in the binding description (especially that you already wrote
it for me in the email :) ).

> 
> When the RPM firmware is started it sets up some data structures in the
> message RAM and then begins serving requests, perhaps like this:
> 
>                +----------------------------------+                                    
>                |          ARM Cortex-M3           |                                    
>                | +------------------------------+ |  +--------------------------------+
>                | |  RPM Firmware                | |  |          Message RAM           |
>  IPC Interrupt | | +----------------------+     | |  | +----------------------------+ |
> ------------------>| SMD Server           |     | |  | | SMD Data Structures & FIFO | |
>                | | | +--------------+     |     | |  | | +--------------+           | |
>                | | | | rpm_requests | ... |     | |  | | | rpm_requests |    ...    | |
>                | | | +--------------+     | ... | |  | | +--------------+           | |
>                | | +----------------------+     | |  | +----------------------------+ |
>                | +------------------------------+ |  |                ...             |
>                +----------------------------------+  +--------------------------------+
> 
> The "smd-edge" node represents the SMD part and "rpm_requests" is one
> of the communication channels that can be used to talk to the RPM firmware.
> 
> Everything below rpm-requests: clocks, regulators, power domains are
> pure firmware constructions. They do not exist in the RPM hardware block,
> the firmware just acts as a proxy to collect votes from different
> clients and then configures the actual hardware.

OK

>  
>>
>>> However, SMD/GLINK is just one of the communication channels to the RPM
>>> firmware. For example, the MPM interrupt functionality provided by the
>>> RPM does not use SMD/GLINK but writes directly to a special memory
>>> region allocated by the RPM firmware in combination with a mailbox.
>>> Currently there is no good place in the device tree to describe this
>>> functionality. It doesn't belong below SMD/GLINK but it's not an
>>> independent top-level device either.
>>>
>>> Introduce a new "qcom,rpm-proc" compatible that allows describing the
>>> RPM as a remote processor/subsystem like all others. The SMD/GLINK node
>>> is moved to a "smd-edge"/"glink-edge" subnode consistent with other
>>> existing bindings. Additional subnodes (e.g. interrupt-controller for
>>> MPM, rpm-master-stats) can be also added there.
>>
>> If this was about to stay, you should also update the qcom,smd.yaml, so
>> there will be no duplication.
>>
> 
> qcom,smd.yaml is deprecated in the next patch (PATCH 07/14).

Please squash it, because it is logically one change - you rework one
solution and deprecate other.

> 
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
>>>  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
>>>  1 file changed, 125 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
>>> new file mode 100644
>>> index 000000000000..c06dd4f66503
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
>>> @@ -0,0 +1,125 @@
>>> [...]
>>> +  interrupt-controller:
>>> +    type: object
>>> +    $ref: /schemas/interrupt-controller/qcom,mpm.yaml#
>>> +    description:
>>> +      MSM Power Manager (MPM) interrupt controller that monitors interrupts
>>> +      when the system is asleep.
>>
>> Isn't this a service of RPM?
>>
>>> +
>>> +  master-stats:
>>> +    $ref: /schemas/soc/qcom/qcom,rpm-master-stats.yaml#
>>> +    description:
>>> +      Subsystem-level low-power mode statistics provided by RPM.
>>
>> The same question.
>>
> 
> Yes, they are services of the RPM firmware. But they have no relation to
> the SMD/GLINK channel.
> 
> To clarify this I extend my picture from above with MPM:
> 
>                  +----------------------------------+                                    
>                  |          ARM Cortex-M3           |                                    
>                  | +------------------------------+ |  +--------------------------------+
>                  | |  RPM Firmware                | |  |          Message RAM           |
>  IPC Interrupt 0 | | +----------------------+     | |  | +----------------------------+ |
>  ------------------->| SMD Server           |     | |  | | SMD Data Structures & FIFO | |
>                  | | | +--------------+     |     | |  | | +--------------+           | |
>                  | | | | rpm_requests | ... |     | |  | | | rpm_requests |    ...    | |
>                  | | | +--------------+     | ... | |  | | +--------------+           | |
>                  | | +----------------------+     | |  | +----------------------------+ |
>  IPC Interrupt 1 | | +----------------------+     | |  | +----------------------------+ |
>  ------------------->| MPM virtualization   |<-----------| MPM register copy (vMPM)   | |
>                  | | +----------------------+     | |  | +----------------------------+ |
>                  | +-----------|------------------+ |  |              ...               |
>                  +-------------v--------------------+  +--------------------------------+
>                        +--------------+                                                  
>                        | MPM Hardware |                                                  
>                        +--------------+                                                  
> 
> As you can see, SMD and MPM are siblings. The MPM functionality
> implemented by the RPM firmware is not a child of the SMD server.

OK, also please include it in the description.

> 
> It's a bit like a webserver and emailserver running on the same PC.
> Two separate services accessible via different ports and protocols.
> 
> Thanks,
> Stephan
> 
> NOTE: All of this is just my interpretation based on the public hints
> that exist. I have no access to internal documentation or source code
> that would prove that all of this is correct.

Sounds good enough for me :). Thank you.

Best regards,
Krzysztof

