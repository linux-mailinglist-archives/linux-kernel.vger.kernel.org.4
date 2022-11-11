Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B99625795
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiKKKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:05:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472BEE08A;
        Fri, 11 Nov 2022 02:05:10 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F77E6602A43;
        Fri, 11 Nov 2022 10:05:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668161109;
        bh=5adrvkaSXXPCJ7a9QDrifMUAtUL+l677DLpywUrMHVo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LhQcL1b2N1D2r4SwayJjDj2OZOCkqbQdXHs6OR83QYo7eutY7CJD5jG2X7SQjam1f
         yPTsiUEuS0mDWQ+gtFWFHnZKnqCCyspl8r55XN+XWmMpxu5hfrE9DnyM3Z4ZENOJtE
         rqAVeLbzKghEX5PErg5+oSWYLMfPnprAY0jZXb91Qixv93WNWxvKQXXjg0x4kNc30X
         pQL73aqlntOSUDVZ1bUh7SOTMkVCBKY1cfgX2ytI0ls2kyQO0kmBDsc7s2Ewp2WODF
         AT5Vrk51MVNyMdbu34wvPfmEBQVELjl7tx7OHwmgvn+tBqqCl/NlyCMdZ+zEaLoo5k
         bMlRz2w0wAZ/Q==
Message-ID: <160cb3fc-176e-bc0e-1bff-9334478af8ec@collabora.com>
Date:   Fri, 11 Nov 2022 11:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     marijn.suijten@somainline.org, konrad.dybcio@somainline.org,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
 <166758411781.2066027.6365889663189109123.robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <166758411781.2066027.6365889663189109123.robh@kernel.org>
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

Il 04/11/22 18:54, Rob Herring ha scritto:
> 
> On Fri, 04 Nov 2022 15:22:03 +0100, AngeloGioacchino Del Regno wrote:
>> Document bindings for the Qualcomm Ramp Controller, found on various
>> legacy Qualcomm SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../qcom/qcom,msm8976-ramp-controller.yaml    | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.example.dtb: power-controller@b014000: '#power-domain-cells' is a required property
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/power-domain.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

I'm unsure about what I should do about this one.
This is a power-controller, but does *not* need any #power-domain-cells, as it is
standalone and doesn't require being attached to anything.

Any hints?

Thanks,
Angelo
