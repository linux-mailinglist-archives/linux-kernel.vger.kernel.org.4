Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACA6AB270
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCEVSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCEVSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:18:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E35BA6;
        Sun,  5 Mar 2023 13:18:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ay14so27218600edb.11;
        Sun, 05 Mar 2023 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+UGEp44lDSINJyqpqG71JeEypCQNtRsdKYQXFnqkL4=;
        b=lT9xwEkq7iQhGBCipX/lvCbHUENMLgsOjiyL/an1A4GLGir8G6m2//UlA4bkrY3iNj
         tcTSeX/ReDeGWSmFyE5TJwqVHYtwdSoEE5X4Svf02LVmQkbeyWrPodJW8qoKWedeZoAi
         31ygT0AVQHcbzVRYOIh4J69GVpu7H+S1mKXCgV1ma6cfWkhNCqBLLU//KvS12ruxZd2u
         tuGCycrhZJ0LV/s2mgX+1vGGRIUeQvf5kXd+CGQ2eQFfRH0GfJHHGgfht5RXe0tJaaDQ
         0sR+ZB0wYLZJpXUp1xKhwiI+4bz4ydE8LVIMtzFdogXaO9EE4tyT0DV2m1Gja7Tk8utX
         qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+UGEp44lDSINJyqpqG71JeEypCQNtRsdKYQXFnqkL4=;
        b=tF9YVEMuGu2Tt+KJ8DhuQ4gzIQ3vStuv0+X9zRxGzAMZCCLjHvhBSsFkzuSZoye01k
         a3fc/2Q7iirJ3J5vNAf57xq3H8Aq7KWK32P9HvGvjokfUXkso2+4mWAdpUzV0+NhWLJa
         3Fqa7dLgFwWh4p3jYBoQIZvbjSOwD292LYY5XrHPWXpgLPXI9Y4VBZSexuwggZxdNAU4
         AWAHYJHxqXP0QACfFa4TCVZvFJsCz5V86+TXVQgu/99ggR94whsH1B2jT1LoNNNSNiRf
         AT1/a9EFWNGG5N/Gyjk4W61BCjRXQtm6hiiz/2b+XgMvYrxze5xdAP7gyFcyY4+YSXaQ
         6sbA==
X-Gm-Message-State: AO0yUKUsZQcKtBs2kUJq5N0rtwvBRAdbtPD3fN24kPnHH1aSlltoWl09
        e+DqagurCobGBsA8GUEXaSH4ArGe3FlqJ9ppascJIrgc5jw=
X-Google-Smtp-Source: AK7set/w0HYMJbBg6VqQIu9Z0GHYir9TOzo2E0vsBl63rRk3GEnb3MYHjR6P355iGs5o3x5CBmdCAOkEWUNluVgG+h4=
X-Received: by 2002:a50:ce19:0:b0:4bc:2776:5b61 with SMTP id
 y25-20020a50ce19000000b004bc27765b61mr4642074edi.6.1678051114973; Sun, 05 Mar
 2023 13:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20230305134512.1596572-1-christianshewitt@gmail.com> <20230305134512.1596572-3-christianshewitt@gmail.com>
In-Reply-To: <20230305134512.1596572-3-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Mar 2023 22:18:24 +0100
Message-ID: <CAFBinCBUYoCSvfnqZSiUR6roEyNqgsfEnU6pvVCVgGrFtbEXmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add support for BananaPi M2S variants
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sun, Mar 5, 2023 at 2:45=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> BananaPi M2S ships in Amlogic S922X and A311D variants with the
> following common specifications:
>
> - 16GB eMMC
> - HDMI 2.1a video
> - 2x 10/100/1000 Base-T Ethernet (1x RTL8211F, 1x RTL811H)
> - 2x USB 2.0 ports
> - 2x Status LED's (green/blue)
> - 1x Power/Reset button
> - 1x micro SD card slot
> - 40-pin GPIO header
> - PWM fan header
> - UART header
>
> The S992X variant has:
> - 2GB LPDDR4 RAM
>
> The A311D variant has:
>
> - 4GB LPDDR4 RAM
> - NPU (5.0 TOPS)
> - MIPI DSI header
> - MIPI CSI header
>
> An optional RTL8822CS SDIO WiFi/BT mezzanine is available for
> both board variants.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
