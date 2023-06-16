Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08347336F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjFPRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbjFPRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:00:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1F3C11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:59:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a2c8e5a2cso1228375a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686934779; x=1689526779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4Z3Oggug3eyCv9fQweYcbj95ltmnIsQ0pJL+WUQHTM=;
        b=ZUZoKNA7K0k9D/HqPP4ymKA+ukrDynS7/jspQ52fZByxXyO9Y8E6eJCr0VINuGnuri
         sNdcWM60tzq0GpJUOPbXWov5q3rm5O0DYCTAQMbOPUHJ6olwHM1syPJO5zTAh6Pp4ken
         1IieQmFb2jcNqLSLW2jgE1gAH9h0t8r+QUts5rLVWwqOOW6UAJjmSlqwszUsGUQgoGmD
         tPLtxydobUZfDRWH+IXbFKmFomswgrf0/z77miCOrY5QXL7qBjahQ+ITb6zIL2aMkltb
         LpCRqOby2lTaSqmtP8p41s0GEg3qwAX/nTK0SyQvAEKwGMpA8QCjCGSReAzU5Fz9yJgA
         CFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934779; x=1689526779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4Z3Oggug3eyCv9fQweYcbj95ltmnIsQ0pJL+WUQHTM=;
        b=GYOUdsH4+slz+5vh8ViNE0xnzmKlJ/mUrnvbtVwNvx90BkjDU6FN24XMXFH/7fa8sn
         MMEWaKL/Wqup6ZoSvxz+ueBQEiYIsWvdQxNFx+N67xUZLoHGL1Kxe9lkIDIDO0AQwjW+
         AGw7gwAs8bIV+pzXkZILO9l4xfxPaBbXo8/IKerjIa7KDAOvxwm4mcfj4WkGix+opRF0
         CXiiS/8VlW8F61+g9hncyLeY2k1lXQmmQqiyT6wlAa5OYIpZAeNz3nJkcf8F0yL6g9fa
         hZj94p1vKUvf43rV/Zuf0nPKKtjlSTReYFT/s71/qUpNP4J5L+qQWdnguQ9sSNk0s7fh
         yiJg==
X-Gm-Message-State: AC+VfDykCH93RpMOsSw+jgRxR7qteQpRaZjX+HLsUuLbZY6WaM38sjt2
        dqSkg4zBav47xC7XL959tn4zQQ==
X-Google-Smtp-Source: ACHHUZ51RY6TzRgBuptSsPtSALaXr8pvLmG3RS/Dw4BcFxiGvu0E1OxIhTA86AICO0U8/AmfLIv32A==
X-Received: by 2002:a17:906:9749:b0:97d:2bdb:aa67 with SMTP id o9-20020a170906974900b0097d2bdbaa67mr2586323ejy.70.1686934779243;
        Fri, 16 Jun 2023 09:59:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709064ad000b009828e26e519sm2969171ejt.122.2023.06.16.09.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:59:38 -0700 (PDT)
Message-ID: <590e511f-4db8-f9f0-df95-4648f5cf10bf@linaro.org>
Date:   Fri, 16 Jun 2023 18:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add support for LX2162 SoM &
 Clearfog Board
Content-Language: en-US
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-4-josua@solid-run.com>
 <c25630ca-c791-287f-36a4-ebc0559d6541@linaro.org>
 <12951175-82c5-e93f-871d-1379e5985b10@solid-run.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12951175-82c5-e93f-871d-1379e5985b10@solid-run.com>
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

On 16/06/2023 14:57, Josua Mayer wrote:
> Hi Krzysztof,
> 
> Thank you for the comments!
> Before sending a v2, I will:
> - move all "reg" properties just after "compatible"
> - give the phy nodes generic names
> - remove dead code / review spi-nor-flash node
> 

You forgot testing.

Best regards,
Krzysztof

