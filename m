Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BF736AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFTLZM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFTLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:25:10 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B7CF;
        Tue, 20 Jun 2023 04:25:09 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57028539aadso52160407b3.2;
        Tue, 20 Jun 2023 04:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260308; x=1689852308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyZC6CHxxs4kO9Cxfd3i2rfWTchHKU3nAYuKkt1T5XY=;
        b=iIBOi/r3JIB5QzEe23cF/zMX2xL6JsYGNBMnc4H/v4Z/Ry8Q6WAuPXy5A4DBP3AYxo
         pOCC11quZkpKWG3kx3iVErMXXVV86x3Pg8EXp0QdMellwQkD6TUdEaWLg5R93COORJpu
         byHLJ8LO0ZFcql7w+si87Km6Gq/gTctiLmZv+4Gmvnw5isayH2qkmULztPzJNLqyI1ku
         ocd1I38Ew2953efoWuYdpCvbdeg2p7ze5azda0p8Y9qfagIMYOMAaOi2yKpY859uPf3h
         S5epZBp6kAL427zWYyezNahR4JGLxoOiIRXLuiWbkRbSJp1P6lEyXu3pv+H5qQMOcCBT
         TxNw==
X-Gm-Message-State: AC+VfDxhsUtXGoD2MbrrTZcDvGq70uUjzvTa0BzMUFxvm4uYz6C0MPFM
        nhSdyXSvwCgL18UExxeCo9uOcpI0H9zIpA==
X-Google-Smtp-Source: ACHHUZ6ttl7Sozhi+OBRKFkuZ1Xahxqz0OOHSwzerXeVacBdbq+KcFIJr8WeRbhqamDIkF4ktBwlng==
X-Received: by 2002:a81:91c1:0:b0:55a:6430:e8fb with SMTP id i184-20020a8191c1000000b0055a6430e8fbmr14003229ywg.8.1687260308486;
        Tue, 20 Jun 2023 04:25:08 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id a133-20020a81668b000000b00569ff2d94f6sm450431ywc.19.2023.06.20.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 04:25:05 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso4850768276.3;
        Tue, 20 Jun 2023 04:25:05 -0700 (PDT)
X-Received: by 2002:a25:ab89:0:b0:ba8:7015:36df with SMTP id
 v9-20020a25ab89000000b00ba8701536dfmr10319681ybi.26.1687260304774; Tue, 20
 Jun 2023 04:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230620103909.37582-1-wsa+renesas@sang-engineering.com> <20230620103909.37582-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230620103909.37582-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jun 2023 13:24:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqVt_ciio+g@mail.gmail.com>
Message-ID: <CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqVt_ciio+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] arm64: dts: renesas: ulcb-kf: add node for GPS
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Jun 20, 2023 at 12:39 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Wolfram Sang <wsa@kernel.org>
>
> Add the node for the GPS receiver and its VCC supply.
>
> Signed-off-by: Wolfram Sang <wsa@kernel.org>
> ---
> Changes since RFC v1:
> * rebased because of patches dropped and refactored
> * added static vcc-suplly

Thanks for the update!

> @Geert: Not sure if we need so many fixed 3v3 regulators. Most of the
> other ones more or less directly derive from d_3v3. Or do you prefer it
> this way?

Probably all of them should refer to &reg_3p3v instead...

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -39,6 +39,13 @@ accel_3v3: regulator-acc-3v3 {
>                 regulator-max-microvolt = <3300000>;
>         };
>
> +       d_3v3: regulator-d-3v3 {

... but if you want to keep it like this for now, please name
it appropriately (s/d/gnss/g).

> +               compatible = "regulator-fixed";
> +               regulator-name = "d-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
>         hdmi_1v8: regulator-hdmi-1v8 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "hdmi-1v8";

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
