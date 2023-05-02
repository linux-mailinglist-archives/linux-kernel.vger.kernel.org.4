Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A36F424A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjEBLHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjEBLHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:07:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9F49FA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:07:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso27532592e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683025631; x=1685617631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PULIHjTL+BqotFHLEBxc5PXwcQ92x+ai+H8UIvev6Xs=;
        b=AhwpCzFayDP+QLvkYnNRRT0diBdlgwhpXgJ9x/uf9Pt0fa1f88cH3CniFGiddMq76b
         B4mxAfNpBpptjmVWBPqmn5FBxwfIDhSWWk2Xq581jqywXnXQDGyKbPjGekn3gVkmQcI+
         oNWVyiqqSiLqVfuRi5bDE560iMUsMv2pZUFXLUN7ZIb1a6VNnEg44oUigHyKeTn6inUb
         Lx0JZLzbOqSp0MsmFg9d11+g3LY0u6rk1B9ZRiJM9OqJXEkaM/8TpkWbc0osI7xR8htK
         LH62GR9VS+W+OFZL6o9XgtsB9IuRZjwGt7+/Z6q9Oq6x39HfSW5wyKSSL7S0GUwe6dOK
         l3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025631; x=1685617631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PULIHjTL+BqotFHLEBxc5PXwcQ92x+ai+H8UIvev6Xs=;
        b=PbLiQufSUTpbRuL+4tKESAk0H8GWEXFn9tVRZWP9SDGdo+HPp9/1dZOoF5NkZqXu8r
         gyW3tRoA6GQR+wQNo6biLMe3UPBrmrkjuj7Z0ii1V0Vu6mZ+x8QgtIo+aOXpgbCDuCrJ
         H3AhrSm0oTHgURDK95RJRJTxG5gFASn1anf2BQE15aRr1SLGMNbFcJh1mioxmK+EfH2i
         jBEarEjpGN7bL1nlTmzXcTcln8zOuN0HF44ewZ41LAkmSXK0p1OXOYQ82SSzaHjp7o+I
         C2c5HEleApHpzyA5IfSwQQ5GJHPffH4DAmHDhKWcQmxwAPxOl+wqESLJUU8fVWCR6oqF
         F58Q==
X-Gm-Message-State: AC+VfDz3OzAG/yYLvRjKD5cJmgwRfkhUOhTVRroHdA9UtpgAnsf7gdgd
        JfXkcXzAKUAwN66GlbsIYWX5ow==
X-Google-Smtp-Source: ACHHUZ5GIrUX3luVCFDWkL2w6BsQXcfgDLim2NjjmJK5Bhhmz7C+bWShuyFVhZPhQEY7YNIiJf5l3g==
X-Received: by 2002:a05:6512:eaa:b0:4ef:edb4:2c77 with SMTP id bi42-20020a0565120eaa00b004efedb42c77mr5980804lfb.11.1683025631089;
        Tue, 02 May 2023 04:07:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y10-20020a19750a000000b004eff0ce3ae5sm4028269lfe.145.2023.05.02.04.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:07:10 -0700 (PDT)
Message-ID: <0e76a9f6-f062-2802-d9de-3c0b2b897a4e@linaro.org>
Date:   Tue, 2 May 2023 13:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: sa8540-ride: Enable first port
 of tertiary usb controller
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-10-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230501143445.3851-10-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.05.2023 16:34, Krishna Kurapati wrote:
> There is now support for the multiport USB controller this uses so
> enable it.
> 
> The board only has a single port hooked up (despite it being wired up to
> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> which by default on boot is selected to mux properly. Grab the gpio
> controlling that and ensure it stays in the right position so USB 2.0
> continues to be routed from the external port to the SoC.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
same comments as patch 8

Konrad
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 24fa449d48a6..53d47593306e 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -309,6 +309,19 @@ &usb_2_qmpphy0 {
>  	status = "okay";
>  };
>  
> +&usb_2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb2_en_state>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +	phy-names = "usb2-port0", "usb3-port0";
> +	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
> @@ -401,4 +414,13 @@ wake-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	usb2_en_state: usb2-en-state {
> +		/* TS3USB221A USB2.0 mux select */
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
>  };
