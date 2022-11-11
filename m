Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802016255CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiKKIzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiKKIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:55:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6DD2F5;
        Fri, 11 Nov 2022 00:55:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5376467wmb.0;
        Fri, 11 Nov 2022 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj8TZH6FHZaJ1Y0eiYMLLPzwa67amSVNW3qpHCEWrZE=;
        b=mWMLW2/uMJD573/qJJXZSTCbmxYU7kkXWZZCedNYMz/0AIVNuezCtnvD2AhJ112QsW
         b2ie5wcZ2wFpwaRb510Kx1nTFDJj2p0T9p8eYI3TTWVnnwcRvU/Sy+LzplTHB4sThRiA
         jtTn+J5MHQ5IoJJBhHUkEfIcBn+QTcCGEvr2TG6z/KWZAElxG1KLhGsu5UGcpQKloSzU
         DJP+9cR57HOn6liPJC6uDbP9WyDJvh24HvzSU1kaYXxCbYRfw+48GtZuApOydYCTOdP/
         9Luyok6bw7TjkekusjdOz8wBTqaP1nsM0D7CKVP9cQ3STDxGaQvlVcPozrQxQxCtPUYt
         WAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj8TZH6FHZaJ1Y0eiYMLLPzwa67amSVNW3qpHCEWrZE=;
        b=Pb1nM9qEqVYthfTUhMzpIhpP3t02sa9iGXzzX/jnJNQBcmz9YFni3cnXckW4v6FqDU
         KalD/bkqaCCH8GYlf7UXdnlzSxrpHUzaWb4cjBYedQYhL5XUypJPXMz6uvxpLngymnIC
         BI1bjRlPpNKpLTLQANVyzQ/zUnl6YLfzAwUBcaETOhbqtKuZP1JPqiQg3tV/UE6xmnzk
         53fNBxwWiNpJ6aSV61euxNHW2TY6INJWh0lkMugblD1cMibZemCQcYcHz8Q7by5Y2aKB
         uRwT3QL49uRssJmIBugxuREQLoZQygV8DQvewByMJ4druTU4COAae9f4GjPQ8q0SkPlB
         l+UQ==
X-Gm-Message-State: ANoB5pnwI5IwrHzieKAvAgYLR9MlFFE+VCagWDedoPTh4T8cC3/bniam
        JSet/1xYb6aV0+5HHW9L/6k=
X-Google-Smtp-Source: AA0mqf5gpxoWo3QN+NFqQyVSF9ENcnuCFFW908PzcZPm9wb9ZK9Z0PdC7xQtzbGzZyh/67SuVZ86kQ==
X-Received: by 2002:a05:600c:2d05:b0:3b4:8603:e2ae with SMTP id x5-20020a05600c2d0500b003b48603e2aemr530274wmf.148.1668156932059;
        Fri, 11 Nov 2022 00:55:32 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z15-20020a056000110f00b0022a3a887ceasm1327149wrw.49.2022.11.11.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:55:30 -0800 (PST)
Message-ID: <d38f8b81-b62e-18c5-1bd3-d1bc1f2b98d9@gmail.com>
Date:   Fri, 11 Nov 2022 09:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 01/11] arm64: dts: mt7986: harmonize device node order
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-2-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221106085034.12582-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2022 09:50, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This arrange device tree nodes in alphabetical order.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
> i modified sams patch
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220427124741.18245-2-sam.shih@mediatek.com/
> 
> by moving pio-node up instead of moving uarts down to ensure alphabetical
> order for switch-/wifi-node.
> 
> And moved uart0 and wifi in mt7986b-rfb too.
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 94 ++++++++++----------
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 22 ++---
>   2 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index afe37b702eef..6189436fe31d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -54,6 +54,53 @@ switch: switch@0 {
>   	};
>   };
>   
> +&pio {
> +	uart1_pins: uart1-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart1";
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart2";
> +		};
> +	};
> +
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +};
> +
>   &switch {
>   	ports {
>   		#address-cells = <1>;
> @@ -121,50 +168,3 @@ &wifi {
>   	pinctrl-0 = <&wf_2g_5g_pins>;
>   	pinctrl-1 = <&wf_dbdc_pins>;
>   };
> -
> -&pio {
> -	uart1_pins: uart1-pins {
> -		mux {
> -			function = "uart";
> -			groups = "uart1";
> -		};
> -	};
> -
> -	uart2_pins: uart2-pins {
> -		mux {
> -			function = "uart";
> -			groups = "uart2";
> -		};
> -	};
> -
> -	wf_2g_5g_pins: wf-2g-5g-pins {
> -		mux {
> -			function = "wifi";
> -			groups = "wf_2g", "wf_5g";
> -		};
> -		conf {
> -			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> -			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> -			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> -			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> -			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> -			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> -			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> -			drive-strength = <4>;
> -		};
> -	};
> -
> -	wf_dbdc_pins: wf-dbdc-pins {
> -		mux {
> -			function = "wifi";
> -			groups = "wf_dbdc";
> -		};
> -		conf {
> -			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> -			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> -			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> -			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> -			drive-strength = <4>;
> -		};
> -	};
> -};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 3443013b5971..7459ddb6b6f0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -25,10 +25,6 @@ memory@40000000 {
>   	};
>   };
>   
> -&uart0 {
> -	status = "okay";
> -};
> -
>   &eth {
>   	status = "okay";
>   
> @@ -99,13 +95,6 @@ fixed-link {
>   	};
>   };
>   
> -&wifi {
> -	status = "okay";
> -	pinctrl-names = "default", "dbdc";
> -	pinctrl-0 = <&wf_2g_5g_pins>;
> -	pinctrl-1 = <&wf_dbdc_pins>;
> -};
> -
>   &pio {
>   	wf_2g_5g_pins: wf-2g-5g-pins {
>   		mux {
> @@ -138,3 +127,14 @@ conf {
>   		};
>   	};
>   };
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
