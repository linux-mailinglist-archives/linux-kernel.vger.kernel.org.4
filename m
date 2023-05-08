Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF46FA2DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjEHJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjEHJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:01:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC372269C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f22908a082so1733295e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536415; x=1686128415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT1MjX9Jt1V1wOfZQ22B9L8R20mNO/popYvQeqwMHes=;
        b=Vqw9qGa5EUnl82dBIYP3d873838EBEWXEGt1jxJjIb3DuldpgfMH0MSDBaGL/nzEMt
         YKHLjY9U59TWVWDU0uy2YXzzcML0x5q1VJ8SnHVYgw57LC/NTzrh1aoektDKxfHphWKa
         kM+KhSnZLOnVaa6UKIE7fovrWRpCXlbTSwF4QRu9dYTMYbYbAOHcwELa+hY4D2vO+Kkq
         WJcaBMVMBd4Uj1MkAJm0JTF1VKELx1/ItDVFytEDn5K2GGjz+gBHB6KDVqV+BOjWEDyu
         1kP4jMFbZiXdEEV20h4JuMQB2FV4fY9Ck552RAhNHAAWG3UirZLXJaq2Fj5FW49Vu226
         w+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536415; x=1686128415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT1MjX9Jt1V1wOfZQ22B9L8R20mNO/popYvQeqwMHes=;
        b=czbQJPzoKQW47e4ya3ogwXQvhQVHX9VN9FgDuiH9BYZFRuOrtyAj2KZhdUuQy1t2e7
         4ePUVXkz6xXmRALduCb73u3+lqHnm5j3FI+INIiAMgOFCNqi5d+1eZ1WQuepCNCa48Wj
         8OiQHyIyGKDnBMXCtQyTIYFzdddaaYQ8P7ROn5HbGsgtDnXTkQFqZ+GgUmtQ+8Z0y3iP
         D0y0euF0mQDgvoIBuTuREurmIKxeuMG7dJ1cR+k4zkwOuwfRWYMwT4TkXutDt/cIPs8d
         99KUFAlwmQe/ywP/IeQmPKNZ5xitLP0CzaewuB/6fHxA1HOvl8gNmmrTaDUkmf/euWMY
         P2YA==
X-Gm-Message-State: AC+VfDxfDzKRR1N7DqNWDYHW/Vu5LZvndbRE10TCujz6NWVAIGNlTwVP
        kifCOA8Jl7/qBSfBmgmlnsDSyg==
X-Google-Smtp-Source: ACHHUZ5tnKfNqFFrQml/C0rlmRjXoCzgUpGXhKhZmXq72SSIs6MgMwcDBJSAnMpLpJ653tjBo2ya/Q==
X-Received: by 2002:ac2:44c9:0:b0:4ef:f509:1184 with SMTP id d9-20020ac244c9000000b004eff5091184mr2276066lfm.3.1683536415351;
        Mon, 08 May 2023 02:00:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id u15-20020ac248af000000b004edc20b8929sm1235989lfg.69.2023.05.08.02.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:00:14 -0700 (PDT)
Message-ID: <9773aeee-1529-7fd8-b24d-d665e622f8d3@linaro.org>
Date:   Mon, 8 May 2023 11:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: ipq9574: add thermal zone nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1683523370.git.quic_varada@quicinc.com>
 <af01d0887e78b55f2af0a251837f7d13a00905bc.1683523370.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <af01d0887e78b55f2af0a251837f7d13a00905bc.1683523370.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.05.2023 07:32, Varadarajan Narayanan wrote:
> This patch adds thermal zone nodes for the various
> sensors present in IPQ9574
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v2]:
> 	Rename clusterX nodes as cpussX nodes
> 
> [v1]:
> 	Fix node names
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 85bba6a..5a29ee7 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -1067,6 +1067,214 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		nss-top-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 3>;
> +
> +			trips {
> +				nss-top-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		ubi-0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 4>;
> +
> +			trips {
> +				ubi_0-critical {
no underscores in node names

Konrad
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		ubi-1-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 5>;
> +
> +			trips {
> +				ubi_1-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		ubi-2-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 6>;
> +
> +			trips {
> +				ubi_2-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		ubi-3-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 7>;
> +
> +			trips {
> +				ubi_3-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpuss0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 8>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpuss1-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 9>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu0-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 10>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <10000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 11>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <10000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 12>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <10000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 13>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <10000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		wcss-phyb-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 14>;
> +
> +			trips {
> +				wcss_phyb-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		top-glue-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 15>;
> +
> +			trips {
> +				top_glue-critical {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
