Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD981625FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKKQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiKKQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:42:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827395BD70
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:42:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so7132810wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRDq3YvWP3xlx40agy7LwTpV95X9uRpVaWN3hJZiIrE=;
        b=CVsNX79HlQ0xGOF1Z1TKcpj8NMOVjQOldIQpoV1xWeKqERQAHxdQfwaVlfzXCpjA/0
         QFuj9ImG3K0oOKY+xgpIvc06pSuEnvTxfITNulGEfv/Q+VluUGXs6XGbLS7JHWMk8Ncq
         62Y5wSWP1JUVMzcXLtKhZ5cpoQgqkj+DhD6oU4rIn/YOvky3+//LewKDXNxVSSFQt2gB
         rgBq/8DDq74p0bOp0yWsSzJl6ppvhItIllWn3wG8hxANEprfRGg0FryKrHFr9vUVn5Jb
         RAj0NVLpco40QSCw2A/B+Zftk81f26r3BkkCM3vzoEUTJKZffoczl1c1+ycdSvbxYt/C
         OGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRDq3YvWP3xlx40agy7LwTpV95X9uRpVaWN3hJZiIrE=;
        b=RZKC6y/zYla96WyYCiyWY/pHoYRw2jIT+FUsvY5EzXh3vXLSxL0sbD4f8Vx2daGTnM
         +928LD/thkSZZ6QFyRf7KTeG71GrvEHYly4X1eR4glrts7Xf5vlCsEwOB4THD8nXyZHL
         xnYXEu83lDd0nDIw5lwJJkO7BiD5nDDi4HEUh4lfH9pKSIFFZO0WKpy0RarMZ1AWgRHn
         5NzKxsY3L05R+TejRXy8LOTuVeVFpoV3SXoQmIN/zk0NPa/Dz7P+3qjmPPBgfRVQxFHE
         aalbLPnxVWfeALIzs3f9jp+9GrJmaePBW1JXHCdei6vYpIsryzqd6vCo/EZt08LSOtph
         315w==
X-Gm-Message-State: ANoB5pnjfXxBIV7XmZAQLTx97iiF0BDi8doPbRVld7zIdBGlHxIOzxD+
        xbczeS7aY5b+boJOjguvnncOiA==
X-Google-Smtp-Source: AA0mqf4CB8B5ldRLG2ZTP+StIEXMyDGoczXmUgfdXQ4MPh8CPep7VpfwIc0MBXZUi8VEgrQHfbasnQ==
X-Received: by 2002:adf:f08a:0:b0:22e:37d1:b598 with SMTP id n10-20020adff08a000000b0022e37d1b598mr1796487wro.377.1668184924029;
        Fri, 11 Nov 2022 08:42:04 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r15-20020a05600c35cf00b003a84375d0d1sm10299100wmq.44.2022.11.11.08.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 08:42:03 -0800 (PST)
Message-ID: <7cdb914a-df88-ca11-45d3-d370d5c94bcd@linaro.org>
Date:   Fri, 11 Nov 2022 16:42:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] ASoC: codecs: wsa883x: Use proper shutdown GPIO
 polarity
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110133512.478831-1-krzysztof.kozlowski@linaro.org>
 <20221110133512.478831-2-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221110133512.478831-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 13:35, Krzysztof Kozlowski wrote:
> The shutdown GPIO is active low (SD_N), but this depends on actual board
> layout.  Linux drivers should only care about logical state, where high
> (1) means shutdown and low (0) means do not shutdown.
> 
> Invert the GPIO to match logical value.
> 
> Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
> Changes since v1:
> 1. None.
> ---
>   sound/soc/codecs/wsa883x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index c7b10bbfba7e..77a7dd3cf495 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -1392,7 +1392,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
>   	}
>   
>   	wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> -						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
>   	if (IS_ERR(wsa883x->sd_n)) {
>   		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
>   		ret = PTR_ERR(wsa883x->sd_n);
> @@ -1411,7 +1411,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
>   	pdev->prop.simple_clk_stop_capable = true;
>   	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
>   	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> -	gpiod_direction_output(wsa883x->sd_n, 1);
> +	gpiod_direction_output(wsa883x->sd_n, 0);
>   
>   	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
>   	if (IS_ERR(wsa883x->regmap)) {
