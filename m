Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF36DFDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDLSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDLSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:51:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716DA619A;
        Wed, 12 Apr 2023 11:50:59 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id ba16so8642081uab.4;
        Wed, 12 Apr 2023 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325458; x=1683917458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8GgKi0Rd6kCiCYBZPhErEcVfM0TkK8lsiwJgbaw5K0=;
        b=e1uDKoOANgFwZXtXr6Q1OJ789UtCyc7uXFniZoXLtq9IL3x4Ad49N2oeEmctylAGzI
         eAGaQaZgUH6iYA1wwvCBJnJppwZOxQvsf1ku8qgDIFnzaxJmqAZVg1zXsQgM/Pd7WdOf
         HNLCt/kcEKvIl6mbeLK9izZKLfpHFR3NuGQ1ZNwWbFTKZ4gwf9Jc2/Swa5Bl2vtlYFGQ
         11B/7VI1M59nTdix34hDNSsk0SDLMsMrDnkl0l3FrfRpXL09Qymh1togU36zZzvx09Z6
         F1TmHAemUutNXwmb93BgH6/pttjKSB+Lm79xlK7Bf/so7KfDB0j8FT9dWeXN43MjPUXG
         XQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325458; x=1683917458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8GgKi0Rd6kCiCYBZPhErEcVfM0TkK8lsiwJgbaw5K0=;
        b=JSTWOgPPPcTYHCts06zJoYr1uzJ9wtS7bn5ym8whFTTZmUsUM91gJWWBSnVEhw4Uvt
         g4FV3bNK9aLBGx7YL+s8ZxYHeRTUlxAwk4yoxvYU9NnfVcN+fX3Kp+tavnMb7M8li9DR
         +vRKjHMsdvzWLrNsimqvdQqBAiXMmq+wXeG/ZWm5/mnyzPkrjGONwkNTh5ygL+HrX0Oi
         +3JPc7hIidYvfav+LxAh5EqRWk3nPqn0caK/fNkuFcOVxeJfvmYS8nCHbIepqH83KPYW
         eY8oZvCqzrmWMD+a7vYl6DpszuguoFgyVE+Xd0LfSoQ4odw6Yp3o6yBzZKHN3NiWNwu5
         psHA==
X-Gm-Message-State: AAQBX9eKnawKq2ZQWr01FSG/EWDukdC7Tp6Rkz0MWrDVNcRAWla6fhOj
        TpDNjbqOMbuNF0wSc5k314+QCaUqGUvA9jTfTAauIO7B
X-Google-Smtp-Source: AKy350ZSVhFoyFTi/fc3NDFlzFOLXKPOeWn5CiJd8C5f/p/xHotBKpHKfdjLlytUOo9/tu0uRyJWhOwLjvnCGyP6tyA=
X-Received: by 2002:ab0:5b54:0:b0:68b:90f4:1d8c with SMTP id
 v20-20020ab05b54000000b0068b90f41d8cmr4868990uae.1.1681325458573; Wed, 12 Apr
 2023 11:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230412025737.20280-1-mibodhi@gmail.com> <20230412025737.20280-3-mibodhi@gmail.com>
 <eddb141e-6a8a-4473-b5e4-2e043d6f5197@lunn.ch>
In-Reply-To: <eddb141e-6a8a-4473-b5e4-2e043d6f5197@lunn.ch>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Wed, 12 Apr 2023 11:50:47 -0700
Message-ID: <CAJaLiFw00VyD4rPBh=06U6wXmbDaK75Cd9MCVwUCN1SF4A1_Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: mvebu: add Thecus N2350 board DTS
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
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

Hi Andrew,

On Wed, Apr 12, 2023 at 5:24=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +
> > +/ {
> > +     model =3D "Thecus N2350";
> > +     compatible =3D "marvell,armada385";
>
> If you look at all the other armarda-385 .dts files, they all have a
> board compatible. It might not be needed now, but it could be useful
> in the future and allow backwards compatibility.
>
> > +&mdio {
> > +     phy0: ethernet-phy@0 {
> > +             reg =3D <1>;
> > +     };
> > +};
>
> Since you have ref =3D <1>, this should be ethernet-phy@1.
>

Thanks! somehow I kept missing that change.

All the best,
Tony
