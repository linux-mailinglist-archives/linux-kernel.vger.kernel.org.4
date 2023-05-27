Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954C7135B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjE0QQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0QQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:16:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F426DF
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:16:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4f8b94c06so30427e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685204171; x=1687796171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzqcMXV8aXA/E+ztgmw9/NYRg5djZnCXl7rg+fvKKrc=;
        b=TtMAQUviQJGDF72CxJTvYtB5tPNXNF9VrGvM7O32PAiE28IptQtNzU5U1Ci0pS3Q91
         Fg28aqMjXlZQrZU9jIig/mffAquE6EuETpOdOd0ASBJ38c3w8sntsNI3Q7qlIBep++eA
         /xo70HT+P2aanYp0tqSCWWpa+ojpMu5E6y96isiGlQKtweI1GfYpj86fbpKPF6XqlxvA
         KmWfi5J7Xa0Cox/8FKrUNRiREiEyGFB0cUjBPxk1PiQbpk4jl8fCMShVHa8uIZlQWY1Q
         QlQPHeuZsGvBLoaf+QSN77hPQt3+z+iNnPWtyxCQa61eIDmU8rG43o7aVUpYPN5WfVpn
         a94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685204171; x=1687796171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzqcMXV8aXA/E+ztgmw9/NYRg5djZnCXl7rg+fvKKrc=;
        b=ZcE/Rd0qZPzSD9dv05ySqE76gVxDu3qSupDrzRUASP5TkXqANtUNQdY0r8mQ+Ezeb/
         hVJzZCIKjwdDZbaEw7bvvm9ON6HW1ovV0cGTTVHg2ozdhROa8aeiQQZTqJLeVwH0x6YL
         ZjfT28D8smDZHstumrV+C5FzpJ9Po5+pV9D0RWdvxrWUn+B6lCAms+9NXF2I34EncnNM
         Ydaz0fIloTKSfZ6dVx/9jICROtJCL4bOQkLsgg61QPfAn1kT4bUGsjCG3AH96KbbQsYc
         ixCXDCz2VJpC9NJh67M9tn5dMoIs9av5+8kdlzOIQoaTeoOakmQ0KVlYQ1OqUofhXZb+
         7o6w==
X-Gm-Message-State: AC+VfDzJyYhwnKzbiRWkOIIJMS4PgvN1Urx71hPii3/D90mYDLQUo7M/
        NqyXkz2oRQPc1WD02S9zN58PHA==
X-Google-Smtp-Source: ACHHUZ4VFGTXe0x62XEJ3vBr9o9yIQ7A76CQBcp/c/JXEH03cAQIi/MjgGe/3z2upGj/n3XlhGanVg==
X-Received: by 2002:a05:6512:64:b0:4f0:c18:5114 with SMTP id i4-20020a056512006400b004f00c185114mr1623049lfo.26.1685204171275;
        Sat, 27 May 2023 09:16:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id x14-20020a19f60e000000b004efe9a169d2sm1175071lfe.64.2023.05.27.09.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 09:16:10 -0700 (PDT)
Message-ID: <f2ed6b88-13df-8df7-55e0-5d11bf5a1ef0@linaro.org>
Date:   Sat, 27 May 2023 18:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8996pro: Add CBF scaling
 support
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
 <20230527093934.101335-3-y.oudjana@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230527093934.101335-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.05.2023 11:39, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add opp-peak-kBps to CPU OPPs to allow for CBF scaling, and change the
> CBF compatible to reflect the difference between it and the one on
> MSM8996.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Now let's sprinkle some BWMON, CPR and GPMU and 8996 will be
fairly complete as far as the core hw goes.. At last!

