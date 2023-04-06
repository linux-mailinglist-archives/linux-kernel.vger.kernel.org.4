Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57F6D982C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjDFN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjDFN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:28:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78493D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:28:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e9so25430428ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680787708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRMl5tP4avmZIwtGIOxBRcaMj9GFhkoxx5NiWKp1wTg=;
        b=g6SNlKh2ImuDKwjuN8GoC2n3bz6tqsdQbcUHAAycJ0wm1rj7eeO/5jb2XaH8m9WcW7
         6bMfMmvOupRJo4GP+U14a/xBQRn4fyJyuzeqvJjLQGSPDAhDkXZrQu4sexLYptwecu9r
         zlbiXtMSP/6tkyFGNbDnEGb+yVuTav8cZ4bMRragoC3wUuJwhRBtYy9C6ql7VE36717/
         uZr2BELPnSDIyvZZLSaapMdVNNTB10OO74rLdQvSk8QWuiTChSsxXfvOSX6oxRGW89mU
         UdGGxB673dTPP0M+JK9635akE79A/iHU2nzVBcEpnY0cSsJMyEx91nJQKLpLG/KplcSq
         d/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRMl5tP4avmZIwtGIOxBRcaMj9GFhkoxx5NiWKp1wTg=;
        b=cy0xKWUNrFRZS+0c6hcNCogW77dBVEHG2xY8o2oimZ+tvvNlIzOKs3K6/vBkh3qcB7
         z6aO7mQFm4N5yVZFIe9GShpV124jPlNc1kJ8FF6GWTGfbO+QI8WkUPVLItOSir4DPwlw
         bbSHyAGV6IjpmkRCMoO0f9V9NgIUkuzH6BVtP8g4ueO4lNBvROG0bv44TbfhRmAEXDDf
         laGeYZBq3Q67EdIoKwKpBphdBuR1lf8dQzK/QhcrySlLFRl/TFeAH+ZY2xGnFmCBu8+3
         FiVOZgOkGzFYH18KbQ4eQZu9c4Vjg7wj5DSuYo1UlKepzUe7VVxAUjB7GXiMdj+wSFG9
         KOHg==
X-Gm-Message-State: AAQBX9fHA/4X8cdSqCA8qe9sDvxvMi+mcG2uPDuSlvbkmCOYBnaUA446
        YLqya0OsMyOfSjHw45F8/SM47w==
X-Google-Smtp-Source: AKy350aq63xXfADHam0MwfZcQprABn7EPyGc2eWjG6O1DFFxRTSaaT7DFN5OH0kM+MVt8tQdJfntKA==
X-Received: by 2002:a2e:9c50:0:b0:29f:1e4f:a71d with SMTP id t16-20020a2e9c50000000b0029f1e4fa71dmr2967555ljj.44.1680787708197;
        Thu, 06 Apr 2023 06:28:28 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id f3-20020a2e6a03000000b0029c13f4d519sm285717ljc.119.2023.04.06.06.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:28:27 -0700 (PDT)
Message-ID: <63da0c87-5343-509e-4786-96a5b10eef33@linaro.org>
Date:   Thu, 6 Apr 2023 15:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/7] soundwire: qcom: use tabs for indentation in
 defines
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230403132503.62090-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 15:25, Krzysztof Kozlowski wrote:
> Use consistently only tabs to indent the value in defines.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index f2e1135ef113..77a5e4cbbe9b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -58,9 +58,9 @@
>  #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
>  #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(11)
>  #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(12)
> -#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
> -#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
> -#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
> +#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2		BIT(13)
> +#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2		BIT(14)
> +#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP		BIT(16)
>  #define SWRM_INTERRUPT_MAX					17
>  #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
>  #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
> @@ -125,20 +125,20 @@
>  #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
>  			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>  
> -#define MAX_FREQ_NUM		1
> -#define TIMEOUT_MS		100
> -#define QCOM_SWRM_MAX_RD_LEN	0x1
> -#define QCOM_SDW_MAX_PORTS	14
> -#define DEFAULT_CLK_FREQ	9600000
> -#define SWRM_MAX_DAIS		0xF
> -#define SWR_INVALID_PARAM 0xFF
> -#define SWR_HSTOP_MAX_VAL 0xF
> -#define SWR_HSTART_MIN_VAL 0x0
> -#define SWR_BROADCAST_CMD_ID    0x0F
> -#define SWR_MAX_CMD_ID	14
> -#define MAX_FIFO_RD_RETRY 3
> -#define SWR_OVERFLOW_RETRY_COUNT 30
> -#define SWRM_LINK_STATUS_RETRY_CNT 100
> +#define MAX_FREQ_NUM						1
> +#define TIMEOUT_MS						100
> +#define QCOM_SWRM_MAX_RD_LEN					0x1
> +#define QCOM_SDW_MAX_PORTS					14
> +#define DEFAULT_CLK_FREQ					9600000
> +#define SWRM_MAX_DAIS						0xF
> +#define SWR_INVALID_PARAM					0xFF
> +#define SWR_HSTOP_MAX_VAL					0xF
> +#define SWR_HSTART_MIN_VAL					0x0
> +#define SWR_BROADCAST_CMD_ID					0x0F
> +#define SWR_MAX_CMD_ID						14
> +#define MAX_FIFO_RD_RETRY					3
> +#define SWR_OVERFLOW_RETRY_COUNT				30
> +#define SWRM_LINK_STATUS_RETRY_CNT				100
>  
>  enum {
>  	MASTER_ID_WSA = 1,
