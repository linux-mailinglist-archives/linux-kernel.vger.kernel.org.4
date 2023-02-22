Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC669F70B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBVOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjBVOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:48 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B938E9E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:27 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h3so2008317lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsfYZbZTcH3AGBn/UIvjg51JaY99ziTDUPxRNM8kMPg=;
        b=wDz3kMMjHapiCiaEAYT158xP5zG/O4p5xL09bvgPuTGB1Y/myR5GXZfwdgWBc/LMQc
         Rwby7x9GxRr/0DpzzFJE4xqU4GC5IiWD4dEQhG+MnP3o5yPbUyrSUv3a7giW6/YC5itX
         99aJnQ51VGiftf84jFkU5vB9VRuk7xhMAER6+qpv0pb163LVK43xIK2W0T5sokrpwhhn
         c5agMKwlAubSEHP+jX64M9Vt9QVnfPcooQ9Zgi/CfzI45l6OjjEcYdA/3z+lAXDRMsNu
         DPGhxMr2zv/xhfjlvlh4jshqqZSXkvVdIoliWr4eiJ+ZqeGeD9yBP8WOyDWSoBgY+EQ8
         EKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsfYZbZTcH3AGBn/UIvjg51JaY99ziTDUPxRNM8kMPg=;
        b=OfHHg5hbwUf1OKVLu2fC9SmYVz/gdkleLQKEa9M2gRXS8QPW7UQrtCcU/YEFR6rQFU
         rjOuANvvheES60CdWmW/m3M4C/8k6JBr5TvTkedqSWJ2JqvKw1RRNMC95qeWp9zGuoCE
         qeHnlzlrToLyIiMOyIGOavdvYItyHlDILbqQoe/QqigCHQzgURwNaA95p5UrqEYE/yAH
         w/ywkBWfB18Ri1sBK02ilw9cwZEKJ5KYn9cYlycGBaKehg8eT/EySxsuLvcGXzsiiGQU
         6Wr0Uc6hLMAqwS4i0AJ8nMTnyMnmLZsB3JSwG/TiI0893P74Kv9XQmaGZvf0o7xv8sPx
         sCMQ==
X-Gm-Message-State: AO0yUKU8TEcsagcu1ohn7F2cQImDJwfPz/k5ZYCMbrPXp2MvEr30LdCB
        DCTmN6M0ZAXDRxHBiclWeL8oXUjKjjiTwOrm
X-Google-Smtp-Source: AK7set+5epA/wJFXcFA8AfQy+dzMhWWm13BX2dxUNOkmKLV4wg9xt3YxvKO23nI9zvgvYTleO8N1OA==
X-Received: by 2002:a05:651c:510:b0:293:4b8e:f7e9 with SMTP id o16-20020a05651c051000b002934b8ef7e9mr4380059ljp.23.1677077245109;
        Wed, 22 Feb 2023 06:47:25 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id a18-20020a2eb552000000b002935899fe3fsm390848ljn.116.2023.02.22.06.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:47:24 -0800 (PST)
Message-ID: <dc544641-b9f1-96b4-95a1-30fafc0712e5@linaro.org>
Date:   Wed, 22 Feb 2023 15:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soundwire: qcom: gracefully handle too many ports in
 DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
 <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 15:44, Krzysztof Kozlowski wrote:
> There are two issues related to the number of ports coming from
> Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
> incorrect memory accesses:
> 1. With DTS having too big value of input or output ports, the driver,
>    when copying port parameters from local/stack arrays into 'pconfig'
>    array in 'struct qcom_swrm_ctrl', will iterate over their sizes.
> 
> 2. If DTS also has too many parameters for these ports (e.g.
>    qcom,ports-sinterval-low), the driver will overflow buffers on the
>    stack when reading these properties from DTS.
> 
> Add a sanity check so incorrect DTS will not cause kernel memory
> corruption.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Fixes: 02efb49aa805 ("soundwire: qcom: add support for SoundWire controller")

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 79bebcecde6d..c296e0bf897b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1218,6 +1218,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  	ctrl->num_dout_ports = val;
>  
>  	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
> +	if (nports > QCOM_SDW_MAX_PORTS)
> +		return -EINVAL;
> +
>  	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
>  	set_bit(0, &ctrl->dout_port_mask);
>  	set_bit(0, &ctrl->din_port_mask);
