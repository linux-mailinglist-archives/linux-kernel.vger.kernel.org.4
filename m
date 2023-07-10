Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1568574DC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjGJR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjGJR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:26:12 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D71991
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:25:43 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3a8d21208so4188683b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689009941; x=1691601941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwgPAnsoGImOTpKq/zgwf6map72bf6KrCfvboKElITA=;
        b=DnCRB6tsdzjlZdKHrMnTb+fC53VCqYuDwixkgrKRM5vkGYDJ6nsznyKJbdq55hSYir
         mFzCJQA1nH7WVsRT814upyrlygD8ernOA230UGe35rMY0mRqzasAH9olSl2vrbuMF7GJ
         Hi9NqqnbgQUWtLUHVa4+cQgOxLdcucRMuFEEPCwgLMMYWFBfDAaKCESSQUqk5LLYS9rx
         So7fu0G4QstJOO+fjRuIYdM0Ov+YkF9F3a0ycLNIcK7qqF15+UyKhpdwKyNdqA4yjjdK
         WFqpyuTYa58MYkQT5vNszobbwT6ex9gjhFkYReikjFaICWssNy4t521UH339mhzP3S33
         dHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009941; x=1691601941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwgPAnsoGImOTpKq/zgwf6map72bf6KrCfvboKElITA=;
        b=PlO3vxFX7BUlBq4FO+kCdyHnT8vqA9pKQk3xZieQdp1OAJPtvLalYkCjbCxIcKvrnq
         IoSHtmoz9UDXG0d0/eCv5Ve8EEMlE+qYCtfL94SEoCUIBiTfM0j1GQ5v9alSDOkoWjUJ
         oLlRRYIYXEQKowNresrjcOb7y1h7AkQCXAOq1u1Om7c9tNZEgB26Q+gAn3FkYy9wms0d
         OmL05Ok+r9KNnu1UaJRi85NnStF1zLJREyx5iBxPvsW0nugNRF7yyYjMNUpjSc1G/bOU
         FytvdHFD8CQNXHNimlJVF/M/lBvs+t8QLVy44NodKtYawy6HVYsjJ49zyO5UoeuMznEA
         2QBw==
X-Gm-Message-State: ABy/qLZkPTwlFppEKgkyQywTiwDYMQC+z9emNrSVNTU15EvUpUDkYnUE
        ssMlLgCGds07+r/NbN96yeYOz+3GkgqNpyoKGTw=
X-Google-Smtp-Source: APBJJlH/RdvKZQnN1ndDfZW8FAy2oHtzFDZlusBzzOd+2kexWvU0EPGCZvfCyy3cnsNAgi5CdTrlDwOygmJybHGlQDk=
X-Received: by 2002:aca:2308:0:b0:3a1:b638:9c2c with SMTP id
 e8-20020aca2308000000b003a1b6389c2cmr11821118oie.55.1689009941122; Mon, 10
 Jul 2023 10:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082515.54604-1-xujianghui@cdjrlc.com> <0cd737878affc60b7b34d58ea9e10e50@208suo.com>
In-Reply-To: <0cd737878affc60b7b34d58ea9e10e50@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 13:25:30 -0400
Message-ID: <CADnq5_MAcyk=h8BebxrZ52n0Dsh3vj9PtjEUaD=PfDmhkej-cg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Mon, Jul 10, 2023 at 4:27=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix four occurrences of the checkpatch.pl error:
> ERROR: "(foo*)" should be "(foo *)"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_atombios.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c
> b/drivers/gpu/drm/radeon/radeon_atombios.c
> index bf3c411a55c5..85c4bb186203 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -1389,7 +1389,7 @@ bool radeon_atombios_get_ppll_ss_info(struct
> radeon_device *rdev,
>
>           num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
>               sizeof(ATOM_SPREAD_SPECTRUM_ASSIGNMENT);
> -        ss_assign =3D (struct _ATOM_SPREAD_SPECTRUM_ASSIGNMENT*)
> +        ss_assign =3D (struct _ATOM_SPREAD_SPECTRUM_ASSIGNMENT *)
>               ((u8 *)&ss_info->asSS_Info[0]);
>           for (i =3D 0; i < num_indices; i++) {
>               if (ss_assign->ucSS_Id =3D=3D id) {
> @@ -1402,7 +1402,7 @@ bool radeon_atombios_get_ppll_ss_info(struct
> radeon_device *rdev,
>                   ss->refdiv =3D ss_assign->ucRecommendedRef_Div;
>                   return true;
>               }
> -            ss_assign =3D (struct _ATOM_SPREAD_SPECTRUM_ASSIGNMENT*)
> +            ss_assign =3D (struct _ATOM_SPREAD_SPECTRUM_ASSIGNMENT *)
>                   ((u8 *)ss_assign + sizeof(struct
> _ATOM_SPREAD_SPECTRUM_ASSIGNMENT));
>           }
>       }
> @@ -3406,7 +3406,7 @@ static ATOM_VOLTAGE_OBJECT_V2
> *atom_lookup_voltage_object_v2(ATOM_VOLTAGE_OBJECT
>   {
>       u32 size =3D le16_to_cpu(v2->sHeader.usStructureSize);
>       u32 offset =3D offsetof(ATOM_VOLTAGE_OBJECT_INFO_V2,
> asVoltageObj[0]);
> -    u8 *start =3D (u8*)v2;
> +    u8 *start =3D (u8 *)v2;
>
>       while (offset < size) {
>           ATOM_VOLTAGE_OBJECT_V2 *vo =3D (ATOM_VOLTAGE_OBJECT_V2 *)(start=
 +
> offset);
> @@ -3423,7 +3423,7 @@ static ATOM_VOLTAGE_OBJECT_V3
> *atom_lookup_voltage_object_v3(ATOM_VOLTAGE_OBJECT
>   {
>       u32 size =3D le16_to_cpu(v3->sHeader.usStructureSize);
>       u32 offset =3D offsetof(ATOM_VOLTAGE_OBJECT_INFO_V3_1,
> asVoltageObj[0]);
> -    u8 *start =3D (u8*)v3;
> +    u8 *start =3D (u8 *)v3;
>
>       while (offset < size) {
>           ATOM_VOLTAGE_OBJECT_V3 *vo =3D (ATOM_VOLTAGE_OBJECT_V3 *)(start=
 +
> offset);
