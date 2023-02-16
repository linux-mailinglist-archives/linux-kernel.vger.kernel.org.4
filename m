Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863B169921A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBPKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:47:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAE83DF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:46:56 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c20so2238294lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwBpAqMFpFr4je9eCvVMSDtRlxM1xwSCZYICMzxMvIg=;
        b=yyl94jbkA/n+iLA6tvBVKkEaoRUKL3iIwO0qH4nhh/hwyqyB8dtxe22GoU8vDmCyWO
         yXF1YFEa+O3zPUSpBsH+/+iw0QN58tRuGdKc3HVtzrKWKPUKFVU6QiE3wOwUp29dklp0
         0Rs/2G40XC8P3tiZst7TmiWwy+zIHRqjINF1LvACaXxyk9jeNJzs59+EQPNb4fh3s2II
         y/Y+MZjU7tDnC/11w5fWw0ECeVAHt1gBRI4gkyIgYC8cLDLpD8f812REXBe1pi7NlYYA
         fEHLy3sd5jgT+GbwSWAUaIEkAXI8im1HiFO4Q/CX0ryh5fwB3lPmPXHf/AM+e0HI1TsO
         IynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwBpAqMFpFr4je9eCvVMSDtRlxM1xwSCZYICMzxMvIg=;
        b=nVQZwVEH+AVi3RtjG7saDt4gT6D17Ab+j4g4BTbdHAqjFGj5yjE6L5se3jKGTyGYRj
         7ZvV2Q6bj50Y51T8Oj50OYVOJnPBqPMOaiV+2Nmym/g79O+zXodE807KDWuL2qBHkkN0
         tobontWuBXZUSKOeMJ/a8c+XPB9NDmfzyUEzMmANHSbxYIhZDWlex82BVMvPtbqnEPAo
         ASpwDW3cnGjZrcgwGpqn6eEEvFKZUFLk22QGCxC2VnhS57PZ/fKCBGw32IM87kwn1UOm
         +zNXlPUuqupx+PnQnQbXNfrOIwv0W8UbQ67eQpKKQghWVGnbZ9lzmKrNa4A980F2VxF2
         TRUw==
X-Gm-Message-State: AO0yUKUnr8OPBgaxYReX/RETBZZnzhXTVcBA+92UygF8+N3jIg4BlhbN
        rCecUSK9zHXW0J59tF/6nmwCHx1oOzuxT0Nr
X-Google-Smtp-Source: AK7set92+49/NTBUM3QPtQPvbgIyz52LEGJVNJWCBHL1j0qmJWItafGhFS4IIKRiTqFaUPRfBrp1hg==
X-Received: by 2002:a19:7506:0:b0:4b4:89a9:6bfd with SMTP id y6-20020a197506000000b004b489a96bfdmr1403805lfe.7.1676544413350;
        Thu, 16 Feb 2023 02:46:53 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512006a00b004dc4af9b351sm245745lfo.153.2023.02.16.02.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:46:53 -0800 (PST)
Message-ID: <8df56794-090f-dd34-eecf-e0debabdb7f1@linaro.org>
Date:   Thu, 16 Feb 2023 11:46:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/4] ARM: dts: qcom: ipq4018-ap120c-ac: align SPI-NAND
 with DT schema
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214161211.306462-1-robert.marko@sartura.hr>
 <20230214161211.306462-3-robert.marko@sartura.hr>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214161211.306462-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.02.2023 17:12, Robert Marko wrote:
> SPI-NAND node name should be flash@1 and not nand@1 according to schema.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> index cd2a32d0d5548..bb0c888b048ec 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> @@ -186,7 +186,7 @@ partition@190000 {
>  		};
>  	};
>  
> -	nand@1 {
> +	flash@1 {
>  		compatible = "spi-nand";
>  		reg = <1>;
>  		spi-max-frequency = <40000000>;
