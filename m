Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17A6BB54B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjCON4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjCONz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:55:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB134038
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:55:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x13so28548385edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678888549;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUoYKIwbEPLMJlRFY3LZ2Wm9oxFPNDYV/KJElx5l8cg=;
        b=n+Ds2o5UiOD5Bb1wkw+d+0BH1Xt+LooclJ3obAcmNQvyHJNDRnQaa9ObKFBA/QUZco
         VgCzj5mW23Qo7skHlk8A02ZAG5kqLfL5HAgzryXSxDSpfAD5Fyxrr1xb6DUVvsxQqgCX
         sHl1ozZAvyi8A8pc1GbSHZmP18nPuaa5txhJ0QfmmOnbIm8JZZtXRo6pcnry1U5VV4dx
         4a6psRDqfrFgtlWRpzE/7nibrYqhxbd0vOTEtAA+PT/vF9pqQAupwarJEjAiE3vQHamg
         /d03f6uVir1t6ZZde1fV8UaxfgibDJZdqCbDpO7fbcmcP4+E6zM88LeS1atN/RNeJE12
         fC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888549;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUoYKIwbEPLMJlRFY3LZ2Wm9oxFPNDYV/KJElx5l8cg=;
        b=e51T+K9rRPvy9fUgtZtoTuaqFXbPe/Cp3mZXXrP01Fzi/hfWYmkvi4/hjBzqBjMVwF
         PY/YuKKCGDYXg9Itsjq2w3FzInJwNyY9J8npV2y8+SjrllfoVQfGboaeoFTbSyP3zVzr
         agurEF0xtpt8kB1O6x4sfLpKCh+kPGPc7HgCXWmLGnzAEFRPrStsBHA/OZskAQG2KEWc
         I1YfEDWD/pVIXpnmW0EyIZ/8Td/IC3LXVzqlhLELWePtgoq+AuKySDd8j8W4XTC9m/fI
         Im9k4tVm7IIgH8wvInuHeeURoGyN31lpvKRNKxnpjKJN33wZ/wEVchrrmgepp0ro7nYo
         RmkA==
X-Gm-Message-State: AO0yUKXJcvJOakJP+9j1N4p+H+cVaX6WA/+GK0gPpbh4IwJt515fJW7Q
        amVX7jZMp4UKkaW/ExGCwdzPEQ==
X-Google-Smtp-Source: AK7set/VV3mEENBlfApLyk3i4f+WooHjZ4NZODuKZ4puxLYSINeHpz5seEl/fCl0teW03eNhSvVh/w==
X-Received: by 2002:a17:907:1690:b0:86f:64bb:47eb with SMTP id hc16-20020a170907169000b0086f64bb47ebmr8168964ejc.3.1678888549459;
        Wed, 15 Mar 2023 06:55:49 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f7-20020a17090660c700b008d0dbf15b8bsm2540738ejk.212.2023.03.15.06.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:55:48 -0700 (PDT)
Message-ID: <109ec760-a139-73b7-81a3-230bb040ca15@linaro.org>
Date:   Wed, 15 Mar 2023 13:55:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] soundwire: qcom: gracefully handle too many ports in
 DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
 <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2023 14:44, Krzysztof Kozlowski wrote:
> There are two issues related to the number of ports coming from
> Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
> incorrect memory accesses:
> 1. With DTS having too big value of input or output ports, the driver,
>     when copying port parameters from local/stack arrays into 'pconfig'
>     array in 'struct qcom_swrm_ctrl', will iterate over their sizes.
> 
> 2. If DTS also has too many parameters for these ports (e.g.
>     qcom,ports-sinterval-low), the driver will overflow buffers on the
>     stack when reading these properties from DTS.
> 
> Add a sanity check so incorrect DTS will not cause kernel memory
> corruption.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---


Thanks Krzysztof, it make sense.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   drivers/soundwire/qcom.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 79bebcecde6d..c296e0bf897b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1218,6 +1218,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   	ctrl->num_dout_ports = val;
>   
>   	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
> +	if (nports > QCOM_SDW_MAX_PORTS)
> +		return -EINVAL;
> +
>   	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
>   	set_bit(0, &ctrl->dout_port_mask);
>   	set_bit(0, &ctrl->din_port_mask);
