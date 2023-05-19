Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D170A354
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjESX1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjESX1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:27:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C2DE45
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:27:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00d41df22so1722961e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684538827; x=1687130827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QsFRFDPv+w7LZXZOw0WA98ik9DN1mQO3qx3JO5B1H0=;
        b=uI81i88i4vLJSz57S9e4aavEnPgPe8LEhscoxsdJHS8rI14Kpk3cINhNwm5LNan95E
         KGil51GWfiZl8vHVIajj5QPGFH/D632STPHGU12u39WIdFD+P0HI+Ql/QCaMX52IfHpW
         +u1wLZu+cjmmp8OZoJj3ZVCpxRxIMCC7vxzmjUVqxVnBS2RChsmk1/ySmEtZ+ykRdcsi
         nJCuIxDB3HsHRY2YqWAX2sUI5VagVp7LfywKJSJWmdwf49zpadHNk0vhRgalgYg7O2ne
         oqc6Zz0A+ZoX9sPzccRWBKKdDw8pjqICsL0hFeYmE8PM3EfpTCrE6p1vt9uZmeJYKnmr
         bcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538827; x=1687130827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QsFRFDPv+w7LZXZOw0WA98ik9DN1mQO3qx3JO5B1H0=;
        b=hiR3Pw0/U6r0BOi22iFUZqrdYSegcx5onrLuuk8RNzrmF/hxva1KN7TYzprOwiaDAZ
         25G3VsBXhIqLBjWfWltCgfuj4Afdzmv3xv9EUUD91/JpOSKSgC8Mck7marsjTyJHeZEa
         IM5COlXpqlBAB9/tqggxaCjwepL7959zxmruEbkWr5tZv45FUSKkp2BIXDhpeKqKewBO
         I4MRRZFKekTpT2NBhvKYHYSWCcOHnbdJXZLTSC0dz6jB4GeNRrGSDXovL5JxjopqIWzO
         72pwXLscNlKiaX2g1b5LatiR216njLAlZ9SFX6cOHyoogA20afiQBhOB/PA+47AEanHZ
         kN7w==
X-Gm-Message-State: AC+VfDywCZZe2GL+B92iF9NAipDVj9QHeMv6M2Kh1BlFFc+HYsjUI5AC
        LJKjejYHaAXXTuM5EEH0lwcz4Q==
X-Google-Smtp-Source: ACHHUZ7VnkPD1ndqaR5abX1TbBBXiGwzOUrBy9MaQnF4clOVweenoPwAMoB73Q3jwaB6Er+KN7+O0g==
X-Received: by 2002:a05:6512:90d:b0:4f1:4898:d183 with SMTP id e13-20020a056512090d00b004f14898d183mr1203512lft.25.1684538826864;
        Fri, 19 May 2023 16:27:06 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004eb2ac90f36sm55315lfh.207.2023.05.19.16.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:27:06 -0700 (PDT)
Message-ID: <3cfacc54-6cc5-1a11-d7db-96409097f290@linaro.org>
Date:   Sat, 20 May 2023 01:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add
 reboot-mode node
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
 <20230519210903.117030-6-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519210903.117030-6-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 23:09, Matti Lehtimäki wrote:
> This enables userspace to signal the bootloader to go into the
> bootloader or recovery mode.
> 
> The magic values can be found in both the downstream kernel and the LK
> kernel (bootloader).
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  .../arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> index 91b860e24681..a05c41191efd 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -279,6 +279,16 @@ touchscreen@4a {
>  	};
>  };
>  
> +&imem {
> +	status = "okay";
Drop, undisable in dtsi

> +
> +	reboot-mode {
You can add a label like imem_reboot_mode and refer to just this
thing from the device dt. Though I'm fairly sure the modes should
be common.

Konrad
> +		mode-bootloader = <0x77665500>;
> +		mode-normal     = <0x77665501>;
> +		mode-recovery   = <0x77665502>;
> +	};
> +};
> +
>  &rpm_requests {
>  	regulators {
>  		compatible = "qcom,rpm-pm8226-regulators";
