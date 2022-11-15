Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75195629C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKOOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiKOOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:45:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCF2D1D3;
        Tue, 15 Nov 2022 06:44:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B7C46602A2B;
        Tue, 15 Nov 2022 14:44:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668523477;
        bh=MIYpf0mHYDWLVle4bO/msR94U3fhD3OM3lpPL+REXds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZWWpeYupRWST7G8bfRnYxT4+c7E8Bs/m/C2+5YC1qEiPPTjz0gwNN/ers00Vvhhu1
         5KVmOJP873AYidT2hJdIa3GraNG6fYFH2IAP6shlqbFRl0Z3RhESkdo0dWiysJVTXc
         qW20/OO3of6PpWUtC/o8+o9fpfZCX6ylGNUr6B6afuV3qZrf19yuOahyG3pydf4qD9
         gHsWENDAFd5VQZVYeoHW3ntpJ3FwEJw+t4p+90T2jcs29jbEvl1gbPJfoFG8KXSC4c
         ipb9n+16BQyUCm4qRjxgsiBtItA3rRMiHOtWB0YN9O42nsVH/H0e6JLugQ42tMO1kR
         ahdH1PH2ACz3A==
Message-ID: <3e9deab6-58ca-3a58-5f06-c1e4d181bc94@collabora.com>
Date:   Tue, 15 Nov 2022 15:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     marijn.suijten@somainline.org, konrad.dybcio@somainline.org,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
 <166758411781.2066027.6365889663189109123.robh@kernel.org>
 <160cb3fc-176e-bc0e-1bff-9334478af8ec@collabora.com>
 <342d556a-e710-590c-3c81-fcc60bbaa6e7@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <342d556a-e710-590c-3c81-fcc60bbaa6e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 14:36, Krzysztof Kozlowski ha scritto:
> On 11/11/2022 11:05, AngeloGioacchino Del Regno wrote:
>> Il 04/11/22 18:54, Rob Herring ha scritto:
>>>
>>> On Fri, 04 Nov 2022 15:22:03 +0100, AngeloGioacchino Del Regno wrote:
>>>> Document bindings for the Qualcomm Ramp Controller, found on various
>>>> legacy Qualcomm SoCs.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../qcom/qcom,msm8976-ramp-controller.yaml    | 37 +++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.example.dtb: power-controller@b014000: '#power-domain-cells' is a required property
>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/power-domain.yaml
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/patch/
>>>
>>> This check can fail if there are any dependencies. The base for a patch
>>> series is generally the most recent rc1.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit.
>>>
>>
>> I'm unsure about what I should do about this one.
>> This is a power-controller, but does *not* need any #power-domain-cells, as it is
>> standalone and doesn't require being attached to anything.
> 
> power-domain-cells are for power domain providers, not consumers. The
> generic binding expect that nodes called power-controller are exactly
> like that.
> 
> Solutions could be:
> 1. Rename the node to something else. I cannot deduct the type of the
> device based on description. What is "sequence ID" and how is it even
> closely related to power control?

This uC is mainly controlling DCVS, automagically plays with voltages for
each ramp up/down step and from what I understand also decides to shut down
or bring up *power* to "certain clocks" before ungating (CPU related, mainly
big cluster).
This also interacts with LMH - setting the LMH part makes it possible to
later use CPR (otherwise CPR errors out internally and won't start, as it
requires this controller, SAW and LMH to be set up in order to work).

What I've seen is that without it I can't bring up the big cluster at all,
not even at minimum frequency, as the HF2PLL (a clock source for that cluster)
will not power up.
All it takes is to initialize these params and start the controller, then
everything goes as it should.

If you're wondering why my explanation may not be particularly satisfying,
that's because downstream contains practically no information about this
one, apart from a bunch of lines of code and because this controller is
just a big black box.

> 
> 2. Narrow the node name in power-domain.yaml which would require changes
> in multiple DTS and bindings.
> 
> 3. Do not require power-domain-cells for power-controllers, only for
> power-domains.
> 

Solutions 2 and 3... well, I don't think that this would be really feasible
as I envision this being the one and only driver that will ever require
that kind of thing.
Also, this programming was later moved to bootloaders and the only SoCs that
will ever require this are MSM8956/76, MSM8953 and.. I think MSM8952 as well,
but nothing more.

Even if I can imagine the answer, I'm still tempted to ask: can we eventually
just name it ramp-controller@xxxx or qcom-rc@xxxx or something "special" like
that to overcome to this binding issue?

Regards,
Angelo

