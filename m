Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9193262128F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiKHNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiKHNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:40:01 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 05:39:59 PST
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6014FFB1;
        Tue,  8 Nov 2022 05:39:58 -0800 (PST)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C0EAA23094;
        Tue,  8 Nov 2022 14:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1667913720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHsTsGETyM9ArztY5iY3V0Rfi7e+Ro5TodRaJCbeNwY=;
        b=edxV4SjwuCrKcDww6MXJVHA2DqSvQDcef57fgUOKjfiGgwMAmbJyQyF04Zi0+rqsmd3tCZ
        cx+0W2zG+4dG/aOBDC5Xl8drqMXZ33xAhmwp90S6YYukvtrFs3JrAXdKtyQqw5SVOILAVZ
        UvGUDBVb0G1LLbO7BsePvRxvGTY6IHM=
Message-ID: <9e8581f7-e54d-35dc-8fd1-b07f35b43f65@ixit.cz>
Date:   Tue, 8 Nov 2022 14:22:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v2 09/18] ARM: dts: qcom: apq8064: add compat
 qcom,mdss-dsi-ctrl-apq8064
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-10-bryan.odonoghue@linaro.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20221107235654.1769462-10-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Heidelberg <david@ixit.cz>

On 08/11/2022 00:56, Bryan O'Donoghue wrote:
> Append silicon specific compatible qcom,mdss-dsi-ctrl-apq8064 to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for apq8064 against the yaml documentation.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: David Heidelberg <david@ixit.cz>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index d036dff4b14f7..f3624832e6841 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -1287,7 +1287,8 @@ mmss_sfpb: syscon@5700000 {
>   		};
>   
>   		dsi0: dsi@4700000 {
> -			compatible = "qcom,mdss-dsi-ctrl";
> +			compatible = "qcom,mdss-dsi-ctrl-apq8064",
> +				     "qcom,mdss-dsi-ctrl";
>   			label = "MDSS DSI CTRL->0";
>   			#address-cells = <1>;
>   			#size-cells = <0>;

-- 
David Heidelberg
Consultant Software Engineer

