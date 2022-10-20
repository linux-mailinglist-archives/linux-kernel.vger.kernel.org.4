Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2D60606E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJTMlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJTMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:41:19 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B918E73F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:41:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o22so12637398qkl.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+V635IJmuXVxEJb4QyeUj3oKwfgTzjuN6h0lmu+zlRM=;
        b=h/DLkhVS0W4P6Wr0Fak+GRkFm7UrKy2rnp69cgXuz+9onLabpU+NKVGglwuNc2tjc0
         wk8OxJST3ZkaPgX/GkE0FyxZ7VXt1evRRIphOB9G8adwQtoCAI8FC3rHSpx2nNqS+is6
         jgb6GcNlxt+DXw4YTF4dneUaTd90bc3LrSgDCsPl1K+VphLuIhiHkEJXbyR2WuJBxvcQ
         d0wK4AENSGbwylBSBfFL0Xk4BxzAn0OrCSQ4Ofje/EkBTMIz5g35XyZsDRYSB4JDXU1S
         vF9RA5czLCjDa36fI2nPpkQfbVSCdUdzdft5kbF9MdJiQkRWlKKGkZo6TNzNLBX8ts+u
         wKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+V635IJmuXVxEJb4QyeUj3oKwfgTzjuN6h0lmu+zlRM=;
        b=tfob5PmHB+HU1Mm5T0mq+CV7vwsAFKeJPFpx15LOX911MxFMTY+P/oGtiICnXfjlMB
         hcvHlbkuLLiwV2tDOz+WpAv87Jzwdz5UaSXW4x+JgIP3FtIglCZUg660Pp9189CqXEBk
         WnotpYV5FCbVGYGfm+HLZI6FpW7Jf0mfAs0R6yeRc641YvjGrv/s3cFucP0aI44aVe4F
         2t6m08k4RhkPQ3qXHucAbIBDFDchtpaEV7ZH/nXy8ROmQ22+2JpGNa5THubsws0YFNVb
         yzGQlmY04IcfMuZlzBntPUg3MEvrdUOwv059AzYUUSyrInSpqLXkSc+h+1gCA15b1YIE
         boRg==
X-Gm-Message-State: ACrzQf1E/Jsk298ifxLpnSYD2+c4rkgfiSO/9U/fkVm6J79SzwQZPX4z
        zWgqXmQOgUo5N1WLlQBHufXm3g==
X-Google-Smtp-Source: AMsMyM7RWwnxTCM8yFqwbiTYLsDxlA1UmPsmjEOT1YaNmu5V8d8JbJGdgihiOY9cGVWQAvZojt+89w==
X-Received: by 2002:a05:620a:6ca:b0:6ec:553a:cf33 with SMTP id 10-20020a05620a06ca00b006ec553acf33mr8771885qky.132.1666269677250;
        Thu, 20 Oct 2022 05:41:17 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a404f00b006ee91ab3538sm7744602qko.36.2022.10.20.05.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:41:16 -0700 (PDT)
Message-ID: <50372a15-56ce-6ad6-f622-00624b909db8@linaro.org>
Date:   Thu, 20 Oct 2022 08:41:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
 <56af2a04-1b21-000d-e3f9-86b6ac74aaf2@linaro.org>
 <a0032338-482f-0de7-5952-c3c8b8423df6@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a0032338-482f-0de7-5952-c3c8b8423df6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 16:21, Melody Olvera wrote:
> 
> 
> On 10/15/2022 6:28 AM, Krzysztof Kozlowski wrote:
>> On 14/10/2022 18:11, Melody Olvera wrote:
>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>>> to boot to shell with console on these SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1646 +++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>>  2 files changed, 1673 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>> new file mode 100644
>>> index 000000000000..777734b30f56
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>> @@ -0,0 +1,1646 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
>>> +#include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/dma/qcom-gpi.h>
>>> +#include <dt-bindings/interconnect/qcom,qdu1000.h>
>>> +#include <dt-bindings/power/qcom-rpmpd.h>
>>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +
>>> +/ {
>>> +	interrupt-parent = <&intc>;
>>> +
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	chosen: chosen { };
>>> +
>>> +	clocks {
>>> +		xo_board: xo-board {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <19200000>;
>> Both clocks are not a property of a SoC. They are provided by the board,
>> so they should either be defined by board DTS or at least their
>> frequency must be provided by the board.
> That doesn't seem in keeping with precedent.... the sm8* series all have the clocks in
> the dtsi. These are common to the boards anyways.

Because people do not pay attention what is part of SoC, what is part of
board. DTSI is for the SoC and these are inputs to the SoC.

We had these talks and my recommendation is the same.

Best regards,
Krzysztof

