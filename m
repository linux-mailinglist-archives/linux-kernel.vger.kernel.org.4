Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE06CF99E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjC3Dgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3Dgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:36:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473F4C13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:36:33 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 50F233F234
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680147390;
        bh=WVv3t+Pvx7XOKT30ywqnnbhHTlBPQeWR9Rwxzm5MrhU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WMg0xioAA20OBa6QjziKxn78H/GLCsj+Axsu5X44d9c646/icWWQByNG+fM1mol6b
         y/DQyHbe4bZgdMSSW01/sXw/LHo1N4oacDGOnMosytnBj06yWiUUaLjpdDayTdsizU
         /Zy3AFGMvd/NPaJzozmjFiEZjYP+VSWBe+USpXVHGMqi3PWvS9MFrckFxdSYGZLU/e
         2VYYTwiOROAQhaWQ5y23aoR12ChDfaInzw7isOe6JR0oDSuz1Ka2Zz86kdUHbei+UW
         zAMwYZ1OJYdPTSZwdpSV3eTyytDJ492wSVz2AjSNVVjnKIiHFZmrfDw299Gu83Z76W
         yF++Z2hw+s03w==
Received: by mail-pf1-f200.google.com with SMTP id x3-20020a62fb03000000b00622df3f5d0cso8221570pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680147388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVv3t+Pvx7XOKT30ywqnnbhHTlBPQeWR9Rwxzm5MrhU=;
        b=pUzuRNGDntzuhpr4dFMXGXIPOAnTMscxkiBpNTh1MBkd/i6Kbxnbq4h37KsbjoD/Wx
         nm8VIsr7q9/QFuDrcCmaiVtDQg9AzyeDuG0FzpX54SsZInmU+QH3sswWZomPRSVNwPbl
         DxZpfE4Q7Fhs7ovHtc6XCl6qHFzmM39wxL8968j9MAAEoplhwQpCQ/txaKJc5BgL74gr
         WY0ZR/eOmisyazxi3efB79fFGyXsv6vOHTDCnb7uFiBxCheZFCTdpcziHEJIjvseposN
         yDexrtt1L6OB6AY1JJdxKFxf5XlWfYgKpQ6c50lBEtWPOZSFGeFks1mHeF38KaCIQ0XU
         o+uw==
X-Gm-Message-State: AAQBX9dPgTOia5Ujb7Ok/fp96xTrl7scTfbzcDqN62YxuWbJyZiC0LvG
        yINeiUzLNfWRoW+uE3ZfInGGvEk9K/a7xqM0FQd8gPEYsW5A+cTy546rGhB8fxeoRLCKbd/FjTk
        mXfSGtobzguLbKW6t87yX5k/n8u2IND5oikrjLfdcUMDXXXTWU4k+umKcVA==
X-Received: by 2002:a65:520a:0:b0:513:a748:c7d5 with SMTP id o10-20020a65520a000000b00513a748c7d5mr36836pgp.3.1680147388557;
        Wed, 29 Mar 2023 20:36:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a7qcCrhgzUIomVjQN3NEsrGYThLydsbmh01I40JAf6r1o0KpqQ5jtvkohqYXO0KmVyfFwrKfX/56O0UesHOG8=
X-Received: by 2002:a65:520a:0:b0:513:a748:c7d5 with SMTP id
 o10-20020a65520a000000b00513a748c7d5mr36812pgp.3.1680147388176; Wed, 29 Mar
 2023 20:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230329095933.1203559-1-kai.heng.feng@canonical.com> <76853776-ddfd-2fbc-a209-ca4f77faa481@amd.com>
In-Reply-To: <76853776-ddfd-2fbc-a209-ca4f77faa481@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 30 Mar 2023 11:36:15 +0800
Message-ID: <CAAd53p7sgowhaFS1b7MM0F0kf14sWf6jbF9T__=4BAMM8bnz3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset GPU on S0ix when device supports BOCO
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Tim Huang <tim.huang@amd.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 9:23=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
> On 3/29/23 04:59, Kai-Heng Feng wrote:
> > When the power is lost due to ACPI power resources being turned off, th=
e
> > driver should reset the GPU so it can work anew.
> >
> > First, _PR3 support of the hierarchy needs to be found correctly. Since
> > the GPU on some discrete GFX cards is behind a PCIe switch, checking th=
e
> > _PR3 on downstream port alone is not enough, as the _PR3 can associate
> > to the root port above the PCIe switch.
>
> I think this should be split into two commits:
>
> * One of them to look at _PR3 further up in hierarchy to fix indication
> for BOCO support.

