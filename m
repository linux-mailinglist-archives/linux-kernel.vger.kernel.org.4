Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34853671F56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjAROUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjAROTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:19:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7312B5957E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:01:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so34015987wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59YX65i1aPfGuHqA5kZ44X3ahFvXLUXQukAt3gsTfws=;
        b=scdnhlJwkNZ+lFcAwcVKpBVym4KL/ZFmWy7BTVitn8sGzabneG9KZdDG/wQgunGkVW
         hKPnCV37emiTEduXKSrmjHgAd730p78gXBbWTxdwR+ctraU35LQGiCoG7eej9vQHmgLh
         nEnVvc+4zrKBchzCE8KnQN5zpz927cXvUCrf9BK/exdGQw2kP6LaIFbRh0yl3XBMz+4b
         MmQhdTEoouE8cHM9dPxzUxHSWuM9D/bl63eWYO6gtJhkPAled0GRH+P76Jfoocw9yv9y
         rIYaj+AZuhRvIi5E5gUoxgHV/mzhPRArh7AX0dFbGk06fJHofdoK4nwTwgSgzAzwtu8y
         N/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59YX65i1aPfGuHqA5kZ44X3ahFvXLUXQukAt3gsTfws=;
        b=W3Gs8qoOF44BGuIbPM6k800GAwh1fW+eBcw11cqqDN+zFMA4pZmDKjka0geMOw2z6c
         PSPZBOYjU3mA9c7UyaIJF7ZEOLWgd5Xbbfe7hSbEO3Es/TNFGmOr7xzVhH23HYYrxpcP
         EI+TXwLse5OjXcjrOZ+3yTmp0m3lnfcjVDfh6tahtUtq6GK64yIkB4/7VQMNDRkxHFNr
         e4d8Y7xebRZPDsWkDlLfqR1p4lJG5Z98A+tXu6QkXB3/t36bERzECIeWfquQwiWgg+P4
         FGfuYomdC/DeQU4XAcyPgKUo79AvESCIZ9B5NpVQXpt17Ad7mBkuyeghAlUnau2zL/xA
         c7Hg==
X-Gm-Message-State: AFqh2kpgkBq99j6xU83y/ZMAp6sDJGi25Yq1X3aw7T6gzkW6e7ooTQMC
        4rE4ItWYn8SLm4D6FVxvJQpCIw==
X-Google-Smtp-Source: AMrXdXu00x0J9P2bv/jgrcotUNDAFg3sYfIGVLuk59ofX9BLs0uF68ODnCOtf4IMDzxGDZFKB7mwWw==
X-Received: by 2002:a05:6000:1374:b0:2bd:f63c:5457 with SMTP id q20-20020a056000137400b002bdf63c5457mr6353718wrz.48.1674050482683;
        Wed, 18 Jan 2023 06:01:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm13467031wrr.20.2023.01.18.06.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:01:22 -0800 (PST)
Message-ID: <ec696e66-531e-6abc-f880-ed1dedbcaa8c@linaro.org>
Date:   Wed, 18 Jan 2023 15:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 15/17] arm64: dts: freescale: apalis-imx8: enable
 messaging units
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230118072656.18845-1-marcel@ziswiler.com>
 <20230118072656.18845-16-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118072656.18845-16-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 08:26, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable messaging units aka MUs.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - New patch enabling messaging units aka MUs.
> 
>  arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> index 545618799852..70c00b92cb05 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
> @@ -684,7 +684,18 @@ &lsio_pwm3 {
>  	#pwm-cells = <3>;
>  };
>  
> -/* TODO: Messaging Units */
> +/* Messaging Units */

Squash the patch.  It's not TODO anymore.

Best regards,
Krzysztof

