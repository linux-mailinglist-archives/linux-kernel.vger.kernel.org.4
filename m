Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6CF696018
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBNKAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjBNJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:59:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309F25970
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:59:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jg8so38700685ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsmYOJWW1U4pHQ0+owMv/ew7wFTIjLP6jViSPAyTH6g=;
        b=GLUVVoQRikCpoO1wHhaMGYqqeuGjCq1M7AMA2KtSV14UtWGDjqv8GQCn8oAjggD0+2
         eVw+Dp355E8IzCaqtcSRBqyp6zKY/Vp/nfekLh1HOyvxVjiA0ZHAgypZ+JEAatE636xC
         uZ0EBf0FNZx9WtCoNSgbbrihrrFXBQc6UOn0Oerimd9wGif9VreZQYpKf5N/Z+ix4j0H
         4oru7yiXtEyHVeHbPcBcaVOpmO39WJMj8FNB/SjVAq+m5MtoMl/Qd5dgZ280A4rOKWeH
         rGH5RnMAg/6bIxYLHRZXnKAlq+/5Ni8F8Rdqs9UKdCKxAoZaYLGvPXYicEaea1XUtVy2
         hIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsmYOJWW1U4pHQ0+owMv/ew7wFTIjLP6jViSPAyTH6g=;
        b=XYblnCvWoZeP8eI6EgDrEoVrFcBXpQ/rCwa3970P5VuPB47OXr2AN5RB3u/QZFKLws
         iWFjpbo8tUKg172YOUXfX3Y/KMpKPHBVyKWQ7BhKZIHUPc4Wn87z6lQ+cSgSfUOlDrRi
         9yzWD4/W8pCUqQbZi1TjbiyjRBBed+tP7AbLvw2VMKYHu1C6i5t7iBrz+8ZVl66Dw1pG
         ONImyCCYNXoWbhn/B6x8nH0QBuRItBFWtjJJASW3heoIjfdw1Us2n5RcfjhyshjsJ7WF
         HpgU9F5C7lRmKCP3sYiHJlE/0rVvjTJV+CYhYeQQifPmIoVnDiV1fBCpgs+GbuB/d6If
         pCYQ==
X-Gm-Message-State: AO0yUKVPPzNB6d2/pifJB9tCSlXQVV/7vIaj5tzI9mCIQXicP2+vqLL+
        VhsGPuVoh5tSfffpCx98q+p3Tg==
X-Google-Smtp-Source: AK7set+b+UztU6qyA/7wC0VSTWvcutSRg3k2oCv/PDS6P/3iqrUCryymBmU7ufot8V1HyAScUt+v/g==
X-Received: by 2002:a17:907:11c5:b0:8b1:3158:2bd3 with SMTP id va5-20020a17090711c500b008b131582bd3mr1251984ejb.32.1676368789689;
        Tue, 14 Feb 2023 01:59:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id lr21-20020a170906fb9500b008af0a1f9596sm7991052ejb.218.2023.02.14.01.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:59:48 -0800 (PST)
Message-ID: <d9ed9287-966d-d562-6982-3affe0285353@linaro.org>
Date:   Tue, 14 Feb 2023 11:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qru1000-idp: Enable mpss
Content-Language: en-GB
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213190122.178501-1-quic_molvera@quicinc.com>
 <20230213190122.178501-4-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213190122.178501-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 21:01, Melody Olvera wrote:
> Add MPSS firmware paths for the QRU1000 IDP platform.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qru1000-idp.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> index 2cc893ae4d10..dd0bccbbd49c 100644
> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -448,6 +448,12 @@ &qupv3_id_0 {
>   	status = "okay";
>   };
>   
> +&remoteproc_mpss {
> +	firmware-name = "modem.mdt",
> +			"modem_dtb.mdt";

Same comment as for the patch 2. Firmware names are wrong.

> +	status = "okay";
> +};
> +
>   &uart7 {
>   	status = "okay";
>   };

-- 
With best wishes
Dmitry

