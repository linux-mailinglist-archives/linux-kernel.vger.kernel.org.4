Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DF66D7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAQIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjAQIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:14:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F627D66
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:13:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z5so28647635wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3o46UZYtS1Pu7ldJQIr+TAat72ZYFFBxEVdiCktlPoU=;
        b=suvkmS1JciHbwVIgP3xqKhqTdMyY+YJoEjWUlYAtlDxjyIzYm3VZDHFeZT6t07C3Z+
         3t+sDXvIYK3+aYGDi8GJn/L9ZfiHHGhWSgWSdfQjt65wWOO/o6p/vjlzdlPaAIBAVfVN
         8qEdTZF/79SDqtp964QKecHBGxosihCRz69fpmOR91hgbrBZc8GcML1MAXOIuB4ira8R
         FsTdy6DoSCrcnp30tKrpU2wNk6Tc6gxOqSH9TJPPD/Q2NwCCHKmrsDwAgeQ5w/oDpPKd
         ULovRbqegJsq9QWw72b4T5OyGBPMumxI+40JLqkXFtY0ElQ5UadiPE25gHJPEw+dH1oh
         8BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o46UZYtS1Pu7ldJQIr+TAat72ZYFFBxEVdiCktlPoU=;
        b=x9uuRTL8C69CyGMbbLYwHbdQgUtVNttYq+j7w0SdF92Hv/Qdl0KLFxJkSYEYczkarU
         gkKNM+BM553TusNoAs1TMxuTY5HPTAunE7Euy16SrmG/tnPk51KkoatYJW+6QyFt1Tfw
         N9bDl94q8tnYDfoBFQ/1/3uS1rYUhMQvOoPeArU0/TmUE/duu38aPTNqKQE4/GKUmnL9
         kNE2y9o2L/BXZUs//Z26JqMqBoxO5FbzuCb/3mnQ1X4cgwDo0LPkLIeyz3Wx8+sHW8WR
         FhLOE6tF5rghiggHX6AlftON9OzBGHJWNOvA2cdPiwYxRutUeZLL9RmNSdlsYtpNwy38
         kwmA==
X-Gm-Message-State: AFqh2kpYkKCzwNeZkYf0rLdkFKmfnqx47NHtFm4FpCSwm8voObKJ5PPy
        wJIi/mok29NVOSGOFCFEdnzbPQ==
X-Google-Smtp-Source: AMrXdXultD1oPczMcR2wM7GOvGtVEJsJmU9PrB288t7nR9paaY4w+Hv5rSuhEJHfx6+sOSrhtEWYVQ==
X-Received: by 2002:a5d:522d:0:b0:2bd:ff91:7e1e with SMTP id i13-20020a5d522d000000b002bdff917e1emr1721677wra.57.1673943237797;
        Tue, 17 Jan 2023 00:13:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w4-20020adfee44000000b0029100e8dedasm28063917wro.28.2023.01.17.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:13:57 -0800 (PST)
Message-ID: <627b62a4-47fe-02bd-7a0f-0377bf9d43d3@linaro.org>
Date:   Tue, 17 Jan 2023 09:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>, Tanmay Shah <tanmay.shah@amd.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
 <e675a037-3c07-a8bb-19d4-781ab881c920@amd.com>
 <39b55b55-b0fd-95fc-5f68-e00cd20f076d@linaro.org>
 <42c34b1a-3ea6-350a-86fe-89f93f32e893@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <42c34b1a-3ea6-350a-86fe-89f93f32e893@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 19:17, Tanmay Shah wrote:
