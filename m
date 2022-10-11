Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEA5FBDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJKWMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:11:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB119411F;
        Tue, 11 Oct 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665526319; x=1697062319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aNynsuIV0rHuoqeRVnCVfLglarBP1m5Y0PIq4JPDuPI=;
  b=vd6KliiuXmEixVMuPBUuU2haYHFT1TOVQpDg2ID0xHNjOPAy4/iyAATC
   15qu7Q3emke2DEf/vaC2xr3Q0bY2WKoFJJOy9Mb/Zo/CUXayhm0FalFGd
   mhPAsgm1YH1nADGexgDZjxouSLqYQY6umNsEFhTo5um2xrIjuJy/roAlI
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Oct 2022 15:11:58 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:11:57 -0700
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 15:11:58 -0700
Message-ID: <d57d500b-a322-4aaa-42ed-5638363b787d@quicinc.com>
Date:   Tue, 11 Oct 2022 15:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock
 bindings
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-2-quic_molvera@quicinc.com>
 <37926f0f-e176-929e-939a-cd43a031e224@linaro.org>
 <bb241d46-6f90-8604-e79d-30a1f3527ce4@quicinc.com>
 <CAA8EJpqqLRJK3GaXt3Uf=+TAupYFkG4Ey_wG2si2WePp5gAaQA@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpqqLRJK3GaXt3Uf=+TAupYFkG4Ey_wG2si2WePp5gAaQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2022 2:32 PM, Dmitry Baryshkov wrote:
> On Mon, 3 Oct 2022 at 21:47, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>
>> On 10/1/2022 4:24 AM, Krzysztof Kozlowski wrote:
>>> On 01/10/2022 05:03, Melody Olvera wrote:
>>>> Add device tree bindings for global clock controller on QDU1000 and
>>>> QRU1000 SoCs.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  .../bindings/clock/qcom,gcc-qdru1000.yaml     |  74 ++++++++
>>>>  include/dt-bindings/clock/qcom,gcc-qdru1000.h | 170 ++++++++++++++++++
>>>>  2 files changed, 244 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>>>>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>>>> new file mode 100644
>>>> index 000000000000..d92f558d547c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>>>> @@ -0,0 +1,74 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdru.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Global Clock & Reset Controller Binding for QDU1000 and QRU1000
>>> Drop "Binding"
>> Will do in v2.
>>
>>>> +
>>>> +maintainers:
>>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>>> +
>>>> +description: |
>>>> +  Qualcomm global clock control module which supports the clocks, resets and
>>>> +  power domains on QDU1000 and QRU1000
>>>> +
>>>> +  See also:
>>>> +  - dt-bindings/clock/qcom,gcc-qdru1000.h
>>> Full path
>> Understood.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,gcc-qdu1000
>>>> +      - qcom,gcc-qru1000
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: Board XO source
>>>> +      - description: Sleep clock source
>>>> +      - description: PCIE 0 Pipe clock source (Optional clock)
>>> Skip "Optional clock"
>>>
>>>> +      - description: PCIE 0 Phy Auxiliary clock source (Optional clock)
>>>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
>>>> +    minItems: 2
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: bi_tcxo
>>>> +      - const: sleep_clk
>>>> +      - const: pcie_0_pipe_clk # Optional clock
>>> Skip "Optional clock"
>> Will remove all optional clock instances.
> Drop the 'optional clock' words, not the clocks themselves. See
> existing examples, which have optional clocks.
>
Ah apologies; I misunderstood.

Thanks,
Melody
