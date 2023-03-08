Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBB6B0EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCHQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCHQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:39:19 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621BD515FD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:39:18 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17683b570b8so16546952fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678293557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HOwa/kMRvl0ZNeGTMl/f21Hk5h4VCvolFHb6yH1E7A=;
        b=Yr745RWyq3JzSo4tbib05k8wguC5rDY7kTjyMvAi8vxbRG+xdDY9GYrETj+IoA0vQK
         1hCZvzJrjvab6zc5lZC1PbPw0sy7CRpuSO4wtHDJ/01ElKmcvPfHDqzSR8BPwh95reO4
         sBzrv1T8oI0nmuFQeSbfVJ6iahJSTxUgMuetOECgalVXcpMufMlD4W1S5LU8CD+9Y+F5
         gbI58oQi9ou2kVhHkJoiqSk1RzpdeFs8jF3n9G+KmL2+XxWvfNGmkHAogIPGkf9yAMYz
         sfz0oBd2ubhQ/LItPgFaQ6lorhypahVGvUZW6u92kjrDls1+cbQ13Ev/jeYjsGaVcHNA
         gakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678293557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HOwa/kMRvl0ZNeGTMl/f21Hk5h4VCvolFHb6yH1E7A=;
        b=Ih1htoaGDHjknKTLzcTzI4epgHJkIKvi9lhRGnuAD/p9dHsFf842k3Vj737VW/atYG
         aKLC/UL7kM8S/+z6b3UqWG25w5Alt3k8l8GRB3HTecFXUBASZppytQVxr3RzeRAfffuc
         Gq6g6HGXcrF1o5VZUYuSijjEJBwjw9fGFM7iTJB8KqTD84jilFqJDLez2z/5+yTCDXlE
         86sLzRLSw4+gGqkDm8Y2wx08Yq7ib1HMDyUd+TsYxhkoJZrrkfNYAZ9tu8k5Mpw5ozZn
         apqH9RyzctnZO7JcBG8phbbzfOuAy5vMfHbdzA+Vr3HOvWhrGtMA9MehNhQnFJJliJQG
         oxNA==
X-Gm-Message-State: AO0yUKVxp3fR86YFj6N4Go/dp+ChWHwx6RQ1sib2nlukgaxjnFhTCxbF
        DejFUP0bVwSpZUxz+yGkhGHlgjedTEW3ML3vyL4b9D+u
X-Google-Smtp-Source: AK7set9zkyPQWjmBsbYUA/TRidhzesoonwBBMVqRMXy1MJ+C6oc0wUTAYrFJFh6OHeMg44NcfzI0hxQOMTw6aUTnd94=
X-Received: by 2002:a05:6870:5a97:b0:176:31db:9a49 with SMTP id
 dt23-20020a0568705a9700b0017631db9a49mr6451972oab.3.1678293557327; Wed, 08
 Mar 2023 08:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20230308093408.239331-1-qingqing.zhuo@amd.com>
 <ac8fed53-6f05-6ec7-9ef5-61110cd83c0b@amd.com> <20230308161945.svooztnablyvm75e@houat>
 <PH7PR12MB58315E9E7362E8A750393B6FFBB49@PH7PR12MB5831.namprd12.prod.outlook.com>
 <20230308163248.u7rvtadhlre3yua5@houat>
In-Reply-To: <20230308163248.u7rvtadhlre3yua5@houat>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 11:39:04 -0500
Message-ID: <CADnq5_NYnb1j9RnurMP2-TU4nAQRsPH8hsn_YXoiPZZ4woXOnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vc4: Fix build error with undefined label
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Emma Anholt <emma@anholt.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
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

On Wed, Mar 8, 2023 at 11:32 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Mar 08, 2023 at 04:27:01PM +0000, Zhuo, Qingqing (Lillian) wrote:
> > [AMD Official Use Only - General]
> >
> > > Hi,
> >
> > On Wed, Mar 08, 2023 at 11:11:22AM -0500, Hamza Mahfooz wrote:
> > > + vc4 maintainers
> > >
> > > On 3/8/23 04:34, Qingqing Zhuo wrote:
> > > > [Why]
> > > > drivers/gpu/drm/vc4/vc4_hdmi.c: In function =E2=80=98vc4_hdmi_bind=
=E2=80=99:
> > > > drivers/gpu/drm/vc4/vc4_hdmi.c:3448:17: error: label
> > > > =E2=80=98err_disable_runtime_pm=E2=80=99 used but not defined
> > > >
> > > > [How]
> > > > update err_disable_runtime_pm to err_put_runtime_pm.
> > > >
> > > > Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > > > ---
> > > >   drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > b/drivers/gpu/drm/vc4/vc4_hdmi.c index 9e145690c480..edf882360d24
> > > > 100644
> > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > @@ -3445,7 +3445,7 @@ static int vc4_hdmi_bind(struct device *dev, =
struct device *master, void *data)
> > > >            */
> > > >           ret =3D pm_runtime_resume_and_get(dev);
> > > >           if (ret)
> > > > -         goto err_disable_runtime_pm;
> > > > +         goto err_put_runtime_pm;
> > > >           if ((of_device_is_compatible(dev->of_node, "brcm,bcm2711-=
hdmi0") ||
> > > >                of_device_is_compatible(dev->of_node, "brcm,bcm2711-=
hdmi1"))
> > > > &&
> >
> > > The current drm-misc-next branch doesn't have that context at all. Wh=
at tree is this based on?
> >
> > This is for amd-staging-drm-next.
>
> I don't get it, why is there a vc4 patch in an AMD tree?

There isn't. it just happens to have an vc4 driver with this issue
when we branched it.  Lillian, please double check drm-next or
linux-next for non-AMD drivers

Alex
