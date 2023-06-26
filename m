Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFF73E372
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFZPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFZPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:35:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08388F3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:35:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313f3cd6bb4so858125f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793699; x=1690385699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyXF+o9wj/oq2REDkSaZZ6G7zdUVUsRy4dXWDEbehBk=;
        b=ZTfd1hsUwLmVqTbM925y9XW95cMMxMS9/Yt3r3RwEzpvz40wTPkuNAXbM7jPD7j95K
         KHjljdtVdCDEAEth1RrsZWhG9VUohTDguirwqJgMrQzf2jq6GlwW4RVwNlub/+4KxLI/
         p4fj6qOCoOYg1FwnWlMm9Co5YOrmTBl/VHwhiu9LOvswlGA8lVBU8L1Lwt/V7oagEXTG
         nfxNrnk7s7UflcPglLPNmjp/eqollpE+12cRJUzThGTXXezmpyKDhr3L9ICldQLXnyLA
         D054E+8e+x153t0fLPXqMLQP8qHZBxVJxZHmz6OMX+9ex/i9c4tplT3CpmpiZBkF/ndm
         u27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793699; x=1690385699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyXF+o9wj/oq2REDkSaZZ6G7zdUVUsRy4dXWDEbehBk=;
        b=hUFSn4R82NvVsEkINq7di/wmX2zLMtPlqZAVr9W+DE6dL8LjQqdPhvsj1TMPEt76Cs
         BLEdVYMZZ9ai4hLK3T2rIwnM6UvOm0KOCy5Wf06MmhFBpdm70Psh7Wgf86P5Q2mRywiX
         8fclsoePl+fgxaayWjXMac8FavC5AmAXHPh5pNYTfyioReePM4pSlwNYNvZ+uT0VrNOv
         zpiSFrT5V1ZU1uFnwsZfgbBWbpXpqI3K5fO5mSVzPmPuQiQ6OkuRvGRCT5g7JzXrqp5x
         maWmmcD7RbGfUOG06CbflwY64YpzvSyT8V532sXhPvpeVHX30YsSy6Sv5COSDtfCxEut
         Leow==
X-Gm-Message-State: AC+VfDyS9PWQ7BIFbwRMulopxDpyOty2/1WaS+51d+i3CD2Lg6TsNR2p
        Iuf3pwzl4qQhCXTvnjR4l436nw==
X-Google-Smtp-Source: ACHHUZ61yHu8nog+sCkK52c4zYTdKwCHOnJ1SgnrNj39cUUfGFLp8MGAJGP8r88trdeyUAaTpd5tgA==
X-Received: by 2002:adf:ea09:0:b0:313:ecaa:1e69 with SMTP id q9-20020adfea09000000b00313ecaa1e69mr2673383wrm.11.1687793699463;
        Mon, 26 Jun 2023 08:34:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b00300aee6c9cesm7718559wrs.20.2023.06.26.08.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:34:59 -0700 (PDT)
Message-ID: <006ddacd-0496-70d1-3310-99b16706de84@linaro.org>
Date:   Mon, 26 Jun 2023 17:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626110909.38718-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 13:09, Hal Feng wrote:
> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.

...

> +required:
> +  - compatible
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwmdac-dit {
> +        compatible = "starfive,jh7110-pwmdac-dit";
> +        #sound-dai-cells = <0>;

BTW, I don't see any resources here. Neither in the driver. I think you
just added this for driver, not for a real hardware.

Best regards,
Krzysztof

