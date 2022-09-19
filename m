Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539EA5BCAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiISLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiISLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:33:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AD27FD5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:33:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go34so63733581ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kv5HblhyqvxLlUTriLxQrCRWfzV2ODxb4GZUjr/Vhec=;
        b=Z/81XP7ouZBwBOCWxRHJmK/QsKc1OGDHqctjdQ8D1I09CuqBIVF2RFhub4IjYcpU1N
         ZxkEiuB6flN5ZU5GqAZkgBzrdsnlhvESstZ3P9grkeJLyX591FIuLU6x0Sy2vRnhmGmD
         Sd+EPUT6EsDOjILhvgeWLUptCnr4t3i5SPuOFoVFd/1B7EjKc0R3/aCnc9wsMXGz1SZZ
         WgNHCpZ0OFQVRpj348NLMCoMmb2bHhzzNtzexHSdkz13mIHV+px8x0Qbje8LGDfhroaJ
         j7X+Z1vjQRe8TbaNTsawTzU8gVxj2B8VU5h1EHHR/fycx4eY1/s6FFzoPBCEZstrH4sT
         E1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kv5HblhyqvxLlUTriLxQrCRWfzV2ODxb4GZUjr/Vhec=;
        b=MTNOc2MFo5+5kbcmhvJYjnulP3CRNb1+kUpOshQ2llECIoucJjZEPYxuzcaf9Sg12e
         xI1be4rVVk1ZirjkzuAuVeeArpHUC4MtjEK86EumNvvK2N78LB3jwrvW9heApxsixA/3
         52KMv62p+VfvK81qvKoGiRvT8166tFDvaN4uz3KLgDYYLP8UlHBEoUj1K7mwngLihbyG
         fXP9AHMiDcwL/mD55Xyak3KwOVYr4ENfE2gxWrPWeoPWQEKMmNdS1Y8BQLkirh7Qe4el
         szMEWDm6gFpjoVvN1Ed64e3u8B1mTdDzkk/YXLx2LPW5I/utNRDVB219A+rWEksI2cwy
         Hp+w==
X-Gm-Message-State: ACrzQf21MQpkDl+ZXjyAj1RGgv/6v/BVlSjJE8LCSAuhPMJe/LiLFysu
        g7FZxa2J2+roMecrDalmBmiqSw==
X-Google-Smtp-Source: AMsMyM5TFPeAP//vtWxrgSHH8LQlUNnTgbgLmwZax5KgiWFRLnOgWrQqCVHxDmoOyaKeCX3wbHRe1g==
X-Received: by 2002:a17:907:7629:b0:776:a147:8524 with SMTP id jy9-20020a170907762900b00776a1478524mr12512473ejc.632.1663587224505;
        Mon, 19 Sep 2022 04:33:44 -0700 (PDT)
Received: from [192.168.174.234] (92.40.199.52.threembb.co.uk. [92.40.199.52])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0078194737761sm87419ejf.124.2022.09.19.04.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:33:44 -0700 (PDT)
Message-ID: <b7dac69f-88b9-f3d2-45c1-659115de3552@linaro.org>
Date:   Mon, 19 Sep 2022 12:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/2] mfd: qcom-spmi-pmic: convert hex numbers lowercase
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220915113523.44074-1-luca.weiss@fairphone.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220915113523.44074-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2022 12:35, Luca Weiss wrote:
> There are some IDs that are written in uppercase. For consistency
> convert them to lowercase.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind Regards,
Caleb
> ---
> Changes since v2:
> * Split out to separate patch
> 
>   include/soc/qcom/qcom-spmi-pmic.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
> index 72398ff44719..fde0148d0077 100644
> --- a/include/soc/qcom/qcom-spmi-pmic.h
> +++ b/include/soc/qcom/qcom-spmi-pmic.h
> @@ -29,9 +29,9 @@
>   #define PM8998_SUBTYPE		0x14
>   #define PMI8998_SUBTYPE		0x15
>   #define PM8005_SUBTYPE		0x18
> -#define PM660L_SUBTYPE		0x1A
> -#define PM660_SUBTYPE		0x1B
> -#define PM8150_SUBTYPE		0x1E
> +#define PM660L_SUBTYPE		0x1a
> +#define PM660_SUBTYPE		0x1b
> +#define PM8150_SUBTYPE		0x1e
>   #define PM8150L_SUBTYPE		0x1f
>   #define PM8150B_SUBTYPE		0x20
>   #define PMK8002_SUBTYPE		0x21
