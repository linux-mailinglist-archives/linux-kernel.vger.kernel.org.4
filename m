Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E786198EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKDOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKDOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:12:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24DE2F66A;
        Fri,  4 Nov 2022 07:12:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEC406602983;
        Fri,  4 Nov 2022 14:12:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667571145;
        bh=E/ZzSsVRUwbO05GoLP6P7MnbEOAXXssqTC73MARKT9w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IbAIC/azZYWBPQAO6MJ9kavEZMFgWgyOQmEH1Lwbzcq5qrrUxRd9tzVYfmEnnt7n6
         Qf9Torw+lDxYLn0Lo6NA2W8Ned2gMsGLOT/X/ooAt+o33UzsFKv5ct9wMr49nZTW8j
         N7RHAN9r9VJYnn+wfNO0OgA/rUi4VVlWf+TRurX4ix2YTg4k0LVIVTvTgwwxbvDe7d
         jJtC6/Nw5Ue/Mx/yDmZ/vyjZyM0H/Yc72Cuzdd/Qu302M6hfP3yKJPv3+SSWo48HLs
         07aTm6ayM9jzXkaZCwxYzc/7TDX8tMv7RboAOB9MFIhBypXR318GMA7mlpkwMELkh5
         +1FkFf64m9wyg==
Message-ID: <34f9a445-74bd-95e8-f1a6-5b142b95ee6f@collabora.com>
Date:   Fri, 4 Nov 2022 15:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
 <20221104133506.131316-2-angelogioacchino.delregno@collabora.com>
 <4bd3afed-f0c7-8479-2e35-f56f542da674@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4bd3afed-f0c7-8479-2e35-f56f542da674@linaro.org>
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

Il 04/11/22 15:00, Krzysztof Kozlowski ha scritto:
> On 04/11/2022 09:35, AngeloGioacchino Del Regno wrote:
>> Document bindings for the Qualcomm Ramp Controller, found on various
>> legacy Qualcomm SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../soc/qcom/qcom,ramp-controller.yaml        | 42 +++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
> 
> Filename based on compatible, so qcom,msm8976-ramp-controller.yaml
> 
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
>> new file mode 100644
>> index 000000000000..95ce48cfca4e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramp-controller.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop quotes from both lines above.
> 
>> +
>> +title: Qualcomm Ramp Controller
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The Ramp Controller is used to program the sequence ID for pulse
>> +  swallowing, enable sequences and linking Sequence IDs (SIDs) for
> 
> s/linking/link/ if I understand the sentence correctly (is used to:
> program, enable and link)
> 
>> +  the CPU cores on some Qualcomm SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> Drop items.
> 
>> +      enum:
> 
> I also think you did not test it...

I'm sorry, I acknowledged that I didn't test the yaml only after sending it...
v2 is coming :-)

Thanks,
Angelo

