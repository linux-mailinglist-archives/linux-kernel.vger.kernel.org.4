Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC62721E74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjFEGnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjFEGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:43:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2CE66
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:43:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-97000a039b2so712166566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685947405; x=1688539405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uw934CvNepJzyaQQUV31TxbXFbtnqLugvutH4AccEcs=;
        b=C7MPx2JRwVd1TLHaSaegjE/x0aHabVAcj4AfLdl1uPogVTjWmjrm5JgVDsmb8Jv6+G
         lD4mgcLc9zSYKqw7y3QUkQOkeID0pomCw5pteniMt5ltImNIhbxfuK/jPDopO3jDPodr
         4dIF4ysieJewoJkSMHGN++J4sRbE33hRvCsoQra/lezrXaovAdbix1NMwkodXTb95OV2
         8WtdelzV0uZxVHChiPRNirjygvHToX1LRNHtj2yIhAJhSY7BllYpYb7ssOo9jhMachYN
         Fk5lCTgbWvzlPCEJjhVkRBscV7Gds8MwE/NG6S6F8VU7J8o+ToleRn2Ae56GkZEy/oqR
         Yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685947405; x=1688539405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw934CvNepJzyaQQUV31TxbXFbtnqLugvutH4AccEcs=;
        b=Egl4S8uvOnCUDzyQ7bwDgtNf/tPI9u/qKSD5MCFKMi6dQcITzTqV3H4r8pH3Iv6IkX
         Zw2HiIvPNz7ovOd3EOBYKtAxrOjADAe2mDvrj7hXcDraomrv3GSH6YkWtcqJoB6ZeBy8
         Tj2yXTambKN/ov5E03ImVzbur/mYQtzmr09UtRKOVPBWcvSASNTn3S++8Equx8sZdPld
         le3ShtrZKBwzMBwz8LYn2Nav/71Cc3egraGlhkbBX3P+OiTRArGmTBKKbiMRRhbwxq7P
         /ZrjwYHpGrJDYgIj/4wgeKa4UeB2fll81VHkJK8niC44+LFY4wOL61V/MHNn6Bcr68Ay
         w1hw==
X-Gm-Message-State: AC+VfDyzv9HSs/LLJjKKfe0ADX47xlBgaLLhziNXbBMunOOO5IZostjv
        Qdz0JQKQI9kET2JXHGK6bq7a0w==
X-Google-Smtp-Source: ACHHUZ6uVGxy9xFnG9Y9A3SHNYvD3NcLQFCgeDBBJmRjdb3lXsh4QvFCpVy68MhjoZMM0vV+dWuDgg==
X-Received: by 2002:a17:906:9b88:b0:973:91f7:5092 with SMTP id dd8-20020a1709069b8800b0097391f75092mr7422310ejc.2.1685947405338;
        Sun, 04 Jun 2023 23:43:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o22-20020a1709061b1600b00977c50476f7sm2602597ejg.44.2023.06.04.23.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:43:24 -0700 (PDT)
Message-ID: <2a538004-351f-487a-361c-df723d186c27@linaro.org>
Date:   Mon, 5 Jun 2023 08:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 17/21] power: reset: at91-poweroff: lookup for proper pmc
 dt node for sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-18-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230603200243.243878-18-varshini.rajendran@microchip.com>
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

On 03/06/2023 22:02, Varshini Rajendran wrote:
> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index d8ecffe72f16..d0f29b99f25e 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
>  	{ .compatible = "atmel,sama5d2-pmc" },
>  	{ .compatible = "microchip,sam9x60-pmc" },
>  	{ .compatible = "microchip,sama7g5-pmc" },
> +	{ .compatible = "microchip,sam9x7-pmc" },

Why do you need new entry if these are compatible?

Best regards,
Krzysztof

