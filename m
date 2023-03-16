Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186F6BC70D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCPH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCPH2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:28:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC220691
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:28:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd5so3827495edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bsi+JLbKWkbl2/O2F9F753mkheOOmEKDrBc+HCXXLxQ=;
        b=uVGMUCCtabrj/ysa78tkpl1QNPZ7Z+i8KUxLerEiMBDXf30AkAPuV6dGj7j1/q2A9c
         uH7ZyfnwhcMsUEKPEjWk0FdqKSWcjIh1r4YuhkLU3EPn+R0vJRQNyjRm/eEMLhC2WKg5
         xZfJRF48EeMwqyJM/baWInprx6p/kG9ct3fF8PlsPxWQAv9RQb/KNHwshjs9dB1oFsK3
         P+XD0mfuBnPV9PYO6I8rjOCnzHVAWSe3y7jV4blWpdP831e2SU7nPIYXTiemkEO6QSKU
         CDkXn8QrDEe6083wz0BJX9dfuwH24GVhPO48JJQQJMdxaSijT4wCCvy0u5PZ5LxvVxM5
         jUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsi+JLbKWkbl2/O2F9F753mkheOOmEKDrBc+HCXXLxQ=;
        b=DjRnKNgNIfIhTmtvyWyyprOhxXLHKypPBBbePjgAz8TsYN8aD/pwXAfIE77xo0/iUm
         kfIDDfE4F4r/TGO8IqgLRlll8IcDKewjUPMKvy0m72DJwxOGCv8TrAEBFIyCLXFeUSeZ
         Qhwwh0pTo4T5Q9vbnzq28mEOqyKyREc3LtvQdkqjm/vfuQtpXFRLlSCQCFdNhcvTmMjR
         0AZ+D/jiMfRaDlAY4ulxZCoL8y5A436+CdIOhvHxuAjLBZwyx9icPZQkPJ5H6h3TMpr1
         /RP11PhTWNNQtJqY4xWDXDfBEzC7+kAheTBFT/KtRYX8JRj3M92xZmN14AurupQIliTR
         oK3A==
X-Gm-Message-State: AO0yUKUxoZiJjRFuL/gFXHj6KpVhmXCNP/HvXKzoHE7qDZejRgKd1Qx0
        jpCjcY7OieNtC6Jjo9GdHjN9xQ==
X-Google-Smtp-Source: AK7set9UpAUpBs5fKHC+6wkTYq8jFs+DftAa9ByGu2cOZjWvf9e/znTZ/UlTzvCyaLx2OWCd1go65g==
X-Received: by 2002:a17:906:2b50:b0:8aa:c2e1:6a64 with SMTP id b16-20020a1709062b5000b008aac2e16a64mr8965947ejg.61.1678951687751;
        Thu, 16 Mar 2023 00:28:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id cd3-20020a170906b34300b00921357fb28csm3416958ejb.123.2023.03.16.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:28:07 -0700 (PDT)
Message-ID: <a25ac419-5b20-d762-93a5-28cb2ad09ea5@linaro.org>
Date:   Thu, 16 Mar 2023 08:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/5] dt-bindings: Add doc for FriendlyARM NanoPi R5C
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230315160228.2362-1-cnsztl@gmail.com>
 <20230315160228.2362-3-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315160228.2362-3-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 17:02, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R5C.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

