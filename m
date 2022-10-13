Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0305FD511
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJMGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJMGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:44:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36213B8F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:44:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e18so554308wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W+rxczmXg10fKsWz9dlAbQXlHy5Vc2mFKgDnkxn2Kck=;
        b=SKEeuhM78a0OTPcXM1o78rSfUJGACYxjpcLwEC8WGbfwciUEy3s3NpS7lyg9hOJ3fQ
         HsQyb6Vf8JF0H5rVbMcUn6Wfo2wtzmOZzx6q29+lVjpi8q7wEq1b7cSPmf2wdhGl2tUa
         0KZNQ7WZ1qTufbsItfFT9WzFCG03971F/zkp7FFPg4SOvDA718Pq1sjIOHnVzRXVLpzf
         inpmOJgckbIlEOboV1dAnGW5sx2oyWN/ttysxHI8+GFz7SBW9CEFzu9nCXgIpN5aUXip
         IjkEbB9T5nJN8IMJwpxcVchHyptScSCjZwDs1teDNhLMY1fqUyx9S1nc+R1xQExeDvdi
         ANBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+rxczmXg10fKsWz9dlAbQXlHy5Vc2mFKgDnkxn2Kck=;
        b=gyOJE28FP1sLGqIKFFGOMusZYVJg+BlG0yOeAJi0+pwM+e7UGxWDhBzj4Sd5bx1yIG
         Lx354QsMEIgP4jkb72UP6k4pV6StWPv4ybMkdI5NGILOgOrU/3dq74zuwt0V+2gQvP75
         fuYhQQHF7UvcQjwG9KU5pmrOgdmdQ4al3/oQCJSsmhUNnZCi2CmfF1Utm8JUwAcaPgYr
         FIqFkqxBjGh8+MwkXK/8LGjEf9W68C9Xw68skQj1CJSvMddHZHuLCzgiwGMeWhZHGCk0
         ckawxW1TRQ+YcnBvGs1I2EvXXtKT+S7eMNE44zUsDIYLd9jJTERmYy4oCp1R+mTQ8cZU
         HvFQ==
X-Gm-Message-State: ACrzQf112krdc2LokahHxfYRAbgzO4JSQwqoW+88DKwJBcehnZcCuijN
        taIUcNkEDMbbccmoqWE71o2KjQ==
X-Google-Smtp-Source: AMsMyM4kKAuve7NBLdS5HA+CyqgC97iUdTL6TelQNzkXQJQZLZ0MDtf/258wuob2uZ0auRgfBqHY2g==
X-Received: by 2002:a7b:ca4f:0:b0:3c6:ce01:bc4a with SMTP id m15-20020a7bca4f000000b003c6ce01bc4amr5400917wml.42.1665643447879;
        Wed, 12 Oct 2022 23:44:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cb49:9049:c0a5:d695? ([2a01:e0a:982:cbb0:cb49:9049:c0a5:d695])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c1d0600b003a5f3f5883dsm3856029wms.17.2022.10.12.23.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:44:06 -0700 (PDT)
Message-ID: <48069056-62f0-f7c1-c8d1-ae072058b5d1@linaro.org>
Date:   Thu, 13 Oct 2022 08:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL
 support
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20221013042749.104668-1-sireeshkodali1@gmail.com>
 <20221013042749.104668-2-sireeshkodali1@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
Reply-To: neil.armstrong@linaro.org
In-Reply-To: <20221013042749.104668-2-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 06:27, Sireesh Kodali wrote:
> Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> platform. The same configuration is used on all SoCs based on the
> MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd0941e552..eff8d34d7f4b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -948,6 +948,7 @@ static const struct adsp_data sm8450_mpss_resource = {
>   
>   static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
> +	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
>   	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
>   	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
>   	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
