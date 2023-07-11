Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD974ED00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGKLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGKLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:40:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DA136
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:40:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso91321341fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689075645; x=1691667645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOb4V8162vKUOvo7wKDsANAZxGIZvl55fC9syM8H/ag=;
        b=ij3igYc4u8/1LaFt+NKVgVhxQkkTIHZZqTP3rQ3Crpr+zZIepL4Z+dAe1XExh8KT3c
         o4EsGOKVnfEi6yzCo84S/4a2w3S/1fBs1fJH27rASDePKeeB6QrtlaNvDbWbjSlz+Az+
         AURVSe/NcvqfiHs8Z++Xg4de8AOLcZ6rhhDEIwg5R4cGOEVTp7CFET84qhZuBz3/e3ac
         Fs/PigXIbQgk5jGNFvuJ2RqHw3VbyjHj7sb+0egzE/wjvYRLuOl3WFBrctSXKhH2+F+f
         TIE3bbO1v4Q3vjaV5n6yq+HRYqljEPy9d+i8e4LTxFOtS5iDrREt3LBh5zXzf1sVxFXr
         veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075645; x=1691667645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOb4V8162vKUOvo7wKDsANAZxGIZvl55fC9syM8H/ag=;
        b=KkP32qzjCqLN/pVWy0EW6FID7naJVAUohmdyOwRIf5IfE9xTUClBaB7fQT1XQi+kIl
         u5V3IOBVDhk3heSIJ9S7Ew+T23aVnA1T4tJ/A/LAM74OOX9dw7zN/N+kkLzVVPhpCPlt
         JghnilU2PJJP2AL/rWxA3gi55qCvJj8oHBhNEVUNAunLTGb9HVQMpDxTUOZFtcgXhVnF
         RIMTxPosNIkv2yCpz4MIO2iMuERK+lF1WFLF94Qgb4nMBpiXF+YdDwAoZE2/obTk7zhl
         s3Pne9ySX7VlChntu5uS/99X1hocxZvgbjI5o8W7JeJzFlK5dVk5548HtTQ8LghvdzcY
         B9Zw==
X-Gm-Message-State: ABy/qLYACqXO0kImJs5r6I0Ys8Lenvihk3iizAP8OTEWzTZ+RP7raDgk
        EYmxawGyYzTE42NpfKlJOycltQ==
X-Google-Smtp-Source: APBJJlHFKdkSAuljFfDBnBKOJY5dlqtGUlVam2d2ELh6oh3HkBBJLd8AOi5Fe8dARpQuArAcxgwZxg==
X-Received: by 2002:a2e:948a:0:b0:2b7:842:a64c with SMTP id c10-20020a2e948a000000b002b70842a64cmr11281027ljh.5.1689075644994;
        Tue, 11 Jul 2023 04:40:44 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e8017000000b002b6daf32c7csm416587ljg.97.2023.07.11.04.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:40:44 -0700 (PDT)
Message-ID: <6a398153-8ff4-3cb7-868c-44fd04a7ef90@linaro.org>
Date:   Tue, 11 Jul 2023 13:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
Content-Language: en-US
To:     Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>,
        quic_nitirawa@quicinc.com, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711105915.30581-1-quic_narepall@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230711105915.30581-1-quic_narepall@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 12:59, Naveen Kumar Goud Arepalli wrote:
> L4c is the supply for UFS vccq, As per UFS spec range of vccq is
> 1.14V to 1.26V, There are stability issues when operating at
> marginal voltage. Hence configure the min and max vccq voltages
> to 1.2V.
> 
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> ---
Couple of things I'd like you to fix in the future:

1. you sent a v2 minutes after v1, with no changelog or reference

(ideally you should include something like:

Changes since v1:
- foo
- bar
- baz

Link to v1: ...)

You can use the b4 tool [1] which makes this really easy for everyone!

2. You overtook the series from your colleague. It's okay, but:

- you should have mentioned this (see point 1)
- it's fine for your colleagues to send your patches, so long as all
  of the co-authors AND the person sending add their Signed-off-by tags

Also, check out [2].

Aside from that, this patch looks sane to me.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>


[1] https://b4.docs.kernel.org/en/latest/index.html
[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Konrad

>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index ab767cfa51ff..26f5a4e0ffed 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -153,8 +153,8 @@
>  
>  		vreg_l4c: ldo4 {
>  			regulator-name = "vreg_l4c";
> -			regulator-min-microvolt = <1100000>;
> -			regulator-max-microvolt = <1300000>;
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			/*
>  			 * FIXME: This should have regulator-allow-set-load but