Konrad
>  arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 51 ++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
> index a679a9c0cf99..b74cff06f300 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
> @@ -24,101 +24,121 @@ opp-307200000 {
>  			opp-hz = /bits/ 64 <307200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-384000000 {
>  			opp-hz = /bits/ 64 <384000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-460800000 {
>  			opp-hz = /bits/ 64 <460800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-537600000 {
>  			opp-hz = /bits/ 64 <537600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-614400000 {
>  			opp-hz = /bits/ 64 <614400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-691200000 {
>  			opp-hz = /bits/ 64 <691200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <307200>;
>  		};
>  		opp-768000000 {
>  			opp-hz = /bits/ 64 <768000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <307200>;
>  		};
>  		opp-844800000 {
>  			opp-hz = /bits/ 64 <844800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <384000>;
>  		};
>  		opp-902400000 {
>  			opp-hz = /bits/ 64 <902400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <441600>;
>  		};
>  		opp-979200000 {
>  			opp-hz = /bits/ 64 <979200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <537600>;
>  		};
>  		opp-1056000000 {
>  			opp-hz = /bits/ 64 <1056000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <614400>;
>  		};
>  		opp-1132800000 {
>  			opp-hz = /bits/ 64 <1132800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <691200>;
>  		};
>  		opp-1209600000 {
>  			opp-hz = /bits/ 64 <1209600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <768000>;
>  		};
>  		opp-1286400000 {
>  			opp-hz = /bits/ 64 <1286400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <844800>;
>  		};
>  		opp-1363200000 {
>  			opp-hz = /bits/ 64 <1363200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <902400>;
>  		};
>  		opp-1440000000 {
>  			opp-hz = /bits/ 64 <1440000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <979200>;
>  		};
>  		opp-1516800000 {
>  			opp-hz = /bits/ 64 <1516800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1132800>;
>  		};
>  		opp-1593600000 {
>  			opp-hz = /bits/ 64 <1593600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1190400>;
>  		};
>  		opp-1996800000 {
>  			opp-hz = /bits/ 64 <1996800000>;
>  			opp-supported-hw = <0x20>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1516800>;
>  		};
>  		opp-2188800000 {
>  			opp-hz = /bits/ 64 <2188800000>;
>  			opp-supported-hw = <0x10>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1593600>;
>  		};
>  	};
>  
> @@ -131,136 +151,163 @@ opp-307200000 {
>  			opp-hz = /bits/ 64 <307200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-384000000 {
>  			opp-hz = /bits/ 64 <384000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-460800000 {
>  			opp-hz = /bits/ 64 <460800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-537600000 {
>  			opp-hz = /bits/ 64 <537600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-614400000 {
>  			opp-hz = /bits/ 64 <614400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <192000>;
>  		};
>  		opp-691200000 {
>  			opp-hz = /bits/ 64 <691200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <307200>;
>  		};
>  		opp-748800000 {
>  			opp-hz = /bits/ 64 <748800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <307200>;
>  		};
>  		opp-825600000 {
>  			opp-hz = /bits/ 64 <825600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <384000>;
>  		};
>  		opp-902400000 {
>  			opp-hz = /bits/ 64 <902400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <441600>;
>  		};
>  		opp-979200000 {
>  			opp-hz = /bits/ 64 <979200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <441600>;
>  		};
>  		opp-1056000000 {
>  			opp-hz = /bits/ 64 <1056000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <537600>;
>  		};
>  		opp-1132800000 {
>  			opp-hz = /bits/ 64 <1132800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <614400>;
>  		};
>  		opp-1209600000 {
>  			opp-hz = /bits/ 64 <1209600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <691200>;
>  		};
>  		opp-1286400000 {
>  			opp-hz = /bits/ 64 <1286400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <768000>;
>  		};
>  		opp-1363200000 {
>  			opp-hz = /bits/ 64 <1363200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <844800>;
>  		};
>  		opp-1440000000 {
>  			opp-hz = /bits/ 64 <1440000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <902400>;
>  		};
>  		opp-1516800000 {
>  			opp-hz = /bits/ 64 <1516800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <979200>;
>  		};
>  		opp-1593600000 {
>  			opp-hz = /bits/ 64 <1593600000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1056000>;
>  		};
>  		opp-1670400000 {
>  			opp-hz = /bits/ 64 <1670400000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1132800>;
>  		};
>  		opp-1747200000 {
>  			opp-hz = /bits/ 64 <1747200000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1190400>;
>  		};
>  		opp-1824000000 {
>  			opp-hz = /bits/ 64 <1824000000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1286400>;
>  		};
>  		opp-1900800000 {
>  			opp-hz = /bits/ 64 <1900800000>;
>  			opp-supported-hw = <0x70>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1363200>;
>  		};
>  		opp-1977600000 {
>  			opp-hz = /bits/ 64 <1977600000>;
>  			opp-supported-hw = <0x30>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1440000>;
>  		};
>  		opp-2054400000 {
>  			opp-hz = /bits/ 64 <2054400000>;
>  			opp-supported-hw = <0x30>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1516800>;
>  		};
>  		opp-2150400000 {
>  			opp-hz = /bits/ 64 <2150400000>;
>  			opp-supported-hw = <0x30>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1593600>;
>  		};
>  		opp-2246400000 {
>  			opp-hz = /bits/ 64 <2246400000>;
>  			opp-supported-hw = <0x10>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1593600>;
>  		};
>  		opp-2342400000 {
>  			opp-hz = /bits/ 64 <2342400000>;
>  			opp-supported-hw = <0x10>;
>  			clock-latency-ns = <200000>;
> +			opp-peak-kBps = <1593600>;
>  		};
>  	};
>  };
> @@ -289,3 +336,7 @@ opp-560000000 {
>  	};
>  	/* The rest is inherited from msm8996 */
>  };
> +
> +&cbf {
> +	compatible = "qcom,msm8996pro-cbf";
> +};
