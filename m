Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA6714288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjE2EUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjE2ET7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:19:59 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D24AD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:19:57 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-19f56608dc2so318491fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685333996; x=1687925996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5EruGneydWrebItl4MLqWHex5pJ5cJmkComuzWUkfk=;
        b=mMszb3MlFKUFM3qvQnr0h3j1Lk0OqdLggIRYGJoLXUB2YjcZGuVde7evV6kvVI4KG3
         AGkMx+HJptcKovROxvCC+Rkh6Wl+aLuIliXb3stWWbwR8jJT/PoLLbj6mX7N5ct4gXMV
         iH2MkgvxOlwZnZnqlSxQHK2w8o8ONphywonkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685333996; x=1687925996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5EruGneydWrebItl4MLqWHex5pJ5cJmkComuzWUkfk=;
        b=KbGq6E0Iw9mL7JNneXtkluMU8T921g1LIWkCFIWhuAUvDM4xtylXL8+xywNoyYCle9
         rGowJ8nh4CMYCkAAJFHTCgW6Y4LjW0iu5mh7mjuqF8qNAzQ/wUNfQMOo64SL7jvGYcWU
         fAFa1/+olKz3SoRqa1/oR3i7L9J+oyySpap30WSgIYGLbaJTIAZaVXwShGmsCSGW418T
         4gDvPdc4arNLUt12hQ+rzfFDP7z7Kz1d/E+8ysF3GoBL1LRH842b4hfY8BOsv22eDNbg
         2vqwIJLM0NNfMbcEQGorHZdUJK7fpE9rkrmqGWZXaqCyFwQgYH2z3f1+mT3WF23l9wVP
         EOdQ==
X-Gm-Message-State: AC+VfDwPhM/FZL0Yahb0jIG8/R7qOkeoPdhqCT6vfkjsoodOZKUOv/m9
        /UVYILD14BC3PJshLNXk2K0VQuD9+9JJEKG5dztYJA==
X-Google-Smtp-Source: ACHHUZ7ShijQbDXG5LNkOewm1aTPMRKRtRGdrly+ELkwdr+vwO4+T7tCAPpPdOqloRkeGytOrvqv8JCRVQBRNjVnHe4=
X-Received: by 2002:a05:6871:4c5:b0:199:cae3:f9d6 with SMTP id
 n5-20020a05687104c500b00199cae3f9d6mr4345361oai.56.1685333996420; Sun, 28 May
 2023 21:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230526100801.16310-1-uwu@icenowy.me> <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
 <0803e9037a8a2ce96fdad6ec209991dcda2a30ca.camel@icenowy.me>
In-Reply-To: <0803e9037a8a2ce96fdad6ec209991dcda2a30ca.camel@icenowy.me>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 29 May 2023 12:19:30 +0800
Message-ID: <CAJMQK-gOtqE=TzmQB+VM1KjScUQjLaKv6c8msv4-EKekritWYg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: remove panel model
 number in DT
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Doug Anderson <dianders@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:14=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wro=
te:
>
> =E5=9C=A8 2023-05-26=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 07:24 -0700=EF=
=BC=8CDoug Anderson=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Fri, May 26, 2023 at 3:09=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> =
wrote:
> > >
> > > Currently a specific panel number is used in the Elm DTSI, which is
> > > corresponded to a 12" panel. However, according to the official
> > > Chrome
> > > OS devices document, Elm refers to Acer Chromebook R13, which, as
> > > the
> > > name specifies, uses a 13.3" panel, which comes with EDID
> > > information.
> > >
> > > As the kernel currently prioritizes the hardcoded timing parameters
> > > matched with the panel number compatible, a wrong timing will be
> > > applied
> > > to the 13.3" panel on Acer Chromebook R13, which leads to blank
> > > display.
> > >
> > > Because the Elm DTSI is shared with Hana board, and Hana
> > > corresponds to
> > > multiple devices from 11" to 14", a certain panel model number
> > > shouldn't
> > > be present, and driving the panel according to its EDID information
> > > is
> > > necessary.
> > >
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > We went through a bunch of back-and-forth here but in the end in the
> > ChromeOS tree we have "edp-panel" as the "compatible" here in the
> > ChromeOS 5.15 tree and this makes sense.
>
> I only have Elm, so I am curious that do all Hana's only rely on panel
> EDID to use different displays?
>
> BTW The Chrome OS document say that Elm and Hana are both board based
> on Oak baseboard, should the DTSI be renamed mt8173-oak.dtsi, and still
> let mt8173-elm.dts include it and then set model information?
>
Oak is a reference design board which is not in the public. Since only
elm and hana board are in the public and the difference between elm
and hana are not much, instead of creating oak.dtsi, elm.dtsi (inherit
from oak.dtsi), hana.dtsi (inherit from oak.dtsi), we decided to make
elm.dtsi as the main dtsi and let hana inherit it and make its own
changes.

> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...in theory one would wish for a "Fixes" tag, but I think in
> > previous
> > discussions it was decided that it was too complicated. Hardcoding
> > the
> > other compatible string has always been technically wrong, but I
> > guess
> > it worked at some point in time. The more correct way (as you're
> > doing
> > here) needs the DP AUX bus support and the generic eDP panels, both
> > of
> > which are significantly newer than the elm dts. So I guess leaving no
> > "Fixes" tag is OK, or perhaps you could do the somewhat weak:
>
> Well I remembered when I was developing the support for Pine64
> Pinebook, which is also an ARM64 laptop with an eDP panel (via a DPI-
> eDP bridge, ANX6345). At first I didn't use any panel node in the DT,
> and the kernel maintainers argued to the bridge that seems to be
> connected to nothing (because DP is a discoverable port), and
> fortunately 2 Pinebook SKUs (11.6" and 14") is finally reduced to one,
> and it's then possible to hardcode a panel model in the Pinebook DT.
> According to my memory, the need to specify the panel is to properly
> handle eDP panel power up timing, because it's not a very standard
> thing. (Well, in my memory, when I was testing that code, on a
> (engineering sample) 14" Pinebook, the EDID timing overrided the
> hardcoded 11.6" timing and it properly works, the 14" panel is 1366x768
> but the 11.6" panel is 1920x1080.)
>
> (BTW when I checked the DT of Olimex TERES-I, which uses the same DPI-
> eDP bridge, it is still in the status of a dangling bridge, and of
> course it works ;-) )
>
> >
> > Fixes: c2d94f72140a ("arm64: dts: mediatek: mt8173-elm: Move display
> > to ps8640 auxiliary bus")
>
> Well this sound quite reasonable, as the kernel should have proper AUX
> support at this commit.
>
>
