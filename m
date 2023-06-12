Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6C72CED9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbjFLS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjFLS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:58:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD551114;
        Mon, 12 Jun 2023 11:58:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9745c5fed21so687774066b.3;
        Mon, 12 Jun 2023 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686596311; x=1689188311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mUonJgToHCgnd4NYbM2VauxjgcAH9HX59bsPeQrQF8=;
        b=BKUK/UGgH4F6ItSoTC+5ps+xppzuLOpyrcR53EjxUGgzeHXMBcF6vsGuNsjG7ZivrH
         LekCx1Km0THyBN8bIKbqbWDqyZxhiTiOdOercO6BylOYa6hpuFOEehSonUcrZcsSt4kQ
         OjKHo+W0jG1y6wc9o1xvg0NnMlkwpFFY2v1CL3/aXF9Pq/LuoKawFzAgzg5GwHG1nmn3
         TKPo9zygdYCWnn64A1xNjn8TkxybrmhOKvGnV+x1gUDxIzPYSDGMpjx3eNStBTt2qGEQ
         VeFKtYmpTEBAzrieyZVHGaTgJwjQHQ5JBDDasJH6TmES73QcPhRkEDd5pxYeIRWIpmBW
         eNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596311; x=1689188311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mUonJgToHCgnd4NYbM2VauxjgcAH9HX59bsPeQrQF8=;
        b=PE+gUWHsHFD18MHy3wI5HYe2D6NNLllHYbbvNL5lv2DB7YdEpsdNIEoG7XxkcG4k9U
         n5l0Gc85ma7yREwLKNTAZQfM2QxbBm6IIFl79wsWL9lGWWtFahEdRG/qhxdHp/rs29N2
         bIrmt0n055yK+NgL9hUf3h7d4TyrdDT7mXJhkGXy/jnouHBH/KiL/r8i84LNREqvL0Kh
         eYqIqu0do8me+sW1dUtYv/Z2f81ThkaT3R3+DTobOE3vtdo++MOGTFBDB71gtHEHfaZT
         aZ1m/KEQKLk5J+sAJs/BiTK1nhqieqEnCI/P+8FZmOPbVTaHpixffh9z6lJ8QRs2MpkW
         xYWQ==
X-Gm-Message-State: AC+VfDwiYBocFxkWqWdZc4nIyJPWgHs+PE5jIc1DXwy/4PK+yyp2eX1Z
        Yds7f0N4InjSHptyxpbdTSCJwEjl7D7B93orK18=
X-Google-Smtp-Source: ACHHUZ72gaCwCv6ASH5Fi/IBsI0MrQyJpEiRZoZuE7BfM5lJamwPMGfN+SlUgNamlTwETDeAHAdCKuU7RSaB2DGEdcI=
X-Received: by 2002:a17:907:3f82:b0:97a:e496:c121 with SMTP id
 hr2-20020a1709073f8200b0097ae496c121mr10409439ejc.69.1686596310880; Mon, 12
 Jun 2023 11:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230612063429.3343061-1-bigunclemax@gmail.com>
 <20230612063429.3343061-4-bigunclemax@gmail.com> <20230612-wriggle-remindful-89d5105c94ee@wendy>
 <CALHCpMjxboLn2eTjOJkE2JAzH3S8OB3v9fWqDOdeipAmLvLx2Q@mail.gmail.com> <20230612-manhole-awoke-599b8ff72edb@spud>
In-Reply-To: <20230612-manhole-awoke-599b8ff72edb@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 12 Jun 2023 21:58:18 +0300
Message-ID: <CALHCpMjY8urNAVFhnBaK1Png1yY3UAQOG8u=W4-v=GiJ8TjZEw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add thermal sensor and
 thermal zone
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 12 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 20:27, Con=
or Dooley <conor@kernel.org>:
>
> On Mon, Jun 12, 2023 at 11:17:20AM +0300, Maxim Kiselev wrote:
> > Hi, Conor
> >
> > =D0=BF=D0=BD, 12 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 10:55,=
 Conor Dooley <conor.dooley@microchip.com>:
> >
> > ...
> >
> > > The RISC-V patchwork automation is complaining about this patch while
> > > running dtbs_check:
> > > arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb: thermal-zone=
s: cpu-thermal: 'trips' is a required property
> > >         From schema: Documentation/devicetree/bindings/thermal/therma=
l-zones.yaml
> >
> > I didn't add 'trips' because I'm not sure if they should be the same
> > for the D1 and the T113s.
>
> I'm sorry, but I am of no help there. Perhaps some of the Allwinner devs
> can help you on that front.
>
> > Maybe it's better to drop 'thermal-zones' from this patch and add them
> > later in separate patches
> > for T113s and D1?
>
> Does it pass dtbs_check with the thermal-zones removed?

Yes, it passes.
