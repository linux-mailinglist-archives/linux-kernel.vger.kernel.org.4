Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F60610465
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiJ0V2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiJ0V2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:28:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931562A4B;
        Thu, 27 Oct 2022 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666906119; x=1698442119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jrKbybPxii/8LFLtEI8Q2yFUWjUeSbp0R5yoUIHIO04=;
  b=gfbzDtYMOpteBY9GQ0RLgdIs9zUb3pNVOZVett/e1tecnCDix1qj6uL2
   K5zmXtEvpslPGukX0ryaWzyUW863YwFS/sFPC41NSPLnKH1Qda5euf7B3
   G97lJOfFGNOZLuQn4lYvtu140CzvBbhr2+n83+OP4x7noV81INPqvsCCR
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Oct 2022 14:28:38 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 14:28:38 -0700
Received: from [10.110.41.43] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 14:28:37 -0700
Message-ID: <a5e8c70a-3358-513b-c8a5-7a7903f6ea42@quicinc.com>
Date:   Thu, 27 Oct 2022 14:28:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clock bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-2-quic_molvera@quicinc.com>
 <e5009a33-1f71-1fe3-3a06-98bba031fdf0@linaro.org>
 <20221027182449.366AEC433D6@smtp.kernel.org>
 <cb9a2732-0904-4a2b-61a5-a6d65cad58ae@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <cb9a2732-0904-4a2b-61a5-a6d65cad58ae@linaro.org>
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



On 10/27/2022 12:35 PM, Krzysztof Kozlowski wrote:
> On 27/10/2022 14:24, Stephen Boyd wrote:
>> Quoting Krzysztof Kozlowski (2022-10-27 08:54:51)
>>> On 26/10/2022 15:04, Melody Olvera wrote:
>>>> +description: |
>>>> +  Qualcomm global clock control module which supports the clocks, resets and
>>>> +  power domains on QDU1000 and QRU1000
>>>> +
>>>> +  See also:
>>>> +  - include/dt-bindings/clock/qcom,gcc-qdu1000.h
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - const: qcom,gcc-qdu1000
>>>> +      - const: syscon
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: Board XO source
>>>> +      - description: Sleep clock source
>>>> +      - description: PCIE 0 Pipe clock source
>>>> +      - description: PCIE 0 Phy Auxiliary clock source
>>>> +      - description: USB3 Phy wrapper pipe clock source
>>>> +    minItems: 2
>>> Why the clocks are optional?
>> They should not be optional. They're always there.
> Just to be sure - I refer to last three clocks here as indicated by
> minItems:2.
>
> DTS does not define them, so something here is not complete or correct.
>
DT is incomplete; I don't have that in my current patchset. Will add later when PCIE and
USB nodes are complete.

Thanks,
Melody
