Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F670714AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjE2Nr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjE2Nrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:47:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF0106;
        Mon, 29 May 2023 06:47:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-309382efe13so2027635f8f.2;
        Mon, 29 May 2023 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368064; x=1687960064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myJE6wqP7SpgcJyO3f8/0tcs82r/jtAw33/b3j2JkJ8=;
        b=oCpcveOpc3ZxOpH99/p0DTvagTnLnycBju6u9B40KEfprAGFjUByl9JlqOLM/v1+8U
         CGqm3R588wyIj0Pj6Dp/toPskJS/CZidIXvZcgfB2lNvWxST65L0b1WWKhGnGoILA1hS
         Juz8Kk2fmmW979GQpwI2/eEI0oWWlBcMa7/cQEaboUWgSGowZzAegovGuyC57RO/WVZK
         4Zn3qpOxCebc7xVHB+Y4Xkaggmr3XAr7SkX3q6RvyrvXt8tWAn7XlzVhPZ3L/NAsCjtQ
         R6nayL5XJKPqNFy+zbSgo5n7NWEF8mJXEFkdBNuacnyn5ty8pOyLdctD7G0agT1ZmhoT
         W4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368064; x=1687960064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myJE6wqP7SpgcJyO3f8/0tcs82r/jtAw33/b3j2JkJ8=;
        b=N5VXvRSMW1mB2YbbmjN5FaKLNWzaS8Z9pPa+WBsdz0s9mzASOxL7bYBl33VcOTUkEZ
         5bpZY3EIt1dKTFhnUWDC1Oy4sT62C+8vuX5ayJ1RDhPvm8CB1uiUcVv4QpQ5ezH/05fy
         vnZSSFwUuLTAwqxpthfnHZa7y03hHmeRnMI1DCe2xUBFtUjD2KMTcfMWfYhhOZaVJQGg
         CWfgIoZd6buuLj5Cmj3LfilcPXaS1eQxUPDxzVrxQjKwN0uInwqCT5/AAmGr/7Or8VbE
         U6iwPJSaUgni/xWMhFK8WRbPXkY3+s0Egsd5NQEHnGCgH6XISZ9Olw5HHej1d20f0MNQ
         D3yg==
X-Gm-Message-State: AC+VfDze1vl0TAYQ5wpBHz52wifr/tf4MI2n1JYv+rn0liFo3XvIo1dz
        VPcQFrGnhnUwbn0h3sOFXz8=
X-Google-Smtp-Source: ACHHUZ4CbOFmTDokYBwfIa3AupZCc9BFrord46r0GreN2feVi5EocX/omYSGgSN05k20qNnh3fvB3g==
X-Received: by 2002:adf:cd8a:0:b0:30a:e59f:cd60 with SMTP id q10-20020adfcd8a000000b0030ae59fcd60mr5247477wrj.48.1685368064021;
        Mon, 29 May 2023 06:47:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d6910000000b00307a86a4bcesm30885wru.35.2023.05.29.06.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:47:43 -0700 (PDT)
Message-ID: <e9064b57-bbe2-7774-1d08-4d7b8e28ecbf@gmail.com>
Date:   Mon, 29 May 2023 15:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
Content-Language: en-US, ca-ES, es-ES
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230405100907.53740-1-bchihi@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230405100907.53740-1-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2023 12:09, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add AP Domain thermal zones for the mt8195 and
> specify the targeted temperature thresholds.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> 

Applied, thanks!

> ---
> This patch squashes and replaces
> 
> [PATCH 3/4] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
> https://lore.kernel.org/all/20230307154524.118541-4-bchihi@baylibre.com/
> 
> and
> 
> [PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds
> https://lore.kernel.org/all/20230307154524.118541-5-bchihi@baylibre.com/
> 
> of the series
> 
> [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
> https://lore.kernel.org/all/20230307154524.118541-1-bchihi@baylibre.com/
> ---
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 180 +++++++++++++++++++++++
>   1 file changed, 180 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 972c5b86ddae..75da456c512b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2909,5 +2909,185 @@ map0 {
>   				};
>   			};
>   		};
> +
> +		vpu0-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
> +
> +			trips {
> +				vpu0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				vpu0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		vpu1-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_VPU1>;
> +
> +			trips {
> +				vpu1_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				vpu1_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu0-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_GPU0>;
> +
> +			trips {
> +				gpu0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu1-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_GPU1>;
> +
> +			trips {
> +				gpu1_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		vdec-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_VDEC>;
> +
> +			trips {
> +				vdec_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				vdec_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		img-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_IMG>;
> +
> +			trips {
> +				img_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				img_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		infra-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_INFRA>;
> +
> +			trips {
> +				infra_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				infra_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cam0-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_CAM0>;
> +
> +			trips {
> +				cam0_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cam0_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cam1-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8195_AP_CAM1>;
> +
> +			trips {
> +				cam1_alert: trip-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cam1_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
>   	};
>   };
