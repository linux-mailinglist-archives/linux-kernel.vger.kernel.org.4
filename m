Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C06864E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBALBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBALBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:01:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089429ECB;
        Wed,  1 Feb 2023 03:01:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mc11so27747120ejb.10;
        Wed, 01 Feb 2023 03:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ykUZcZURVXB/3zMYBdPYuNhDjgfUm115ZWrfevf/KU=;
        b=HCTpoDckU4A8dRNfpWfoQIuZW+ALGjdLX4rU7prLxk6M01ZWYWpVcRilDN5mxIrsi+
         UArefBzqsRd/Rd19nl46gU+sPXgTtURPMveAXUFse1PUcX/XlFGUq0MjB6hwKZnazc4m
         T2k0IwphBobMhA+Nhul1nPnj5SVF9I+vQTqJpHUjylI7EJDn8sJ45Vqd9tXAsOmBZtUn
         OfoDtfwJWQY6Ko+ShNP5W6zrPfNqPyDyPcIxod/OaMJf5TK4aniuPBPfKaFROfgn+xmm
         ttzpEF7kxi2lSnDneLu4w7ze1uPKvDzKrKAFSJHZ9Z/mWGCqv7oZ3gYfLCX4JybFY5CN
         gyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ykUZcZURVXB/3zMYBdPYuNhDjgfUm115ZWrfevf/KU=;
        b=j8QZT+QAaELEQyjzSumAe8bLqzX8ayAgdjjvRtq/0A+c9Hp24g87WpNREmEf+N+PO9
         NTp426bYgT9EUYPmOKBRdJ7H/q+Sv4UUhnwdUiVOL1Y97sOdJWyGRbcw1m0iHDFQ9waY
         tbU+wa/taN0wDesRKjA7murjqnr9uvqeVuYKsmNm+YDiISfCNRWQFOEWkE8pWqIG3w2d
         vIqJi7bCHgQIoMPchTw5xZF1JaaFGNCMz2nGg4xUqmgrs1BnV6AH4o6nIbhzwHuhC6PS
         AhEX5NzeplQv/jkz5LpLUu1i34fYcPWuAvCFg68Dhx1n+U6pCjergzXAvvBDkdgJ1BBr
         gwRg==
X-Gm-Message-State: AO0yUKVxsiJFLm+SQarytIT+75MX4feBjgol82r8zDwreOrHCXLXhmRM
        5Ig2M7wWV6lO+k9LiL0lCD8=
X-Google-Smtp-Source: AK7set8htpLs17WtIha84GzJupQJaOVpvGk9F3VBPJU5BKY5qKjlqWwbP16VDKuDRQISkFpOpNTV+w==
X-Received: by 2002:a17:906:6a24:b0:888:d373:214d with SMTP id qw36-20020a1709066a2400b00888d373214dmr2528655ejc.29.1675249269292;
        Wed, 01 Feb 2023 03:01:09 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id g9-20020a170906394900b00872a726783dsm9811108eje.217.2023.02.01.03.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:01:08 -0800 (PST)
Message-ID: <618392ed-7d20-a49f-1ec5-b27850d71dec@gmail.com>
Date:   Wed, 1 Feb 2023 12:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
 <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.02.2023 11:46, Michael Walle wrote:
>> Before I convert brcm,nvram to NVMEM layout I need some binding & driver
>> providing MMIO device access. How to handle that?
> 
> I'm not arguing against having the mmio nvmem driver. But I don't
> think we should sacrifice possible write access with other drivers. And
> I presume write access won't be possible with your generic driver as it
> probably isn't just a memcpy_toio().
> 
> It is a great fallback for some nvmem peripherals which just maps a
> memory region, but doesn't replace a proper driver for an nvmem device.

OK, then maybe I'll retry again with generic MMIO and without converting
existing specific drivers. That is what (AFAIU) Rob asked though.


> What bothers me the most isn't the driver change. The driver can be
> resurrected once someone will do proper write access, but the generic
> "mediatek,efuse" compatible together with the comment above the older
> compatible string. These imply that you should use "mediatek,efuse",
> but we don't know if all mediatek efuse peripherals will be the
> same - esp. for writing which is usually more complex than the reading.

mediatek,efuse was already there, don't blame me for it ;)


> nitpick btw: why not "nvmem-mmio"?

Because I read from left to right ;)
It's MMIO based NVMEM. Not MMIO on top of NVMEM.

Sure, we have "nvmem-cells" but that is because those are cells of NVMEM
device.

Unless my English knowledge fails me.


> So it's either:
>   (1) compatible = "mediatek,mt8173-efuse"
>   (2) compatible = "mediatek,mt8173-efuse", "mmio-nvmem"
> 
> (1) will be supported any anyway for older dts and you need to add
> the specific compatibles to the nvmem-mmio driver - or keep the
> driver as is.
> 
> With (2) you wouldn't need to do that and the kernel can load the
> proper driver if available or fall back to the nvmem-mmio one. I'd
> even make that one "default y" so it will be available on future
> kernels and boards can already make use of the nvmem device even
> if there is no proper driver for them.
> 
> I'd prefer (2). Dunno what the dt maintainers agree.

(2) looks OK, Rob, Krzysztof?
