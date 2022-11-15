Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AD629AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiKONgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKONgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:36:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58649E88
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:36:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so24443330lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L08sSZkkLJR/Xis3kPyL4dXQKyIOGpQdlbvy+xnKTHI=;
        b=lFwJu6lfWyg4+UeVvj5+1FuqOS6xzhU8igzOK+fMyYLoc0FcWcrVH+U2pWhTgGm/Hc
         GhDmrgxSa9H2xffc1wLXuOH+DwmKZ6GkgVsHnBUrgUF6ATK9VrBhbgydsn7xD1Lh4GKZ
         ECRjMFvGa0h1453MtC0tGdBwuIOYgZLE7IFL4C945mh8TqtfvYfS4mA9lluCdHg84DSD
         AIPmpwqL1r6Hnay13eu/1CtRp39ZMhXvu4nSEkbfAg+K7lefjNgEoSIuT/L56MjwKVtp
         /b514u+c7i7y0MSYbmwDJXeeH2A9y15hp4bzquJDoJMKLiSI7akWCWQSHKGggtNizv7j
         SOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L08sSZkkLJR/Xis3kPyL4dXQKyIOGpQdlbvy+xnKTHI=;
        b=bF9KueI1tOxp6aRyfqfZKoi4Upz6PdxBwtzPmHqmaoa5ceS7NfOsWaO96vVcUu8fuu
         UuZNVxuqZytsL8IwOIUCkOrBdf1MCVzCaPBh+dMWvtVSx4O+ZPZ2pNzKzW/kofeVfE26
         rzx6Yq5G7XnPR+HySzfGmm6B6tXp0UImRhxlEWae4Qln1f6svkYxoKZS3QaMOJFqvGfI
         0vdRLwFFFrCdnSJKJom1uNot8JyEvCHbIhTQc7O8ovHqKRsDacTXXKF96PSvlnD0B+gD
         1GrNSyVRdFRqtDJzBpsDlrZTybS4u30y5f67Fw8z5qz8U5fqhfwZ1H0ln3cLHoFqQSDT
         n6Tg==
X-Gm-Message-State: ANoB5pnAUlQnQXHgYZVmiEBXdwpv3hPCgnYQ/i99muzzc4U5vxCkhUuf
        YVQaIXtn09gj6vLeywmYFjcWXg==
X-Google-Smtp-Source: AA0mqf4DZa93lhlkQle/LTc5d7gmoVjw2tALlSonGlZ7ybNLrT9WhK3s9ry9y4tLa0TiyvJDg0YIXw==
X-Received: by 2002:a19:440a:0:b0:4a6:2ff5:ddd2 with SMTP id r10-20020a19440a000000b004a62ff5ddd2mr6166445lfa.166.1668519402646;
        Tue, 15 Nov 2022 05:36:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a056512211500b004b3c505a71dsm2206817lfr.92.2022.11.15.05.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:36:42 -0800 (PST)
Message-ID: <342d556a-e710-590c-3c81-fcc60bbaa6e7@linaro.org>
Date:   Tue, 15 Nov 2022 14:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <160cb3fc-176e-bc0e-1bff-9334478af8ec@collabora.com>
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

On 11/11/2022 11:05, AngeloGioacchino Del Regno wrote:
> Il 04/11/22 18:54, Rob Herring ha scritto:
>>
>> On Fri, 04 Nov 2022 15:22:03 +0100, AngeloGioacchino Del Regno wrote:
>>> Document bindings for the Qualcomm Ramp Controller, found on various
>>> legacy Qualcomm SoCs.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../qcom/qcom,msm8976-ramp-controller.yaml    | 37 +++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.example.dtb: power-controller@b014000: '#power-domain-cells' is a required property
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/power-domain.yaml
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/patch/
>>
>> This check can fail if there are any dependencies. The base for a patch
>> series is generally the most recent rc1.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
>>
> 
> I'm unsure about what I should do about this one.
> This is a power-controller, but does *not* need any #power-domain-cells, as it is
> standalone and doesn't require being attached to anything.

power-domain-cells are for power domain providers, not consumers. The
generic binding expect that nodes called power-controller are exactly
like that.

Solutions could be:
1. Rename the node to something else. I cannot deduct the type of the
device based on description. What is "sequence ID" and how is it even
closely related to power control?

2. Narrow the node name in power-domain.yaml which would require changes
in multiple DTS and bindings.

3. Do not require power-domain-cells for power-controllers, only for
power-domains.

Best regards,
Krzysztof

