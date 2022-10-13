Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CCE5FD392
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMDf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJMDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:35:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BFD03B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:35:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so900550edj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/RnWDHakvB3xqyl8HlC7PmuXWjiVUyJfu/0aj+YTdo=;
        b=aGBoVakhLLIHUk8QdHR4T57YVtaIBGYYB3kdNqKVJ3NCk1ZufQbWtDd9840Nm4KnhB
         BGnqR0QsDGr3nGgJZ8Ph68uTcpBtfQ3a3pApKGfn4/mzYzJB6fyYtx47fppOq+cINLpA
         l7BRUmKDNgjm3wqgCRXsmbhNnkfgVDTufbcp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/RnWDHakvB3xqyl8HlC7PmuXWjiVUyJfu/0aj+YTdo=;
        b=x/UbmnCpweByAe81km+ugWD0+9Jmxe5xlmn/jAhzcu0WRIO1Ro3src9SaD6FoWHOtP
         WywJzAehWiJrB9GX/4iPHD1GKE0ZLSnDjZxaaU60QZcVcTMSi8FxCpeg6UFloKmhQtgr
         xLNlaJtDIRzETIPz44AepbiRcIsLp+nT9Gkj/8aUTCKkmaXZUvyejnqzkiB1zcrACHtI
         opIggZO1282PchhXcxvvAk+uZTIIy6vTWPs1CKpowVMFzES5XjAI/6xZ70ED+XiBpYqC
         vRZi8oZvcO7F9pj7Ogs4OP3lTAQwkRWQlM79ITa2n7fwCD5PqgZexrqvf4S4hRxbOEbe
         Xd6A==
X-Gm-Message-State: ACrzQf1bletCx1z8dlaaBrmj2CSBBMcHKj6IWNCYYfydbUPopYyrwej0
        hhKFNakBoYHGQ3eFdxDWSsC/rAz2/Lm50b5PM9I+vw==
X-Google-Smtp-Source: AMsMyM5vH6zf1A6cPcPxyCBpJslErrSoPJQuSdL3BNZHZ2RrgtwxqgI5k8R3y5zXlRd+rqDyNqGwET0nhN21GDKrGYw=
X-Received: by 2002:a05:6402:1604:b0:458:b2b7:bd5a with SMTP id
 f4-20020a056402160400b00458b2b7bd5amr29067970edv.73.1665632149352; Wed, 12
 Oct 2022 20:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220621091854.1904372-1-treapking@chromium.org>
 <de6412d4-732c-79cf-ac00-e0fccee44270@gmail.com> <CAEXTbpf=w6qB1X3dYSR=kdJgqNAFW-pRYuiOGuv9WWEtuY47Cw@mail.gmail.com>
 <CAEXTbpdxj3Yd3dbyAd0Yc+8adCtK1bi=UXt+j7Fbtx6q8xd0RQ@mail.gmail.com>
In-Reply-To: <CAEXTbpdxj3Yd3dbyAd0Yc+8adCtK1bi=UXt+j7Fbtx6q8xd0RQ@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 13 Oct 2022 11:35:38 +0800
Message-ID: <CAEXTbpchG0=ofGnzT=nTud24apND1qN6dabBN3z=CVw0oSb2_A@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mt8173: Fix elm panel DT node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping again on this thread.

On Mon, Jul 25, 2022 at 4:25 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi Matthias.
>
> Gentle ping on this thread. Any feedback or suggestions?
>
> Regards,
> Pin-yen
>
> On Mon, Jul 11, 2022 at 11:09 AM Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > All we know is that the functions mentioned in the commit message were
> > working in 4.19 kernel, but not in the latest kernel tree.
> >
> > Unfortunately, we don't know which patch breaks the driver.
> >
> > Best regards,
> > Pin-yen
> >
> > On Thu, Jul 7, 2022 at 10:50 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > >
> > >
> > >
> > > On 21/06/2022 11:18, Pin-Yen Lin wrote:
> > > > Move the panel DT node under `aux-bus` node, so it won't use the buggy
> > > > `ps8640_bridge_get_edid` to get the display modes. Also, change the
> > > > compatible string from "lg,lp120up1" to "edp-panel", so the panel-edp
> > > > driver gets the displays modes from the EDID instead of using the
> > > > predefined display mode (`lg_lp129qe_mode`) in the driver, which is
> > > > actually not working.
> > > >
> > >
> > > Do we need a fixes tag here? I'm not quite sure if we fix an upstream bug here,
> > > to be honest.
> > >
> > > Regards,
> > > Matthias
> > >
> > > > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Include more details in the commit message.
> > > >
> > > > Changes in v2:
> > > > - Remove the Fixes tag because this change is not compatible with the
> > > >    old kernel versions.
> > > >
> > > >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
> > > >   1 file changed, 14 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > > index 9c75fbb31f98..1e0802a6f6d2 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > > > @@ -90,18 +90,6 @@ volume_up {
> > > >               };
> > > >       };
> > > >
> > > > -     panel: panel {
> > > > -             compatible = "lg,lp120up1";
> > > > -             power-supply = <&panel_fixed_3v3>;
> > > > -             backlight = <&backlight>;
> > > > -
> > > > -             port {
> > > > -                     panel_in: endpoint {
> > > > -                             remote-endpoint = <&ps8640_out>;
> > > > -                     };
> > > > -             };
> > > > -     };
> > > > -
> > > >       panel_fixed_3v3: regulator1 {
> > > >               compatible = "regulator-fixed";
> > > >               regulator-name = "PANEL_3V3";
> > > > @@ -282,6 +270,20 @@ ps8640_out: endpoint {
> > > >                               };
> > > >                       };
> > > >               };
> > > > +
> > > > +             aux-bus {
> > > > +                     panel {
> > > > +                             compatible = "edp-panel";
> > > > +                             power-supply = <&panel_fixed_3v3>;
> > > > +                             backlight = <&backlight>;
> > > > +
> > > > +                             port {
> > > > +                                     panel_in: endpoint {
> > > > +                                             remote-endpoint = <&ps8640_out>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > >       };
> > > >   };
> > > >
