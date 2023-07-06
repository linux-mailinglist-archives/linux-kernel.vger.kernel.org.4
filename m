Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAE749A40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGFLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjGFLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:09:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE210C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:09:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso644826e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688641757; x=1691233757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/oYYhSbhJmqOXl3WeZk4kX2/u8Tf8KLHQQBSEPCIVg=;
        b=pIHMjHfJduYZzkTHgIiil58NGHIKjRaQAWq7g35hKDw+F7gRBuswwn6A36meCd8uqv
         P4fTvWp+UdIpiOIoD1iJ571Q85qECK2W3XC8seJ1a3jageFMtPAYrBBVnODTPBV2MchE
         dt6JLZ79+Ei0jyqANQZcQ8/MjcDeshtNlMA19kZ/gZQvAieKUNpFCRK2QXSM+ivj27XK
         LfLYgyyM3fJcQuhQYdbSW6xQKrfvTSeLqmqRK0VkI1f1nhP7YT4BoZJAGuugu8ikrMzS
         46vY3KsXH+F/gLzQ3yZURGx3gvoIEwXLJafvCl2OB2Yrf+sT5+/uU6Oj/ak8WBBcwzPS
         uLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641757; x=1691233757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/oYYhSbhJmqOXl3WeZk4kX2/u8Tf8KLHQQBSEPCIVg=;
        b=jdRkrRPvd5LTuVkItu3P5iURRMWEAElN0kOOXJWZRQJzZC33aCllCYqae1D5fduyoW
         gZn3ZRnsuM5QlrT3wN1wsceuy0YT6eqIhnPgM2+hty7l3WDjKEA11EuI/RGl8IXyVRN6
         0SIMaDyi9kgfLECBNHxRBT4NfIxZuqo2hbkjk772o5efVQQpvXfWM1JZkwOVtbeFkpQv
         OiEAx50PV6P1Kcx/8CFnBvk9kI+Eddf+K+wFfiyee2u2OqIfgECJVxgregv+s0uzj5bJ
         y3+BT4eTMoWpCGMN7QORsjBXdxwO55J3CRDnvEom+wgIDoH6a6gB/8MXXX3cxdyL4DNi
         CDVg==
X-Gm-Message-State: ABy/qLYqECpOr3RZaTB1ZTI136jB6OsKuH5HdwbY803a0sN9pD3kUKnl
        V4/gFqO8dWY3bEm9YAHoMt/WXA==
X-Google-Smtp-Source: APBJJlEBSUaXKkpOKcgRuOXlYHiHk2CCdPExcN0HHxQqs225FP1lp/mzkXW7F/tV8pEK76T9qIDAAQ==
X-Received: by 2002:a05:6512:2005:b0:4f8:5b23:5287 with SMTP id a5-20020a056512200500b004f85b235287mr1568498lfb.62.1688641757036;
        Thu, 06 Jul 2023 04:09:17 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u16-20020a05600c211000b003fbdd5d0758sm1781419wml.22.2023.07.06.04.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:09:16 -0700 (PDT)
Message-ID: <921f73f6-256c-74f6-78a5-f229c732d30b@linaro.org>
Date:   Thu, 6 Jul 2023 12:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/8] ASoC: qdsp6: audioreach: fix topology probe deferral
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-3-johan+linaro@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230705123018.30903-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2023 13:30, Johan Hovold wrote:
> Propagate errors when failing to load the topology component so that
> probe deferrals can be handled.
> 
> Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
> Cc: stable@vger.kernel.org      # 5.17
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>   sound/soc/qcom/qdsp6/topology.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
> index cccc59b570b9..130b22a34fb3 100644
> --- a/sound/soc/qcom/qdsp6/topology.c
> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1277,8 +1277,8 @@ int audioreach_tplg_init(struct snd_soc_component *component)
>   
>   	ret = snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw);
>   	if (ret < 0) {
> -		dev_err(dev, "tplg component load failed%d\n", ret);
> -		ret = -EINVAL;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "tplg component load failed: %d\n", ret);
>   	}
>   
>   	release_firmware(fw);
