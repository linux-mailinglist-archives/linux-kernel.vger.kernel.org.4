Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB6616D10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiKBSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiKBSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:47:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A482FFD4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:47:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z6so11928491qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtKcJi4R+48TsMqCQH8XbgPczt6c7dDfQAB3HD59hhY=;
        b=pfumJRZiHgyJtXnF8PDr9lKiJtTxPbqBr1M1hCs6+w3gsHb3qhj7zcyp30HmvnyZjt
         nY51eJMa4l0wv1s/JGywDrh7oO19aAsyEiieQ/7q0RntsmIjE90KfUtY4kzzlCmTgaCk
         IqaVAr0069VGzZNijegHpWaNlTeHpIaGa7TuPDAkkc3cEngVPMx3+/JgNezm9OHrqyqJ
         v+fCkElj1RSKTTZ2m9UwiTZ0Q4c3lsr63S7Kf8juhl9tWLLge9nZKtwbIrcZeb/ynqId
         AZ8ImC5YP698K5O0sEHzd/xM8KXBr/L6ovJoW1TQcVHE21bHXw33jqHqoB68nyEBMPTn
         +5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtKcJi4R+48TsMqCQH8XbgPczt6c7dDfQAB3HD59hhY=;
        b=XaIFNlhKTaziTS0zaPpr6C8izz6RJWrqhrNQFR64QrVbTG6m7DelmNrXczyKU9rCZj
         cjisLMREuM5qO+5r7enet8D8+w7QVYjIlqhbGNBiCdoL8ZMChULne7agG5+j0ZIU2E//
         moN3i4lyaDxXhCad9dyo9HnPsdO7HY7UMpYGnBIGJbViSv05lBmaIbW2ibEE7c1vuF+d
         VfjM5ylaqBRQ1ppH9haGgcuuUkW1iISo9KM/VAOnB/iz1FXCxfvXpt79+hTv5Z2m0muH
         uaXytppEYrd7at9cSQRjQ/ZBhjzJIz6M+4V30ojNLLhM47Vn6EMS6aWgxdvp+9tsQiTn
         pcIA==
X-Gm-Message-State: ACrzQf1fJf+zre2fZTkjh4WWzUZElpVyQpO9hmS/EWsYICEowfXfFt3u
        CoUkzvxWGewkwsZSMVQAVM1uTA==
X-Google-Smtp-Source: AMsMyM7tImKnGk9XhaAiOo0zzhJ2EQR6Zs464t+GgKh7kg2gdsVZ7zA3dCADMCh4CvutPud+rvmN1A==
X-Received: by 2002:a05:622a:64f:b0:3a5:d40:b58d with SMTP id a15-20020a05622a064f00b003a50d40b58dmr21547399qtb.308.1667414832073;
        Wed, 02 Nov 2022 11:47:12 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a40d300b006eea4b5abcesm9162922qko.89.2022.11.02.11.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:47:11 -0700 (PDT)
Message-ID: <c9c3bffc-0d2a-ef67-ccab-ee040608405a@linaro.org>
Date:   Wed, 2 Nov 2022 14:47:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 02/13] dt-bindings: Add binding for gunyah hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-3-quic_eberman@quicinc.com>
 <20221012155645.GA2173829-robh@kernel.org>
 <ca13eb92-9b5b-19fd-27a5-f91f5048b142@quicinc.com>
 <CAL_Jsq+cR5AEa5i1u-_L6sP6nYXS6qgaVWZ=KwxpUbxV3ZW-BA@mail.gmail.com>
 <75ef3cc5-3b19-9eab-b3eb-56fa254d92bd@quicinc.com>
 <79673829-a079-201f-91e1-790eb7cc3a4b@linaro.org>
 <df09560d-803b-33f6-69ed-6d377d05d336@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df09560d-803b-33f6-69ed-6d377d05d336@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 23:19, Elliot Berman wrote:
> 
> 
> On 10/27/2022 12:55 PM, Krzysztof Kozlowski wrote:
>> On 27/10/2022 12:17, Elliot Berman wrote:
>>> Hi Rob,
>>>
>>> On 10/26/2022 2:16 PM, Rob Herring wrote:
>>>> On Thu, Oct 13, 2022 at 6:59 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>>>>
>>>>>
>>>>> On 10/12/2022 8:56 AM, Rob Herring wrote:
>>>>>> On Mon, Oct 10, 2022 at 05:08:29PM -0700, Elliot Berman wrote:
>>>>>>> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
>>>>>>> Resource Manager applies a devicetree overlay describing the virtual
>>>>>>> platform configuration of the guest VM, such as the message queue
>>>>>>> capability IDs for communicating with the Resource Manager. This
>>>>>>> information is not otherwise discoverable by a VM: the Gunyah hypervisor
>>>>>>> core does not provide a direct interface to discover capability IDs nor
>>>>>>> a way to communicate with RM without having already known the
>>>>>>> corresponding message queue capability ID. Add the DT bindings that
>>>>>>> Gunyah adheres for the hypervisor node and message queues.
>>>>>>>
>>>>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>>>>> ---
>>>>>>>     .../bindings/firmware/gunyah-hypervisor.yaml  | 87 +++++++++++++++++++
>>>>>>>     MAINTAINERS                                   |  1 +
>>>>>>>     2 files changed, 88 insertions(+)
>>>>>>>     create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..f0a14101e2fd
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>>>>>> @@ -0,0 +1,87 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Gunyah Hypervisor
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Murali Nalajala <quic_mnalajal@quicinc.com>
>>>>>>> +  - Elliot Berman <quic_eberman@quicinc.com>
>>>>>>> +
>>>>>>> +description: |+
>>>>>>> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which
>>>>>>
>>>>>> How you end up with the node (applying an overlay) is not relavent to
>>>>>> the binding.
>>>>>>
>>>>>>> +  describes the basic configuration of the hypervisor. Virtual machines use this information to determine
>>>>>>> +  the capability IDs of the message queues used to communicate with the Gunyah Resource Manager.
>>>>>>
>>>>>> Wrap at 80. That is the coding standard still though 100 is deemed
>>>>>> allowed. And yamllint only complains at 110 because I didn't care to fix
>>>>>> everyones lines over 100.
>>>>>>
>>>>>>> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - const: gunyah-hypervisor-1.0
>>>>>>> +      - const: gunyah-hypervisor
>>>>>>
>>>>>> 2 compatibles implies a difference between the 2. What's the difference?
>>>>>> Where does '1.0' come from?
>>>>>>
>>>>>
>>>>> There's no difference. I thought the convention was to have
>>>>> device-specific compatible and the generic compatible. "device-specific"
>>>>> here would be specific to version of Gunyah since it's software.
>>>>
>>>> No, that's just what people do because "vendor,new-soc",
>>>> "vendor,old-soc" seems to bother them for some reason. At the end of
>>>> the day, it's just a string identifier that means something. If
>>>> there's no difference in that 'something', then there is no point in
>>>> having more than one string.
>>>>
>>>> You only need something specific enough to discover the rest from the
>>>> firmware. When that changes, then you add a new compatible. Of course,
>>>> if you want existing OSs to work, then better not change the
>>>> compatible.
>>>>
>>>
>>> Thanks for the info, I'll drop the "-1.0" suffix.
>>
>> You still did not answer from where does 1.0 come from... Compatibles
>> are usually expected to be specific.
>>
> 
> The 1.0 comes from the Gunyah version. This is the same version returned 
> by "hyp_identify" hypercall.

Then dropping 1.0 makes sense - your SW provides auto-detection.

Best regards,
Krzysztof

