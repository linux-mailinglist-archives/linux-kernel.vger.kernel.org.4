Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE464D4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLOAiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLOAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:38:09 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C54D5ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:38:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s25so8466584lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaXTzEJKmgLz+SAFN0DeG64y723tiZblK0P+iFI17hA=;
        b=nXgdMXMlXc4YZNcKifowoGMKNa+co1HPUWTVq27PRY6w89JZ3Ejc2212MRdAFIYUhy
         rKkdpqfNS7kdTebj4RVOgs9+ajsaVD1JqxFXnQllO/yuel6HEDH7DdO+g8uVNPJ/2cZj
         Icos7gQxPO6B9djSw6RJdPjG4OMUWfPs35k/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SaXTzEJKmgLz+SAFN0DeG64y723tiZblK0P+iFI17hA=;
        b=NGDP3r1AxAW/bSoXth7y7zPQ4Qjo248Oat0RyQTnYOKx7ASh5dawHJzAJVdNQYekey
         1ClrZebqYMSVnLVa0pDre2OoHRyipsPtjfGP5+JJLMK0xezmUwWw41CRFe7aqmXyqZ8m
         O7LGUYtxJfQ4F6Wi4QksWe3/lCE/NCbzKG4cViX5NEatp943KcphBckndzgz6l5yDeOL
         W3ztgIsz3Wquyk2os7OAMCYBktwx0QU0gsIUY5wjuEkPaT1K1YiLdxy1tIKRxlyldfHc
         n+RWqOmX6YrVskKFRacfu3AIoNkzwoE0alpYGgRrNJTl9c1e3hrkXtJkQIl1iSz5qWFI
         4rBw==
X-Gm-Message-State: ANoB5pmh2YBDYccR/fImmjJl1WxZpIlCOLa9+EPYZkE8k1PdPhh6mxx/
        S/CyH2w+IPf/Z8Y/JB6Xvt0Rswmo7TJDKu2hY/stOg==
X-Google-Smtp-Source: AA0mqf4VcPwauzdtgPycgk8YSzSnpCLwL/tuuSk9YZ6/aN69rAyE9+MaT6XlGF2IV6qyZaGEtZp4gqVNb6T4m84M1vA=
X-Received: by 2002:a2e:a544:0:b0:278:f5b8:82c8 with SMTP id
 e4-20020a2ea544000000b00278f5b882c8mr26380240ljn.228.1671064684762; Wed, 14
 Dec 2022 16:38:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Dec 2022 19:38:04 -0500
MIME-Version: 1.0
In-Reply-To: <b38af164-08bc-07e7-dfaf-fb4d6d89d7db@quicinc.com>
References: <1670967848-31475-1-git-send-email-quic_khsieh@quicinc.com>
 <1670967848-31475-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52eHYCqxUJqQXoaQ8vyqCk-QfouSun+zUp3yo5DufWbwg@mail.gmail.com> <b38af164-08bc-07e7-dfaf-fb4d6d89d7db@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 14 Dec 2022 19:38:04 -0500
Message-ID: <CAE-0n53Cb6TFGfM6AYup5aP4=24j0ujVPi463oVqmzfNV2B4RA@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-12-14 14:56:23)
>
> On 12/13/2022 3:06 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-12-13 13:44:05)
> >> Add both data-lanes and link-frequencies property into endpoint
> > Why do we care? Please tell us why it's important.

Any response?

> >> @@ -193,6 +217,8 @@ examples:
> >>                   reg =3D <1>;
> >>                   endpoint {
> >>                       remote-endpoint =3D <&typec>;
> >> +                    data-lanes =3D <0 1>;
> >> +                    link-frequencies =3D /bits/ 64 <1620000000 270000=
0000 5400000000 8100000000>;
> >>                   };
> > So far we haven't used the output port on the DP controller in DT.
> >
> > I'm still not clear on what we should do in general for DP because
> > there's a PHY that actually controls a lane count and lane mapping. In
> > my mental model of the SoC, this DP controller's output port is
> > connected to the DP PHY, which then sends the DP lanes out of the SoC t=
o
> > the next downstream device (i.e. a DP connector or type-c muxer). Havin=
g
> > a remote-endpoint property with a phandle to typec doesn't fit my menta=
l
> > model. I'd expect it to be the typec PHY.
> ack
> >
> > That brings up the question: when we have 2 lanes vs. 4 lanes will we
> > duplicate the data-lanes property in the PHY binding? I suspect we'll
> > have to. Hopefully that sort of duplication is OK?
> Current we have limitation by reserve 2 data lanes for usb2, i am not
> sure duplication to 4 lanes will work automatically.
> >
> > Similarly, we may have a redriver that limits the link-frequencies
> > property further (e.g. only support <=3D 2.7GHz). Having multiple
> > link-frequencies along the graph is OK, right? And isn't the
> > link-frequencies property known here by fact that the DP controller
> > tells us which SoC this controller is for, and thus we already know the
> > supported link frequencies?
> >
> > Finally, I wonder if we should put any of this in the DP controller's
> > output endpoint, or if we can put these sorts of properties in the DP
> > PHY binding directly? Can't we do that and then when the DP controller
> > tries to set 4 lanes, the PHY immediately fails the call and the link
> > training algorithm does its thing and tries fewer lanes? And similarly,
> > if link-frequencies were in the PHY's binding, the PHY could fail to se=
t
> > those frequencies during link training, returning an error to the DP
> > controller, letting the training move on to a lower frequency. If we di=
d
> > that this patch series would largely be about modifying the PHY binding=
,
> > updating the PHY driver to enforce constraints, and handling errors
> > during link training in the DP controller (which may already be done? I
> > didn't check).
>
>
> phy/pll have different configuration base on link lanes and rate.
>
> it has to be set up before link training can start.
>
> Once link training start, then there are no any interactions between
> controller and phy during link training session.

What do you mean? The DP controller calls phy_configure() and changes
the link rate. The return value from phy_configure() should be checked
and link training should skip link rates that aren't supported and/or
number of lanes that aren't supported.

>
> Link training only happen between dp controller and sink since link
> status is reported by sink (read back from sink's dpcd register directly)=
.
>
> T achieve link symbol locked, link training will start from reduce link
> rate until lowest rate, if it still failed, then it will reduce lanes
> with highest rate and start training=C2=A0 again.
>
> it will repeat same process until lowest lane (one lane), if it still
> failed, then it will give up and declare link training failed.

Yes, that describes the link training algorithm. I don't see why
phy_configure() return value can't be checked and either number of lanes
or link frequencies be checked. If only two lanes are supported, then
phy_configure() will fail for the 4 link rates and the algorithm will
reduce the number of lanes and go back to the highest rate. Then when
the highest rate isn't supported it will drop link rate until the link
rate is supported.

>
> Therefore I think add data-lanes and link-frequencies properties in the
> DP PHY binding directly will not helps.
>

I didn't follow your logic. Sorry.