Yes, this part can be split up.

>
> * One to adjust policy for whether to reset

IIUC, the GPU only needs to be reset when the power status isn't certain?

Assuming power resources in _PR3 are really disabled, GPU is already
reset by itself. That means reset shouldn't be necessary for D3cold,
am I understanding it correctly?

However, this is a desktop plugged with GFX card that has external
power, does that assumption still stand? Perform resetting on D3cold
can cover this scenario.

>
>
> > Once the _PR3 is found and BOCO support is correctly marked, use that
> > information to inform the GPU should be reset. This solves an issue tha=
t
> > system freeze on a Intel ADL desktop that uses S0ix for sleep and D3col=
d
> > is supported for the GFX slot.
>
> I'm worried this is still papering over an underlying issue with L0s
> handling on ALD + Navi1x/Navi2x.

Is it possible to get the ASIC's ASPM parameter under Windows? Knowing
the difference can be useful.

>
> Also, what about runtime suspend?  If you unplug the monitor from this
> dGPU and interact with it over SSH it should go into runtime suspend.
>
> Is it working properly for that case now?

Thanks for the tip. Runtime resume doesn't work at all:
[ 1087.601631] pcieport 0000:00:01.0: power state changed by ACPI to D0
[ 1087.613820] pcieport 0000:00:01.0: restoring config space at offset
0x2c (was 0x43, writing 0x43)
[ 1087.613835] pcieport 0000:00:01.0: restoring config space at offset
0x28 (was 0x41, writing 0x41)
[ 1087.613841] pcieport 0000:00:01.0: restoring config space at offset
0x24 (was 0xfff10001, writing 0xfff10001)
[ 1087.613978] pcieport 0000:00:01.0: PME# disabled
[ 1087.613984] pcieport 0000:00:01.0: waiting 100 ms for downstream
link, after activation
[ 1089.330956] pcieport 0000:01:00.0: not ready 1023ms after resume; giving=
 up
[ 1089.373036] pcieport 0000:01:00.0: Unable to change power state
from D3cold to D0, device inaccessible

After a short while the whole system froze.

So the upstream port of GFX's PCIe switch cannot be powered on again.

Kai-Heng

>
> >
> > Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2458
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 ++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 +++++-------
> >   3 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 60b1857f469e..407456ac0e84 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -987,6 +987,9 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_dev=
ice *adev)
> >       if (amdgpu_sriov_vf(adev))
> >               return false;
> >
> > +     if (amdgpu_device_supports_boco(adev_to_drm(adev)))
> > +             return true;
> > +
> >   #if IS_ENABLED(CONFIG_SUSPEND)
> >       return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
> >   #else
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index f5658359ff5c..d56b7a2bafa6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2181,7 +2181,12 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
> >
> >       if (!(adev->flags & AMD_IS_APU)) {
> >               parent =3D pci_upstream_bridge(adev->pdev);
> > -             adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
> > +             do {
> > +                     if (pci_pr3_present(parent)) {
> > +                             adev->has_pr3 =3D true;
> > +                             break;
> > +                     }
> > +             } while ((parent =3D pci_upstream_bridge(parent)));
> >       }
> >
> >       amdgpu_amdkfd_device_probe(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index ba5def374368..5d81fcac4b0a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2415,10 +2415,11 @@ static int amdgpu_pmops_suspend(struct device *=
dev)
> >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >
> > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > -             adev->in_s0ix =3D true;
> > -     else if (amdgpu_acpi_is_s3_active(adev))
> > +     if (amdgpu_acpi_is_s3_active(adev) ||
> > +         amdgpu_device_supports_boco(drm_dev))
> >               adev->in_s3 =3D true;
> > +     else if (amdgpu_acpi_is_s0ix_active(adev))
> > +             adev->in_s0ix =3D true;
> >       if (!adev->in_s0ix && !adev->in_s3)
> >               return 0;
> >       return amdgpu_device_suspend(drm_dev, true);
> > @@ -2449,10 +2450,7 @@ static int amdgpu_pmops_resume(struct device *de=
v)
> >               adev->no_hw_access =3D true;
> >
> >       r =3D amdgpu_device_resume(drm_dev, true);
> > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > -             adev->in_s0ix =3D false;
> > -     else
> > -             adev->in_s3 =3D false;
> > +     adev->in_s0ix =3D adev->in_s3 =3D false;
> >       return r;
> >   }
> >
