Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD606EE36F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjDYNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjDYNq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:46:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5800F16182
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:46:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f3cd32799so1078439966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682430359; x=1685022359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI0Ck3d/S1SQIjv352Lo/cQB4x+mg+ti5BsRpNPACt0=;
        b=IbCqrE+0qE1Vta7QCUFthlILPfO9eniXf6400K6oMk+lpgOsl9KXaDA1uRvGgcqVwh
         PAGGWi8fUGEkeNspx6ZhnsvdwhU+aStjzOGNzaXq4c7EJhKTH686w69OBcNaxQQBKdID
         rUjiI1iHNLFRwmrUxEb71IxGS/hVwHwC5Vs/QrPdDI45DojY0g/reV7S8kIKYNG4Z9is
         y41dzqRhtgn2fatnzf91nHfGrooO8kF2iGw9+cD48LdFOloX9hMmuUKLPketS4Qdv6xK
         lvY6LO2me1uYUzYF62v05ZWnQuXsz6Puy21MoGLtSX+jgC0DsBeAnM50weEs9mjoT+g0
         W/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430359; x=1685022359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI0Ck3d/S1SQIjv352Lo/cQB4x+mg+ti5BsRpNPACt0=;
        b=ZLFNB45vZdlM3rEm28TSGH6ti0ZNdVZhSZ3sdtAHU2obiW8BtS9DgIFETPc3iNGboL
         XcVjP8n9PY9WuQ6FeBMsqmqhPjw4CHBrA0tb/ovPQliBMbKTlQ66Qugv3U3Ng22zPqEd
         mdEdAay8lk0vnszbaBZ2lGrsFWApfOCYGaDj5vD25xJygkfZxmIAWfRVsAPKeNZdqRNU
         HC8YJhw46SfO8TpXbN7yj0AwBZtuxtVXTELcHx/aXsNfrEUZ7wvIW81bEIaCbFz9GsyS
         pJ9RFfHs6NEj2FocEPdLv7S/DUcZBDgizXueSx76o51E7XtRwapTYR0TYyVlvJD9lLmc
         PZpw==
X-Gm-Message-State: AAQBX9cU4De0XuZm4EpkcesZDKB1JFTGV84HCFCeWwVazzO64CGZGMRa
        Ara/ObKk1emBfOBdrS7IMS4Fhw==
X-Google-Smtp-Source: AKy350Y5d56yR3yCA+n72WOYxsRIheFXOTdTuxBeiaMFVX4jeFXOmiuq4zZPQKXKHZXpv/m9cuIXJQ==
X-Received: by 2002:a17:906:470a:b0:94e:6294:9d23 with SMTP id y10-20020a170906470a00b0094e62949d23mr13534582ejq.26.1682430359582;
        Tue, 25 Apr 2023 06:45:59 -0700 (PDT)
Received: from [172.23.2.104] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id my34-20020a1709065a6200b0094f6f45b2c1sm6827559ejc.156.2023.04.25.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:45:58 -0700 (PDT)
Message-ID: <9f28dbff-ca3a-8523-5bfc-37b38bc846c3@linaro.org>
Date:   Tue, 25 Apr 2023 14:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in
 SPI_TRANS_CFG
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/25/23 09:42, Vijaya Krishna Nivarthi wrote:
> The CS_TOGGLE bit when set is supposed to instruct FW to
> toggle CS line between words. The driver with intent of
> disabling this behaviour has been unsetting BIT(0). This has
> not caused any trouble so far because the original BIT(1)
> is untouched and BIT(0) likely wasn't being used.
>
> Correct this to prevent a potential future bug.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---

Has this always been the case, or did the switch to BIT(1)
only occur on some recent platforms?

Konrad

>   drivers/spi/spi-geni-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index ba7be50..8a7d1c2 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -35,7 +35,7 @@
>   #define CS_DEMUX_OUTPUT_SEL	GENMASK(3, 0)
>   
>   #define SE_SPI_TRANS_CFG	0x25c
> -#define CS_TOGGLE		BIT(0)
> +#define CS_TOGGLE		BIT(1)
>   
>   #define SE_SPI_WORD_LEN		0x268
>   #define WORD_LEN_MSK		GENMASK(9, 0)
