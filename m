Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06E5EBD49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiI0Ia3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiI0IaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:30:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E2357E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:30:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a1c440a000000b003b494ffc00bso822524wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=dbuQOe3pFZvmT6+HOPkDlXjOm8BeB2xsU1eHBI9Ld4g=;
        b=xNpdmvdRiP0RtD/67ppEEA9lEnlpKlwNwlNmbN53x6nSe0K3L2VOQuO2LIqJiaEdIY
         eWBZ+38MHIXV+6QJQXnqc1m23qxXlLss4pysqhxb7LhzKJLi9BjXeT1sZPyx7tTSLhr5
         cZqjqAcSPlHeLcXfX3USZn3BqeNvzagI7B4dsAjc4aAYxuDxsUkGlFmJi+PyI7TdhuWn
         ICRKmrAOHsj4i55jA6LQ1SeaGiaFMi28h1KqF+mqmquKFYW7m4TFA/jL/amzaNqp+NEp
         F4H0DSrVPy8U2iDHEmq8+iIUEsTmS/Fl6H961VvLoD9zEWDo41s4sOg0u9RqKGqvKFBv
         JM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dbuQOe3pFZvmT6+HOPkDlXjOm8BeB2xsU1eHBI9Ld4g=;
        b=Wln/IEmoJV3Z+3y7Ld5S+o1NnQm06zPDs9OrmJo7rV3XJmm+XYU0HQ7HgaRRD4cZ/V
         04vwOyzIaJbJrVVeHvyPL9LdVDNxOX2XYThoO6m69EPI4c6FVlHda8aBzg+WLOJVsO5O
         6wBvvKHUoxRTA0CVxMU+T4r2SxomuNcMHt7SZldfibT4pCS/kQbuaQJDVI+s4fS2ZjSV
         LBPsUvu+TfhBEBG7xr5XU5a4nJR++hJU9+mfeeuo9WCvHnrl833O6ws1Orga4oxwI5vr
         YA/IC1q0Es+7ubJzBi7RCx345i18V0nNtGg6IwnIP45UBovBViiWdTizGDUk9kJKXdSP
         JPtA==
X-Gm-Message-State: ACrzQf3Zxng12Z5y2Gr/anjPB943egTJ1U6BTp2uzbog/h/bCwQVxBpN
        qOaXiCaXWz+ViMl/etgQtd6SFw==
X-Google-Smtp-Source: AMsMyM5RGTznKVMVuAGcUTRiYQAR8un7aByG5CUNLtCf41KydJUjFyeUP4h8pc+wje1HYy6CFe/GMQ==
X-Received: by 2002:a05:600c:211a:b0:3b4:75ee:c63e with SMTP id u26-20020a05600c211a00b003b475eec63emr1786727wml.44.1664267407748;
        Tue, 27 Sep 2022 01:30:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b771:c77b:f889:9833? ([2a01:e0a:982:cbb0:b771:c77b:f889:9833])
        by smtp.gmail.com with ESMTPSA id p14-20020adfce0e000000b0022af6c93340sm1199236wrn.17.2022.09.27.01.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:30:06 -0700 (PDT)
Message-ID: <09081275-be9c-9d0c-856b-ed2df8fc0b13@linaro.org>
Date:   Tue, 27 Sep 2022 10:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK
 line when idle
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com
References: <20220809172017.215412-1-aouledameur@baylibre.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220809172017.215412-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On 09/08/2022 19:20, Amjad Ouled-Ameur wrote:
> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
> signal from the SPICC controller it's not an issue because when the
> transaction resumes all pins come back to the right state at the same time
> as SS.
> 
> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
> state change and SPI pins state change from idle, you can have a missing or
> spurious clock transition.
> 
> Set a bias on the clock depending on the clock polarity requested before CS
> goes active, by passing a special "idle-low" and "idle-high" pinctrl state
> and setting the right state at a start of a message.
> 
> Amjad Ouled-Ameur (2):
>    spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI
>      signal states
>    spi: meson-spicc: Use pinctrl to drive CLK line when idle
> 
>   .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 15 +++++++
>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 14 +++++++
>   drivers/spi/spi-meson-spicc.c                 | 39 ++++++++++++++++++-
>   3 files changed, 67 insertions(+), 1 deletion(-)
> 

Will you send a v2 with comments adresses ?
