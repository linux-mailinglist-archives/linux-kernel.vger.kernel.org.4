Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE06D5A97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjDDISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjDDISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:18:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1AE41;
        Tue,  4 Apr 2023 01:18:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bi9so41298547lfb.12;
        Tue, 04 Apr 2023 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/QeljmY9ct+nUTJxfQkxtnhru1EvuO2W6K2JXJBd5M=;
        b=begmmzpBpxM+H+/TfWsPuz1pxN6UU6cPTsULjtlIvyIcFJF6QmO3Bx3X6DLH8TIQic
         pPyJbKxrMkNJBovjO1tDri2hHyY6pXJOs/rZPCwgGZ+y6fSha/lGleBEVWMq6rIu5tnI
         zZz5j5ri4bJbHOtmkA+hoiBgOccf1kWK3Hv37eg3JbWg5ASbHZsS4i1CyfuaRiWHlyrI
         ddoxR1DWML4ZXQJ1lfiRpUkbvwiUrlGbu/y5N0NlkHJ3USrKDM3nX8uZw/ZBFKLsf7WX
         IbzzjCgLFlgBLqyhgMLFGgk4t0l1rjEetchT20nDlcSaxHgJgB4E55HDfk80tKl8MRP4
         ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/QeljmY9ct+nUTJxfQkxtnhru1EvuO2W6K2JXJBd5M=;
        b=vJiHRDzyXj8xX0fbMMXn9G4blezyQHK8uOHiFwYzeZUsZl3jlDIihMuMD96Uom66LE
         CJruqTNyYFiDncsPz8ofkpRsEzRXYn9+xKLwZT6JE/SY38Kt/UOXjB9/g6U07h7WNS+E
         dQE47CGzz9dkiCAN5680YiGqVYXDFuof9u3lJAMv3oV2+0Xc9iguNY/xEdylL4zNAyCp
         iQsy0DqTWFBF6i7n97maW62bBb2PT6AuyPqeXMeGviJFTTIuxFDC3k0z+T2HR5vKfcbB
         UKG5xbN8gnSFIpCaeFO0S2HecgdDtOhOszwxGY3srOxKG8M0hZhB7ded6FyKtAVDitx0
         9mxg==
X-Gm-Message-State: AAQBX9fO1FORaPT+EWhXBQfvWV2VC/wKFXBPQUoK+Twxbjb4zWfqvKMu
        lqmPT8QzJBYNJ4TDgyel4Uno6n7Sn4g5gx6zZdI=
X-Google-Smtp-Source: AKy350bbM5GMuM9I8+CJRhYYmrG98DJyI9xbsiBVqND+hXASyGkI2G6jgOoZflvixZBnnQGtJDOvOCVhTjRlosv1MPQ=
X-Received: by 2002:ac2:4c85:0:b0:4d5:ca32:6fa1 with SMTP id
 d5-20020ac24c85000000b004d5ca326fa1mr478151lfl.0.1680596313053; Tue, 04 Apr
 2023 01:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230403175937.2842085-1-javierm@redhat.com> <3738011.44csPzL39Z@diego>
 <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
In-Reply-To: <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Tue, 4 Apr 2023 09:18:21 +0100
Message-ID: <CALeDE9OVq8ys9Ymx6Na+a0oK6R8CpfD=fbM6FTtWGnJQn_SR5Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     Jarrah <kernel@undef.tools>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
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

On Tue, Apr 4, 2023 at 9:13=E2=80=AFAM Jarrah <kernel@undef.tools> wrote:
>
> Hi,
>
> On 4/4/23 17:51, Heiko St=C3=BCbner wrote:
> > The interesting question is always if this will break someone else's se=
tup.
> > I've never really understood the strange setting of 1.5MBps, but on the
> > other hand it _is_ a reality on most boards.
> >
> > Personally I don't care that much either way, but would like a comment
> > from the other people working on that device - if possible.
>
>
> I don't have a strong opinion either way, but I would note that
> Tow-Boot[0] which later models of this device ship with uses 115200,
> meaning that this would put the device out of sync with the default
> u-boot implementation from the factory.

Upstream U-Boot support uses the 1.5m that all the other rockchip devices u=
se.

> At least for me it's been convenient to have both the PP and PPP use the
> same settings while debugging.

Pinebook Pro and numerous other devices use 1.5m so I don't think what
other devices use make are ultimately particularly relevant.
