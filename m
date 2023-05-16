Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7B704286
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjEPAz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbjEPAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:55:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD09D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:55:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so126388391fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684198521; x=1686790521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjwcRaJlCzCEpC45Q3lrZNiqWX2wV3fmSeCUq6aK9MU=;
        b=Eo1bPVLTcSa18AkqgwZmOmq7tjqPDPdxiE83ZBG2GU5u4NrU+XEFduTdSrbNsH6hwy
         eoZ4ytNQkjRYgnuUmKW0+TZjZoNyijblWZeGkNtjDU7iEVc73XnEcGWPWk+arKMwq6qc
         Z/PHZs+u+WPRT8c4bhMa2rkxxi4iU0vGKui6bRRvdSd6CGouscdYDnEcB7v/F+4SjNah
         OvzY/ou8HuF6vb9UBKcY0IgbQ5M/9vptGHCcMPsZA3KgAybfnR+5OHcgCjTeYQWwmZmo
         R1vRoBdhj48woi56J9AFy/VinBxAZVvMD9tzHejyUvWC5IpgwEjHe7A9Fd85EEM+7ubC
         kiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684198521; x=1686790521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjwcRaJlCzCEpC45Q3lrZNiqWX2wV3fmSeCUq6aK9MU=;
        b=FRn92sB6XrEv5NFAztUr9nUxLM4c7fGp0UnY8H8IFkPuHvs9pxI7yyPS3pUVtjb/Ri
         Lv0kylD4tdfI9Ohtj3fVURVH83P1frdv6EeSO0yXBfrJYe8/mjNgGATs1bgtwk+SyMTm
         eIxL20SCBxzTaqk3VCJX9x47qtX2CMzX+ncwKtHTNsdr/G8iUvVg7NDXQ4UtLBe6UzTm
         YInlrtMF66Rqh/b72b5XFZOMpq6mDGHSCkQElUIEuLE0xDWNoBSExQWcX7ska9HNZ6mW
         aFE0edGie51D5/Ui2pCBtWzXp/enlRglNlFnWrOApJsTScKAyK2rXWcRIlFCoOfejVhV
         xVFg==
X-Gm-Message-State: AC+VfDzfNHWGrl0yb2KWQA67ENrD6HDhJ6sRLfdY5u2nKJL9rC/dEI1h
        wnC0Re+Qh2jj709z9Dp7U0hWcg==
X-Google-Smtp-Source: ACHHUZ4uObSf76PIKmze2hfEFu3fRFKJ1GwNFdHpG6uo+NrROdw/IsCoRGcd500n4VePoEgEmwJDRg==
X-Received: by 2002:a2e:98c3:0:b0:2ac:6038:ece5 with SMTP id s3-20020a2e98c3000000b002ac6038ece5mr7751117ljj.49.1684198521047;
        Mon, 15 May 2023 17:55:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q22-20020ac24a76000000b004f2509b87cesm2777036lfp.107.2023.05.15.17.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:55:20 -0700 (PDT)
Message-ID: <e6890e88-8c1d-18ca-50b3-b9b077e7eec9@linaro.org>
Date:   Tue, 16 May 2023 02:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq5332: rename mi01.2 dts to
 rdp441
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230412164920.21862-1-quic_kathirav@quicinc.com>
 <20230412164920.21862-2-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230412164920.21862-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 18:49, Kathiravan T wrote:
> To align with ipq5332-rdp468.dts, lets rename the mi01.2 dts as well to
> ipq5332-rdp441.dts.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
If the name property is supposed to stay as-is:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/Makefile                               | 2 +-
>  .../boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts}    | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} (100%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index e0e2def48470..42736c46203c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -3,7 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> similarity index 100%
> rename from arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> rename to arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
