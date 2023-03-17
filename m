Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC856BF2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQUiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:38:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9DE1FCA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:38:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bh20so4699077oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiRvHTQSgz2sGcSTSQDgv3aXyZNisuXYRa3sxKRv48Y=;
        b=noYwnuOKwWFBEAWH0wq1AdvXvo0lxwy+yu1fQsV7rQIPzMSyaxnzBDlyQxhC4v52Ct
         yXtAe5qHKmzlFVyMg2MvEFUZ/in5sNDuzVPjvobe2cQE62L/zUXtgdG9/5dE98golwAz
         Ed6z4X5fJrzBPJ92tZUmfPGZpMxFkxdUQn3yJLtTRhXkKIZI73bNql15Ard1aygScgz2
         hkyTxS5hYGkMVbyo34mOVMwqwZXxoQZn1uAlYtJA8C4RMswGdbBrsnvGqU2wuoxXbDhG
         oZuh9h0n4hPXDMqiJ6BIgFFltwVOeD84pfIPmMRcaNmpuio5cimIqvhzvcT6GeJgdDUp
         NBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiRvHTQSgz2sGcSTSQDgv3aXyZNisuXYRa3sxKRv48Y=;
        b=VeRC4df7dJ7XxG0buGOFwpWSw6MpecLuheprdkUOs4vsHMomTN1ExYic9Np8R0VioR
         o3YKHTndRMLuzlOPUaJ9JY/ipTRpTB5A6XGgIVD5KN1TuI253Tm/jWi75zy59RM/fEIm
         2gogUIt4vZxmo0Q3kpcISj6Qf1/Ze+WJSPV9L8piHfrpRP1XEZyuvEltzl3ka7k0+Kin
         2sHh5j7L0trgvU7T3OBeqQvINsvjwWOlE+3fHryjLlRV20Rch4pD/jXOtlIBa1OutjA8
         Z3OrbisXyaj7WY7V0+zcQjTbMF4oJQrOekf+JXCly3ySpJoq7mD0IxS5VvTgeUdCv4uQ
         NfJA==
X-Gm-Message-State: AO0yUKV8kiGXG/Z4DRyjBGouajUk9pXjFGwYtPzReYaqM6nm1e1aImHJ
        vfCSdmvK2aNip6wuCyHz4GPV41ZoLbeSs6JOLb8=
X-Google-Smtp-Source: AK7set8f+RPp3l5ctUFTldzEQWJ2g1WSss80boStaRHFLdQ+ziQfn8ZgMwEGBd9VJfl8grT2a0sf3hJhAwAYLhNr0Zs=
X-Received: by 2002:a05:6808:6384:b0:386:9c6c:ebc with SMTP id
 ec4-20020a056808638400b003869c6c0ebcmr3725311oib.3.1679085495886; Fri, 17 Mar
 2023 13:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-30-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-30-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:38:04 -0400
Message-ID: <CADnq5_PR+VHHELVqbVYjOoJA-u_2V=kZmbyk2E0LJ==QOwPnbw@mail.gmail.com>
Subject: Re: [PATCH 29/37] drm/amd/display/dc/link/link_detection: Remove
 unused variable 'status'
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Wenjing Liu <wenjing.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c: In funct=
ion =E2=80=98query_hdcp_capability=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:501:42: w=
arning: variable =E2=80=98status=E2=80=99 set but not used [-Wunused-but-se=
t-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index 9177b146a80a8..9a4cfa777622e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -498,8 +498,6 @@ static void query_hdcp_capability(enum signal_type si=
gnal, struct dc_link *link)
>         dc_process_hdcp_msg(signal, link, &msg22);
>
>         if (signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT || signal =3D=3D SIGNA=
L_TYPE_DISPLAY_PORT_MST) {
> -               enum hdcp_message_status status =3D HDCP_MESSAGE_UNSUPPOR=
TED;
> -
>                 msg14.data =3D &link->hdcp_caps.bcaps.raw;
>                 msg14.length =3D sizeof(link->hdcp_caps.bcaps.raw);
>                 msg14.msg_id =3D HDCP_MESSAGE_ID_READ_BCAPS;
> @@ -507,7 +505,7 @@ static void query_hdcp_capability(enum signal_type si=
gnal, struct dc_link *link)
>                 msg14.link =3D HDCP_LINK_PRIMARY;
>                 msg14.max_retries =3D 5;
>
> -               status =3D dc_process_hdcp_msg(signal, link, &msg14);
> +               dc_process_hdcp_msg(signal, link, &msg14);
>         }
>
>  }
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
