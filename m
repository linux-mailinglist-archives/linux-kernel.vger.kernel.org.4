Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62296712E82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbjEZUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjEZUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:52:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0335A3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:52:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso1369828e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685134327; x=1687726327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOtEQ35IPkwIpGkFbmSz/EpWP/HTUv2mT/RCQs7Eigk=;
        b=j2L8fZi4cmoxoC/MS2awmvNvm0Owk8CYBu/8OITteaZYDFftdofWiRr/SbfXw7f5OQ
         ssQ7UbyTM71yF1zYUvUbQ6NawWT96oIJjuE4f8WEm8wOmAChfQZgW+X3OSDEcNIhyHnS
         QBE+N3G3DyTvYb10qoScxWrKjrfY6plGWL38LXk/yCcR3SIQebZnw+CeT/yCzWe0YZin
         re92DJdFWJzwRzMEV3VGbMdmGs+0ZXylFV3TY6aK0EplAwyx95+63BLamyYS+15RGZGR
         zxq4vAv9GUoAbt1ZpE5TQQ0id0BUqYOq2JVP9TzI8avHA3cdUCPLp86XFMq22P83iWHE
         J4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134327; x=1687726327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOtEQ35IPkwIpGkFbmSz/EpWP/HTUv2mT/RCQs7Eigk=;
        b=SGCRw8Sx28ukjdmlnpAcGV9faL7APQy6B7ep0AhZH60wHKTEvcIxIevuYitG0ylu01
         Nw8hOyMfPEWppcY2jU2v5v0jkERsTU8qJRLSabvN7VFXj1S979f1bQHmth1sAXt03z0Y
         0302jVHCwErZOjgVa5bWJHxuHyibvQIXvG251gvOO/IDnc4Y1bDK9DU8TREPVjq4Kwbq
         Z+zeHTv9NS8sVG6y2NZcnFVBsoz/vBYXK6lVJn5b7y0WW6gxy0N2GWD/U6A95G3x97Qj
         bjYqqwtp49duzf6pj0u7QYw/JjyXLIm3ETbCC7AzC/YvGsBVD6VumrcmRyPEI8dTdS54
         8B4A==
X-Gm-Message-State: AC+VfDw4mMN0H8hckVRG5re8AZjmNxaWd/2OfjF6BBb3gDccQtDYXNYi
        2Tz5CnAqMmEOeTzNkSOyet4pk56tcoX1PjfYuUE=
X-Google-Smtp-Source: ACHHUZ4Gm25jkLb+czSn7UCVBJM6klFJZXCmLn+TQl6e0hT+v8L49SM7vb4ELfePZ6yNsFav1N/xlg==
X-Received: by 2002:ac2:5dfc:0:b0:4e8:44e3:f3da with SMTP id z28-20020ac25dfc000000b004e844e3f3damr873410lfq.39.1685134327163;
        Fri, 26 May 2023 13:52:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id y24-20020a197518000000b004ef92c6e645sm773699lfe.263.2023.05.26.13.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:52:06 -0700 (PDT)
Message-ID: <5833388f-51c6-ad42-f8c2-2ad37cecc31f@linaro.org>
Date:   Fri, 26 May 2023 22:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] clk: qcom: ipq6018: fix networking resets
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526190855.2941291-1-robimarko@gmail.com>
 <20230526190855.2941291-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526190855.2941291-2-robimarko@gmail.com>
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



On 26.05.2023 21:08, Robert Marko wrote:
> Networking resets in IPQ6018 all use bitmask as they require multiple
> bits to be set and cleared instead of a single bit.
> 
> So, current networking resets have the same register and bit 0 set which
> is clearly incorrect.
> 
> Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq6018.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index abd97b939850f..b8310f29a8ff4 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -4520,24 +4520,24 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
>  	[GCC_PCIE0_AHB_ARES] = { 0x75040, 5 },
>  	[GCC_PCIE0_AXI_MASTER_STICKY_ARES] = { 0x75040, 6 },
>  	[GCC_PCIE0_AXI_SLAVE_STICKY_ARES] = { 0x75040, 7 },
> -	[GCC_PPE_FULL_RESET] = { 0x68014, 0 },
> -	[GCC_UNIPHY0_SOFT_RESET] = { 0x56004, 0 },
> +	[GCC_PPE_FULL_RESET] = { .reg = 0x68014, .bitmask = 0xf0000 },
GENMASK / GENMASK|GENMASK / GENMASK|BIT?

Konrad
> +	[GCC_UNIPHY0_SOFT_RESET] = { .reg = 0x56004, .bitmask = 0x3ff2 },
>  	[GCC_UNIPHY0_XPCS_RESET] = { 0x56004, 2 },
> -	[GCC_UNIPHY1_SOFT_RESET] = { 0x56104, 0 },
> +	[GCC_UNIPHY1_SOFT_RESET] = { .reg = 0x56104, .bitmask = 0x32 },
>  	[GCC_UNIPHY1_XPCS_RESET] = { 0x56104, 2 },
> -	[GCC_EDMA_HW_RESET] = { 0x68014, 0 },
> -	[GCC_NSSPORT1_RESET] = { 0x68014, 0 },
> -	[GCC_NSSPORT2_RESET] = { 0x68014, 0 },
> -	[GCC_NSSPORT3_RESET] = { 0x68014, 0 },
> -	[GCC_NSSPORT4_RESET] = { 0x68014, 0 },
> -	[GCC_NSSPORT5_RESET] = { 0x68014, 0 },
> -	[GCC_UNIPHY0_PORT1_ARES] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT2_ARES] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT3_ARES] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT4_ARES] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT5_ARES] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT_4_5_RESET] = { 0x56004, 0 },
> -	[GCC_UNIPHY0_PORT_4_RESET] = { 0x56004, 0 },
> +	[GCC_EDMA_HW_RESET] = { .reg = 0x68014, .bitmask = 0x300000 },
> +	[GCC_NSSPORT1_RESET] = { .reg = 0x68014, .bitmask = 0x1000003 },
> +	[GCC_NSSPORT2_RESET] = { .reg = 0x68014, .bitmask = 0x200000c },
> +	[GCC_NSSPORT3_RESET] = { .reg = 0x68014, .bitmask = 0x4000030 },
> +	[GCC_NSSPORT4_RESET] = { .reg = 0x68014, .bitmask = 0x8000300 },
> +	[GCC_NSSPORT5_RESET] = { .reg = 0x68014, .bitmask = 0x10000c00 },
> +	[GCC_UNIPHY0_PORT1_ARES] = { .reg = 0x56004, .bitmask = 0x30 },
> +	[GCC_UNIPHY0_PORT2_ARES] = { .reg = 0x56004, .bitmask = 0xc0 },
> +	[GCC_UNIPHY0_PORT3_ARES] = { .reg = 0x56004, .bitmask = 0x300 },
> +	[GCC_UNIPHY0_PORT4_ARES] = { .reg = 0x56004, .bitmask = 0xc00 },
> +	[GCC_UNIPHY0_PORT5_ARES] = { .reg = 0x56004, .bitmask = 0x3000 },
> +	[GCC_UNIPHY0_PORT_4_5_RESET] = { .reg = 0x56004, .bitmask = 0x3c02 },
> +	[GCC_UNIPHY0_PORT_4_RESET] = { .reg = 0x56004, .bitmask = 0xc02 },
>  	[GCC_LPASS_BCR] = {0x1F000, 0},
>  	[GCC_UBI32_TBU_BCR] = {0x65000, 0},
>  	[GCC_LPASS_TBU_BCR] = {0x6C000, 0},
