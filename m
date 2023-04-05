Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9F6D7266
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjDECYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDECYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:24:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089E1FDC;
        Tue,  4 Apr 2023 19:24:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c18so33085061ple.11;
        Tue, 04 Apr 2023 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680661480;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QNbM9lP47YBzDxJmWKWYEJzZC9ZIOjbZpNDsjzB1/E=;
        b=Xihw6CgZ9/9usz7a8VJsWY8rfqP+LOYjs7G3CCcJY+RprHUpGDw82g//kV+M/lN2eN
         MCKYQ+HhvY5W1cSsIACkXEtTwItPP3atD7PSnn6CY3edFU7fRlyEpyLbrZYs5XvWXdKy
         t9elDA+lhxpC06IPynnlGlvRp14mdfczCSvYnTbh9qn3oESdwAnGclujGnTFKq1PvYHe
         UNDDXArlN2SssUcwAIha7XxGo6wmqlEvq3mMQaulR81DCsd7RPPSH6PKtAexQR7gj6dj
         3c+zp0QURkwJcGXiXIAuMESlFidSs+6E6PbTvTKTDji9VpvU3LDj2Ttziz8wU064/qwl
         Zonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680661480;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QNbM9lP47YBzDxJmWKWYEJzZC9ZIOjbZpNDsjzB1/E=;
        b=4lHcdDcU+kVkqi3c8yjTzXgbF5KWrrxDG0ZvG+z7Yqq2/nUytX09hE3RcbBmOk1mon
         mGliFZIbRvM1ifPWww13EcQslHE/dsMtxDlExyOKiQ/N7XtBCDKGB83K9RTJfOZWHmbX
         BSCJKvTFJ6sdNpsTs0qAOE7s//aAoO7ocQ9qB4GA7gXmnngrIJpEorDv5TRkXyNCXxMS
         tcJzD0vl5vChBEmNGiuMxHXGgxWau2fIQZOY6JAuE13nFzF4jTwX625OhEF3DYH7wAG9
         j/sUPbzHv4zCAYbS+v0aX20AfzjK57XirEXRyA3Hu32vsGuLzofrcDOtlsOJ4i8+KIUV
         dk7g==
X-Gm-Message-State: AAQBX9dXt7pAKbxR00URXFVSrumboZk0+ORyaV5FpjFsNz52ZfXm3oUB
        k+/PilDtGY8k9qU/cACcYDg=
X-Google-Smtp-Source: AKy350YC3ggg9qLvnDzmFothcUSjAQpi7xNqcwvsbbun0pCTYz8A4L5T/wFudH3EGQ7zlYXf1Kpd3g==
X-Received: by 2002:a05:6a20:659c:b0:da:c40:8dc with SMTP id p28-20020a056a20659c00b000da0c4008dcmr4172153pzh.6.1680661479619;
        Tue, 04 Apr 2023 19:24:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id x9-20020aa793a9000000b005898fcb7c1bsm9679454pff.177.2023.04.04.19.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 19:24:39 -0700 (PDT)
Message-ID: <364610b8-2c40-6a71-513e-4e154b077055@gmail.com>
Date:   Wed, 5 Apr 2023 09:24:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 06/10] hte: Re-phrase tegra API document
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-7-dipenp@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230323012929.10815-7-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 08:29, Dipen Patel wrote:
> Make Tegra194 API document generic to make it applicable for
> current and future tegra hte providers.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  Documentation/driver-api/hte/tegra194-hte.rst | 33 +++++++++----------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 

While generalizing the doc, the doc file name should also be renamed
(i.e. to tegra-hte.rst).

> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
> index f2d617265546..85e654772782 100644
> --- a/Documentation/driver-api/hte/tegra194-hte.rst
> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> @@ -5,25 +5,25 @@ HTE Kernel provider driver
>  
>  Description
>  -----------
> -The Nvidia tegra194 HTE provider driver implements two GTE
> -(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
> -(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
> -timestamp from the system counter TSC which has 31.25MHz clock rate, and the
> -driver converts clock tick rate to nanoseconds before storing it as timestamp
> -value.
> +The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
> +driver implements two GTE instances: 1) GPIO GTE and 2) LIC
> +(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
> +from the system counter TSC which has 31.25MHz clock rate, and the driver
> +converts clock tick rate to nanoseconds before storing it as timestamp value.
>  
>  GPIO GTE
>  --------
>  
>  This GTE instance timestamps GPIO in real time. For that to happen GPIO
> -needs to be configured as input. The always on (AON) GPIO controller instance
> -supports timestamping GPIOs in real time and it has 39 GPIO lines. The GPIO GTE
> -and AON GPIO controller are tightly coupled as it requires very specific bits
> -to be set in GPIO config register before GPIO GTE can be used, for that GPIOLIB
> -adds two optional APIs as below. The GPIO GTE code supports both kernel
> -and userspace consumers. The kernel space consumers can directly talk to HTE
> -subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
> -framework to HTE subsystem.
> +needs to be configured as input. Only the always on (AON) GPIO controller
> +instance supports timestamping GPIOs in real time as it is tightly coupled with
> +the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
> +below. The GPIO GTE code supports both kernel and userspace consumers. The
> +kernel space consumers can directly talk to HTE subsystem while userspace
> +consumers timestamp requests go through GPIOLIB CDEV framework to HTE
> +subsystem. The hte devicetree binding described at
> +``Documentation/devicetree/bindings/timestamp`` provides an example of how a
> +consumer can request an GPIO line.
>  
>  See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
>  
> @@ -34,9 +34,8 @@ returns the timestamp in nanoseconds.
>  LIC (Legacy Interrupt Controller) IRQ GTE
>  -----------------------------------------
>  
> -This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
> -lines which this instance can add timestamps to in real time. The hte
> -devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
> +This GTE instance timestamps LIC IRQ lines in real time. The hte devicetree
> +binding described at ``Documentation/devicetree/bindings/timestamp``
>  provides an example of how a consumer can request an IRQ line. Since it is a
>  one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
>  number that they are interested in. There is no userspace consumer support for

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

