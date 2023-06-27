Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126A73F604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjF0Hsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjF0Hsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:48:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFC10D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:48:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so5005504f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687852119; x=1690444119;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4EUTaqa/YZ4jDA+Wf1yQ+b2ojB9ttSnQ3Vj0U/AFAc=;
        b=KIVE3qLp9MOBy+CqVm0+geaIX+RLBtz+wOiea8N3KzO8WPFtcCx9qYQrAC++H9SINZ
         i0g2DPH673kChSqCMCfyjRum6Z5Ym8PLUkZYiwQjEKs5+x1YX3NUouD+rzjslxfSMZcW
         br8N5AOu7n5zdYQ9GSpsdcKL36yyjmvxuQp2vrIWRwnCMgzZXwGvAS8yUqpROsfmuQkz
         Sj3JP1XrhsB3V3l8eklSDCMMQd1EftEhjI1UBTALpgsN9P7CBIqakTCIOBfiHfBybyh7
         GKnNeCcmKMPqege+xdXOeS460z2xQndPypotQquk9V/r5HAlj4HrMS4XwhLRjL9qtFmn
         vjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852119; x=1690444119;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4EUTaqa/YZ4jDA+Wf1yQ+b2ojB9ttSnQ3Vj0U/AFAc=;
        b=ju/6PZ5qUv22sQxeAit3H5vNk22zeK0lJNLslOV+HEFRN7Gmw1u5+G3zB50JOouPfL
         WhfBoPt0aYSxlVIrl4JHyHR2TD4otSI/bfMnWOyRp/OVXqgjm/M0TedQo9sY6RYzsAVI
         Pm7A0nBu+iqvYvJ5JwwhDdBGhyjtVINYQCvJi5tuN6chUf3Ql5wRNR7Ra9o8L8EEWX7q
         VT8wZWVsW4yXwOXBdmDyVXLxUN+2G8bxeLziqblTnjtxDB44Gd6JajN0Hfu3lY5gQ5hS
         y00qzoF+OnUhBfWV698HyBTGAIekWyNuC/KKp/PdsLMdfk5y6Qblc3EUA15/71aYWEN+
         wGLA==
X-Gm-Message-State: AC+VfDyIcAw3LTvq6j3NaauKqwI2giB+tlDgt7pB6UaMiy5ec0w2OUnD
        9cLzJUImyJHixltUR/qoXHz7fw==
X-Google-Smtp-Source: ACHHUZ4NGBLdm1hGEsZxgHN5juAUz7/putOdrOALifK/OsCWo56HfuMIKI+Mle/Ykas2mq4X/0EqCA==
X-Received: by 2002:a5d:58d8:0:b0:313:e2a2:fc80 with SMTP id o24-20020a5d58d8000000b00313e2a2fc80mr7320553wrf.33.1687852119497;
        Tue, 27 Jun 2023 00:48:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cec9:2929:7a19:7afa? ([2a01:e0a:982:cbb0:cec9:2929:7a19:7afa])
        by smtp.gmail.com with ESMTPSA id q15-20020a056000136f00b0031122bd3c82sm9583932wrz.17.2023.06.27.00.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:48:39 -0700 (PDT)
Message-ID: <c74f99c9-c565-8837-79d1-e08f9bfd4a7e@linaro.org>
Date:   Tue, 27 Jun 2023 09:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 3/4] tty: serial: meson: Add a earlycon for the T7 SoC
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230623081242.109131-1-tanure@linux.com>
 <20230623081242.109131-4-tanure@linux.com>
Organization: Linaro Developer Services
In-Reply-To: <20230623081242.109131-4-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 10:12, Lucas Tanure wrote:
> The new Amlogic Meson T7 SoC does not have a always-on
> uart, so add OF_EARLYCON_DECLARE for it.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/tty/serial/meson_uart.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2501db5a7aaf..84d33903038a 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -649,6 +649,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-t7-uart",
> +		    meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>   #else

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