> Hi Kryzsztop Thanks for reviews. Please find my comments below.
> 
> On 1/15/23 6:45 AM, Krzysztof Kozlowski wrote:
>> On 13/01/2023 19:04, Tanmay Shah wrote:
>>> Hi Krzysztof Thanks for your reviews.
>>>
>>> Please find my comments below.
>>>
>>> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>>>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>>>> driver. This bindings will help in defining TCM in device-tree and
>>>>> make it's access platform agnostic and data-driven from the driver.
>>>>>
>>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>>> ---
>>>>>    .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>>>>>    1 file changed, 137 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..02d17026fb1f
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>>> @@ -0,0 +1,137 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Tightly Coupled Memory (TCM)
>>>>> +
>>>>> +maintainers:
>>>>> +  - Tanmay Shah <tanmay.shah@amd.com>
>>>>> +
>>>>> +description: |
>>>>> +  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
>>>>> +  cortex remote processors to use. It is low-latency memory that provide
>>>>> +  predictable instruction execution and predictable data load/store timing.
>>>>> +  TCM can be configured in lockstep mode or split mode. In split mode
>>>>> +  configuration each RPU core has its own set of ATCM and BTCM memories and in
>>>>> +  lockstep mode redundant processor's TCM become available to lockstep
>>>>> +  processor. So In lockstep mode ATCM and BTCM size is increased.
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "sram-[0-9a-f]+$"
>>>> Drop node name requirement.
>>>> Why do you need sram node at all?
>>>
>>> I will remove sram- node. However, it device-tree I was planning to put
>>>
>>> all TCM nodes under single node for example:
>>>
>>> tcm {
>>>
>>>       tcm-lockstep {
>>>
>>>       };
>>>
>>>       tcm-core@0 {
>> Mix of nodes with and without unit address is pointing to some design
>> issues.
> 
> 
> The design currently tries to accommodate physical relocation of the 
> memory. May be there is another way to represent this.
> 
> Here is address space of TCM memory on zynqmp platform: 
> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map
> 
> As per above address map, there are 4 TCM banks, each 64KB ( 0x10000 ) 
> size at following addresses:
> 
> *In split mode*:
> 
> ATCM0: 0xFFE00000---|---> Assigned to RPU core0
> BTCM0: 0xFFE20000---|
> 
> ATCM1: 0xFFE90000---|---> Assigned to RPU 1
> BTCM1: 0xFFEB0000---|
> 
> However, In lockstep mode, ATCM1 and BTCM1 relocates to different 
> addresses (i.e. 0xFFE10000 and 0xFFE30000 respectively)
> 
> and becomes available for RPU core 0:
> 
> 
> *In lockstep mode Both used by RPU core 0*:
> 
> ATCM0: 0xFFE00000-----|
>                                           |----> ATCM: 0xFFE00000 size: 
> 128KB
> ATCM1: 0xFFE10000-----|
> 
> BTCM0: 0xFFE20000-----|
>                                           |----> BTCM: 0xFFE20000 size: 
> 128KB
> BTCM1: 0xFFE30000-----|
> 
> 
> I am not sure how to represent this physical relocation of addresses in 
> device-tree.

What do you mean by "relocates"? Move? You set one address in DT and
other address appears to be used? Then just set the other address?

> 
> Ideally such sram nodes can be represented as following:
> 
> [1] Representation of TCM in split mode:
> 
> [ a|b ]tcm[ 0|1 ] {

You do not have unit address here.

> 
>     compatible = "xlnx,zynqmp-tcm";
> 
>      reg <>;
> 
>      ranges <>;
> 
>      power-domain: (only 1 power domain for current bank)
> 
> }
> 
> However, to represent TCM in lockstep mode as well, I might have to add 
> platform specific optional reg and ranges property which optionally 
> represent address space of lockstep mode for atcm and btcm.

I don't understand why. You have IO address space, so why do you remove
unit address and make reg optional?

> 
> For example, ATCM0 and BTCM0 will be represented as above [1] However, 
> ATCM1 and BTCM1 will have following extra properties:
> 
> [a|b]tcm1 {
> 
>     compatible = "xlnx,zynqmp-tcm";
> 
>      reg <>;
> 
>      lockstep-reg <>; /* represent address space of this bank in 
> lockstep mode */

Device is either in lockstep or it is not, right? Why do you put here
some dualism?


Best regards,
Krzysztof

