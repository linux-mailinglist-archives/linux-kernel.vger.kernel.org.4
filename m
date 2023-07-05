Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11946748263
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGEKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGEKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:43:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8F10C3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:43:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso37891191fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688553835; x=1691145835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XpFANK8O72T/687G0Eqx6Y2H2qKfCo8puKRdfbJYT4=;
        b=M6tyrQb9/1yH433wswL5+Wcv+PkOIgmBJmSxEJATpZNMaqUdtghE/++2Hd1wm4BqTf
         Cz1oDSvba6oMd+bjRC9IAAKcIuyQd4wuaCq/vF/yqg+1TsFfeMTW/Wlcv2VzlSvvg6hH
         tQ3fzOAAVUjtJ+WgKYHyPsi8pFBYFlH0Sf2eX+nXb0eQkAK0n96L0QQgOgF8lNLHT0nT
         gvx59QCEB7fC/6TXbPObUqkbLEkJUemKQGbhcvj8rZGgl/KulYdME7dMsIh7Ot1kvPhp
         l8Xoq9jOiDIIKaDzvRUWlLhENny1TpuGPD5gP4Wvh1GKa3FD5/gzoq5il7jv3fWpQZth
         zvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553835; x=1691145835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XpFANK8O72T/687G0Eqx6Y2H2qKfCo8puKRdfbJYT4=;
        b=Ln7h6kBcH+V7FbKfbD/OFSQa9rNO4XWd07C/dBDnOAzXsJO4p5CeAdQ9qFS+pkX9ty
         gDQRmF0Q6bJFB1CVcefOWYZ8KXJwd0OXgVo99iE7belvLhrApts9B2FNgxe3ft7FdIAO
         UgJF/abipp7ZnuobJajNVqOvTSz8WhIgz45ZdYh9/phwkggVQxhUJn9/GScsjmBllR1w
         jYoUACmO5MY1U47r0/uLpPHrE246VOTPQBY+sAJP+TJ+YDpiCry1dFvt1bzgTWKFBip7
         TXU7pfiCezOOEOWWQIC9ix91aea9aoMoA8WoL8pfbCBgbfwroAjLKYzKiBVoJQGpn/pW
         S5dQ==
X-Gm-Message-State: ABy/qLZeXBmmoNCqgFblwVjH1u2GRMq/PxPrp2PQet+yEvm2GXhRXAzz
        ol3zMHNf+JX157DDthrZCMvH4A==
X-Google-Smtp-Source: APBJJlEu6L+t9Pj240lSYBR6iXI3bFNIkgZCZDi7trbka3TzczQYjTRE43T+NGoBk24IM7SuF6nmSQ==
X-Received: by 2002:a2e:9dd0:0:b0:2b6:fc95:efbd with SMTP id x16-20020a2e9dd0000000b002b6fc95efbdmr1974698ljj.31.1688553835634;
        Wed, 05 Jul 2023 03:43:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e9d15000000b002b6fe751b6esm274081lji.124.2023.07.05.03.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:43:55 -0700 (PDT)
Message-ID: <237b76cb-91c9-60bf-a2f0-1a6ad40260b0@linaro.org>
Date:   Wed, 5 Jul 2023 12:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qru1000-idp: Add reserved gpio
 list
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705091730.32087-1-quic_kbajaj@quicinc.com>
 <20230705091730.32087-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230705091730.32087-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.07.2023 11:17, Komal Bajaj wrote:
> Add reserve gpios for QRU1000 IDP platform. These gpios are
> needed for modem subsystem.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> index 2cc893ae4d10..80dadd2f30a3 100644
> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -448,6 +448,10 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> +&tlmm {
> +	gpio-reserved-ranges = <28 2>;
> +};
> +
>  &uart7 {
>  	status = "okay";
>  };
> --
> 2.40.1
> 
