Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F026F6921DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjBJPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBJPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:19:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190F37404F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so16776580ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMOuSrFwNSQJToHyKbXZ5i5g/s5Gsc1rzby/p9WcP1U=;
        b=KnWqk0u1nE2SN7HnvxefE8FjJKe2I12SdPUp2NYouv2yTJDhli06JVLt8/kzYR10d7
         S085Jq0KlYAkm+Ttp+xtuIUKHKWkYiEDW3yvs3Pfuk6P3IVdW1CHj0QYGFqwtdVA/qgd
         fck05sqdeFRnjl+IeDOp9xYCJM08DH5d6FgPKJUyyIe8TXeJ+vz8lGGIf6tjdvE0kCEw
         9+WyxdRaHQtMssmgATegD7hLSDTdCmWEUETC3reoR3ZrFw6J35dp0z2Zo0HrY5hFLJe4
         5zBiW59D36ci7uP1YMuh/RK1ezUDnsoxsbJQka6aVIjqBRSlbDHyA6QVnblU+uYjRNqc
         3iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMOuSrFwNSQJToHyKbXZ5i5g/s5Gsc1rzby/p9WcP1U=;
        b=PM4U7aRZljJBJycAaXE2W2IabFuINmnuAqapOUSdW+MvGEAiNuWlHEQ8ijrN1locSf
         Orhq6LIabakiWMWFKmB4vIZZZ60iUSraDtNPA5fA75Yn1KsPWWxFpsz0BDWa+xyOsrgu
         Ei9qkugho55ZffsC6mae9VEBhFXzAGTmhL8Dq78WmuANA08Cwm5MZ+aQbHCtD/9cISBD
         kcZf8aCxGu4CY0TeeTERY9jTx9jcGGAiSuEA2lZVxRn9HMAXFMg9SPlimADclYv++uYX
         yyEdXh5dmhNuWaJkYqhP3TIjQA4UKvdb3Lm/WhEEeMn5545Zw7EIfpEERclIqPYEdzOR
         yBhQ==
X-Gm-Message-State: AO0yUKVHuapw0Pv1nS3ElbnIdylZx9lcvloi7/nQJlgFI9tPkwjMIf3h
        1Q+DeRxrYidgSX7oDtXV7qeScQ==
X-Google-Smtp-Source: AK7set+rjlQgPokRWh3kjiNIpg6kLzEU9l19ISqEBfDaxKgt2SmuxPZRxDT7zisDwbi5/EpuDsO7iQ==
X-Received: by 2002:a17:907:a45:b0:8af:1a8c:f13f with SMTP id be5-20020a1709070a4500b008af1a8cf13fmr12172031ejc.71.1676042350721;
        Fri, 10 Feb 2023 07:19:10 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id ch9-20020a170906c2c900b0088dc98e4510sm2504428ejb.112.2023.02.10.07.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:19:10 -0800 (PST)
Message-ID: <68078baa-5fca-9a28-604f-81313ba286cf@linaro.org>
Date:   Fri, 10 Feb 2023 16:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 05/11] arm64: dts: qcom: sm8350: add port subnodes in
 dwc3 node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-5-71fea256474f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-5-71fea256474f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 16:02, Neil Armstrong wrote:
> Add ports subnodes in dwc3 node to avoid repeating the
> same description in each board DT.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 0a422637b61f..3f4631e06187 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2727,6 +2727,25 @@ usb_1_dwc3: usb@a600000 {
>  				snps,dis_enblslpm_quirk;
>  				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						usb_1_dwc3_hs: endpoint {
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						usb_1_dwc3_ss: endpoint {
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> 
