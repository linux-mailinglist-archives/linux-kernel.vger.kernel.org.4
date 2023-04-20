Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3916E8DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjDTJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjDTJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:11:41 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344D46AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:11:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7637c5ed865so75758539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681981857; x=1684573857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jApLsIPicCWYWY8ghJs6Wqkso3cOUL2m8oysLKQNPCs=;
        b=Ur9jtx0E94T0GI9XNaXArOQcj0se42481pOZjFlLPL+HB5Lj3VQ0Skl82gG5KPW/re
         V0XDWaTSQ6C8cKi+Hx/1+6fYNfQIAmbBMmPo9Tx61XMp6Lk4cMhypk7IL0R+08PSOOT6
         fulCTs04wVatbGLIdZn0FIjfOxwjNWV2iKIEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681981857; x=1684573857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jApLsIPicCWYWY8ghJs6Wqkso3cOUL2m8oysLKQNPCs=;
        b=DpHJB2ZRuZbp+i3uWA5LyttETQ/6h98E5UFs0THcuaPA+u03jIjNuxMwO8zx3vfqLS
         CzGPTGC8ZQIsG06C8Zdzh7z5HFUnMJkfu5C7WxHjNbip80oyZdmPsX7AX0SxarfDS5ZS
         hKwZ93TuMEa3oA7z6SDFphsttukibOlEHXKLib8DEQNXYSkOj76KM5w0EToB5tlKQ+ky
         xk2i+rtVpP+IpsuEV/4niXJIDVBpbt4A50kMbwfWeSGPGKFLvRY9kajVUkBtZbWky4YM
         fcChUTL+3R0tzLR+5aav7Acm/CcPmkKl72P7PnIE2VW2scsCpRZga9sIR1A3UuwT8Fzh
         DVIw==
X-Gm-Message-State: AAQBX9ewzeTB+vSpqH6qHF+6tAbltOLsjUkaxh1eYF6LXsqCqnOpdzQY
        ZoG8y1JoRPGaKpl4mUhGf+I8myFT3bJV6EK9NrsF/g==
X-Google-Smtp-Source: AKy350Y4t++JqRfXaFXQUgB02uSAJYZVXkFSdgGLBxELTeSwXAZpeLFbnln9lKU9ujIzGQATjnMs8vmkMD8DbLkGgsY=
X-Received: by 2002:a02:b019:0:b0:40f:910c:92d6 with SMTP id
 p25-20020a02b019000000b0040f910c92d6mr253400jah.6.1681981856946; Thu, 20 Apr
 2023 02:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230331091145.737305-1-treapking@chromium.org>
 <20230331091145.737305-5-treapking@chromium.org> <CAE-0n51E5foFWQAsA73662_5e6XP426wuUCVVmcS5UWwiYpDmw@mail.gmail.com>
 <CAEXTbpdcbB_z4ZGCGzc-cM74ECKyxekbroKCWFnhH8eR=4HmvA@mail.gmail.com>
 <CAE-0n50atfmr-bFh5XtTCm4WpSijJGSe0B5JP8ni7CCYk7Bs5A@mail.gmail.com> <CAE-0n51Qy-KDGHOCr4Smpebq1fCURqvJ2RJz6KAtVpv5e+DSGA@mail.gmail.com>
In-Reply-To: <CAE-0n51Qy-KDGHOCr4Smpebq1fCURqvJ2RJz6KAtVpv5e+DSGA@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 20 Apr 2023 17:10:46 +0800
Message-ID: <CAEXTbpeKe1dVHp9cauMN-9nQb35oJ-ZhdFV-8BiWzjjhWAy0Zg@mail.gmail.com>
Subject: Re: [PATCH v15 04/10] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 2:10=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Stephen Boyd (2023-04-13 17:22:46)
> > Quoting Pin-yen Lin (2023-04-13 02:50:44)
> > >
> > > Actually the `mode-switch` property here is mainly because
> > > `fwnode_typec_mux_get`[1] and `typec_mux_match`[2] only return matche=
s
> > > when the property is present. I am not sure what side effects would b=
e
> > > if I remove the ID-matching condition in `typec_mux_match`, so I adde=
d
> > > the property here.
> > >
> > > Is it feasible to remove the `mode-switch` property here given the
> > > existing implementation of the Type-C framework?
> >
> > Omitting the mode-switch property would require changes to the type-c
> > framework.
> >
> > I'm wondering if we can have this anx driver register mode switches for
> > however many endpoints exist in the output port all the time when the
> > aux-bus node doesn't exist. Then the type-c framework can walk from the
> > usb-c-connector to each connected node looking for a device that is bot=
h
> > a drm_bridge and a mode-switch. When it finds that combination, it know=
s
> > that the mode-switch has been found. This hinges on the idea that a
> > device that would have the mode-switch property is a drm_bridge and
> > would register a mode-switch with the type-c framework.
> >
> > It may be a little complicated though, because we would only register
> > one drm_bridge for the input to this anx device. The type-c walking cod=
e
> > would need to look at the graph endpoint, and find the parent device to
> > see if it is a drm_bridge.
>
> I've been thinking more about this. I think we should only have the
> 'mode-switch' property possible when the USB input pins (port@2) are
> connected and the DPI input pins are connected (port@0). Probably you
> don't have that case though?

No we don't have the use case that uses the USB input pins on anx7625.
>
> In your case, this device should register either one or two drm_bridges
> that connect to whatever downstream is actually muxing the 2 DP lanes
> with the USB SS lanes onto the usb-c-connector.

What do you mean by "muxing the 2 DP lanes with the USB SS lanes''? In
our use case, the USB data lanes from both ports are connected to a
USB hub, but the DP lanes are muxed by the crosspoint switch on
anx7625. HPD and AUX for the external display are muxed by the EC. You
can find the diagram at
https://lore.kernel.org/linux-usb/YxGzk6DNAt0aCvIY@chromium.org/

> If that is the EC for
> ChromeOS, then the EC should have a binding that accepts some number of
> input ports for DP. The EC would act as a drm_bridge, or in this case
> probably two bridges, and also as two type-c switches for each
> drm_bridge corresponding to the usb-c-connector nodes. When DP is on the
> cable, the type-c switch/mux would signal to the drm_bridge that the
> display is 'connected' via DRM_BRIDGE_OP_DETECT and struct
> drm_bridge_funcs::detect(). Then the drm_bridge in this anx part would
> implement struct drm_bridge_funcs::atomic_enable() and configure the
> crosspoint switch the right way depending on the reg property of the
> output node in port@1.

So there will be two drm bridges that act as the downstreams for
anx7625, and we find the downstream with connector_status_connected to
configure the crosspoint switch? How do we support that kind of
topology given that the drm bridge chain is currently a list? Are you
suggesting making the bridge topology to a tree, or maintaining the
two downstreams inside the anx7625 driver and not attaching them to
the bridge chain?

Also, if we still register mode switches on the two downstream
bridges, why do you prefer that over the original approach that
register switches in the anx7625 driver?

>
> Because you don't have the part that implements the orientation-switch,
> you don't need to implement the code for it. I think simply adding
> support in the binding for mode-switch and orientation-switch if this is
> directly wired to a usb-c-connector should be sufficient. Those
> properties would be at the top-level and not part of the graph binding.
