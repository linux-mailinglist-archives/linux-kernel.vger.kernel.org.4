Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DD74B0F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGGMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:31:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF78213C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:30:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso27463051fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733054; x=1691325054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGvyCAsX8L6WnC8v9SRyT2lXuT9dJtv6Ob7UfVhRf9g=;
        b=u7ln/9RrvRdtuIdt+mrgHIC4WouXbUjvvcIVfUQeCc9olrHTNL+Xsz/i6tHmVIFHov
         BT/41CpZZMgWHCcDQQw5z+/9MP7kVM0Op4jNJXt1x0b2k3IDHC+2Y069a/yUZ3q5mmB4
         14yJrVWZI2i0ymEfyZAe9EfFHKdM6vyxeyAvT/fZFjGyEhjY1anAHfwkflU8qiYZAUFS
         9b38yUCTryN1/fjlrmgEGzpp91TJS/uGRN0dpd1FKmY9k8L8sKKMNogghvqmKVdocCHY
         LVLvvpnEhxLZFV6VadxC2JiCNHTjGS/MmLvaQfRwt1yBPMy+M4BSBEjxfw7RumA/1IsH
         OsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733054; x=1691325054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGvyCAsX8L6WnC8v9SRyT2lXuT9dJtv6Ob7UfVhRf9g=;
        b=e4cXHEX/0hWEwkPw4KL+pDLY77Mm9VwVYHgmUhg3BWiba6wUHl4Jp1i8MkFgNORN/e
         DI+9F5fn3GHc3HymLoIHk++fM4hQxnvzPC1DtMn2erbItDorFFesF58zmWf4tGqLLPX6
         GYGJajZwfT6idDg/yjwOcKK3EPcnP4fntzgBmG85fh4eSKY7KZrabobgaFphZpJFyF7z
         Op+WmU0sekrQbyvtInLM+0MtW50dETaSXnchollCy2gmCIx5745EFBA5n2qncrATEBBp
         LK12QdEE7G0mv48M7Hnf8E49nucus0r5u6R5P52IaNcfLV1EA8QxlXNTSt9eP7fYFpn2
         RObQ==
X-Gm-Message-State: ABy/qLaz0pfp1FMCcynpfN+z8CnndeHPhjpgy0wU1hJwF+8TQR4cQS9D
        nLWDxZQpDqIKv2TClmwJ1WReSQ==
X-Google-Smtp-Source: APBJJlFVEtG496EnoT85BigKA2kUu5jfUK+oufO+W1N79iqyCJ+ptwY0uD9THh4p7PbnlmkyehJ19Q==
X-Received: by 2002:a2e:9596:0:b0:2b6:d4f7:b7fa with SMTP id w22-20020a2e9596000000b002b6d4f7b7famr3220754ljh.5.1688733053913;
        Fri, 07 Jul 2023 05:30:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id m18-20020a2eb6d2000000b002b6e00a3e19sm751496ljo.132.2023.07.07.05.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 05:30:53 -0700 (PDT)
Message-ID: <95ac3e2d-69c6-e795-af68-924000eb318e@linaro.org>
Date:   Fri, 7 Jul 2023 14:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add SM7125 device tree
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230706124339.134272-1-davidwronek@gmail.com>
 <20230706124339.134272-7-davidwronek@gmail.com>
 <021ad5b4-772d-f2f6-f9ec-bca06db04dd8@linaro.org>
 <CAEoe_eVAeNZVUHgpj64Redx5vg7wfzU4wjgH33TZ7ieoDifH-Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAEoe_eVAeNZVUHgpj64Redx5vg7wfzU4wjgH33TZ7ieoDifH-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 17:36, David Wronek wrote:
> On Thu, Jul 6, 2023 at 5:25 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>> On 6.07.2023 14:40, David Wronek wrote:
>>> The Snapdragon 720G (sm7125) is software-wise very similar to the
>>> Snapdragon 7c with minor differences in clock speeds and as added here,
>>> it uses the Kryo 465 instead of Kryo 468.
>>>
>>> Signed-off-by: David Wronek <davidwronek@gmail.com>
>>> ---
>> Can you please paste the output of `dmesg | grep "secondary processor"`?
>>
>> That would let us determine the unique identifier of the cores.
>>
>> Konrad
> I get this output with the command:
> [    0.005884] CPU1: Booted secondary processor 0x0000000100 [0x51df805e]
> [    0.007191] CPU2: Booted secondary processor 0x0000000200 [0x51df805e]
> [    0.008559] CPU3: Booted secondary processor 0x0000000300 [0x51df805e]
> [    0.010046] CPU4: Booted secondary processor 0x0000000400 [0x51df805e]
> [    0.011639] CPU5: Booted secondary processor 0x0000000500 [0x51df805e]
> [    0.014424] CPU6: Booted secondary processor 0x0000000600 [0x51ff804f]
> [    0.016421] CPU7: Booted secondary processor 0x0000000700 [0x51ff804f]
Hm okay so they are indeed Qualcomm-branded cores.. Sometimes they use the
ARM ones and still call it Kryo 

btw the implementer id of 0x51 is the ascii code of 'Q', nice quirk

Konrad
> 
> Sincerely,
> David
>>>  arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
>>> new file mode 100644
>>> index 000000000000..12dd72859a43
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
>>> @@ -0,0 +1,16 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>>> + */
>>> +
>>> +#include "sc7180.dtsi"
>>> +
>>> +/* SM7125 uses Kryo 465 instead of Kryo 468 */
>>> +&CPU0 { compatible = "qcom,kryo465"; };
>>> +&CPU1 { compatible = "qcom,kryo465"; };
>>> +&CPU2 { compatible = "qcom,kryo465"; };
>>> +&CPU3 { compatible = "qcom,kryo465"; };
>>> +&CPU4 { compatible = "qcom,kryo465"; };
>>> +&CPU5 { compatible = "qcom,kryo465"; };
>>> +&CPU6 { compatible = "qcom,kryo465"; };
>>> +&CPU7 { compatible = "qcom,kryo465"; };
