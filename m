Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33373194C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbjFOM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbjFOMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:55:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D136213F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:55:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f841b7a697so1206397e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686833751; x=1689425751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr+C4HV3ypYhMAH5p+tz4TJXh2rByBSODsfmyqqfM3o=;
        b=Ix+HXY8lKizE+F/v9G5aOrSdAwCUUPO3rC5F22k4R8aUIph0mG19vve1xPug+9DdRb
         EhVfImlBBTz3KHcBCs/FVDcF4s18euAZMEXNNGWJaZdTYVPo7GAwKezYf000qbO4P5IJ
         /nIpu0ZHAqYiqYbsKwbtR1R3OpX8r0Hth+2c2RSA/sepTHT+LABrrk3FFL44W/CEquEs
         nZTyeZSTdy9PoWlYB5PUWppt0pgx/iXJvPhOW4+8eqBEcjjCHqX4++5PsCFOo3G2FxLp
         PamKcUhhjm8AhIUuMqpr+gyCFZlqkl3SmIQr2lI2eG5mEH4oqpnltkTtHCuyStR4sRVU
         A7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833751; x=1689425751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr+C4HV3ypYhMAH5p+tz4TJXh2rByBSODsfmyqqfM3o=;
        b=QRLy0z4XL+XJK0P+pmO1NVD55HYzdLhuJI5c7XzL/rhiFh+KtrRj2C6tymx4mqN9xn
         bg6jp2aq3akWNfeQtbuZlwFa28e+OAnkL+pwZbUWmYlauL4Mm79TQXr3rYT/l0Th0HUD
         AkVofWl5aS/N27RZkTX1LZlCJWMPxaCkzXkj8miy5iHd67+Qs5z9Wtl0KyM9cxFyZgzC
         6MMGk2f6nhR2ZzthWI9RcFaRRj73fv/gyHVg4IZuDWT7a+Ie1fb9xSfE8tZtLTUl4/2/
         740YoNnavR/i5R8pJnqwvhv/wYzHEerqEJk9pl6GxtSxP7ShXNOtHi9mFZuq0ugkpFoO
         G9hQ==
X-Gm-Message-State: AC+VfDyhDn8NKyh0K9s/ccDbb7BwSkARUTpveVaxVuqtFOAHR4SmJeag
        jyOBdaGFXu92zHcegMC6e3z3Mg==
X-Google-Smtp-Source: ACHHUZ5r5g0/EdaBgh3ItbXCv7EHaR9YYHxAHfFr/UG529fhS2cSFA7JJ0Qe09gXlXkN1fN/RsAUhg==
X-Received: by 2002:a19:da12:0:b0:4f7:669f:7da8 with SMTP id r18-20020a19da12000000b004f7669f7da8mr3474493lfg.7.1686833751155;
        Thu, 15 Jun 2023 05:55:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004f14ea05895sm2550319lff.213.2023.06.15.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:55:50 -0700 (PDT)
Message-ID: <1d1756c6-b79f-7f8f-2f00-6fcb3657295a@linaro.org>
Date:   Thu, 15 Jun 2023 14:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v10 2/6] clk: qcom: Add Global Clock controller (GCC) driver for
 IPQ5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robimarko@gmail.com, krzysztof.kozlowski@linaro.org,
        andy.shevchenko@gmail.com
References: <20230615090638.1771245-1-quic_srichara@quicinc.com>
 <20230615090638.1771245-3-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230615090638.1771245-3-quic_srichara@quicinc.com>
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

On 15.06.2023 11:06, Sricharan Ramabadhran wrote:
> Add support for the global clock controller found on IPQ5018
> based devices.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---

> +
> +static const struct freq_tbl ftbl_apss_axi_clk_src[] = {
> +	F(400000000, P_GPLL0, 2, 0, 0),
> +	{ }
> +};
This is weirdly far away from its use.

With that fixed:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
