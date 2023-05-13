Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFD701598
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEMJXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbjEMJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:23:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E872A83D8
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:22:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96652cb7673so1230933966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683969774; x=1686561774;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7TOHB/NHWBi86ZmPK4qdtvR9exgc7Bql5K3NEDIFsU=;
        b=Lq3awNlGwGZmZIWfZfnxg5+BsfF7Ay0JrGi14fsLC+jg4Dzzhzf1zkM9TUQtcnOOQ9
         Dbrwt9qyBt1I/U92tngji1ym2qI3dSpeLPH58JlIyTHkCMVPtgr9utNqgaK+eZuiwE0B
         rIsqCSQD+BEcXUOedNtawT9XfaNGMjqeX3X392p+9+Lew/hEDJqD7uMFworQem/3ylcU
         NVAM7vli6kNoeueR1iOGuJTPq08lptKmJ9S74HrjVIj5TATd2VEyA/zQZLPz082jff/T
         Bs3scSD/8/6mmg7xYyBmMVu45sNiS7QQopPHlqN4SBf9MRquKiu5uHDIdaRDAwJvGtNR
         2hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969774; x=1686561774;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TOHB/NHWBi86ZmPK4qdtvR9exgc7Bql5K3NEDIFsU=;
        b=GTbv9/VZ9eojhvbjF2JydKNH/TAyyZO5hdA5z2Em1fhO7Snvoyl8V3oL1KhtRH8iyw
         Ryme3NK8ziguWnyPEpdGLd6P7xDVIQmJLbRgoLTcz1v4y4bFvPEgGaBmYVvRYfOjLbxY
         6RwuVEGfMl7xMuInngtZI08vuAgH7kk5i3e6QiDxJL05/3npLhdGrZ9KC+r9FAlprslT
         YkBmhHa7RlykkbDa/+Rb2MGFLBpdOMqu8Zb+LbIWdt432WnT9ofplSTdnA40Py6WE1oB
         EdYGEO6XbHoQpLyn6Cko6MekeznybQGg+dKlIcCcHb+6LxK5tNzZINEnHvRVshMDljTB
         F8FQ==
X-Gm-Message-State: AC+VfDyotP0NeLTHs6AqNqgJQRC36AbEYaqNLQdSKoFlqKJDzdAeix5z
        KMSSMA8LBNcvwJBrRUqm16TCXA==
X-Google-Smtp-Source: ACHHUZ5ERA+i35sdXaGUG5ytpfbcMkfZR268N1qch9IRgmJ1l+4uJFrfRhWOfOlxqtSQkaqEIhT1yA==
X-Received: by 2002:a17:907:2d12:b0:969:98eb:3fdd with SMTP id gs18-20020a1709072d1200b0096998eb3fddmr19380064ejc.3.1683969773913;
        Sat, 13 May 2023 02:22:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b00966447c76f3sm6577143ejr.39.2023.05.13.02.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:22:53 -0700 (PDT)
Message-ID: <18e90736-b2b9-fe8c-fb3f-b6b1078e2334@linaro.org>
Date:   Sat, 13 May 2023 11:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: imx8mq-mnt-reform2: drop invalid simple-panel
 compatible
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
References: <20230326204502.80794-1-krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326204502.80794-1-krzysztof.kozlowski@linaro.org>
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

On 26/03/2023 22:45, Krzysztof Kozlowski wrote:
> "simple-panel" compatible is not documented and nothing in Linux kernel
> binds to it:
> 
>   imx8mq-mnt-reform2.dtb: panel: compatible: ['innolux,n125hce-gn1', 'simple-panel'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts | 2 +-


Shawn,

Can you pick up the patch?

Best regards,
Krzysztof

