Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB06F521E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjECHpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:45:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA82120
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:44:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55d2e87048cso2323917b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683099896; x=1685691896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az3ZjZw5c+oMwn1F0ZqH0yI5AWLiLyNI1BlVOd3ymQ8=;
        b=zir+QTa2OoYRyEL82qbdMjPM4PdjHMEJZY1MWJvAskJCX9GmJP35sQw11Pz/ae8iZI
         LK1uvUO9Yb09slOZ0h2VU2o6LxBLLXBPAn0lM+i23XeI31IBGAMn9LDnPf85h3nXEu7W
         /7lcfLKxWlWg80qPzKTTHQsA0tK94v1RQFJwLfXKFdbVSjKVvWS8G1q1Aq1g8CdRJW2P
         RiYMX4qkZDTKuTpQoq4xXiIT9r7zG3ZeWzZP8UBf959kQlWLRLqWHI1EskALyQJ+giZY
         SyglIN3PcF7IDp3j0DC8O9D2GxfaD5oD/I+04S+wsp9y3Rb4KP/PdyCj9ym1yV+JaqP9
         sf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099896; x=1685691896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az3ZjZw5c+oMwn1F0ZqH0yI5AWLiLyNI1BlVOd3ymQ8=;
        b=mFMeeSGupIeqy9LIdo7nT3zIIf068SVQ+TfEEZPUXgFkQQJ8qC0PGpp0QKzYOfNKmJ
         0J5qrH2xj7696XWKL3jKqB13GyrfpRxDOPWh0sHuu/2AdMH6AX1pjivENq7D0vzRCrQv
         fuZolAAdph+529kUhtXK0Y01YWrF8sAgpim3P5LS5gZS+693xTsFRA+XKISOuhR1eP8Z
         Yt9vPZVXIbxnuRenchmCrmSJuVF7ZrGD8plVMTJD1HPqkvMAtTDr3cH5QbfuRq8rxQ9n
         00/JsoCvy5Hf0959Nebbi6Vw4JPUppTjvWagUL6CwoVbLfDlqz/WDR8H1ppFpuPCLjN5
         Y88w==
X-Gm-Message-State: AC+VfDx/hNBDhdmxtvBGd5oVtePgB6Ax3NUMOen7+ZjYbCCHDqOxCKHt
        2BPsUDdyAdVkyPFGsH5uviUADQ==
X-Google-Smtp-Source: ACHHUZ6nzF9dKBpKYl4KrQ1B3kU7KyZBLmv5XILSEzR8eD10wsiU6RQ9szs3+zgoxeFB55g7Mr6CjQ==
X-Received: by 2002:a0d:efc2:0:b0:556:ceb2:c462 with SMTP id y185-20020a0defc2000000b00556ceb2c462mr17663236ywe.2.1683099896640;
        Wed, 03 May 2023 00:44:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k63-20020a0dc842000000b00555ca01b112sm3283263ywd.105.2023.05.03.00.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:44:56 -0700 (PDT)
Message-ID: <0a7caa8d-289a-d76a-d57b-611b178fdc34@linaro.org>
Date:   Wed, 3 May 2023 10:44:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1683027347.git.quic_varada@quicinc.com>
 <65d05b81201a8d24c14f0d7564e708348a368068.1683027347.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <65d05b81201a8d24c14f0d7564e708348a368068.1683027347.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 07:46, Varadarajan Narayanan wrote:
> This patch adds thermal zone nodes for the various
> sensors present in IPQ9574
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

one nit below.


> ---
> [v1]:
> 	Fix node names
> ---
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index b22b999..bc4d061 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -1067,6 +1067,214 @@
>   		};
>   	};
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
> +		cluster0-thermal {

I think we were usually using cpussN instead of clusterN, but this is 
really a minor issue, we don't have that standardized.

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
> +		cluster1-thermal {
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
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
With best wishes
Dmitry

