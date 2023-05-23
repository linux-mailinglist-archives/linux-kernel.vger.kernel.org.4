Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D470E60B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjEWTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEWTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:53:04 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0511D;
        Tue, 23 May 2023 12:53:00 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af6ec6d73bso1449a34.3;
        Tue, 23 May 2023 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684871579; x=1687463579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp+ShQdW7PB+8DG4rAciHgSrob5gFvAziJEY22PEZdo=;
        b=H/qd4f3vNxm2DmFvUxFqVq8G30x7NRqd9AGckXg3qMNfAg9NSA6zVZ4hwOTjxj7Ex5
         CIRdifTNTphlreVZXLYHYXsbjxiLUoXurl3OjJRj/1a74MMh6GTQNEOs7Q8G4NBBV+JA
         DNaui/5hFWzVQhGHp5TguZXH9u0VzpqZAUHDwvRdciNuSQPyTdS8HxkUh1ZKHkPl1mlg
         FvvTLO2ZzT2muayA8X0VffUp8E77Ibee1CKZ1ewcdwbeA6vrijZA1qI4bDD/yHo7kl53
         6U3TadjvS81Cq1TBUorY7ZrhbsNn7+LxJopMEalzvHsMOxyVCY+GeM/oUtjgpxjnef+4
         ECgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684871579; x=1687463579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp+ShQdW7PB+8DG4rAciHgSrob5gFvAziJEY22PEZdo=;
        b=R6IqThwvfY9GMig/qQghgevQ9diUlfKJ1tsX/F4GnNBNd8EsSCZniseKnkUhECVaSI
         ko4+hS9C2q57iE61nEyMmevbTyGdkhe3tFikk3ZRQ93cYYlh4ooJLPBjHdyGbeKncfjA
         zYme7xwzwsaXvqO7yh2KSAGN1Rrd1qDdd/OhXsMR7CYGNOYUiw13L4qnPHYoNW8fUFDR
         +ESR/xsVBrUn1eDos4G94KXGILJXSqDtuF4NqxMWOJwomE70d6V7wz5aNTgAJ9oSTP4u
         I0AblvEkYsq2/DRDjB8u3JgiXg4mFrNmwBGGlhaGtEBLWhk397CqPjg6FDXftkVekugd
         5wyQ==
X-Gm-Message-State: AC+VfDyGCSodKIJEZeYLk5KxlePNweG6hZStRd3yTZ+/oj3U/yjo3uLP
        WLlzrGIdnatJ5/+Y2X8EzGZNPMpCcRi8gXj7tloNI/dt
X-Google-Smtp-Source: ACHHUZ6ULiPhWw1lgwrqdu23Hrw7vXt2YVDLQ/71nwCurMNdKV2WTpd4fsR5i54abHRQv2b7sT9H399LZQgRqLDxYKM=
X-Received: by 2002:a9d:5617:0:b0:6aa:e821:88eb with SMTP id
 e23-20020a9d5617000000b006aae82188ebmr7119572oti.4.1684871579561; Tue, 23 May
 2023 12:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
 <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org> <ZGzalLjTvUfzEADU@hovoldconsulting.com>
 <f530691b-989d-b059-6b06-e66abb740bdb@quicinc.com>
In-Reply-To: <f530691b-989d-b059-6b06-e66abb740bdb@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 23 May 2023 12:52:48 -0700
Message-ID: <CAF6AEGuNO46Nz0sTD+yDPa_7PF2u7Phx+rGPFUSJBz7nwaya_A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: add module parameter for PSR
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        swboyd@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 23, 2023 at 12:23=E2=80=AFPM Abhinav Kumar
<quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 5/23/2023 8:24 AM, Johan Hovold wrote:
> > On Fri, May 12, 2023 at 09:13:04PM +0300, Dmitry Baryshkov wrote:
> >> On 28/04/2023 02:28, Abhinav Kumar wrote:
> >>> On sc7280 where eDP is the primary display, PSR is causing
> >>> IGT breakage even for basic test cases like kms_atomic and
> >>> kms_atomic_transition. Most often the issue starts with below
> >>> stack so providing that as reference
> >>>
> >>> Call trace:
> >>>    dpu_encoder_assign_crtc+0x64/0x6c
> >>>    dpu_crtc_enable+0x188/0x204
> >>>    drm_atomic_helper_commit_modeset_enables+0xc0/0x274
> >>>    msm_atomic_commit_tail+0x1a8/0x68c
> >>>    commit_tail+0xb0/0x160
> >>>    drm_atomic_helper_commit+0x11c/0x124
> >>>    drm_atomic_commit+0xb0/0xdc
> >>>    drm_atomic_connector_commit_dpms+0xf4/0x110
> >>>    drm_mode_obj_set_property_ioctl+0x16c/0x3b0
> >>>    drm_connector_property_set_ioctl+0x4c/0x74
> >>>    drm_ioctl_kernel+0xec/0x15c
> >>>    drm_ioctl+0x264/0x408
> >>>    __arm64_sys_ioctl+0x9c/0xd4
> >>>    invoke_syscall+0x4c/0x110
> >>>    el0_svc_common+0x94/0xfc
> >>>    do_el0_svc+0x3c/0xb0
> >>>    el0_svc+0x2c/0x7c
> >>>    el0t_64_sync_handler+0x48/0x114
> >>>    el0t_64_sync+0x190/0x194
> >>> ---[ end trace 0000000000000000 ]---
> >>> [drm-dp] dp_ctrl_push_idle: PUSH_IDLE pattern timedout
> >>>
> >>> Other basic use-cases still seem to work fine hence add a
> >>> a module parameter to allow toggling psr enable/disable till
> >>> PSR related issues are hashed out with IGT.
> >>
> >> For the reference: Bjorn reported that he has issues with VT on a
> >> PSR-enabled laptops. This patch fixes the issue for him
> >
> > Module parameters are almost never warranted, and it is definitely not
> > the right way to handle a broken implementation.
> >
> > I've just sent a revert that unconditionally disables PSR support until
> > the implementation has been fixed:
> >
> >       https://lore.kernel.org/lkml/20230523151646.28366-1-johan+linaro@=
kernel.org/
> >
> > Johan
>
> I dont completely agree with this. Even the virtual terminal case was
> reported to be fixed by one user but not the other. So it was probably
> something missed out either in validation or reproduction steps of the
> user who reported it to be fixed OR the user who reported it not fixed.
> That needs to be investigated now.
>
> We should have ideally gone with the modparam with the feature patches
> itself knowing that it gets enabled for all sinks if PSR is supported.
>
> I had discussed with Rob that till we have some more confidence with the
> reported issues we would go with the modparam so as to not do the full
> revert.
>
> In this particular case, the one line revert is not really a deal
> breaker. In some other implementations, it might not really be so
> trivial to revert the feature with a one line change.
>
> So I would like to understand what is the concern with the mod param if
> the maintainers are onboard with it.

Tbf, I'd go further in the modparam direction, ie. add a default
disabled modparam, but then _also_ enable the modparam in CI and add
the failing tests to xfails.  I'd rather have xfails in CI than skips.

Acked-by: Rob Clark <robdclark@gmail.com>

BR,
-R
