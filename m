Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572772E163
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbjFMLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjFMLYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:24:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C419B7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:23:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f74d6695e4so1687835e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686655425; x=1689247425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeltQpI3+3qyooJ37HTTxHHHJtJEkGjqZq1LPAnv2Bo=;
        b=Dg9U/onYg507EvTF5/pyYKdVz+1kO9B1n1TRu7XpUCTtrSaUbcrDYiTdSKMDW163N0
         avtGELaAXjBkBDGJmv+lKjhevFtlOGhTLl8azhSWYMqlSewvSdR9C6BjowU0Uek4LAmV
         1yU3Q8qE2QPBcCXF1bEwRX1MzQOx9WrmXFaZnwQWCR/Fcmsi5jrLR/h4k26VgkbjoqgC
         eC5enB4rHFBWQYAFByRP3UDvpLAsoa2s/nGsVS2WC2ebyRuuwPMYbHko7wiwIHDcuZQT
         tyR/JMYJ6Mop4elnqX7PDJUX4riPLCPvguorTilposTbfw9ZUHVb/DhFEWEGJVmuZt3T
         hepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655425; x=1689247425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeltQpI3+3qyooJ37HTTxHHHJtJEkGjqZq1LPAnv2Bo=;
        b=fnlKZCS6rfAzK+5DfgpjoQKq5Kgtxv6Gu4bytOrN9fP8VDANmsunLjEPCaKQCXKHwR
         s3dG73tvAO65TOYEBBAIuQk5QbXEvFXP9abDxVJ/Ki56DFhA9sgWFxZWX7VmC4LsrLIb
         l1oQ9tXk77PdtYLYYH8SP2DOY9+Ssz8FtoD94ZNtNTqwqT/laYTMJNUKZPmD8xoPkWSJ
         sJfvDSK37Zn4k8+uTr1QJx2SM4wvVmoJQmkg6fCNV6+OQUG6NgT1NKiyF28/Wzs9rK1Z
         tcj6B0XW8B0TBrMF+RjdIfDpNzWgJdeusRiOswRrFP8o2yOyyYQbMRcPsVuvnPaG03tC
         yQ8Q==
X-Gm-Message-State: AC+VfDwUIXWKiyAAVCpJpMqjF269zAv05zegOwIVubDY2crzUhOFRHxB
        HsYFLcw5NaK2LrLQ6/Uv4ZP8oAr/3MFf5Y5hrR4=
X-Google-Smtp-Source: ACHHUZ5gkagN42flhlztem6UjZki38r4E8YJrxs7Hz322h8PEpMfk1SQAyKAw95WnCvqRmQc1WSu8w==
X-Received: by 2002:a19:5049:0:b0:4f6:2e38:83a9 with SMTP id z9-20020a195049000000b004f62e3883a9mr4163970lfj.29.1686655425001;
        Tue, 13 Jun 2023 04:23:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512014500b004f73eac0308sm1026530lfo.183.2023.06.13.04.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:23:44 -0700 (PDT)
Message-ID: <bc4f38b3-9511-5b07-25b0-747e968cbc0b@linaro.org>
Date:   Tue, 13 Jun 2023 13:23:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 5/8] qcom: pmic_glink: enable altmode for SM8550
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-5-22c9973012b6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-5-22c9973012b6@linaro.org>
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



On 13.06.2023 09:55, Neil Armstrong wrote:
> Altmode is also supported for SM8550, allow it.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/pmic_glink.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index c87056769ebd..8af06bdc6f5a 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
>  							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
>  							   BIT(PMIC_GLINK_CLIENT_UCSI);
>  
> -/* Do not handle altmode for now on those platforms */
> -static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> -							   BIT(PMIC_GLINK_CLIENT_UCSI);
> -
>  static const struct of_device_id pmic_glink_of_match[] = {
>  	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> -	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
>  	{ .compatible = "qcom,pmic-glink" },
>  	{}
>  };
> 
