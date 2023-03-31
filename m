Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC06D200B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjCaMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCaMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:21:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF6320639
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:20:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e9so7538688ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680265229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H16BPzJztbd3HhazhXcI1P8r1+/2++5vbOFamiLRHNU=;
        b=BlVahfuPWT0j8HZz1RZflHoZMFUESz2hAMgu4LPi2xdY6ayIz7DfuR0yABB8ZvZrkW
         sYr2e7zHM6nx0it+FEg4yPH8bAmP/s8b8tewooNgjV5WKeU4VRRu4JzH9iileUN/d50X
         /LHlb0FwzEAYMfQncZV7vDxmjchcsXW32fNK+jaaN/wYfH91kFHW6B4PgbMP5yawUuEe
         XzEQco64VoJ5916HPH+lBfAxC7JbqHKgEevMl+1Y3XqNSgaxrUhs9ZIo8DMr9f1nnRBE
         tYTSpkqFmDtkhUGBIndFEOP3qMrWrxkFVG2YDRGb36HRQ/hgVagRhO64OgfM6QLBBGZm
         xBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H16BPzJztbd3HhazhXcI1P8r1+/2++5vbOFamiLRHNU=;
        b=TANqGlW26zBVeHL4SjiEKYoBJG2C8XdE36MciGKnw0O4NBBD0qmz3ijl/pOxxHkNOV
         qmWY5125qq4qyDOgbo8JsHQaL9E/qeRUHx952/CztjJ1E0LCMgpbOSVyucQiTL1upgZk
         F7vwsR9AwW6BvsfSPh/zRN7tDBOYtL32ZHekR7zXd0RARy6TUYIOvS2s3FXkIGwF96Sg
         V1XXQ6yxz6r0+XwKJmB2opr3yU0GPcuRH7waXtzYOy5BPF4ttu/qVUmsQoyKkr5KWgfx
         k/fbEgGk5i+invanl1WS5+zLZvsy4SW3thP6LDEkH6YaiubwlYF+kPX5t92UJ8YdQJZI
         2qgw==
X-Gm-Message-State: AAQBX9eLuoboCNYlHHx/7PHRF6OwmsQgBzTmOunAyQXI0jN5O6AaGhA4
        /E2rcX0lWIqxfvkOSnoD2tiAvw==
X-Google-Smtp-Source: AKy350Z/1M/vqT1JYEJ7bqIsbB1UnFAUGbHJ5SekA9BN0UeXAuixfK9k4n5Z3qziMPSbTFX/QOLrHg==
X-Received: by 2002:a2e:7c10:0:b0:29c:956f:536f with SMTP id x16-20020a2e7c10000000b0029c956f536fmr7373518ljc.52.1680265228952;
        Fri, 31 Mar 2023 05:20:28 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id o24-20020a2e7318000000b002934b9ce521sm343867ljc.10.2023.03.31.05.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 05:20:28 -0700 (PDT)
Message-ID: <e43e944c-9f65-cde5-5d8c-a76f33f99b44@linaro.org>
Date:   Fri, 31 Mar 2023 14:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330165322.118279-1-me@dylanvanassche.be>
 <20230330165322.118279-3-me@dylanvanassche.be>
 <f9a4a2de-42f8-676a-ae6d-d20391206f83@linaro.org>
 <e7b73a24b8ba76cb6dc9921f73c47632a749b93f.camel@dylanvanassche.be>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e7b73a24b8ba76cb6dc9921f73c47632a749b93f.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.03.2023 11:36, Dylan Van Assche wrote:
> Hi Konrad,
> 
> On Fri, 2023-03-31 at 04:03 +0200, Konrad Dybcio wrote:
>>
>>
>> On 30.03.2023 18:53, Dylan Van Assche wrote:
>>> Qualcomm SDM845 SoC features a SLPI DSP which uses FastRPC through
>>> an allocated memory region to load files from the host filesystem
>>> such as sensor configuration files.
>>>
>>> Add a FastRPC node at /dev/fastrpc-sdsp and a DMA region, similar
>>> to
>>> downstream, to allow userspace to communicate with the SLPI via the
>>> FastRPC interface for initializing the sensors on the SLPI.
>>>
>>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 3b547cb7aeb8..8ea4944f3ad6 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -878,6 +878,14 @@ mdata_mem: mpss-metadata {
>>>                         size = <0 0x4000>;
>>>                         no-map;
>>>                 };
>>> +
>>> +               fastrpc_mem: fastrpc {
>>> +                       compatible = "shared-dma-pool";
>>> +                       reusable;
>> Please move it last to get a nice reverse-Christmas-tree layout.
>>
> 
> Will fix in v4.
> 
>>> +                       alloc-ranges = <0 0x00000000 0 0xffffffff>;
>> Would there be any issues with it starting over (1<<31 - 1)?
>>
> 
> You mean a bigger region then, like the whole CMA region then? AFAIK,
> the SLPI always use the same region expecting it to be in this range.
> However, I cannot confirm more, as I have no insights in the firmware
> running on there, this all comes from finding out what it exactly does
> on downstream.
I was asking about the <.. 0 0xfff.f> part specifically, as that means
it can't be allocated above 4 gigs. But I guess it's just how qcom
envisioned it.

Also, please use 0x0 in alloc-ranges as well, this is all addresses/
reg sizes.

Konrad
> 
>>> +                       alignment = <0 0x400000>;
>> Please use 0x0 for the 0 here, as it's essentially reg.size with
>> size-cells = 2
> 
> Will fix in v4.
> 
>>
>>> +                       size = <0 0x1000000>;
>> Ditto
> 
> Will fix in v4.
> 
>>
>>> +               };
>>>         };
>>>  
>>>         adsp_pas: remoteproc-adsp {
>>> @@ -3344,6 +3352,22 @@ glink-edge {
>>>                                 label = "dsps";
>>>                                 qcom,remote-pid = <3>;
>>>                                 mboxes = <&apss_shared 24>;
>>> +
>>> +                               fastrpc {
>>> +                                       compatible =
>>> "qcom,fastrpc";
>>> +                                       qcom,glink-channels =
>>> "fastrpcglink-apps-dsp";
>>> +                                       label = "sdsp";
>>> +                                       qcom,non-secure-domain;
>>> +                                       qcom,vmids = <0x3 0xF 0x5
>>> 0x6>;
>> Please use the recently-introduced header and depend on (and
>> make a patch atop)
>>
>> https://lore.kernel.org/linux-arm-msm/8685b710-b74d-556a-815d-0ffef2b0eeff@linaro.org/T/#t
>>
>> Konrad
>>
>>> +                                       memory-region =
>>> <&fastrpc_mem>;
>>> +                                       #address-cells = <1>;
>>> +                                       #size-cells = <0>;
>>> +
>>> +                                       compute-cb@0 {
>>> +                                               compatible =
>>> "qcom,fastrpc-compute-cb";
>>> +                                               reg = <0>;
>>> +                                       };
>>> +                               };
>>>                         };
>>>                 };
>>>  
> 
> Kind regards,
> Dylan
