Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27770189B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjEMRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjEMRoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:44:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36A2711
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:44:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so1366306466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683999855; x=1686591855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0MfMxYHMVpabibphe3gjo4rmP02GnILlTLW34tWHtg=;
        b=eQZU27tfmNPmObPzU0S6ddtWIW4xW0BcUJjXods9jHVgbWVuV8Ed7uVP65n9uOOXCG
         93Xo3fhn8LwqF3ifU4SVfkqlNahI0Yi0VfvNPI1CaB3k/gTtXZIim52Aa/Thv1/H45zy
         7aETvwnme5OoC63l6rASwhZve3q2wBZlfvI4dQvDFe00wBPDu/m4yWDz07L5mWiPEnAq
         JrKe15PyYfWfxsclIrr+sQXVgu3Vx5z5Tce9tAW330YSbxf6GNGmzzBKJI6hJqiXCGa7
         LotuWGow+teCh3LxS9KIrMdUPcqSTB8D+rv0yU2nwi6T5suubdkCrh2cq6c2VJwfoDF2
         EQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999855; x=1686591855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0MfMxYHMVpabibphe3gjo4rmP02GnILlTLW34tWHtg=;
        b=VXlcrEr1VDoQBA4vObRUCjrrbd6JIY94Qm89PISdT+KhB2zTGpt7T8C1vUNDsS07ec
         tnmi3lLB2nAsV5/792tV+Zb6puAXhpcqZdbYNAP/GieQ3t1eeKM3levIrRbwgx2tnsr0
         lHueu44UBHpRKHfsCSzDX2fHgMR5183qKyT0nNy0LIcPfyAuHRrwvsxTfkB31NB2sGPo
         u2B6d9EgZE29c/vn7PkFr2Wbv/O7y6a0YrUcrXBlMDC6IAqW2VrwNyIKk/RoGVWzW/hK
         Pb2E1NJban4KulNR27HNvr1ezEsLWoHJvVWQCU6AtOjXb+fxXm8amsmAPpXJQ+ZcSccQ
         EmpQ==
X-Gm-Message-State: AC+VfDxEWAK+FzvtyZhxAxY27hh2xB0tf6FXu9p5TGK9Epv4tUloQUG+
        aIu+pXb4VI9ztsg908k8FPhATw==
X-Google-Smtp-Source: ACHHUZ6ppFk8WpvzJfantfOmQmiBocbhhBm6AheHQW2QgDKI/CV3p4m5cYhJHjOyGTwTqFN3J3TcNQ==
X-Received: by 2002:a17:907:98d:b0:94e:cf72:8147 with SMTP id bf13-20020a170907098d00b0094ecf728147mr27125003ejc.48.1683999855517;
        Sat, 13 May 2023 10:44:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bc2d:23f8:43c2:2aed? ([2a02:810d:15c0:828:bc2d:23f8:43c2:2aed])
        by smtp.gmail.com with ESMTPSA id de9-20020a1709069bc900b0094e6a9c1d24sm7133727ejc.12.2023.05.13.10.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 10:44:15 -0700 (PDT)
Message-ID: <8821e105-d00a-8a60-edc0-c3d9891f8266@linaro.org>
Date:   Sat, 13 May 2023 19:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: fsl: Add Emtop SoM & Baseboard
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
 <20230513113133.1913736-3-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513113133.1913736-3-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 13:31, Himanshu Bhavani wrote:
> Add support for i.MX8MM based Emtop SOM-IMX8MMLPD4 and
> IMX8MM Mini Baseboard
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

