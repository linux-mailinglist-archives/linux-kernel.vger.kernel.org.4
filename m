Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF665AFBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjABKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjABKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:46:07 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F8B6D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:46:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s22so28722356ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gsaUC0v/Cx5daJxVpaOTwcaRSbHxERH/kPKOxzGKg8=;
        b=ySumzhfMgn3J5b1AANttX0HuNBh+TRE28mbc3axsMnBXWRt0CblRawg0KCCbs5Hes1
         Y0CrIPjLGiyap2GE9bzcMQ5GwyMBBOCoVss1remJH70Dyv9BKOpmRKKAfVQIwpYoM+7T
         8/QagXqqkXmSqwGgrNZ9G00Py2y4kvwtHYNZgR53ewaTYUq8lt+7DawIEHTjznWUjN2W
         GEdWO5drD7iHWmYtlIndlqITdJXSBlMxWF5lBI/PFgIqmaRU6ZwbwNMtQVciImrG3PBy
         1roOjvyI38f4UwGGP5/l72bjjA3TTTDfL6z2Qp47HnOx2ODhK78Yy5us+6YjzMCrub9Q
         gQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsaUC0v/Cx5daJxVpaOTwcaRSbHxERH/kPKOxzGKg8=;
        b=dMxF6BGbTy9LdR6d01sDKzr1mxxC2zGBosEN14SX7Y+qP561x0Ont+YaHmPjWQmD/O
         PL9W8MF0G9GVunBLsAFzorQ2TrLrD2Ng+5LQ1dTiohmum+TnDXJuuI27uys4BDM7TUlZ
         egxK3h67xZr417hCO0aSJr58spJvpDWAITp2dubV0cr5ekyuTuGDvT7+CtyKRiGu+Gl0
         zuA6PFeorSbO2SncZWfd/4V4Wd04jAis0w1QLTMpGSQgeQLt0zu39JBNmPLewpQYHPnx
         2OYuqy4oty5MmYYTtCLe35A42B1wI8LbcXhfj6Yo1TEQfietQmyyxU7soB2ze1YoEtNH
         2qsg==
X-Gm-Message-State: AFqh2kpADB6gAWXpY/RjOUHWMgTIl5SqHklrHDji+u5jfsrM7Mb2nnF6
        1zN60H4CyqOA01L3RCxVwWOtEluCfbpaYuFO
X-Google-Smtp-Source: AMrXdXuasK8L9eUYNVBhGgmy9LlpmUexMB/f0GpYDAJGhlriilXQgFqKIoDK+pbJNMPY8DBYhFDTyQ==
X-Received: by 2002:a2e:934c:0:b0:27f:b489:d8d4 with SMTP id m12-20020a2e934c000000b0027fb489d8d4mr9907313ljh.47.1672656364664;
        Mon, 02 Jan 2023 02:46:04 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e9818000000b0027fc11a8e1asm2090917ljj.60.2023.01.02.02.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 02:46:04 -0800 (PST)
Message-ID: <514482a4-614c-d6b8-ec7c-0e69fff72295@linaro.org>
Date:   Mon, 2 Jan 2023 11:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20221231131945.3286639-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221231131945.3286639-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.12.2022 14:19, Bhupesh Sharma wrote:
> Add the Embedded USB Debugger(EUD) device tree node for
> SM6115 / SM4250 SoC.
> 
> The node contains EUD base register region and EUD mode
> manager register regions along with the interrupt entry.
> 
> Also add the typec connector node for EUD which is attached to
> EUD node via port. EUD is also attached to DWC3 node via port.
> 
> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - This patch is based on my earlier sm6115 usb related changes, which can
>   be seen here:
>   https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
> - This patch is also dependent on my sm6115 eud dt-binding and driver changes
>   sent earlier, which can be seen here:
>   https://lore.kernel.org/linux-arm-msm/20221231130743.3285664-1-bhupesh.sharma@linaro.org/
> 
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 030763187cc3f..c775f7fdb7015 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -565,6 +565,37 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		eud: eud@1610000 {
> +			compatible = "qcom,sm6115-eud","qcom,eud";
Missing space between entries.

> +			reg = <0x01610000 0x2000>,
> +			      <0x01612000 0x1000>,
> +			      <0x003e5018 0x4>;
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +			ports {
Newline before ports {}.

Not sure if debugging hardware should be enabled by default..
> +				port@0 {
> +					eud_ep: endpoint {
> +						remote-endpoint = <&usb2_role_switch>;
> +					};
> +				};
Newline between subsequent nodes.

> +				port@1 {
> +					eud_con: endpoint {
> +						remote-endpoint = <&con_eud>;
> +					};
> +				};
> +			};
> +		};
> +
> +		eud_typec: connector {
Non-MMIO nodes don't belong under /soc.

> +			compatible = "usb-c-connector";
Newline between properties and subnode.


> +			ports {
> +				port@0 {
> +					con_eud: endpoint {
> +						remote-endpoint = <&eud_con>;
> +					};
> +				};
> +			};
> +		};
> +
>  		usb_hsphy: phy@1613000 {
>  			compatible = "qcom,sm6115-qusb2-phy";
>  			reg = <0x01613000 0x180>;
> @@ -1064,6 +1095,12 @@ usb_dwc3: usb@4e00000 {
>  				snps,has-lpm-erratum;
>  				snps,hird-threshold = /bits/ 8 <0x10>;
>  				snps,usb3_lpm_capable;
> +				usb-role-switch;
Same here.

On a note, this commit + driver-side changes give me a:

1610000.eud     qcom_eud: failed to get role switch

Konrad
> +				port {
> +					usb2_role_switch: endpoint {
> +						remote-endpoint = <&eud_ep>;
> +					};
> +				};
>  			};
>  		};
>  
