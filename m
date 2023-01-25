Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27D67AA95
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjAYG4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:56:14 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D946156;
        Tue, 24 Jan 2023 22:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674629769; x=1706165769;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YMx7fJhFYNEDzZOnRhXuw3ctktU/hF+YlmhWtXN/IKU=;
  b=m32ULWG4CDMiTTmyUjiuk4bSb5VLtR1gqJkcyDfrggb5vLPgahpUaWp6
   rernIFeQx/AUPJwswB8KGBo7rLbkM/2BkvmPeEg3lRNUtiUz+7VnAUcb5
   DdASTQMiR8pAF4XB3Ft+l22s/Y240rhq81DUeB9feHiaq5O1AvCKKYt2H
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jan 2023 22:56:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 22:56:09 -0800
Received: from [10.216.52.138] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 22:56:03 -0800
Message-ID: <30166208-ba9d-e6e6-1cd2-807a80536052@quicinc.com>
Date:   Wed, 25 Jan 2023 12:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8540p-ride: Document i2c busses
To:     Andrew Halaney <ahalaney@redhat.com>, <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bmasney@redhat.com>
References: <20230124192351.695838-1-ahalaney@redhat.com>
 <20230124192351.695838-2-ahalaney@redhat.com>
Content-Language: en-US
In-Reply-To: <20230124192351.695838-2-ahalaney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 12:53 AM, Andrew Halaney wrote:
> It isn't obvious in the current devicetree what is connected. Go ahead
> and document what's on the other end.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> Not sure if this sort of patch is actually welcomed or not but I went
> through this exercise (for the prior patch) and thought it might be
> useful to document.
> 
> Shazad, this also highlights (unless I misread things) that i2c12 has no
> use for us, right? If agreed I can remove it but sorting through the
> lore links that provided all this it seems like at the time it was
> desired to be added.
> 

Andrew, i2c12 has GPU PWR ctl use case, so let's keep it enabled.

-Shazad

> Thanks,
> Andrew
> 
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index cb9fbdeb5a9e..3478ab91fe73 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -317,6 +317,7 @@ &xo_board_clk {
>   
>   &tlmm {
>   	i2c0_default: i2c0-default-state {
> +		/* To USB7002T-I/KDXVA0 USB hub (SIP1 only) */
>   		pins = "gpio135", "gpio136";
>   		function = "qup0";
>   		drive-strength = <2>;
> @@ -324,6 +325,7 @@ i2c0_default: i2c0-default-state {
>   	};
>   
>   	i2c1_default: i2c1-default-state {
> +		/* To PM40028B-F3EI PCIe switch */
>   		pins = "gpio158", "gpio159";
>   		function = "qup1";
>   		drive-strength = <2>;
> @@ -331,6 +333,7 @@ i2c1_default: i2c1-default-state {
>   	};
>   
>   	i2c12_default: i2c12-default-state {
> +		/* Not connected */
>   		pins = "gpio0", "gpio1";
>   		function = "qup12";
>   		drive-strength = <2>;
> @@ -338,6 +341,7 @@ i2c12_default: i2c12-default-state {
>   	};
>   
>   	i2c15_default: i2c15-default-state {
> +		/* To display connector (SIP1 only) */
>   		pins = "gpio36", "gpio37";
>   		function = "qup15";
>   		drive-strength = <2>;
> @@ -345,6 +349,7 @@ i2c15_default: i2c15-default-state {
>   	};
>   
>   	i2c18_default: i2c18-default-state {
> +		/* To ASM330LHH IMU (SIP1 only) */
>   		pins = "gpio66", "gpio67";
>   		function = "qup18";
>   		drive-strength = <2>;
