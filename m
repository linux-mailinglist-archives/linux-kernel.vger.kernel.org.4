Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3971557F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjE3GZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjE3GZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:25:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A12BF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:25:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9daef8681fso3140243276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685427922; x=1688019922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOlMpam2kXZ0NreKKU8RZ924QV5LazGnCRSzw/kR1po=;
        b=DLEnIVlzrUvEekpze2GkSbuJFCJbdFfo9+FQRmnmmOirDj8s9a7aXAjA0DKS3F3poi
         lG3JyuTbHD5GMH7krISFMJk8pmBdpgzUyDodmkWy8jqeDers+5sXmidQM96RAxHS0bq/
         480KdzjufQKwo/4YqmTrBR0JTVcio0x0mrhfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685427922; x=1688019922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOlMpam2kXZ0NreKKU8RZ924QV5LazGnCRSzw/kR1po=;
        b=fzVTGG/8dilnI47Ck4EaL46MsO0XmK0c1V5navkEe/kPlAVlzYXYwmhGHXQoWuH/b1
         pwDSJJLHQR4qiKiujsQO03ijyvpXwfvG6QtXsqpuPP1Q2xw9bK6wHjEtQ2ONGR7J5iGI
         SOAHYiKCAmxot1lyAybRezJv3jQ7YToCmW+iUAROrnckChVnfTKAtM7gDbr9/NCbks3V
         4klt0F1/6AJNIXAAfCIGZvD2JqGbvUL7F3LYbOhmYzAEHL2SBAWLBb81/WobrZo0saT3
         SSPYjgrI5t7nK18kpFlqyGg0S8Fyf4WgHkRdcD5M7vzg+tHEppAaH3kvC+UzEDc7J1y8
         CXcQ==
X-Gm-Message-State: AC+VfDwb73ncxNc2AhGYg/TSk3ANJ2zz5xfdQDsb1JVIk27a+tICL6S+
        5bejawW6cPjUTrVeZH4mEjEbasSu+pCefUvMmjWIHw==
X-Google-Smtp-Source: ACHHUZ4sItdsjQ7pB9PdqtemdF5Juj1rYgsq7Ifn54tyYkzcZ0COMpT7XW5O8au1v15Fwpo8RiRMmRqK8oPuTUin86w=
X-Received: by 2002:a25:2707:0:b0:ba6:a923:4744 with SMTP id
 n7-20020a252707000000b00ba6a9234744mr1694940ybn.44.1685427921802; Mon, 29 May
 2023 23:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230331091145.737305-1-treapking@chromium.org>
 <20230331091145.737305-5-treapking@chromium.org> <CAE-0n51E5foFWQAsA73662_5e6XP426wuUCVVmcS5UWwiYpDmw@mail.gmail.com>
 <CAEXTbpdcbB_z4ZGCGzc-cM74ECKyxekbroKCWFnhH8eR=4HmvA@mail.gmail.com>
 <CAE-0n50atfmr-bFh5XtTCm4WpSijJGSe0B5JP8ni7CCYk7Bs5A@mail.gmail.com>
 <CAE-0n51Qy-KDGHOCr4Smpebq1fCURqvJ2RJz6KAtVpv5e+DSGA@mail.gmail.com>
 <CAEXTbpeKe1dVHp9cauMN-9nQb35oJ-ZhdFV-8BiWzjjhWAy0Zg@mail.gmail.com>
 <CAE-0n50bj303jou==v6eMabrZ3EL6Cq7tPJmCj9vM_B7FA8s2g@mail.gmail.com> <CAEXTbpcWfYV_58pw_VupjhAFZsUU3pkLRN_8JoASyLLBmgTYqQ@mail.gmail.com>
