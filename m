Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3626F36B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjEATZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjEATZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:25:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396132D50
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:24:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38dfa504391so1832520b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969098; x=1685561098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bLR1GbZyZQUdq7br0qZHdQ9hAXjjgioO0YDBrhDkvo=;
        b=pXZA61PiZhaZlnA+xdKWkmYbzFs3eWCrQJ8H26eQPJ5EhIP9vceeHgFdijexnZeuTa
         zva8i2qX3O/jIS293YZUCi9hSKEDvKIr9QntcEczJtJMLZHLPseq6Pc+LhuaQjXE1jtr
         HTBBHUMRKOj9byGzHQle9Tj3/52RtiZysg4sEmcXgo9JTUdFi4z1TFYZ8gs4epy+6Is3
         eALRJ0e8JNELbb4zriVyatIA7YEVoCNem8b8UpsZDAdd8q8IrQJ9KisngOuHKQOJ/VYI
         Vm9e0XMNcHfMIHM+WLwX4trfGehb9Ko+g8LocHXn1uIkMwXFd6loNHHdPEubWnGSUJ4J
         bqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969098; x=1685561098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bLR1GbZyZQUdq7br0qZHdQ9hAXjjgioO0YDBrhDkvo=;
        b=fOWy65Oe5PqyDfpvg8O39bf1Xx7TWJGyV4C1rz8u9eTE8Up5FDzLfo0kn1Mr79Kj5m
         YSuEGQxm7kCq8stS92O60vyt763PHrPGQW+jv23oSYx0lCatN7KNR1xi6ZeIA3WdpH6f
         QzRzgxIIH2Ii75/CzeWex0z5gkNBjgqfs3W9GcHHpi7UziFr+xCgMzFX5+U1Vq7Ywe4X
         QPjCob5ygMoRgtO4HReJYsYY9/oWr4rJejaEk2YI1uegrazU2BAMCE7KdJ19I4WFYG2c
         intO5wwsLpaIB5u6dfsFo+SADHgQpLU18rxLucBHoXVamaR4WtDZ64FKPSYYijHXyMBe
         lvWQ==
X-Gm-Message-State: AC+VfDxsCKc027/+s7hrh/iHe01TOvhXLDDutSNi383PcJaHNf5/jjQs
        4GbyxoyPM6f1DwNeNJa3MO3Q4FZr1xwU7ZddeD4=
X-Google-Smtp-Source: ACHHUZ59tWI8+zhOkYkZ6pl9dhM5SsMozl6Skp/3tRe2BBRCrTjJMg8N/8iR0vG+rgDark0GOGaqZmsDR2BrWi16Wxg=
X-Received: by 2002:a05:6808:2342:b0:38d:ed4a:52eb with SMTP id
 ef2-20020a056808234200b0038ded4a52ebmr6825147oib.38.1682969098214; Mon, 01
 May 2023 12:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230501185747.33519-1-andrealmeid@igalia.com>
In-Reply-To: <20230501185747.33519-1-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 1 May 2023 15:24:46 -0400
Message-ID: <CADnq5_NXj4W44F_etRQ7HWdVTnf5zARCM3Y_o3EiwWiHj8QMpA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Add AMDGPU_INFO_GUILTY_APP ioctl
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com, christian.koenig@amd.com
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

On Mon, May 1, 2023 at 2:58=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Currently UMD hasn't much information on what went wrong during a GPU res=
et. To
> help with that, this patch proposes a new IOCTL that can be used to query
> information about the resources that caused the hang.

If we went with the IOCTL, we'd want to limit this to the guilty process.

>
> The goal of this RFC is to gather feedback about this interface. The mesa=
 part
> can be found at https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests=
/22785
>
> The current implementation is racy, meaning that if two resets happens (e=
ven on
> different rings), the app will get the last reset information available, =
rather
> than the one that is looking for. Maybe this can be fixed with a ring_id
> parameter to query the information for a specific ring, but this also req=
uires
> an interface to tell the UMD which ring caused it.

I think you'd want engine type or something like that so mesa knows
how to interpret the IB info.  You could store the most recent info in
the fd priv for the guilty app.  E.g., see what I did for tracking GPU
page fault into:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl

>
> I know that devcoredump is also used for this kind of information, but I =
believe
> that using an IOCTL is better for interfacing Mesa + Linux rather than pa=
rsing
> a file that its contents are subjected to be changed.

Can you elaborate a bit on that?  Isn't the whole point of devcoredump
to store this sort of information?

Alex


>
> Andr=C3=A9 Almeida (1):
>   drm/amdgpu: Add interface to dump guilty IB on GPU hang
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  7 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 29 ++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h            |  7 ++++++
>  7 files changed, 52 insertions(+), 1 deletion(-)
>
> --
> 2.40.1
>
