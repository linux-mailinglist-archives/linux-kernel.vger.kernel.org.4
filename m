Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9D613D57
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJaS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJaS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:29:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D01261B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v7so1852114wmn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUHDIHfTHvE+Ti0vvj6SEtCpulXlPZfgxMR3wyAbMCg=;
        b=d4CnvNDIxCD0H28VAA+U0guyZMJ2QYN1DogRcqfmXvo7eqA/MMwaXIZGRCy6QrN4dv
         7Sf+ptYULqcK24JSQ/EpUTF+axOypIbCU85mcegZ60tW6xxE+fGN1TzpfLRAdYwZJZCx
         IPpixdP818jos4menf+0spQQbJEwu9jeYLF0Omlmi9uBTLfoZA2OQgg39y+Q0i0SuqkW
         gkypUcTGx5PuUGkjmk04oofHprRtWWGYP0wB9S8t5crGw7jb+ty4DOdZzknW1kPyRaw5
         8a+uiUBFUkpDq/mRmEZyoDA7Tcszp8sj5i28QJzDuaVKQJHDxuL4HhLcdhOXwoV+FZmJ
         6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUHDIHfTHvE+Ti0vvj6SEtCpulXlPZfgxMR3wyAbMCg=;
        b=gKcvFH8bhP8XIDWAEBs3NUtVZJcvy+nYeKfh9TyPr/jTmUh7wNCZTLtfyNkLUmYV2K
         t+9BgxR7AT3atZ1d/EuH64uQuyHBrQxkMnpT9Arzj6FcvtqibAlBjfQzLuQLjpHiLl9R
         zUNXiKbMF24fzkjCONxtr0EQWvDHGszAKNOzQvzWs+iM1uJKSX8uZtLa/yjVcKJOIjHu
         bWx78l/61oqKKb2zwDkQaG4/XMj1ZNra/vVcLewMCQSP6Ap98WaBsMzpnw4AuoZrpJ2z
         8EoG6G3Kj+T8pAWX/BEF1x5OJPY2mz4ZTy/MDv0EW1YBWFaSu2ZmmZiYJK8Ja+HLVf3N
         w9bA==
X-Gm-Message-State: ACrzQf0SeSM+kegtJRfVRBxNxyhC16050mvGc5BbqBVO+M1cT05Sewo3
        6z+AE8e9kJtzUC1tKfcCiIQFyA==
X-Google-Smtp-Source: AMsMyM4GnNmljpEATOt6DHzH3LtKOU2Knri8PMbYG1W2OFAlPUdsGeaW15eeeBvjdqXHpbSJehvGWQ==
X-Received: by 2002:a05:600c:1549:b0:3ce:794f:d801 with SMTP id f9-20020a05600c154900b003ce794fd801mr9129071wmg.63.1667240937823;
        Mon, 31 Oct 2022 11:28:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f7-20020a1c6a07000000b003a3170a7af9sm7894668wmc.4.2022.10.31.11.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:28:57 -0700 (PDT)
Message-ID: <57a8c6f4-0bea-f596-e50f-cfe441764eee@linaro.org>
Date:   Mon, 31 Oct 2022 18:28:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] slimbus: stream: handle unsupported bitrates for
 presence rate
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2022 11:00, Krzysztof Kozlowski wrote:
> Handle errors of getting presence rate for unsupported stream bitrate,
> instead of sending -EINVAL in change content message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> ---

Applied both,
thanks,

--srini
> 
> Changes since v1:
> 1. Rebase (drop development pieces in the context).
> 2. Return prrate (which has errno) instead of -EINVAL.
> 3. Add Rb tag.
> ---
>   drivers/slimbus/stream.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index d5ce974e880b..f631d5ed9809 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   {
>   	struct slim_controller *ctrl = rt->dev->ctrl;
>   	struct slim_port *port;
> -	int num_ports, i, port_id;
> +	int num_ports, i, port_id, prrate;
>   
>   	if (rt->ports) {
>   		dev_err(&rt->dev->dev, "Stream already Prepared\n");
> @@ -221,6 +221,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   	rt->bps = cfg->bps;
>   	rt->direction = cfg->direction;
>   
> +	prrate = slim_get_prate_code(cfg->rate);
> +	if (prrate < 0) {
> +		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
> +			cfg->rate);
> +		return prrate;
> +	}
> +
>   	if (cfg->rate % ctrl->a_framer->superfreq) {
>   		/*
>   		 * data rate not exactly multiple of super frame,
> @@ -241,7 +248,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>   		port = &rt->ports[i];
>   		port->state = SLIM_PORT_DISCONNECTED;
>   		port->id = port_id;
> -		port->ch.prrate = slim_get_prate_code(cfg->rate);
> +		port->ch.prrate = prrate;
>   		port->ch.id = cfg->chs[i];
>   		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
>   		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
