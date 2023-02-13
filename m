Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09113694279
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBMKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:14:29 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829D2694
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:14:28 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-52bfa3dfd95so156224717b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m24dMml2jSsL7Dl+CG8vq6QyqBxUdcOiPSlfJt9P/gU=;
        b=dE2vgPahqJN7F/K1m9ROLqCom5+Eovp9L8bfNcPdximbdKLGcCyli9VhHJJ6scj4ng
         avy/w/0zSP4GRNmvUk6hcT+Va2/KMge2BIxpA0RYQEUbvCMw9fPLXtWUEm0Ry6jHZ8So
         E5TDI1o+5iJkkRvMIrc/Nv0bf5fh64ST0ifoQ1hA4XOnulMD/m/8ofstgAXaHgfxxWJG
         S2c4k0ZhFOD/c4lqig543GHI20z+6VNiE6d9paWKFiOh/pQmg+QlojRQ5f14stuLyCVA
         sunw43YfiiXnapdsh5eTnhUuJ8h0L1wQDftkz+XE08sOwEfwAXyY/WchXmYdRGC0Rb5t
         y0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m24dMml2jSsL7Dl+CG8vq6QyqBxUdcOiPSlfJt9P/gU=;
        b=nfTlLY56ZogvMNmSZqV4D8GLE80MFfP4dqkbcEYX/rtjMwJ3dEgio0ClVwBrKuQOry
         DSoB+1wHWxdzcXF6r3K6LnM50iFwvJKtjD09+rFpR0F+LOxzIPV1lbVxdznTaz7eb1vj
         R8JFhByu4IV9eQuIZY2IVgGnksNxDOH28BqvXbVTx0grcr1SrkqBq5/2i0ITpvzL9uDM
         sdQZo8fPZlcxvJHlriU53rQEpOujJKkMsJomiqlyJjQVZPKTOJP2lqfJQl/zyMG+3WLb
         TaJLyksSoOtTiWIbNkMudoObTVpC6nVu43iVvGKE4rYa91xmHhSkv3xDzEqSTbTUCODe
         o3ig==
X-Gm-Message-State: AO0yUKV0jdwN18uv9XAMLTt6XiP2ZneLsdgwbERDSmD7kybJ23r8G5wt
        AmnTUeXbybQf6gp3VWXv4ZXo0fhd/DLyTgk7G79nTA==
X-Google-Smtp-Source: AK7set+LuEjq0hGS8kTkbDCf7Aen0jDGWuexoGHd2jNkgiQU/80/rPS3PmbPLavbhwF7RZcjpke/lJUVBzgNfpa3fRQ=
X-Received: by 2002:a0d:f804:0:b0:527:ad38:2c5b with SMTP id
 i4-20020a0df804000000b00527ad382c5bmr3046509ywf.336.1676283267256; Mon, 13
 Feb 2023 02:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net> <20230202-asahi-t8112-dt-v1-11-cb5442d1c229@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v1-11-cb5442d1c229@jannau.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Feb 2023 11:14:16 +0100
Message-ID: <CACRpkdadj1Jwh+XwbEvzsULOo2vaKX9ioJVw3aekRbPB371A_Q@mail.gmail.com>
Subject: Re: [PATCH 11/17] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t8112-pinctrl compatible
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 4:41 PM Janne Grunau <j@jannau.net> wrote:

> This new SoC uses the same pinctrl hardware, so just add a new per-SoC
> compatible.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