In-Reply-To: <CAEXTbpcWfYV_58pw_VupjhAFZsUU3pkLRN_8JoASyLLBmgTYqQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 30 May 2023 11:55:09 +0530
Message-ID: <CAMty3ZArgjaPmVMCHvps875c22WWS-bXx5GVMhQUURORgx7UvQ@mail.gmail.com>
Subject: Re: [PATCH v15 04/10] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 9:12=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> +Jagan who worked on a similar design and initiated the thread.
>
> Hi Stephen,
>
> On Sat, Apr 29, 2023 at 12:47=E2=80=AFPM Stephen Boyd <swboyd@chromium.or=
g> wrote:
> >
> > Quoting Pin-yen Lin (2023-04-20 02:10:46)
> > > On Thu, Apr 20, 2023 at 2:10=E2=80=AFPM Stephen Boyd <swboyd@chromium=
.org> wrote:
> > > >
> > > > Quoting Stephen Boyd (2023-04-13 17:22:46)
> > > > > Quoting Pin-yen Lin (2023-04-13 02:50:44)
> > > > > >
> > > > > > Actually the `mode-switch` property here is mainly because
> > > > > > `fwnode_typec_mux_get`[1] and `typec_mux_match`[2] only return =
matches
> > > > > > when the property is present. I am not sure what side effects w=
ould be
> > > > > > if I remove the ID-matching condition in `typec_mux_match`, so =
I added
> > > > > > the property here.
> > > > > >
> > > > > > Is it feasible to remove the `mode-switch` property here given =
the
> > > > > > existing implementation of the Type-C framework?
> > > > >
> > > > > Omitting the mode-switch property would require changes to the ty=
pe-c
> > > > > framework.
> > > > >
> > > > > I'm wondering if we can have this anx driver register mode switch=
es for
> > > > > however many endpoints exist in the output port all the time when=
 the
> > > > > aux-bus node doesn't exist. Then the type-c framework can walk fr=
om the
> > > > > usb-c-connector to each connected node looking for a device that =
is both
> > > > > a drm_bridge and a mode-switch. When it finds that combination, i=
t knows
> > > > > that the mode-switch has been found. This hinges on the idea that=
 a
