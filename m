Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90211668A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjAMDce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjAMDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:31:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378763387
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:31:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v25so31243418lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xxkk3k7kZDxZBMfIcVCwNGDJhBXh5gAT/YppjztnhV8=;
        b=k4KzBEYonpzqHdcf8H1rP5P2jbyHiXZeHLYBh13JBA0TdQZ5bPs3wUND+ZXehXtrE5
         JYVIPFadh1CGAjVaq45lUrNf8apoS4RZo5ygFcNtwgm/eyWxEyWOFzJ2Xl3Av5NTpfeF
         jUDg3bRFhzy26ZkTjtlJd0kN+SgegIExMNM0bjaBI/6RKNRSsKtKADe++SSWQeIDMrGp
         2RfS29AvTZNShJuoz0+dPrEZQKQFKhBM6dGnJyNBQF6+Qs7Zcf0q1A4nESSjZAsHVziY
         zZNXw6O6KzIHoVq5rkpvqZ+ZyV2ZhGkw7qd3Vr8ODQxPaHlH9ED2zYZ9CdsGCmxtS0yr
         Bmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxkk3k7kZDxZBMfIcVCwNGDJhBXh5gAT/YppjztnhV8=;
        b=Ztr/nlsWa0XoS3WOekrSkw8KVVj/pC45MDmForVx+npd22hl7X3wUgMuNELAB4RZbU
         QEJiKlwgPbjdOJ8Gh9LqjBRVmJVQdvx70WFTu4c9TLTZzhhDAGOSRi3SVBD1aOLT4eGy
         9UpHw6MRuukj2+TF2WZQJuD3YMTb7eLLDpVHkscay3bWFEo94IfifUUSD+1nKZCRDEcz
         cSQZ6Uh/8azBiXUs+qlp5sm0dbf5WzU9sGB/lJfx+U8P7hX/5ZjnExMYelaK03rXUaHi
         8HPRTnpPDn5psZ7Yr3n4OkljVPtHD751k9guB/R01tn0ABzynb1trSxdUt+O9AB84O8x
         0HYA==
X-Gm-Message-State: AFqh2kr25b4dllA4XI5LPVNNahsMH4WiWNUDrhdNgVxx6X/MO3/J3eZG
        DA96vm6JlRAmYmgsnX02hqEZThiZjXvSNKpa
X-Google-Smtp-Source: AMrXdXsbMx70B238pRdj+lJGMKopHIcg5ieKpoy3XX+PFuS2TGe2wD54E86b+KY8QYkULCEPEBFoYQ==
X-Received: by 2002:a05:6512:695:b0:4cd:efb8:6a0d with SMTP id t21-20020a056512069500b004cdefb86a0dmr1174830lfe.25.1673580714687;
        Thu, 12 Jan 2023 19:31:54 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ac02000000b004bd8534ebbcsm3602603lfc.37.2023.01.12.19.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 19:31:53 -0800 (PST)
Message-ID: <921f2f4b-a3b8-58d9-b3b9-ad65cb8f4d29@linaro.org>
Date:   Fri, 13 Jan 2023 04:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: add display port audio
Content-Language: en-US
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230113032510.749804-1-judyhsiao@chromium.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113032510.749804-1-judyhsiao@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: this is not the first revision that you've sent, the
versions are 1-indexed, so [PATCH] is implicitly [PATCH v1],
this should have been a v2....

On 13.01.2023 04:25, Judy Hsiao wrote:
> Add DisplayPort sound node and lpass_cpu node
> in sc7280-herobrine-audio-rt5682.dtsi.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> 
> ---
> Changes Since v1:
..because otherwise this doesn't make sense, as the subject
suggests *this* is the v1.

Konrad
>     -- Fix the commit message.
> 
> 
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> index af685bc35e10..69e7aa7b2f6c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -33,9 +33,22 @@ codec {
>  		};
>  
>  		dai-link@1 {
> -			link-name = "ALC5682";
> +			link-name = "DisplayPort";
>  			reg = <1>;
>  
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +			};
> +
> +			codec {
> +				sound-dai = <&mdss_dp>;
> +			};
> +		};
> +
> +		dai-link@2 {
> +			link-name = "ALC5682";
> +			reg = <2>;
> +
>  			cpu {
>  				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
>  			};
> @@ -92,6 +105,10 @@ dai-link@1 {
>  		reg = <MI2S_SECONDARY>;
>  		qcom,playback-sd-lines = <0>;
>  	};
> +
> +	dai-link@5 {
> +		reg = <LPASS_DP_RX>;
> +	};
>  };
>  
>  /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
