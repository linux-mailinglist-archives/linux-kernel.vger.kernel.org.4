Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8A670DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjAQXni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAQXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:43:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD49656E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:48:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g10so23435584wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYCcWqCCZCUHqzEyU/xnDg7cnPafRId64wsa4xHKDIA=;
        b=y6NtW/6VxO1x8kKxzAS+q88Nf99KzaIP+D2IjKsLyOFqIjWSXZBEy7GiUTILBrFWye
         bPbeaUC+x0Fu2tXv3IifcnPxKHhzNfVWY1GrU1kZdsz8GprC+PVxsF3z0WINvHJMhlcz
         x9ZwiBtK3rhAOdN4YVIBCAJkUpTcgqmvlXTUugGxjATB6/AGSjuRjLruAtEH3aolU1Jq
         pMRxrOeo1+/5mRNTN4F2aEhRix6CEgJzz0i73MG/60NZi5I3ytzccm96+eWCU/4YxwAA
         wKHqZzmvWdTYfO+FJfYCTndwki5xB2wymqjQttORaUdKXJT2mFh6vgQ5erDSFSxecAwr
         yn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYCcWqCCZCUHqzEyU/xnDg7cnPafRId64wsa4xHKDIA=;
        b=OOMeRvcoTLqLxUQ9opD8FokgJZwvcCR/qGGrdC6+U42Y1lGQjZQspkRjrUq9Iw/TZw
         PMXtQlGhlW4pEcdOxHmfvmrYbjHjd0mGmqKMgJxQrNwm2nFmObQ67KeL/axBMWFwB2Py
         6uA7Dgx85N9n1FKOO/EWP5jMCaSjZi2H4OrsZrFsCLbPbBQAXraJSjpOHve7YoCCsw0s
         44412Q/Felzt9C4VztP9bgzXXsBLRkVSQA3ZX2p+96XXpSipKDFP4WyCJyot7efA6oKW
         9hXhvsk6nLAPqLqSTxFbNnMG4+lV4Unp2+ZEWHgCd0/7WTYwCqFUOLiRiMUcyP6lWMpp
         dTeQ==
X-Gm-Message-State: AFqh2kpBs+YQl3OsCezpUwYvqOE9Sq+YgCpGv5GhZ5sO8VxqyYqC7VUS
        xE9ycaaHsFbQyn0dOaYBMscCcQ==
X-Google-Smtp-Source: AMrXdXuFvYbZV9S/7lQ8QJ10PZT/eT5LWRdZmBUuVkcgeLYgs3Z2XUHlrgXrVqMt4pxJK4LZ4oNphw==
X-Received: by 2002:a05:600c:920:b0:3da:22a6:7b6b with SMTP id m32-20020a05600c092000b003da22a67b6bmr4561497wmp.13.1673995719688;
        Tue, 17 Jan 2023 14:48:39 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c314600b003d99469ece1sm159069wmo.24.2023.01.17.14.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:48:38 -0800 (PST)
Message-ID: <28e1df7a-6577-bf39-9739-d0a047b36f12@linaro.org>
Date:   Tue, 17 Jan 2023 22:48:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <20230117205800.cqexxwxmtupapy7e@builder.lan>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230117205800.cqexxwxmtupapy7e@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 20:58, Bjorn Andersson wrote:
> On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
>> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
>> differences to msm8916.
>>
>> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
>> - DRAM 1x800 LPDDR3
>> - Camera 4+4 lane CSI
>> - Venus @ 1080p60 HEVC
>> - DSI x 2
>> - Adreno A405
>> - WiFi wcn3660/wcn3680b 802.11ac
>>
>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Co-developed-by: Benjamin Li <benl@squareup.com>
>> Signed-off-by: Benjamin Li <benl@squareup.com>
>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>> Co-developed-by: Max Chen <mchen@squareup.com>
>> Signed-off-by: Max Chen <mchen@squareup.com>
>> Co-developed-by: Zac Crosby <zac@squareup.com>
>> Signed-off-by: Zac Crosby <zac@squareup.com>
>> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
>> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
>> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Just to make sure when I get the question, you all co-developed this
> patch, right?

A long list but a fair one.

>> ---
>>   arch/arm64/boot/dts/qcom/msm8939.dtsi | 2393 +++++++++++++++++++++++++
>>   1 file changed, 2393 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> new file mode 100644
>> index 0000000000000..8cd358a9fe623
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> @@ -0,0 +1,2393 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020-2023, Linaro Limited
>> + */
>> +
>> +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
>> +#include <dt-bindings/clock/qcom,rpmcc.h>
>> +#include <dt-bindings/interconnect/qcom,msm8939.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
> 
> Why do you use a default of 2? In particular since you reduce it to 1 in
> /soc...

You asked that before, and I took a note of the answer but, then because 
I was away from the main machine when I sent V2, I didn't have the log.

Here's what I wrote down.

"  - address-cells/size-cells = 1 in /soc - Bjorn
     I experimentally changed address/cell sizes to 2
     I'm finding that lk chokes "

So AFAIR LK was unhappy about changing the top level address/size cells 
to <1> <1> and converting the /soc address/size cells to <2> <2> caused 
a number of breakages during boot.

To be honest, this pattern is copied from the msm8916.dtsi original. 
msm8953.dtsi has the same thing. msm8994 too, and 8998.

If you think it needs changing, then I'll have to see what can be done 
with soc@{} entries.

> 
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <19200000>;
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +		};
>> +	};
> [..]
>> +	smp2p-hexagon {
> 
> To avoid having people start sending patches that changes the sort order
> as soon as I merge this, could you please sort your nodes by address
> (not applicable for this one), then by node name alphabetically, then by
> label alphabetically.

ah. I sorted the contents of soc. I missed the upper level groupings.

> 
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <435>, <428>;
>> +
>> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		mboxes = <&apcs1_mbox 14>;
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <1>;
>> +
>> +		hexagon_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		hexagon_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			#address-cells = <0>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the reg */
>> +		reg = <0x0 0x80000000 0x0 0x0>;
>> +	};
>> +
> [..]
>> +	soc: soc@0 {
> [..]
>> +		pronto: remoteproc@a204000 {
>> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
>> +			reg = <0x0a204000 0x2000>,
>> +			      <0x0a202000 0x1000>,
>> +			      <0x0a21b000 0x3000>;
>> +			reg-names = "ccu", "dxe", "pmu";
>> +
>> +			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
>> +
>> +			memory-region = <&wcnss_mem>;
>> +
>> +			power-domains = <&rpmpd MSM8939_VDDCX>,
>> +					<&rpmpd MSM8939_VDDMX_AO>;
> 
> The purpose of the remoteproc driver's vote is to keep the rails powered
> while we're booting the remote, in the event that Linux decides to
> suspend and turn of the power rails while we're waiting...
> 
> Once the remote pulls the "handover" interrupt, it signals that it has
> cast the necessary votes and need no more hand-holding.
> 
> So it's unlikely that _AO is the right choice here.

Yes, it's probably just VDDMX isn't it.

I'll change that.

---
bod
