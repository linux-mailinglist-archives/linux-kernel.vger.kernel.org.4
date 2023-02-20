Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804169C9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBTL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjBTL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:27:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27365AD;
        Mon, 20 Feb 2023 03:27:23 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66272660213E;
        Mon, 20 Feb 2023 11:27:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676892442;
        bh=Ccrr/t4+V0OVhZ8gqGibkB/KOTRPiWU2u1jxcFC3QY8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iqKdIru32vHfY8IikTkBuOYDwm/PEvVwiXXTbSEEM6JQDSYhqkM0QEXpgXnx2EVHT
         V4Ht1juoMp41IRJT6k+gTQm76I6uniiisL4G6kTAMjqKuziOR/HzqxjEfrG5P8D56z
         /7ayqtpWo4zi7MzafWXd2aw1AlXNWjwJXqYV6UKFbvPiCadkc2IHwEru/Tiq6GOKoz
         /54259VsZUrtEN7xgd9Ak2uOz7nt1vlkR+tp5j2BbhwZ4FV2jwnJpXLBFU7q5I0TUz
         U4oiPXXOB3SmvnSA5QmhQKj2Uc6XlARftU3qBu4BYyCugEI96PbWjo/r3uHsip92nf
         s6bS6JuQRrI1g==
Message-ID: <1274e18b-e35e-7997-68ea-22aa11592720@collabora.com>
Date:   Mon, 20 Feb 2023 12:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v10 2/6] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
 <20230217231330.GA2238521-robh@kernel.org>
 <c2bfa6b0-edee-b492-d40e-cf43291b90d4@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c2bfa6b0-edee-b492-d40e-cf43291b90d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/23 01:26, Konrad Dybcio ha scritto:
> 
> 
> On 18.02.2023 00:13, Rob Herring wrote:
>> On Fri, Feb 17, 2023 at 12:08:25PM +0100, Konrad Dybcio wrote:
>>> CPR3 and newer can be fed per-OPP voltage adjustment values for both
>>> open- and closed-loop paths to make better decisions about settling
>>> on the final voltage offset target. Document these properties.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>> index a30ef93213c0..93cc88434dfe 100644
>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>>> @@ -34,6 +34,20 @@ patternProperties:
>>>           minItems: 1
>>>           maxItems: 2
>>>   
>>> +      qcom,opp-cloop-vadj:
>>> +        description: |
>>> +          A value representing the closed-loop voltage adjustment value
>>
>> A value?
>>
>>> +          associated with this OPP node.
>>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>>> +        maxItems: 2
>>
>> Or 2 values?
> Right, this description doesn't make any sense if you're just
> looking at the documentation without looking at the driver..
> 
> Generally, each CPR3 instance can have multiple "threads"
> (each one of which regulates voltage for some on-SoC IP or
> part of it). The nth entry in the qcom,opp-[co]loop-vadj
> array corresponds to a voltage offset for the nth thread.
> 
> If the nth entry in the array is missing, the driver assumes
> the arr[0] one is "global" to this CPR3 instance at this OPP
> level and applies it to all threads. ...and looking at it
> again, this is sorta just bad design, especially if you
> take into account that there's no known user of CPR3 that
> employs more than 2 threads.
> 
> I'll remove that from the driver and make the description clearer.
> 

description:
   Represents the closed-loop voltage adjustment associated with
   this OPP node.

P.S.: Drop '|' here and on oloop!

This binding is intended to support either single or multiple CPR threads;
the driver's behavior is unimportant as bindings describe the hardware,
not the driver.

Regards,
Angelo

> 
> Also, only noticed now.. "qcom,sdm630-cprh" was not documented,
> so that's to be fixed for the next submission as well!
> 
> 
> Konrad
>>
>>> +
>>> +      qcom,opp-oloop-vadj:
>>> +        description: |
>>> +          A value representing the open-loop voltage adjustment value
>>> +          associated with this OPP node.
>>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>>> +        maxItems: 2
>>> +
>>>       required:
>>>         - opp-level
>>>         - qcom,opp-fuse-level
>>>
>>> -- 
>>> 2.39.1
>>>



