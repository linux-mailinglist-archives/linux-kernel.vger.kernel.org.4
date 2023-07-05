Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7C748624
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjGEOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGEOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:23:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802B1732
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:21:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so9700177e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688566890; x=1691158890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1lxUyn9OeMxYyMrh1OEm/wSr8uEeCcDCyt09KXL8Ds=;
        b=IOzYGMDGc7kSbNMLtthH5+u+QPR+ojlXRXAGDJlbkCtONgNWS2s6W/QniIe7n/Dhbn
         Il9o1On7sijd4EjbPA2VvJZjVt3YVJA58p7tog3HwB2gAuIpNdUBBhUWYLq7RfxPoEQZ
         RVDXel8tcBIxw2aiMk1s1nsJ2dDLx9OXFLPXAVJVgXeGTo2aiLRfJvpGxSMKdLP6Rvds
         i1dSKAIECsBwCa2m7A6OVBLnopDLpsgBT3msUqsISs75U55o1loP2EQwkLJMUIqDGjWF
         XxHkmUACOVVzF5CO+b6Oipa2bhD3enf+82nGf9pPxUYCMNaWEqj3icvdS34CtTthC5iM
         1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566890; x=1691158890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1lxUyn9OeMxYyMrh1OEm/wSr8uEeCcDCyt09KXL8Ds=;
        b=LOff0eY/gcy/ZKe2W5Of+6a/bPdoHnGDW3DoYdOmXna8jxEBPWoMvd0YkbUbIMB/16
         MJxrLcTLqSRfxX0DZe5m4FDLkxpZHPiC06mRDu9in/0s5jyYYSAZQvkONVL3Fn/BRXlZ
         B3cf7oMCT+qnhVR/GaC/k75tRxsHv5co1dAF3XmCqo3guxvsQLDUg/T1YUeIfLQvBG0b
         uZD46ew1G8gu9EaClvTvUAhcVbW2i3o+E1+X3gl2Whdc2I+w0E7ibZ2sUIasRE4cq70x
         0yeRHYFzxuBi0W0Bo9QF/sS2SPqu3LK7L9Yh3LwsywErUP8X4N7KasFvN1Yz6u1sTWfz
         ly6Q==
X-Gm-Message-State: ABy/qLYhNhNLGTrLAJG4j/V4MBlRANMIE/TOWcC08ESvzifG7bIqnwL0
        goI7kW9uMFz/cumVx40hK1Rm0Q==
X-Google-Smtp-Source: APBJJlFwM7hrd9aBAnZ9PPNWHOVOX3Pla6S/uVAF4JZT6y+NwWPmWyPHJjWLuK+ijjCc3OwuDiXlwQ==
X-Received: by 2002:a05:6512:1196:b0:4f8:5e3c:f3a7 with SMTP id g22-20020a056512119600b004f85e3cf3a7mr14595057lfr.43.1688566890026;
        Wed, 05 Jul 2023 07:21:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7cb47000000b0051e0ea53eaasm4371298edt.97.2023.07.05.07.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 07:21:29 -0700 (PDT)
Message-ID: <8bd8ffbe-f50d-6e4a-2fdf-3983a76fb5ad@linaro.org>
Date:   Wed, 5 Jul 2023 16:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved
 memory region
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705110620.7687-1-quic_kbajaj@quicinc.com>
 <20230705110620.7687-2-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705110620.7687-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 13:06, Komal Bajaj wrote:
> Add missing reserved regions as described in QDU1000 memory map.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 1d22f87fd238..47e5e31dde23 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -448,6 +448,28 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> +&reserved_memory{
> +	ecc_meta_data_mem: memory@e0000000{

Missing spaces before '{'. I was correcting this already:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66b14154e278807811d67de9fb0d5cc76638d07b
so it seems I need to keep doing the same.

Anyway, the names should follow purpose, not "memory". See link from Konrad.


Best regards,
Krzysztof

