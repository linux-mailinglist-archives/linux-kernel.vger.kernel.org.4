Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2F7383B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjFUM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjFUM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:26:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22867DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:26:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso7957091a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687350359; x=1689942359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGk3oqjnNfHNIndAjqYr6Ubn4S+JmM/i7wpQCzmK7X0=;
        b=TDon5/PIbqBy/Ab2NWNtGLR3goBGa2sjDUeYrPM6Y0qhvkUsZvHTyLzdA/WDGtECes
         yCyjL6jjAvC/LjB/kFAJbwnMCoROQcEmZv/prrMeRcx/BZURkbsd9ZYDnDCXBSeYWbPJ
         r8V/n3ZyWu1A3YIzyLV0o/J+vc6eCC5hsrSuAAa4zgz3MF9LSPoBeiVvvXF24X2f1FNU
         49mfSD2inLZwX78ar8Vj1WVxTJj2Q3PX/tSUU3KVHqKuyv6/JtF7+AfsVUoRYDaEhDO+
         KH/J2H9HaRckvJSHXcNT/s7OCtkSrwZCeztjPTFrk1Ao6ebmI1/5gDGB2pY356aEyUSA
         4tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350359; x=1689942359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGk3oqjnNfHNIndAjqYr6Ubn4S+JmM/i7wpQCzmK7X0=;
        b=ehsmAg24XpdQ9nKumGPTr1m9b3ihzlbKgNClAbq6L2B7INGoHtzpmh722yjfjcSmH0
         aU3L7jjy8/obSQ6pKSStO8chhaffKHk1TJHuzU4to1+UAhJHDWE6pCUG1di2dypydj/p
         D1RjBIlCt1X8rbBbBiuW9NS2HiSgPyg3BiYNfP5NzUF1t48qpNf5PmoGmB/ITTFiqMnE
         fk64kN8wrShF/xTIAT+rFbflX3afnP8Bo++SENRwRwD4EFRP4/JEty1EfNhc4r9kyYo8
         JqoEnj1SWtJ+0xB2bpazPcCd1aqK2wk8XlfDihbp92Aa4B3YbZJNnPn8uQ0C8kNUiH6+
         UQAg==
X-Gm-Message-State: AC+VfDwQZSmtbI/PHuwHkl8LBE3ZuyrX0rjqdkgkQDUmh1VTp3s1R+Pe
        RxDy3aSaDp37A6eORDlrWHCUVQ==
X-Google-Smtp-Source: ACHHUZ45ul/F6dXXQy/jtZVfcMApc1r5PDXrdq2EaA1pSCoE6yOWuKq1vxIO7aPtxItfkHTVcxfmOQ==
X-Received: by 2002:a05:6402:2cd:b0:51a:2125:74d5 with SMTP id b13-20020a05640202cd00b0051a212574d5mr10619396edx.20.1687350359644;
        Wed, 21 Jun 2023 05:25:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051bc58b8dbcsm2512156edv.59.2023.06.21.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:25:59 -0700 (PDT)
Message-ID: <29666c1f-c670-b38c-8555-e606771b480b@linaro.org>
Date:   Wed, 21 Jun 2023 14:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230621115523.923176-1-valentin.caron@foss.st.com>
 <20230621115523.923176-2-valentin.caron@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621115523.923176-2-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8
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

On 21/06/2023 13:55, Valentin Caron wrote:
> STM32 SPI driver is not capable to handle device mode with stm32f4/f7 soc.
> Stop probing if this case happens.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

...

>  
>  static const struct of_device_id stm32_spi_of_match[] = {
> @@ -1798,8 +1802,15 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	bool device_mode;
>  	int ret;
> +	const struct of_device_id *of_match =
> +		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
> +	const struct stm32_spi_cfg *cfg = (const struct stm32_spi_cfg *)of_match->data;

It seems you open-coded of_device_get_match_data().

Best regards,
Krzysztof

