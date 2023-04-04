Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A146D61A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjDDMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjDDMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:52:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3509172C;
        Tue,  4 Apr 2023 05:52:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so130341747eda.0;
        Tue, 04 Apr 2023 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680612735; x=1683204735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hohqJ0IRkgadARh+RFpo5PqgLtx6zYqkk8fyrFCTkmQ=;
        b=axa5R95ck091V5Ed2YimkNZdszQD9vtj+hhAXOu7kJIc64/erLFd7wZ6V1nTJp0eVX
         /HUcyHy/g/CHONzZwHllAEgtWL8AHOSBE8Nb0fCKGEErrMq76qwyTg0lYl+4drrdxPgj
         vLZRARURzYNwcd5kDA+wktkjq7jIMDNbqCbiI+DipvjJ4ExLrBPq5z0v8et70FuRGyWR
         hrOF234zfQ78ApKmL5CSKNse8ZtsxZlTV6OFJxQazbQYBOQSDelfz4y3jhwncbvEtoLz
         AxLDdjz/ijt9z4II0USK6vfpnxR6GIYqoIhMzf/wW0NHuH7OHnM/W+6YNRdBkM0ukkWa
         xMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680612735; x=1683204735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hohqJ0IRkgadARh+RFpo5PqgLtx6zYqkk8fyrFCTkmQ=;
        b=PrZeBwawgXv0P+ZZ/TC4Iv7Mok7n//1nA4EVUwCH3848wNhANod6ocxjWOFRm1/TYr
         GIgJ2ck22QLEVTCaKTno5vv4uJSg8IRxqRJT5bi+STSmUQ8aKxCC31sslQZ7eJ03Tk3n
         PaiDPr39QI6eTtEY5sRMEVyFE9LXYXlLXyEC6jmKsDI7wwDtLwNNwcChHZCfzvehNwvH
         tlo3zclBZ3EaoDQDNRHIBYIPTl48lrSXKf1P7zlzglyiDxcsJ51XQENjSy99XN2Zb9vQ
         i8weNiT8iSLNUHDKeAuXdUjy1JnzPY+Yj/MyvFh6l5AWXp97dlPLZWcu1le5nuHcsLOW
         +16g==
X-Gm-Message-State: AAQBX9fZUHroPf+dW4o7nYdy2pwdfczsAYQ7dy5Qg/yg+dZ5f+eagO4m
        80DNjrh7vgcxj7twIAbuV7Ddh1YZmUpfsEcE25M=
X-Google-Smtp-Source: AKy350a6hJFElVGx6OrQgSXH8YqifO0Ytv8rsQnUDGl/mZVDqrepPpWOM7sSy08bd0fzcKKAvVmSA2LnIBwbdcIfqqE=
X-Received: by 2002:a50:a457:0:b0:4fb:3549:a708 with SMTP id
 v23-20020a50a457000000b004fb3549a708mr1294643edb.6.1680612734887; Tue, 04 Apr
 2023 05:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230403175937.2842085-1-javierm@redhat.com> <3738011.44csPzL39Z@diego>
In-Reply-To: <3738011.44csPzL39Z@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 4 Apr 2023 08:52:02 -0400
Message-ID: <CAMdYzYqT=vVZxFK=P6xYDAht_KWk3CTsTtruPAbGqx1K9EcJsQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
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

On Tue, Apr 4, 2023 at 3:55=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
>
> Hi,
>
> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> > This baud rate is set for the device by mainline u-boot and is also wha=
t
> > is set in the Pinebook Pro Device Tree, which is a device similar to th=
e
> > PinePhone Pro but with a different form factor.
> >
> > Otherwise, the baud rate of the firmware and Linux don't match by defau=
lt
> > and a 'console=3DttyS2,1500000n8' kernel command line parameter is requ=
ired
> > to have proper output for both.
>
> The interesting question is always if this will break someone else's setu=
p.
> I've never really understood the strange setting of 1.5MBps, but on the
> other hand it _is_ a reality on most boards.

Good Morning Heiko,

The 1.5M baud is default because the clock structure on rockchip
devices does not allow a clean 115200 baud. By attempting to force
115200, it will always be slightly off (either low or high depending
on how the driver decided to round). If this actually causes any
problems is the subject of much debate.

Very Respectfully,
Peter Geis

>
> Personally I don't care that much either way, but would like a comment
> from the other people working on that device - if possible.
>
> I guess if we don't hear anything, I'll apply it nevertheless at some poi=
nt
>
>
> Heiko
>
>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >
> > I tried to instead get rid of the baud rate altogether, as suggested by
> > Peter Robinson. AFAIU that should just pick whatever bad rate has been
> > using by the early console.
> >
> > But neither using 'stdout-path =3D "serial2" nor 'stdout-path =3D &uart=
2'
> > worked for me.
> >
> > In both cases I didn't have any output unless setting a baud rate using
> > the 'console=3D'param.
> >
> >  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/ar=
ch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > index a0795a2b1cb1..6bbe65bd5bd4 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > @@ -26,7 +26,7 @@ aliases {
> >       };
> >
> >       chosen {
> > -             stdout-path =3D "serial2:115200n8";
> > +             stdout-path =3D "serial2:1500000n8";
> >       };
> >
> >       gpio-keys {
> >
> > base-commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346
> >
>
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