> > > > > device that would have the mode-switch property is a drm_bridge a=
nd
> > > > > would register a mode-switch with the type-c framework.
> > > > >
> > > > > It may be a little complicated though, because we would only regi=
ster
> > > > > one drm_bridge for the input to this anx device. The type-c walki=
ng code
> > > > > would need to look at the graph endpoint, and find the parent dev=
ice to
> > > > > see if it is a drm_bridge.
> > > >
> > > > I've been thinking more about this. I think we should only have the
> > > > 'mode-switch' property possible when the USB input pins (port@2) ar=
e
> > > > connected and the DPI input pins are connected (port@0). Probably y=
ou
> > > > don't have that case though?
> > >
> > > No we don't have the use case that uses the USB input pins on anx7625=
.
> > > >
> > > > In your case, this device should register either one or two drm_bri=
dges
> > > > that connect to whatever downstream is actually muxing the 2 DP lan=
es
> > > > with the USB SS lanes onto the usb-c-connector.
> > >
> > > What do you mean by "muxing the 2 DP lanes with the USB SS lanes''? I=
n
> > > our use case, the USB data lanes from both ports are connected to a
> > > USB hub, but the DP lanes are muxed by the crosspoint switch on
> > > anx7625. HPD and AUX for the external display are muxed by the EC. Yo=
u
> > > can find the diagram at
> > > https://lore.kernel.org/linux-usb/YxGzk6DNAt0aCvIY@chromium.org/
> >
> > I mean that you must have some sort of orientation switch hardware that
> > takes the 2 DP lanes and the 2 USB SuperSpeed "lanes" or "pairs" and
> > puts them all onto a usb-c-connector. The usb-c-connector node can't be
> > connected directly to the anx7625 in your diagram because there must be
> > some sort of "flipper" that does the orientation control. Otherwise the
> > usb-c-connector wouldn't work if the user flipped the cable. Probably
> > this is some TCPC or redriver controlled by the EC.
> >
> > >
> > > > If that is the EC for
> > > > ChromeOS, then the EC should have a binding that accepts some numbe=
r of
> > > > input ports for DP. The EC would act as a drm_bridge, or in this ca=
se
> > > > probably two bridges, and also as two type-c switches for each
> > > > drm_bridge corresponding to the usb-c-connector nodes. When DP is o=
n the
> > > > cable, the type-c switch/mux would signal to the drm_bridge that th=
e
> > > > display is 'connected' via DRM_BRIDGE_OP_DETECT and struct
> > > > drm_bridge_funcs::detect(). Then the drm_bridge in this anx part wo=
uld
> > > > implement struct drm_bridge_funcs::atomic_enable() and configure th=
e
> > > > crosspoint switch the right way depending on the reg property of th=
e
> > > > output node in port@1.
> > >
> > > So there will be two drm bridges that act as the downstreams for
> > > anx7625, and we find the downstream with connector_status_connected t=
o
> > > configure the crosspoint switch? How do we support that kind of
> > > topology given that the drm bridge chain is currently a list? Are you
> > > suggesting making the bridge topology to a tree, or maintaining the
> > > two downstreams inside the anx7625 driver and not attaching them to
> > > the bridge chain?
> >
> > Good point. I'm suggesting to make the drm bridge chain into a tree. We
> > need to teach drm_bridge core about a mux, and have some logic to
> > navigate atomically switching from one output to another. I was talking
> > with dianders@ and he was suggesting to use bridge attach/detach for
> > this. I'm not sure that will work though because that hook is only
> > called when the encoder is attached to the bridge.
> >
> > It may also turn out that this helps with DP multi-stream transport
> > (MST). As far as I can recall DP MST doesn't mesh well with drm_bridge
> > designs because it wants to operate on a drm_connector and
> > drm_bridge_connector_init() wants to make only one drm_connector for a
> > chain of bridges. If you squint, the anx7625 could be an MST "branch"
> > that only supports one drm_connector being enabled at a time. Maybe tha=
t
> > is what we should do here, make drm_bridge support creating more than
> > one drm_connector and when there is a mux in the tree it walks both
> > sides and runs a callback similar to struct
> > drm_dp_mst_topology_cbs::add_connector() to tell the encoder that
> > there's another possible drm_connector here.
>
> I have been surveying the approaches to change the bridge chain in
> runtime, and I found this thread[1]. Quoting from Daniel:
> "... exchanging the bridge chain isn't supported, there's no locking
> for that since it's assumed to be invariant over the lifetime of the
> drm_device instance. The simplest way to make that happen right now is to
> have 2 drm_encoder instances, one with the lvds bridge chain, the other
> with the hdmi bridge chain, and select the right encoder/bridge chain
> depending upon which output userspace picks.
> ...
> I wouldn't try to make bridge chains exchangeable instead, that's
> headaches - e.g. with dp mst we've also opted for a bunch of fake
> drm_encoders to model that kind of switching."
>
> I'm not sure how we register two encoders properly, though. Do we make
> the encoder driver check all the downstream bridges and register two
> drm_encoder when a bridge is acting as a mux?
>
> [1]: https://www.spinics.net/lists/dri-devel/msg340511.html
>
> >
> > >
> > > Also, if we still register mode switches on the two downstream
> > > bridges, why do you prefer that over the original approach that
> > > register switches in the anx7625 driver?
> >
> > I prefer to not have a mode-switch property here for a couple reasons:
> >
> >  1. The binding is usb type-c specific, and in the case of the IT6505
> >  part there is nothing that indicates this is a usb type-c piece of
> >  hardware. The IT6505 is simply a display bridge. The anx7625 part
> >  actually does accept usb signals though, but that isn't being used or
> >  described here. That's where my disclaimer about mode-switch making
> >  sense applies when the usb input is used.
> >
> >  2. Putting mode-switch into the graph endpoint nodes is awkward. It is
> >  a device property, and graph nodes are not devices. Some patches in
> >  this series have to work around this fact and special case the graph
> >  walking logic to treat the graph itself as a place to look for the
> >  property.
> >
> >  3. The mode-switch property probably isn't necessary at all. The DT
> >  reviewers have been asking why it is needed. The EC driver that
> >  registers the usb-c-connectors can be the mode-switch and the
> >  orientation-switch. And in reality, it _is_ both. The DP signals and
> >  the USB signals go to the TCPC/redriver that is controlled by the EC
> >  and the EC is the device that's doing the mode switching to push DP an=
d
> >  USB through the TCPC/redriver out on the right pins of the
> >  usb-c-connector.

I'm hoping that I'm replying to the right in-line comments.

The design I have tried was able to switch the runtime display, where
I initially booted the system with LVDS and once Linux comes up the
console then I can connect HDMI Out cable so-that switch bridge will
detect the HPD and Turn-Off LVDS and Turn-ON HDMI Display. If I unplug
HDMI Out cable then the switch bridge detects the change of HPD and
Turn-Off HDMI and Turn ON LVDS.

The design uses a switching bridge that acts as another gpio-interrupt
bridge that sits between the DSI controller and SN65DSI84/ADV7535
bridges. From the switch bridge, the final bridge pipeline will attach
during bridge ops attach call which is indeed uncommon with respect to
some of the mainline drivers. If the switch bridge detects the changes
in HPD then the handler will update kms and which indeed updates the
bridge chain at run-time. So may be unconventional but I don't find
any other solutions other than altering the bridge chain at run time.
Incidentally, I see more switch bridges coming on this design in the
market in order to produce more than one output.

May be it is a worthy topic to discuss further.

Thanks,
Jagan.
