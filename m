Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C547611E49
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJ1XtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJ1XtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:49:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C82475CC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:49:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b25so4500608qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BWT12cmS3hZogCGoRQZdPiSUfY711/3MhZolzbjO68=;
        b=lNRM++TEsOOQdoJkPPi2j3oCwZ9MgoABUmqx/DlBsZEE5TBaGJ/iUNlnKTFD9+wUpo
         fWaA7zH19/CcjOcWPUdHi+VUe9Ws1PP+Xb/MGBi0wZXV9L702eSZ5QXub6eRLKqv2p8j
         mUWHgbktkLvNPkwi9lUCdJQg74YF48tLUF1AiSGXy2wglL7mETxiWkpPKzgh19rWNfN3
         bCtvv4LfwMNx+WI+8o6v7YVoA9e4aTXVairb4A4AWxmbjYCCzCungBVsjx2MkU3Ah65K
         2FeQ+N6XN0xabbZU/awhiFqNFlWXzeo/MM/wVGO1S+IrtkIqIWqOe66sR/uQbW21vWL/
         jqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BWT12cmS3hZogCGoRQZdPiSUfY711/3MhZolzbjO68=;
        b=qFCBWNwXDCnGIBsb68P7csImyd3LBWIo2pVEY+Xzzlszp0YIZf5mNPVBGcTnSATvA9
         rBUpguRpkPDSaGH+00fdg/uJuTUmtBTnGPIrEKZ3aBRwo8gv3GR9lLp9nDo5aPknDogf
         ab84HjYOO5u/ePDOLqdeBS2NvpmL65IoMozaedYBX7afKUpXARQh1hVB+Ga3BjH0/Lis
         aQwoRj0aunz5DxJttexM1pjsSabv4TMHrwRhc+4LE6Y5zNAX4kjJQrVT7RAe48o0sgqF
         3iuw2pA8iwXvuP/cRSq1UPC63BnsRm43UJEt7D69FRp8DyTB7rkVT9PAB7cMHYDyjv4W
         FNXw==
X-Gm-Message-State: ACrzQf2FRu5v+TJ89jdrt2+uUFjQ9iyAGktD6xgsb39q0BJiYU81+Clp
        fxt93Ld92nKxdAPFjlfU1HfBAg==
X-Google-Smtp-Source: AMsMyM7R4pV35Ac0Ut6hmcynP9u2Swne9bQcW3gcQ8DsD39A/z8fNafRdy0YOTjAOD/DwE5dqG6JeQ==
X-Received: by 2002:a05:620a:d94:b0:6bc:5a8c:3168 with SMTP id q20-20020a05620a0d9400b006bc5a8c3168mr1451802qkl.56.1667000949580;
        Fri, 28 Oct 2022 16:49:09 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bs11-20020ac86f0b000000b0039cc82a319asm8100qtb.76.2022.10.28.16.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 16:49:09 -0700 (PDT)
Message-ID: <360e6322-e5c1-b698-22d7-d7c8c5be368a@linaro.org>
Date:   Fri, 28 Oct 2022 19:49:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Microchip MCP795xx RTC driver patch
Content-Language: en-US
To:     tollsimy <simonetollardo@gmail.com>, a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016162913.38661-1-simonetollardo@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016162913.38661-1-simonetollardo@gmail.com>
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

On 16/10/2022 12:29, tollsimy wrote:
> RTC Microchip mcp795 patch for 5.19-rc5
> 
> Here is the mcp795 patch for the 5.19-rc5 merge window.
> The main modification are the following:
>         - fixed wrong driver naming: RTC is a Microchip
>           mcp795 and not Maxim mcp795
>         - added date/time write sequences: added date/time      
>           write sequences accordingly to official silicon 
>           errata document to fix silicon bugs.
>         - added support to date/time permanent storage:
>           the driver was missing some register bits in order
>           to enable the storage of date/time whenever the       
>           device looses main power.
>         - added a check after starting oscillator in order
>           to be sure that it is properly working as specified
>           in the datasheet
>         - renamed OSCON bit to OSCRUN as in the datasheet
>         - add debug messages when setting and reading the
>           alarm
>         - removed wrong offset when retrieving the current
>           year from the device
> 
> The patch has been successfully tested in the latest
> linux-next releases, and the original problems that I found have
> all been resolved.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed several people so it seems you did not follow the process.

> 
> Signed-off-by: tollsimy <simonetollardo@gmail.com>

Full name is needed.

> 
> ---
>  .../devicetree/bindings/rtc/maxim,mcp795.txt  |  11 -
>  .../bindings/rtc/microchip,mcp795.txt         |  11 +

Bindings are always separate patch.

>  drivers/rtc/rtc-mcp795.c                      | 359 ++++++++++++++----
>  3 files changed, 296 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mcp795.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> deleted file mode 100644
> index a59fdd8c236d..000000000000
> --- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -* Maxim MCP795		SPI Serial Real-Time Clock
> -
> -Required properties:
> -- compatible: Should contain "maxim,mcp795".
> -- reg: SPI address for chip
> -
> -Example:
> -	mcp795: rtc@0 {
> -		compatible = "maxim,mcp795";
> -		reg = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt b/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt
> new file mode 100644
> index 000000000000..854364c3a173
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/microchip,mcp795.txt
> @@ -0,0 +1,11 @@
> +* Microchip MCP795		SPI Serial Real-Time Clock
> +
> +Required properties:
> +- compatible: Should contain "microchip,mcp795".
> +- reg: SPI address for chip
> +
> +Example:
> +	mcp795: rtc@0 {
> +		compatible = "microchip,mcp795";
> +		reg = <0>;
> +	};

This part is not erally explained/justified.

Best regards,
Krzysztof

