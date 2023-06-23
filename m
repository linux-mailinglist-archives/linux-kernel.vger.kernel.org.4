Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33BE73C300
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFWVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:39:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC30E8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:39:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98d25cbbb43so135435366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687556393; x=1690148393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDPCLE1RQkTvsneplUketcXAUHKug/HnPFR18EZ6AFs=;
        b=rh8CgMHL2CJ0apk+OZNHOye2H6lF+tYhn+2PD+nbRiTI6VY/TE3CXI3qMGJ/pQkOWV
         O1fMBNSm23YqBi1c1bdtCOJNaGe4wWgXtQg7zcPIUruue8qyzwQXKtyYyZC4VOBr3AJN
         XAG61nRdd40N6PQ3wBhCw+/2CgS+8LMlRlTnRQ4H354o+fP8NTFga8FvlGdSF7CmZOVS
         GYrcJgpxBdTbmPUSWjKjRCFaeqiwsZ4Yi7yAoyzB74Hx+jmMb7dmFTaujt0ykty3WqGS
         BeNP+ZGqWGEcEKgGr4q/KqzE0Fu/kL71ff5lhSNjumKUzugAt9e5ebVr8+4dwFfhb5KB
         WOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556393; x=1690148393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPCLE1RQkTvsneplUketcXAUHKug/HnPFR18EZ6AFs=;
        b=VIzNMvnPfYxanW+NFnzHwIHrYEdF5fYh19kw0qQITcU18d/zN79LU4A0H3UDO9wFM4
         nHmbvW+cKJx4lfEGKEJnkIAPjcSqt/YacgXKCJ+aAcBj8lexidMTGPdyWCNqI6Oh54H8
         CEEzb/89JT2xIuwMSbUwkGmbkBrJrKiwUF6auhRBE7J1/JqvE4/8XdoHRx8SiDob18g/
         MNBWUnOlX1hM7dBpqtZjuB/+5b/6Uag7o72eazVWu3wX9qoi6PnBrM3WE28And5efWvP
         9yKkYYo7w4NKHSdd92DvEC/UmMD0t6CcCDGDPBvR/lAOLamb0GoVQDgW7KuH7NBEwwt6
         pRVQ==
X-Gm-Message-State: AC+VfDxT2Nlpmf3HDly/G5xjy7qffEgI6B5DFq7GsXZ7OtwswEYZuHQH
        do5ytMjymwWnafQtRr8wDOKbVVk9FtlcYXD/ebIDDzDCiTk=
X-Google-Smtp-Source: ACHHUZ7jX9fQESz+mCRUFDUxcYHWjremM0Jjg5A7lhHtogW5QN8OXanaIBIKvu4MWWbX1yMKIdWTbXIhjHsI5zmujRc=
X-Received: by 2002:a17:907:7e8b:b0:988:fafd:d93a with SMTP id
 qb11-20020a1709077e8b00b00988fafdd93amr13044572ejc.70.1687556393257; Fri, 23
 Jun 2023 14:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230623211808.7667-1-alexander.deucher@amd.com>
In-Reply-To: <20230623211808.7667-1-alexander.deucher@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 24 Jun 2023 07:39:40 +1000
Message-ID: <CAPM=9tyQBhUftYrrQzTNwfZqoaXAwHDydKCFiYkqH18ESTapOA@mail.gmail.com>
Subject: Re: [pull] amdgpu drm-fixes-6.4
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull this directly,

Thanks,
Dave.

On Sat, 24 Jun 2023 at 07:18, Alex Deucher <alexander.deucher@amd.com> wrot=
e:
>
> Hi Dave, Daniel, Linus,
>
> Last few fixes for 6.4.  Dave already sent out the drm-fixes PR this week=
.
> I was out of the office earlier in the week and just got this out now.
>
> The following changes since commit 9bd9be5cbaf8a8faa175ef4fba04a5623281de=
be:
>
>   Merge tag 'drm-misc-fixes-2023-06-21' of git://anongit.freedesktop.org/=
drm/drm-misc into drm-fixes (2023-06-23 12:16:48 +1000)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.4-2=
023-06-23
>
> for you to fetch changes up to 134ea95255cf359a2e6d70308c15243c3fdf8eaf:
>
>   drm/amd: Don't try to enable secure display TA multiple times (2023-06-=
23 16:44:45 -0400)
>
> ----------------------------------------------------------------
> amd-drm-fixes-6.4-2023-06-23:
>
> amdgpu:
> - BO locking fixes
> - MCBP fix
> - GPU mapping clear fix for always valid BOs
> - ASPM fixes
> - SDMA4 hang fix
> - Misc display fixes
> - Parade TCON PSR hang fix
> - SMU13 fixes
> - Gang submit fence fix
> - Secure display fix
>
> ----------------------------------------------------------------
> Alex Deucher (1):
>       drm/amdgpu/sdma4: set align mask to 255
>
> Christian K=C3=B6nig (3):
>       drm/amdgpu: make sure BOs are locked in amdgpu_vm_get_memory
>       drm/amdgpu: make sure that BOs have a backing store
>       drm/amdgpu: fix number of fence calculations
>
> Evan Quan (2):
>       drm/amd/pm: revise the ASPM settings for thunderbolt attached scena=
rio
>       drm/amd/pm: update the LC_L1_INACTIVITY setting to address possible=
 noise issue
>
> Hamza Mahfooz (1):
>       drm/amd/display: perform a bounds check before filling dirty rectan=
gles
>
> Ilya Bakoulin (1):
>       drm/amd/display: Fix 128b132b link loss handling
>
> Jiadong Zhu (1):
>       drm/amdgpu: Skip mark offset for high priority rings
>
> Kenneth Feng (1):
>       drm/amd/pm: add abnormal fan detection for smu 13.0.0
>
> Leo Chen (1):
>       drm/amd/display: disable seamless boot if force_odm_combine is enab=
led
>
> Mario Limonciello (2):
>       drm/amd: Disable PSR-SU on Parade 0803 TCON
>       drm/amd: Don't try to enable secure display TA multiple times
>
> Samuel Pitoiset (1):
>       drm/amdgpu: fix clearing mappings for BOs that are always valid in =
VM
>
> Sung-huai Wang (1):
>       drm/amd/display: add a NULL pointer check
>
> Tao Zhou (1):
>       drm/amdgpu: check RAS irq existence for VCN/JPEG
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 11 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c       |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 81 ++++++++++++++--=
------
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             | 13 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  4 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  4 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 13 ++--
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +
>  .../drm/amd/display/dc/dce112/dce112_resource.c    | 10 +--
>  .../dc/link/protocols/link_dp_irq_handler.c        | 11 ++-
>  .../drm/amd/display/modules/power/power_helpers.c  |  2 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  1 +
>  16 files changed, 108 insertions(+), 62 deletions(-)
