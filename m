Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE23602FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJRP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJRP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:27:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB9BC62D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:27:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o22so8844185qkl.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlrRdSiBc3+5x9el6+WiPvB5GSvm3lz/xveRGeJez/Y=;
        b=EG4Jn93JA7AM0w+NYd6U5tSunzgTzsLPJB6RjP4zYCZU9YHf1M0jKzBPVe27OL136x
         MyKkdfB2RKkeJ21qM2W8EIkOq99xdz8GYOH1phybCn/G3EHufIgmp3UoJMOCFs/8giKr
         vxm5yZcYMM441WpCJSKIfKCy2c36eX2ddb7N4X4Zpm/EPI6WzKBY5QumEHJyKO9EnZuI
         qOJY4mDirk6vZ6bSZldRzeY2UjHOE2LVs0nCcHvdoLHAT17synotSEmp68cI0tl+gYRI
         z/ioOlQDknuVnOveAKcJI0eeRX2k3Q9zCs8Y3i/bhFNCB9rsVncWP+jvt1+WKrbn2aiT
         3mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlrRdSiBc3+5x9el6+WiPvB5GSvm3lz/xveRGeJez/Y=;
        b=dIgtKoPRExsnxdSbDttHOsXV0NvU8QTfC6LTqhXb0KQnkg7uzRWicp8Gfhk1w8dNi2
         c3L/ZWozwk7l0fMLHfnQ39oZXg8YIzLLErWEponhXFxjl6axzvvkDTzozF5HH5/ltKuh
         a7l9kBZbm3Dbdah4/WW0KPEVUAKmGyi54xgx1/V8XCO1nhIF8KerHFqGfJVN5z/CtOi5
         SHZ7yt5YMV7moXZzW8Y+eXl8NDXECwX/hhJ9D5Rw3M1JsqTeJjAH6mUDYELEmmFH+D/J
         S7pbEfFGVtknPKda7BHqGYdjJZPfBsuUmT7HQeeRRNiXR8taf4iBev9I8JtrGonzd26i
         KykQ==
X-Gm-Message-State: ACrzQf1Ws/zbXytxVEoxeydk+anbBKxmcrsbB9QjIgj4juaVuKfmyY+3
        QFoE3IqozbJphSiId2NW1sfILQ==
X-Google-Smtp-Source: AMsMyM5iD16RwRypyXJlH9TWM1p1s0lQhnKdXXOoxUFalUOI9aplDm8h+1FMPxcIpbk+rdSjCD1iuw==
X-Received: by 2002:a05:620a:bc9:b0:6be:9d56:78dc with SMTP id s9-20020a05620a0bc900b006be9d5678dcmr2165897qki.365.1666106857366;
        Tue, 18 Oct 2022 08:27:37 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id b14-20020ac844ce000000b003434d3b5938sm2107848qto.2.2022.10.18.08.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:27:36 -0700 (PDT)
Message-ID: <39a7d2d1-06c2-4002-e222-54c24c5eb31f@linaro.org>
Date:   Tue, 18 Oct 2022 11:27:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <5e153119-f853-ff57-8277-2d782e255be2@linaro.org>
 <Y05Qf2nDCIVg23Zh@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y05Qf2nDCIVg23Zh@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 03:06, Johan Hovold wrote:
> On Mon, Oct 17, 2022 at 01:15:45PM -0400, Krzysztof Kozlowski wrote:
>> On 17/10/2022 10:53, Johan Hovold wrote:
>>> The current QMP PCIe PHY bindings are based on the original MSM8996
>>> binding which provided multiple PHYs per IP block and these in turn were
>>> described by child nodes.
>>>
>>> Later QMP PCIe PHY blocks only provide a single PHY and the remnant
>>> child node does not really reflect the hardware.
>>>
>>> The original MSM8996 binding also ended up describing the individual
>>> register blocks as belonging to either the wrapper node or the PHY child
>>> nodes.
>>>
>>> This is an unnecessary level of detail which has lead to problems when
>>> later IP blocks using different register layouts have been forced to fit
>>> the original mould rather than updating the binding. The bindings are
>>> arguable also incomplete as they only the describe register blocks used
>>> by the current Linux drivers (e.g. does not include the per lane PCS
>>> registers).
>>>
>>> In preparation for adding new bindings for SC8280XP which further
>>> bindings can be based on, mark the current bindings as "legacy".
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--
>>
>> I don't think we should rename anything as legacy. These are "normal"
>> platforms, not legacy ones. SM8450 is not even that old.
> 
> I'm not really referring to the platforms as legacy, but the rather the
> format of the bindings. The intent is that by marking the current ones
> as such, people will not base new bindings on the old scheme.
> 
> There's no problem supporting both schemes in the driver also for the
> current compatibles, but expressing such a deprecation in DT schema
> sounds like it would be painful. We instead decided to simple draw the
> line at SC8280XP and have future bindings be based on its binding.
> 
>> The recommendation is to keep names matching the compatibles, not adding
>> some legacy/newer/newest suffixes.
> 
> Yeah, I know, but that's not what the current bindings do. And if we
> keep 
> 
> 	qcom,qmp-pcie-phy.yaml
> 
> and add
> 
> 	qcom,sc8280xp-qmp-pcie-phy.yaml
> 
> then I fear that people will base their bindings on the former rather
> than the latter.

Then how about renaming this file to something matching the oldest
supported SoC? Like: qcom,msm8998-qmp-pcie-phy.yaml
(I don't know which one is the oldest there)

Or ipq6018 as the first one appearing in the list.

> 
> I guess I can just add a comment in the old schema file with a reference
> to the sc8280xp bindings to try to prevent people from adding new ones
> in the wrong place.

Yes, that's also works for me. You can change the description part to
have something like:
"QMP PHY controller on SoCs like sc8180x and older. For newer SoCs,
please look at xxxxx.yaml"

> If I understand you correctly this is what you are suggesting? And that
> the new file should still be named "qcom,sc8280xp-qmp-pcie-phy.yaml"
> also as new bindings are added to that file?

Yes.

> 
> I could also rename the old schema file after one of the old platforms
> platforms therein (e.g. qcom,msm8998-qmp-pcie-phy) to make it sounds
> less like a generic schema for new bindings.

Oh, we thought about the same.

> 
> That is
> 
> 	qcom,msm8998-qmp-pcie-phy.yaml + comment (for current bindings)
> 	qcom,sc8280xp-qmp-pcie-phy.yaml (for new bindings)

Yes, please.

Best regards,
Krzysztof

