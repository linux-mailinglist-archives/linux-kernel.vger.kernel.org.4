Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C5608D42
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJVM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJVM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:56:53 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFA22B38C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 05:56:48 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id x64so504673vka.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQaY+HDVEiFRpN3kWAbD+MEiHpWt4WE+omD3Z9rD2lE=;
        b=ZS81E+md9y/nvgPQJ7eLi4ZxZmDaZwaZoIVi6+cuvhfIghlsLBgIFFbSx61taz1jEV
         Qlr/zG1Nz/HrR1MN9sNZxqgZjzoisMX39yMZBIYA8L8aVWQ2jgrg1r0XUW3DVbX4ij0d
         kUgsxFGTR9ptAnfIGkmkIA4BQPqUds9xLrXU2nUe+7O1F1k39M8SzIcouc8F8OiGpB6s
         YJyAGdMnlk6a0yrwuXwAO6oAQV7RJpfekeyiMn+53S3UD+cestjWDXUj/9ydYyUMtnyy
         QQQANOVzaQ8lEsFJfUU9xnY69w3K4wlak2vkqEvZJtt+sTdzPbqBCc/aNXvAJOLc2NEL
         dR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQaY+HDVEiFRpN3kWAbD+MEiHpWt4WE+omD3Z9rD2lE=;
        b=KWeqjeqpLt7Kbd2HcGCZ8lQIIJj578T1Hg8TIzAvVId42f88QL7Hq/f6HHVTEadbim
         2tfkCogxtin+VOmeI3ojA4slRlD1ov5DwUMWYxkIcDp4svO7qV8lol78fL6nE275iFy8
         gHs5lESJSMv343PFRI8E7uC1F/hLAtE8RjYpU1A8fj1o3kQtGF3oGGgNqQ03YGaqJue+
         5eSnQHVe+6u2NFbxXn7RV8v8cZYBuj2STinKYg2ovpyhmxq7hyOLBSC0p34mx2KbHtR+
         /paKOVV6vDK9StwAgyiZR0zCroV/05Iu9EkvvdIWmReeH4QUR8SmVCmaSPSZUoCE34DV
         vB0A==
X-Gm-Message-State: ACrzQf3qiG9VcHy0YoGGXfHzpEZ9vIU7rO2tuP4QdzCoAoIBJAEEvjeh
        akLyu2mvSY8O7fcXRCApq/SZFoOYio8u3bR6E64=
X-Google-Smtp-Source: AMsMyM4IaF0foAqgyB3f1MxLG7fcq0RGmAjxcusLRSTau3x3HWCRzMis6PlfMbncxSOltIV/QZX++R9Fdk0+kpvzWPA=
X-Received: by 2002:a1f:b405:0:b0:3ae:be72:32bc with SMTP id
 d5-20020a1fb405000000b003aebe7232bcmr14550010vkf.41.1666443407803; Sat, 22
 Oct 2022 05:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214639.31134-1-palmer@rivosinc.com>
In-Reply-To: <20221013214639.31134-1-palmer@rivosinc.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Sat, 22 Oct 2022 14:56:36 +0200
Message-ID: <CABgxDoL1+TY1heaaJaCrbaJSPX+Agz5WSFYyhyXMmMjo3sjpWw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for linux-chenxing
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     daniel@thingy.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
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

Hi,

Le jeu. 13 oct. 2022 =C3=A0 23:49, Palmer Dabbelt <palmer@rivosinc.com> a =
=C3=A9crit :
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-gith=
ub/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bc404b292d3..5a7194bd66d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2430,7 +2430,7 @@ M:        Romain Perier <romain.perier@gmail.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  S:     Maintained
>  W:     http://linux-chenxing.org/
> -T:     git git://github.com/linux-chenxing/linux.git
> +T:     git https://github.com/linux-chenxing/linux.git
>  F:     Documentation/devicetree/bindings/arm/mstar/*
>  F:     Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
>  F:     Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
> --
> 2.38.0
>
Reviewed-by: Romain Perier <romain.perier@gmail.com>

Thanks,
Romain
