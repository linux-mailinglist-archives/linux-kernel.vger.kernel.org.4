Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19A72906F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFIGya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFIGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:54:25 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0B35B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:54:20 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-789ca7e52d4so435651241.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686293659; x=1688885659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWjk+u2aodMppO3MarY+I/93to0vWHLLHWpZ0LdR2fs=;
        b=YWycUxPopqZ6PCDKeAukOx8zNYQ6quMy0n4axU3QYAGyueU2uzcuLzkbKjRO/o+YBK
         6xDXfifgQX8Ko7oJ57gRzPinP+ciAL8BAGCKv4PDfiqgaWyeVPHSiosaObVJ8fc/guHa
         yyAPEam7EX3fHC12iaAFVeqD0G+O7ie8OJYRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686293659; x=1688885659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWjk+u2aodMppO3MarY+I/93to0vWHLLHWpZ0LdR2fs=;
        b=ccJDchI6jeh3CigtjwdtZPe26ysmHFqT8umRQXaWmn6zoTZy5ACTzNSJf65XYEEZ05
         5YMF1LhydrwmnhcIlcoY8oZ6DEsOcyLyqVSMHeHUcDrnmPbHTwdic5Q3XeOl6ASoS0lE
         kUNNZ26A0fEMjLfpR9WZLs3v5ydza8wP54OSGIxR1f0VysPFZ8JBElVfG1c3g8Lyb/0Z
         4FCkU28KonyNZ+9cmIjtEmY6H/P8sOH7cCpRXjAm6ZqstxLIpXQ42A6qunT83hNVhoc5
         bWE8UWB8c2Iwczgolx5xt3dK6ood6HO4R+tHUBJuFGqtLmeoOWjt6HJ/0/A3ZeZ9vrxM
         HPZg==
X-Gm-Message-State: AC+VfDzLSnrI5Uw834V6NC9bc/c+Km08zZcmfbX80n2S9BygQLDnhup1
        /XHURY7qpcq3dnrtE//izkh/liYnTRtjmWbd4Y4jdw==
X-Google-Smtp-Source: ACHHUZ5zdxMYMog4VI/k9il6dhuxPxVXO7AMtOqZyoNO4FOu3+hnOspZilQnfqUZ5b2emBjPA1nJxIc+bJhug/f3sMo=
X-Received: by 2002:a67:fc1a:0:b0:439:3f3e:dab5 with SMTP id
 o26-20020a67fc1a000000b004393f3edab5mr117499vsq.24.1686293659188; Thu, 08 Jun
 2023 23:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230607090653.2468317-1-wenst@chromium.org> <20230607090653.2468317-5-wenst@chromium.org>
 <b61c7d8c-85e7-2248-d386-ffec8c275aa4@collabora.com>
In-Reply-To: <b61c7d8c-85e7-2248-d386-ffec8c275aa4@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jun 2023 14:54:08 +0800
Message-ID: <CAGXv+5Gi1B0FzVtA4ZoQ7Ra+JOZWh68mQTi+G4Y2NBe+t9ehiA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8186: Wire up GPU
 voltage/frequency scaling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 8:14=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> > Add the GPU's OPP table. This is from the downstream ChromeOS kernel,
> > adapted to the new upstream opp-supported-hw binning format. Also add
> > dynamic-power-coefficient for the GPU.
> >
> > Also add label for mfg1 power domain. This is to be used at the board
> > level to add a regulator supply for the power domain.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 140 ++++++++++++++++++++++=
-
> >   1 file changed, 139 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8186.dtsi
> > index c58d7eb87b1d..a34489e27cd4 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > @@ -695,6 +695,142 @@ clk32k: oscillator-32k {
> >               clock-output-names =3D "clk32k";
> >       };
> >
> > +     gpu_opp_table: opp-table-gpu {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp-299000000 {
> > +                     opp-hz =3D /bits/ 64 <299000000>;
> > +                     opp-microvolt =3D <612500>;
> > +                     opp-supported-hw =3D <0x38>;
>
> For all of the OPPs that are supposed to be supported by all speed-bins, =
you don't
> need to restrict them to all "known" bins.
>
> Please change opp-supported-hw from <0x38> to <0xff>, which literally mea=
ns
> just "applies to all revisions".

OK.

> > +             };
>
>
> ..snip...
>
> > +
> > +             opp-900000000-3 {
>
> What about calling those like "opp-900000000-bin3"?
> Makes it clear that it's tied to what MediaTek calls a speedbin "3" (as w=
e're
> interpreting the values in the nvmem driver to make them compatible with =
the
> opp-supported-hw's expectations).

I thought that at first as well, but the bindings require the OPP node to
be named following '^opp(-?[0-9]+)*$':, so numbers only.

ChenYu
