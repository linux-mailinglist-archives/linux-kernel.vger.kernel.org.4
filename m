Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B96D9F24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjDFRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbjDFRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:45:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7F13E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:45:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-946a769ae5cso125879566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDtxzvUg1yWLifiB6kB+sDRZj/DJwVq/5cG70JDnEHc=;
        b=j333mUs9ZlR7d+yes5ED7p4biRa4m4REkB5fiwfVdhMuiEgPauY0zg+0eWFZSGrbia
         vGeNOn6vkeUpvG9Ky74BCI7+/NUTyTNyJ6CZhmu6CnbNG9377jeTd3sF5Aq+iQZPePgX
         ftZCAvgGpa1XCoetxNQC6SvfaqvIPecA0Lp/LHoPiAc4iSnQLCPv4OiqCpv/SmeVVtN7
         Z2+gOVgOlMR2aBRGICgTpu6X3dSiTQ4xSqogum90KvWNiSXoluCiPzQ2YhSFkq0CSvln
         fniEYI+BsnMrke/X8S+mCUKCm0nfHi6KBPQ/Z30ejf12aMk0dotmgTN/YeWJMZXhJcB9
         49AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDtxzvUg1yWLifiB6kB+sDRZj/DJwVq/5cG70JDnEHc=;
        b=E4qsxhA46Axfidn7jCQZCp2KLEIQjUbNNn+LCluVxAd2SUqufPiRgYTYYmUJVvSCXP
         7B3kP1UVPqLh2PmretJCgspUTBS5JJps8nRCblxH2FbpddZMFOcH+SwyBVxvxrcgRI9E
         KvXbSEOL8kU4OUyg0AeGp9pzMJmXyCabM+zqIWroSSwkNWVY9p4n3GKY6giiQXTPPw/q
         jpzu6jTtm1GdMtUc9Xwmqzd8jFcnzr9vvvaFwQc0edBLBxWflktr692COwtaFQ3kkS75
         R7Q8s1UfgS+q8Rtfx9oPp45xDmmmxXXKS8+7zTEWceMFoGez8Z3xK2S9JwXX0u8oX+J2
         izlg==
X-Gm-Message-State: AAQBX9dEgaKj967plUmZ/4W1Bmn1idvIBJOsSDr886BeH3XScnbHJaPv
        vWGRiFueI5/lBhQwGnIiU8+VXg==
X-Google-Smtp-Source: AKy350av2omisW9B8G4Q3lstD+cTmNqSjHONZdE8w0j8lPdV10ZP4RupsYnNz/GjneZIWMl944Mnhg==
X-Received: by 2002:aa7:c0ca:0:b0:4fa:ba60:8188 with SMTP id j10-20020aa7c0ca000000b004faba608188mr304985edp.8.1680803141624;
        Thu, 06 Apr 2023 10:45:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id a29-20020a509b5d000000b004fd204d180dsm994752edj.64.2023.04.06.10.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:45:41 -0700 (PDT)
Message-ID: <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
Date:   Thu, 6 Apr 2023 19:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
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

On 05/04/2023 15:49, Konrad Dybcio wrote:
> 
> 
> On 5.04.2023 15:47, Rob Herring wrote:
>> On Wed, Apr 05, 2023 at 07:22:40AM -0500, Rob Herring wrote:
>>>
>>> On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
>>>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>>>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>>>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>>>
>>>> Document passing the register space as a slice of SRAM through the
>>>> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict
>>
>> Looks like this is colliding with the example template which has to 
>> craft an interrupt provider for 'interrupts' properties. Either adding a 
>> parent node or using interrupts-extended instead should work-around it.
> Check the devicetree-org issue linked in the cover letter, please!
> 
> I suppose wrapping it in a parent node could work as a temporary
> measure, but since it belongs outside /soc, I'd have to make up
> a bogus simple-bus, I think.

I don't think your issue in dtschema is accurate. As Rob suggested, you
need wrapping node.

Best regards,
Krzysztof

