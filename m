Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03395BF76E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIUHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiIUHPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:15:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F07AC3F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:15:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t7so8259297wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+2gYSefCpFz7zvMbQh2X85Wn00eX/c1TWwJPLjqJoy0=;
        b=gwU08wStlOFrKlZQfEJeakYCknAHImXsSTWe7Xisb2aQLxIlPLQL7oUI7KoI3P3cxY
         BW+JorASkKbERot1olyykBjavzrFfltPOP2gHOnjl1s8VWs5Fq/YDq9XBl6zefWJ88k6
         poz4W6s6co1xPZ6ffOBg6lOiwDQkXbKFb+zxolNcM3nEfYf1rUjQ6MqlxQ+XM0u9Q+IV
         rjzDTJAJI29dzOg5zyDYpom/trWz7VkLyG0IDx2AZWY6EszkRXP/QHGeJJWuHhg+aqtO
         uXC8Gek5ND6xi/ZP5+pr8qTVZUCshi+c0OBGLimXnZa/fZ3THFFFYD3XLgSVDQxdDpl5
         NZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+2gYSefCpFz7zvMbQh2X85Wn00eX/c1TWwJPLjqJoy0=;
        b=ctXXXMI6VtTJavv7PLEcZql2gW1S6+pW5UZsnFcaswXXzzTtjhXQR3R40hXN4bnEzy
         WYaOHR+ZJXiZn7snNl5h8ORaEVu6quxYmi9/3VhAsFDFHahO9Dtpf2txwNR7bRz2jmcm
         iBH/VB8UHMnF3PEYGBLj5uqTuyNH7h7h/47Cdz//t8eU1NXDKYwr0cHfKjAhRDU4tFu3
         ZZVCZzIpRtvTPnBwZR+2lXiYGatAt2iOD6axj1ERHqsVM9mwx/H5RjiMu7MwR8BtDoCs
         DxWzVfmGPHL6U34DoLO2MY7gQ6EBe1BRjT03waCN6ilAbQIKP+3Y9Ra0OCfBRNG+HtuI
         BIpA==
X-Gm-Message-State: ACrzQf2TNklm3GSoCxWXOpK0qMQPinS0VCUMVfR4w3YA4XcSj+GdKzvB
        NsXIfxwqUOLoZBkmFOeyIRmVmA==
X-Google-Smtp-Source: AMsMyM4l+dv6ILSnOFRB+lqQJkUCQ4UqYtSAyTOTRWjncL+oQlrSqcK9Y5ONbXxQYPLx2Xhs+QnrCA==
X-Received: by 2002:a05:6000:18a1:b0:22a:f4c2:c9d3 with SMTP id b1-20020a05600018a100b0022af4c2c9d3mr11112021wri.92.1663744540929;
        Wed, 21 Sep 2022 00:15:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ce3:ff4e:ae9b:55f3? ([2a01:e0a:982:cbb0:8ce3:ff4e:ae9b:55f3])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4b84000000b00228a6ce17b4sm1747887wrt.37.2022.09.21.00.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:15:40 -0700 (PDT)
Message-ID: <fcf8368c-7423-a350-c637-86b9adecaca1@linaro.org>
Date:   Wed, 21 Sep 2022 09:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] soc: qcom: smd-rpm: Add SM6375 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220921004534.151990-1-konrad.dybcio@somainline.org>
 <20220921004534.151990-2-konrad.dybcio@somainline.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220921004534.151990-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 02:45, Konrad Dybcio wrote:
> Add a compatible for the SM6375 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - changed the compatible to match the style used in the file
> 
>   drivers/soc/qcom/smd-rpm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 413f9f4ae9cd..15671a917fb9 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -246,6 +246,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
>   	{ .compatible = "qcom,rpm-sdm660" },
>   	{ .compatible = "qcom,rpm-sm6115" },
>   	{ .compatible = "qcom,rpm-sm6125" },
> +	{ .compatible = "qcom,rpm-sm6375" },
>   	{ .compatible = "qcom,rpm-qcm2290" },
>   	{ .compatible = "qcom,rpm-qcs404" },
>   	{}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
