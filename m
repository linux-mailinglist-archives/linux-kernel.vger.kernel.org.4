Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2E7199C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjFAKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjFAKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:30:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D010DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:29:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so713218e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685615386; x=1688207386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp5xxOt20GHMe9x9oOlssfGvZFl/WMiJaJ496BlN+YU=;
        b=kP/zj0HAKnPgUuu7Tgrr++eMwujhAUwYvyrnwCZ/9sgnT+z3G/B9L7afSaX3QAuF8P
         OTVqXxoPZuNQoH3tVYg3GcEoXykvO+m9pSIXC9dc6fIAIgBFju39VCg+nwYFuEyaghAa
         WowicwdIuIuZCFgRVT3glsVxtcr+I6blVFTOjMWrdlQ2auo+WkrX3ll5yCzHnJIUTjpV
         0feMbLTg9/RnvDvZa75U8hZjLJgblauY4ofKLWvvOENre3/Rr2JdodDXLwLkMMxjz7QM
         Jwc2xLW5XnqBplIZRlUS6StIxQO0xDRRhS+JYilIIrao7koEBMod3b6pIgtByUeHTFAg
         QAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685615386; x=1688207386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp5xxOt20GHMe9x9oOlssfGvZFl/WMiJaJ496BlN+YU=;
        b=a8s/FrvKFu4g7fTd+8FN9Hn+u2zvJefBO9b9zn+2X7PCcxODnY+pWp+r1Dh2ShhSNj
         /jaNKp9RebfME5CxpJ4gxOCpn2cBPiqTWBm+U9wUSoiE7/P/eXyeBLa9S/bOHonPJ0Wi
         XhsBhsXGaM33Grhm+qHaCPaDEH8iq99OoBEIRLkIyQd21587UOM1TQJlNURteJsqDNKK
         hTNNdp2wWaToMVjZ6MUfHYH9OnlgYBc3mP+l+Rv+SwdhWFX3EmapIKeLpbbh/fNubuAA
         N5HcFEScEFgs8ZzFZxyPAgobDH686TSUYJCF5IiacJ0tjwMKecvqpvGAWEyE0TnqRtqv
         bOOQ==
X-Gm-Message-State: AC+VfDy+7KNO+RRdlXRvJtWP2dm35NnftQilMdaXMBiLWRb5d7Ts63iA
        fYhSOkl/XDqNl0ewrkKGpLpCQA==
X-Google-Smtp-Source: ACHHUZ4OWftVrfoV87qYQLL4OGbRoiW1uL9XruidkQ3APydLZi5AlKND7uOLjblqaNOABc+5UzXDmQ==
X-Received: by 2002:a05:6512:66:b0:4f4:b3a6:4140 with SMTP id i6-20020a056512006600b004f4b3a64140mr1036037lfo.42.1685615385755;
        Thu, 01 Jun 2023 03:29:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id x28-20020ac25ddc000000b004f4b0493749sm1038511lfq.303.2023.06.01.03.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:29:45 -0700 (PDT)
Message-ID: <8e5380cd-2ee4-95be-14df-add5ff440088@linaro.org>
Date:   Thu, 1 Jun 2023 12:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] soundwire: qcom: fix storing port config out-of-bounds
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 12:25, Krzysztof Kozlowski wrote:
> The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
> however we index it starting from 1, not 0, to match real port numbers.
> This can lead to writing port config past 'pconfig' bounds and
> overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
> smatch:
> 
>   drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
> 
> Fixes: 9916c02ccd74 ("soundwire: qcom: cleanup internal port config indexing")
> Cc: <stable@vger.kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202305201301.sCJ8UDKV-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 7cb1b7eba814..88a772075907 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -202,7 +202,8 @@ struct qcom_swrm_ctrl {
>  	u32 intr_mask;
>  	u8 rcmd_id;
>  	u8 wcmd_id;
> -	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
> +	/* Port numbers are 1 - 14 */
> +	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
>  	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
>  	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
>  	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
