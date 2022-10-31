Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199E613FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJaVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJaVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:19:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B461161;
        Mon, 31 Oct 2022 14:19:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k2so32664956ejr.2;
        Mon, 31 Oct 2022 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qWsb0SGi8QeQtOKhb0/4kvJ5Eb+D2s5VKybi0N7j1Y=;
        b=AzZULfLPBMcm+DUmjgEYV107VADO9otzoaT9RLKeDX8V2ypcVjCMMxR1ZfS339jhbz
         xnA3jaA3aIv/uzdt0kbteLtMmNzUos7Z9ZY4vmerRpOKEPe+u7e33u1bN3MRQT5LLI4p
         dtq1ToR3KPduVwJjwTukPWqEywH7+NA6wJN1a22IdXuJOKi6clXO8Zy1dMzy7mGZd1b9
         koT+JXMa9w13JgOsvT0XSCo+m9lJ6oCh9S7cqKa1D45GcLy4jqPykMqyzyRHqThojUdE
         yZyzJkFRjr4FnWPe6x6oIRtNChO8SK5z74xhMZ+dMWIhL8OnY/hKdq6lBJimYNiFRO/g
         0KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qWsb0SGi8QeQtOKhb0/4kvJ5Eb+D2s5VKybi0N7j1Y=;
        b=bX47nELsX7P7ZiW/1UUI8ssXKBLJ5mVGYTRBqMWN7HSQ5LQwmsNEUlXEW/CO5V5NbT
         9BDPZHOs+z/W/xFYcnAhxtcd6LRjyCPOiLeTTAgGFqnq9PMdhIrQh5p76q2G47bZLq+f
         gjw1zANblqph+dmWgbaiMBJ/OGbQUBL9+bk9fhY3g5IbY/5qMippQeNqGBM7e5kq3KC6
         zGfKOfY3TC8r85Fvoy04n3gFJLoFMc58CUNru/QbfrbTMOKkM0nGOV8cG+DhO4vW/3fT
         cdOHGd/44GHOFC9zKXCktbn9sW1zIrbGSXYbi2B5zwnnjyH2/uAIS4ONwfAGeQNiO+rk
         8vrQ==
X-Gm-Message-State: ACrzQf0uuydBFVOomifL/vxM9PHLFH6mh8NuvSUTu64hAqst8RF0STLS
        X2oZgMCaSQQtb4BCrII2AKG8CM47oaH7syiDrZg=
X-Google-Smtp-Source: AMsMyM793wQb5dTAUE/EmKc++FETmfnoTczV6euc1hrr77pY+81h0cawpbby2zZhteI7qZWz0A+LqmZypQ+fPno4seo=
X-Received: by 2002:a17:906:7314:b0:791:a45a:bc84 with SMTP id
 di20-20020a170906731400b00791a45abc84mr14859875ejc.394.1667251149204; Mon, 31
 Oct 2022 14:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org> <20221031-b4-odroid-go-ultra-initial-v1-3-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-3-42e3dbea86d5@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 31 Oct 2022 22:18:58 +0100
Message-ID: <CAFBinCAuiGtigKwzJ1WUgs5bbwf-y1fvVFq79wZA-E1e6tMXtw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: amlogic: document Odroid Go Ultra compatible
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 5:47 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> This documents the Odroid Go Ultra, a portable gaming device,
> with the following characteristics:
> - Amlogic S922X SoC
> - RK817 & RK818 PMICs
> - 2GiB LPDDR4
> - On board 16GiB eMMC
> - Micro SD Card slot
> - 5inch 854=C3=97480 MIPI-DSI TFT LCD
> - Earphone stereo jack, 0.5Watt 8=CE=A9 Mono speaker
> - Li-Polymer 3.7V/4000mAh Battery
> - USB-A 2.0 Host Connector
> - x16 GPIO Input Buttons
> - 2x ADC Analog Joysticks
> - USB-C Port for USB2 Device and Charging
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
