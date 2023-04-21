Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667FD6EA772
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjDUJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjDUJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:44:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A26B47B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:44:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763703a6df9so179296739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682070262; x=1684662262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnz+CeyBg3xSNr9PqiNTHXQ+dbZ0EMgPRiV2a5GlAR4=;
        b=Mf3FCqEwPMRSpsLwD4QJyC1MOjG++hHgSdPevq7QToxICdA6dcGVeopRVwgQCugdhi
         kIarRuJAILYtURSdH1hSmCVg8jaJltsqWidIdP0dWXxJ8a7fbBHxJ/GbtXC1ErEn1sLs
         1GCCx9nX3Z9y2QDmlBaenF3xrtHBa0Xsn9Ttw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070262; x=1684662262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnz+CeyBg3xSNr9PqiNTHXQ+dbZ0EMgPRiV2a5GlAR4=;
        b=KanEljeIJaqJDOJV4huDtX5yxrHus59WKDFqCiujRYhFIChzwnT+Q9f1YTcvqDz8wY
         c6js/qmnTg+YYxjSxinda5BkimpqPLh78EcEGjOa3UjdCqi/1yjnDsw1GGE1I/hYrGF5
         M27l85tFVfTthHEjC6q2UkTNieJeSnjDo+kPZTqML88T3giekd0c8eKOZICr5zzImpAg
         ObhUq9Xd774C0g0N5hFRYCu3tG7eBeigJyIhQ1Bec3EXEAkmi342mXvb230rnzIzlGDq
         2oMchpPPNgpqq3pjCf/Tu8ucouqpxAWhAXQS0NxfpSuArgiOsR6pSy1kVgZzJOb/8wKI
         fOVQ==
X-Gm-Message-State: AAQBX9cYOBk4uu2ybbX9u9k2yqwOu9yik/EW5WjJCSMW4m69d/EY43U2
        v3yX5wCJM0lEouKffn9RaOF97v8JlSJcA1im7CnzCA==
X-Google-Smtp-Source: AKy350YCslq6VFKPwWNjtIByK+QV1czrNdIgADjG+fb48UYdiq7mGNUbqkwSJjjdr55Cf+8MIwM+FGPck1Oz1wvgN6g=
X-Received: by 2002:a92:ce0f:0:b0:32b:13ad:3e48 with SMTP id
 b15-20020a92ce0f000000b0032b13ad3e48mr3885678ilo.14.1682070262628; Fri, 21
 Apr 2023 02:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230315041107.2886940-1-treapking@chromium.org> <e15eac65-94d4-6a70-cab1-4fdb550116f7@collabora.com>
In-Reply-To: <e15eac65-94d4-6a70-cab1-4fdb550116f7@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 21 Apr 2023 17:44:11 +0800
Message-ID: <CAEXTbpevkMte1Oa1Z174SYi0Frvyg9fHxqUyphK=0PecHU933w@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: mediatek: mt8173-elm: Move display to
 ps8640 auxiliary bus"
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to drop this patch because 102e80d1fa2c ("drm/bridge:
ps8640: Use atomic variants of drm_bridge_funcs") breaks the
ps8640_bridge_get_edid function. The atomic helper requires an atomic
state to do the chain enablement, but we don't have that in the
.get_edid callback.

The latest ChromeOS tree uses the "aux-bus" with "edp-panel"
compatible string, and it seems to be working well. I'll upload
another patch to update this.

Best regards,
Pin-yen

On Wed, Mar 15, 2023 at 6:34=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 15/03/23 05:11, Pin-yen Lin ha scritto:
> > This reverts commit c2d94f72140a28d0f516b7c5e8274a9c185a04ff.
> >
> > The `lg_lp120up1_mode` defined in panel-edp.c is not working for some
> > panels used on elm/hana devices. Move the panel node out of the aux-bus
> > subnode so the driver only uses the modes retrieved from the EDID.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
>
> This commit was sent to fix display functionality on MT8173-Elm (Acer Chr=
omebook
> R13).... apparently this should get fixed with [1].
>
> Investigating if this is the case.
>
> Regards,
> Angelo
>
> [1]:
> https://patchwork.kernel.org/project/dri-devel/patch/20230315035508.28749=
15-1-treapking@chromium.org/
>
> > ---
> >
> >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++----------=
-
> >   1 file changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8173-elm.dtsi
> > index d452cab28c67..d45a2aeb0eb1 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > @@ -90,6 +90,18 @@ switch-volume-up {
> >               };
> >       };
> >
> > +     panel: panel {
> > +             compatible =3D "lg,lp120up1";
> > +             power-supply =3D <&panel_fixed_3v3>;
> > +             backlight =3D <&backlight>;
> > +
> > +             port {
> > +                     panel_in: endpoint {
> > +                             remote-endpoint =3D <&ps8640_out>;
> > +                     };
> > +             };
> > +     };
> > +
> >       panel_fixed_3v3: regulator1 {
> >               compatible =3D "regulator-fixed";
> >               regulator-name =3D "PANEL_3V3";
> > @@ -282,20 +294,6 @@ ps8640_out: endpoint {
> >                               };
> >                       };
> >               };
> > -
> > -             aux-bus {
> > -                     panel: panel {
> > -                             compatible =3D "lg,lp120up1";
> > -                             power-supply =3D <&panel_fixed_3v3>;
> > -                             backlight =3D <&backlight>;
> > -
> > -                             port {
> > -                                     panel_in: endpoint {
> > -                                             remote-endpoint =3D <&ps8=
640_out>;
> > -                                     };
> > -                             };
> > -                     };
> > -             };
> >       };
> >   };
> >
>
