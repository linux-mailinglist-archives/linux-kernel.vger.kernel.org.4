Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C744632DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKUUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKUUTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:19:15 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FEFCFE97;
        Mon, 21 Nov 2022 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669061954; x=1700597954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJjPPfqtwXDOZTz8w4nKeTkIpxh4baLgRuhX2/yvNOE=;
  b=C386iROQu47t7+Iq/NVP1NVfQI+DRcY85+BuSs4xD0kl84zW9F336Efu
   p1Ad+hmTawi67GSyobrCd4pPyR1vb1k8wllo/SGvdWbFDszlS+r847uxA
   pc6J8YmZvON1tkz4HBFQqgf6NyYIbPZZsA7ZA+LFfnC6dy1gCWJH5mEug
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Nov 2022 12:19:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 12:19:13 -0800
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 12:19:12 -0800
Message-ID: <bb5f2000-1e54-fc37-a596-0a3dafdbff57@quicinc.com>
Date:   Mon, 21 Nov 2022 14:19:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221118181826.28269-1-quic_molvera@quicinc.com>
 <20221118181826.28269-2-quic_molvera@quicinc.com>
 <a5afd699-64a5-4034-88d2-95035e08c9c7@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <a5afd699-64a5-4034-88d2-95035e08c9c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2022 5:06 AM, Krzysztof Kozlowski wrote:
> On 18/11/2022 19:18, Melody Olvera wrote:
>> Add device tree bindings for global clock controller on QDU1000 and
>> QRU1000 SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../bindings/clock/qcom,gcc-qdu1000.yaml      |  70 ++++++++
>>  include/dt-bindings/clock/qcom,gcc-qdu1000.h  | 170 ++++++++++++++++++
>>  2 files changed, 240 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>> new file mode 100644
>> index 000000000000..90935a6795ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdu1000.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
>> +
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module which supports the clocks, resets and
>> +  power domains on QDU1000 and QRU1000
> Keep the same style as existing files. They were cleaned up recently.
>
>> +
>> +  See also:
>> +  - include/dt-bindings/clock/qcom,gcc-qdu1000.h
> Keep the same style, so missing '::', drop '- '.

Got it.

>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,gcc-qdu1000
> SM8550 is coming with proper style of compatible, so let's do the same
> also here: qcom,qdu1000-gcc
> (and file name matching it)

Ok... this is fine if we're moving to a new style. sm8550 seems to have the file
name wrong in last PS.

>
>
>> +      - const: syscon
> I don't see usage of it as syscon. Which parts of GCC are needed for whom?

I think I got this from another binding. We can remove.

>
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Sleep clock source
>> +      - description: PCIE 0 Pipe clock source
>> +      - description: PCIE 0 Phy Auxiliary clock source
>> +      - description: USB3 Phy wrapper pipe clock source
>> +    minItems: 2
> Same question as for SM8550 - why inputs are flexible? Either you have
> these or you do not.

Fair enough. We have these clocks so we can remove minItems.

>
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  '#power-domain-cells':
>> +    const: 1
> Missing ref to gcc.yaml. Drop all properties provided by gcc.yaml.

Got it.

>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - '#clock-cells'
>> +  - '#reset-cells'
> Drop these required by gcc.yaml.

Ack.

Thanks,
Melody
>
>
>
> Best regards,
> Krzysztof
>

