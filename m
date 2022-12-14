Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2064C7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiLNL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLNL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:27:12 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FFE23146
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:27:11 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s25so6363155lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUwSQfrmxkXxcSThv/gqQeUGBMH96Xj+hcZQD1ayQ7E=;
        b=X9PdEGBsX25/wMEwZvSh76s1LBIktzXudvlLiWb9b+sBhL9x1TO50Ju5bXSoi+3KCU
         hzdzXwM+Vpvh1PNdPWl7KNwT/Dq9YVj/wSojZ5ZZzkAxU1cJq3WDUXE1OwWClvXKAK2v
         h38b1EX9Z7d8Ok0DUQ85IfIQqoQwAUWAawVtXxpSlKjQ+oTNf/bvpE2c4lIj8ZKh/WW5
         2OB3f+8fqvmHSv0Lk5i7/caABrWJE+ix37KMCHEysPV3G+Tfxqqz4VVjW/aLx1nSRnll
         eeFeoqUkh/Vvw0qAYgkMOUi6HFg7EwW+Ux6XAw92x6bmvrmdG/ac4gMmVvMlWFT8fpWn
         KqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUwSQfrmxkXxcSThv/gqQeUGBMH96Xj+hcZQD1ayQ7E=;
        b=7rtK+NalpottQ6WDHznOIb7EnunrgJke9qbTFrdL00zImuY0WUM+CNeu4rUd+9sK6H
         bMTxYKND3VSUeU8okG4tIIq+oz4aEThh6hnHhbOr4vgUCepkSyU6JpGTw2993bUvMFj6
         MhSawRcCmNt1HVVI/P1VLlLILtliSZRS7s/I/xgqQfkeYRo7SnSlcNxf/s2NDte1kwe3
         G1gK4EnhF2Lp4VzZzsZqJMb98OIgsk/B9NO+6E1LPBmbA92ptsJ/hSLV/tFGtgYwmrA3
         Jr+uE42HT/0ul2Ae11mBWA0deJetmRv4VVl1utTLHrMvLFi9xmK26ONJ4OsT7LNnnkN9
         9Zhw==
X-Gm-Message-State: ANoB5pl/3fsv9w04jJBC6tLNUf1CI3OEaUA+XY5H5AO4wDSP5ZVsQHuS
        40MYfkqmy5z93xY383uDoF6MYQ==
X-Google-Smtp-Source: AA0mqf4ZsxFMzN2tnAv+bREH1nhgkBpN0zhJoAJDlvEeMMLWRWSG3rLB65FUlsO0W2/OexNhaEat5A==
X-Received: by 2002:a05:651c:1ca:b0:279:71ff:5f59 with SMTP id d10-20020a05651c01ca00b0027971ff5f59mr6982679ljn.43.1671017229750;
        Wed, 14 Dec 2022 03:27:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r6-20020ac25f86000000b004b4cbc942a3sm769241lfe.127.2022.12.14.03.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:27:09 -0800 (PST)
Message-ID: <f23f3db8-08a7-78a9-a516-de211c53b6f4@linaro.org>
Date:   Wed, 14 Dec 2022 12:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: Introduce a carveout for modem
 metadata
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-2-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213140724.8612-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 15:07, Sibi Sankar wrote:
> Introduce a new carveout for modem metadata. This will serve as a
> replacement for the memory region used by MSA to authenticate modem
> ELF headers.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi    | 6 ++++++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi                  | 9 +++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi                  | 9 +++++++++
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts                | 7 ++++++-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi           | 7 ++++++-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 7 ++++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi                   | 9 +++++++++
>  7 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index 5b47b8de69da..4242f8587c19 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -127,6 +127,12 @@
>  			reg = <0x0 0xf6f00000 0x0 0x100000>;
>  			no-map;
>  		};
> +
> +		/delete-node/ memory@91700000;
> +		mdata_mem: memory@f7100000 {
> +			reg = <0x0 0xf7100000 0x0 0x4000>;
> +			no-map;
> +		};
>  	};
>  
>  	vph_pwr: vph-pwr-regulator {
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index cc65f52bb80f..3f5fb08e2341 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -462,6 +462,11 @@
>  			reg = <0x0 0x91500000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		mdata_mem: memory@91700000 {
> +			reg = <0x0 0x91700000 0x0 0x4000>;
> +			no-map;
> +		};
>  	};
>  
>  	rpm-glink {
> @@ -2458,6 +2463,10 @@
>  				memory-region = <&mpss_mem>;
>  			};
>  
> +			metadata {

Does it pass dtbs_check?

Best regards,
Krzysztof

