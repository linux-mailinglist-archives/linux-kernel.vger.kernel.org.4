Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFB6C9420
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCZMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:15:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFA6E89;
        Sun, 26 Mar 2023 05:15:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d17so5911429wrb.11;
        Sun, 26 Mar 2023 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679832926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0X0IVqjnE4GWpoQcuqF7rO1/hOAXNdvp0AiJjukc3U=;
        b=qVxt62xawSEhPWFgEX0PQW7ZAi7jWK9MHmWhc2MHtIrtxqXQvIojSpFrn8uDw2SbaG
         t/lb8nXS9CAqv6a6XdUMV8xbUHt75f+t5Kx1+8iuR9az6odwTS4Bkynr1iBvEi8t2QhV
         ejpoV5ip/bGRoANzpc2zxEgyFzAfPhCtXDwt2b78UYxgGEicMJbN4UVobm2Iehz/73iR
         8UkusbgQGJ3fjyc9jUC8s1H9wsG0N3xpbZjNqyUw8WrzRHWdsAnEhJL+26eyYFPSSWDC
         RqJjhejyLjwcC2mp0PPB9+7bOtitH0XBG9xE96+nMwghH5rh98yU3kTB1MFPOAnxajhn
         zN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679832926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0X0IVqjnE4GWpoQcuqF7rO1/hOAXNdvp0AiJjukc3U=;
        b=ceHy0I/JA8LE4Xig80eH8c13u4vE62TpoY8wviNrOHZOqrS8YmovxJm8fJJdSGzVTO
         2eN8ZB109EbOepLA9VYb3Rno0uXKogfQ6552mIaMrrQpvVpQxv37nAAjwTG/HirzUY4v
         7n9cmU9vIYkHLhb6Tlkvfzq/5+YWJI47KW4UDKQy7a0AiTefoQ9x6eglZroiBMXKRlNf
         0BgQ7sm+jaTnZc7hhIkpXybQ4aZlyyynl+WsKclgsn7grjIPp8GPXXUi17gFioY3mLeo
         BtSqBf25upYkb3JDVt/074SQxCbdDiHh+QUBxFzfrOoFneGKOXXm/VrS8k9u416AZtSo
         eqvQ==
X-Gm-Message-State: AAQBX9eG2gbs67hJqoQjXuwXNvxyVCJOCGmpR4m8xbxfRCZ9WWD/dMkw
        melt+ArxHeJeOf4geb4HB/fpP3qskHQNyl2qnLM=
X-Google-Smtp-Source: AKy350ZyC1hmbCAqH2PE38tVkcOijPvTEjTrk6Bbob5z53kn/8egAoCIB4tn2r+qQLb2/2kGaO5z5XUWHXg5jmLzpuc=
X-Received: by 2002:adf:f4c2:0:b0:2ce:ad3a:551d with SMTP id
 h2-20020adff4c2000000b002cead3a551dmr1361058wrp.2.1679832925722; Sun, 26 Mar
 2023 05:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com> <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
In-Reply-To: <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Sun, 26 Mar 2023 13:15:15 +0100
Message-ID: <CABnpCuCh2kmvTRrmsY0cwNqjFR6nv1xwxrZPJieM4_Ph8qEGeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):

Will do, I haven't submitted patches for a while totally forgot the
wrapping guidelines

> Unfortunately the reason is not good enough for ABI break. Replace
> vendor boot uboots with open-source one or just correct them (it's still
> U-Boot so even for vendor one you have the source).

Replacing uboot is fine for this case, however I can foresee that can
cause issues further down the line.


1. No uboot source from the vendor, we all know no everyone respects
code licencing

2. Secure environments (like android tables), this chipset will likely
end up in android tablets that have the secure boot chain enable.
These will be unable to replace uboot even if source is available.

As this SoC is new to the Linux kernel (not even useable for much it's
current state) would it not be better to aling on this so vendor and
mainline DTS "agree" now rather than possibly have to address is in
the future ?

I have also investigated setting these clock rates during kernel boot,
but the SoC locks up.


On Sun, Mar 26, 2023 at 10:37=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 01:15, Shane Francis wrote:
> > Some vendor uboot bootloaders use the target kernels
> > DTB image to determine the target clock speeds for
> > some PLLs, currently this can cause uboot to set the
> > clock rate for gpll incorrectly on to cpll (breaking)
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/s=
ubmitting-patches.rst#L586
>
> > RGMII.
> >
> > This change starts the PLL clock definitions from 1
> > to correct this miss-match
>
> Unfortunately the reason is not good enough for ABI break. Replace
> vendor boot uboots with open-source one or just correct them (it's still
> U-Boot so even for vendor one you have the source).
>
> >
> > Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> > ---
> >  .../dt-bindings/clock/rockchip,rk3588-cru.h   | 1442 ++++++++---------
> >  1 file changed, 721 insertions(+), 721 deletions(-)
> >
> > diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/=
dt-bindings/clock/rockchip,rk3588-cru.h
> > index b5616bca7b44..d63b07d054b7 100644
> > --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> > +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> > @@ -12,727 +12,727 @@
> >
> >  /* cru-clocks indices */
> >
> > -#define PLL_B0PLL                    0
>
>
> Best regards,
> Krzysztof
>
