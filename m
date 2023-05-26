Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860C712995
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbjEZPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbjEZPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:33:39 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B679189;
        Fri, 26 May 2023 08:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685115169; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GBZZbiF7ruXKJwRU/UKRSvUduto2+nmr4tXorwsczmiQgYX5e6umskk2/+tQhriO9AZJe+ftvfTVGPPJgN/YK7iutS10S2cp/wr/Og4mmoDK2oENdQeFS9o1jv42hN/xJCiZpSZ9qBZ687gwRW465DRV7vz9XlH2dte/6iTb1/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685115169; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=u7/zPgaI11esUwuCZ9ANb4+ClUiUCXAYGeOO9rKo5Z4=; 
        b=ZM6/lRZvtjrUDMmygJ2k0TEchfTsmI4414dS4hXzJM786P3m0vmHy1WAjo8ekPvy1ii8GlwE82D7ve1P7Stv7Y3xUEeB8WRGed0ieug1FztMp3FTPk+SFlyQk1t7PcHDegAqDhcP6shJhwZizRkFkiA0B9MC2zSpJrr/3Fl5v40=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685115169;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Date:Message-Id:Reply-To;
        bh=u7/zPgaI11esUwuCZ9ANb4+ClUiUCXAYGeOO9rKo5Z4=;
        b=XirbvXIgZTqaZCkasaoHW07kTVH/k1kyf9zy1EJryUVey0lrjOlEwmiJ5HfGPpFc
        RKi2On/gJAM8lRIJjgE9+0SEB0YgSc0QM03OCevQH/UopUICPeo+dLOAFio8xlt393w
        Yrw9GdiGGzDaqTPbj+F4UVZfTA2FMvynOpXMgG0E=
Received: from edelgard.fodlan.icenowy.me (120.85.97.71 [120.85.97.71]) by mx.zohomail.com
        with SMTPS id 1685115168167230.90243257128157; Fri, 26 May 2023 08:32:48 -0700 (PDT)
Message-ID: <0803e9037a8a2ce96fdad6ec209991dcda2a30ca.camel@icenowy.me>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: remove panel model
 number in DT
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Doug Anderson <dianders@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
References: <20230526100801.16310-1-uwu@icenowy.me>
         <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Fri, 26 May 2023 23:29:11 +0800
User-Agent: Evolution 3.44.4 
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-05-26=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 07:24 -0700=EF=BC=
=8CDoug Anderson=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> On Fri, May 26, 2023 at 3:09=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wr=
ote:
> >=20
> > Currently a specific panel number is used in the Elm DTSI, which is
> > corresponded to a 12" panel. However, according to the official
> > Chrome
> > OS devices document, Elm refers to Acer Chromebook R13, which, as
> > the
> > name specifies, uses a 13.3" panel, which comes with EDID
> > information.
> >=20
> > As the kernel currently prioritizes the hardcoded timing parameters
> > matched with the panel number compatible, a wrong timing will be
> > applied
> > to the 13.3" panel on Acer Chromebook R13, which leads to blank
> > display.
> >=20
> > Because the Elm DTSI is shared with Hana board, and Hana
> > corresponds to
> > multiple devices from 11" to 14", a certain panel model number
> > shouldn't
> > be present, and driving the panel according to its EDID information
> > is
> > necessary.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> We went through a bunch of back-and-forth here but in the end in the
> ChromeOS tree we have "edp-panel" as the "compatible" here in the
> ChromeOS 5.15 tree and this makes sense.

I only have Elm, so I am curious that do all Hana's only rely on panel
EDID to use different displays?

BTW The Chrome OS document say that Elm and Hana are both board based
on Oak baseboard, should the DTSI be renamed mt8173-oak.dtsi, and still
let mt8173-elm.dts include it and then set model information?

>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>=20
> ...in theory one would wish for a "Fixes" tag, but I think in
> previous
> discussions it was decided that it was too complicated. Hardcoding
> the
> other compatible string has always been technically wrong, but I
> guess
> it worked at some point in time. The more correct way (as you're
> doing
> here) needs the DP AUX bus support and the generic eDP panels, both
> of
> which are significantly newer than the elm dts. So I guess leaving no
> "Fixes" tag is OK, or perhaps you could do the somewhat weak:

Well I remembered when I was developing the support for Pine64
Pinebook, which is also an ARM64 laptop with an eDP panel (via a DPI-
eDP bridge, ANX6345). At first I didn't use any panel node in the DT,
and the kernel maintainers argued to the bridge that seems to be
connected to nothing (because DP is a discoverable port), and
fortunately 2 Pinebook SKUs (11.6" and 14") is finally reduced to one,
and it's then possible to hardcode a panel model in the Pinebook DT.
According to my memory, the need to specify the panel is to properly
handle eDP panel power up timing, because it's not a very standard
thing. (Well, in my memory, when I was testing that code, on a
(engineering sample) 14" Pinebook, the EDID timing overrided the
hardcoded 11.6" timing and it properly works, the 14" panel is 1366x768
but the 11.6" panel is 1920x1080.)

(BTW when I checked the DT of Olimex TERES-I, which uses the same DPI-
eDP bridge, it is still in the status of a dangling bridge, and of
course it works ;-) )

>=20
> Fixes: c2d94f72140a ("arm64: dts: mediatek: mt8173-elm: Move display
> to ps8640 auxiliary bus")

Well this sound quite reasonable, as the kernel should have proper AUX
support at this commit.


