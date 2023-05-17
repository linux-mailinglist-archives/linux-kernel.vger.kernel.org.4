Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D8370737E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEQVDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:03:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B45B85;
        Wed, 17 May 2023 14:03:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ab38a85a1eso980956a34.1;
        Wed, 17 May 2023 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684357388; x=1686949388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yscgqUTR1f75Dpuvdyvo/LM34y7Four8Xo8HFyqJqAY=;
        b=r8L8WhCz6Txtq/XEy+HNrrarx7HTmEQu439citQF4p5Mdk3EEsgCPmSsOvvX19LnMT
         vEreCjsqyDqs6Y9By4M+3kESJn2SA7gTR4gcQ+eU4PoWeTWcsRmdPFfqMnhotQhVAXpo
         Sm677HmP+sZTO0CeNvUMQS7WmqSbyhol6IJt/OcGOSmf4pd9jITNdZj+0hQfTdI+0EaO
         46PGtor8YGm4aRqS1ASJ3Oet4fchvtwYqOrEjoTubAxkXycU+QwTnn+StM77wUb15D/M
         fkB5+paBMWac5lP7pYgJvRQmAmhjW0Mm87QH/nnpcMLUjMTMaY2YGD3sd4ZdCkKIO1Or
         FbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684357388; x=1686949388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yscgqUTR1f75Dpuvdyvo/LM34y7Four8Xo8HFyqJqAY=;
        b=RnhjgPo29VhJnK2E5Ip52HxD51zw3VBjj0oROCAPmNSyv969T/NAzSs6fg6Z3SELpy
         n8NT3ls4b/hz0d+KxXCXEU4IpBwfOj7lsZUh0pwxNXAP47C0j4vk0coyz3dpwMFkLRIZ
         HoFGbSD7w1LRUKnDAsX55TeRjWViK8qhwSPFc8BQVhDXhYKAN4ErnEv5d75E4MnYkeAP
         8KLDpaTBVu9hdPbLZBnYN//+kMV/h4if5bq1qKCTmbPeoT/cCeqou7eJAD0djnv67+jd
         C3LvtOpIBi5KVzbRAlbzYgYQTewuWvANSilIGV8AKhE5PmdY0RdYW6xk1dp4Hs7FnUe1
         sKCg==
X-Gm-Message-State: AC+VfDxZ6kwXoYSH8q5TsA+Gx96C5OaZ2qGqChma+mfpP9efkOf4xTFd
        w9NDdalLSGQtuC7PRWPBOjFjIA9i9yoWDw7fQwHdXk6K
X-Google-Smtp-Source: ACHHUZ7cTEQNg9F2+W+6DvNoiF+0D+SrpOPXBFq2tbsF5THQLDHAxo0D0ITWyUZNPSHBWYdZyNVmQZWpguWLBq2VYkk=
X-Received: by 2002:a05:6870:e281:b0:18e:d237:9693 with SMTP id
 v1-20020a056870e28100b0018ed2379693mr72228oad.46.1684357388082; Wed, 17 May
 2023 14:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230517025219.50281-1-suhui@nfschina.com>
In-Reply-To: <20230517025219.50281-1-suhui@nfschina.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 May 2023 17:02:57 -0400
Message-ID: <CADnq5_OjW+hzwSBox5ApEHO0HPPt_gfHsNydMDZPpOHCgdY0FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove unnecessary (void*) conversions
To:     Su Hui <suhui@nfschina.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, May 17, 2023 at 3:08=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> No need cast (void*) to (struct radeon_device *)
> or (struct radeon_ring *).
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/r100.c         | 8 ++++----
>  drivers/gpu/drm/radeon/r300.c         | 2 +-
>  drivers/gpu/drm/radeon/r420.c         | 2 +-
>  drivers/gpu/drm/radeon/r600.c         | 2 +-
>  drivers/gpu/drm/radeon/radeon_fence.c | 2 +-
>  drivers/gpu/drm/radeon/radeon_gem.c   | 2 +-
>  drivers/gpu/drm/radeon/radeon_ib.c    | 2 +-
>  drivers/gpu/drm/radeon/radeon_pm.c    | 2 +-
>  drivers/gpu/drm/radeon/radeon_ring.c  | 2 +-
>  drivers/gpu/drm/radeon/radeon_ttm.c   | 2 +-
>  drivers/gpu/drm/radeon/rs400.c        | 2 +-
>  drivers/gpu/drm/radeon/rv515.c        | 4 ++--
>  12 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.=
c
> index d4f09ecc3d22..affa9e0309b2 100644
> --- a/drivers/gpu/drm/radeon/r100.c
> +++ b/drivers/gpu/drm/radeon/r100.c
> @@ -2929,7 +2929,7 @@ static void r100_set_safe_registers(struct radeon_d=
evice *rdev)
>  #if defined(CONFIG_DEBUG_FS)
>  static int r100_debugfs_rbbm_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t reg, value;
>         unsigned i;
>
> @@ -2948,7 +2948,7 @@ static int r100_debugfs_rbbm_info_show(struct seq_f=
ile *m, void *unused)
>
>  static int r100_debugfs_cp_ring_info_show(struct seq_file *m, void *unus=
ed)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         struct radeon_ring *ring =3D &rdev->ring[RADEON_RING_TYPE_GFX_IND=
EX];
>         uint32_t rdp, wdp;
>         unsigned count, i, j;
> @@ -2974,7 +2974,7 @@ static int r100_debugfs_cp_ring_info_show(struct se=
q_file *m, void *unused)
>
>  static int r100_debugfs_cp_csq_fifo_show(struct seq_file *m, void *unuse=
d)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t csq_stat, csq2_stat, tmp;
>         unsigned r_rptr, r_wptr, ib1_rptr, ib1_wptr, ib2_rptr, ib2_wptr;
>         unsigned i;
> @@ -3022,7 +3022,7 @@ static int r100_debugfs_cp_csq_fifo_show(struct seq=
_file *m, void *unused)
>
>  static int r100_debugfs_mc_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32(RADEON_CONFIG_MEMSIZE);
> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.=
c
> index 7b0cfeaddcec..9c1a92fa2af6 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -589,7 +589,7 @@ int rv370_get_pcie_lanes(struct radeon_device *rdev)
>  #if defined(CONFIG_DEBUG_FS)
>  static int rv370_debugfs_pcie_gart_info_show(struct seq_file *m, void *u=
nused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32_PCIE(RADEON_PCIE_TX_GART_CNTL);
> diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.=
c
> index 7e6320e8c6a0..eae8a6389f5e 100644
> --- a/drivers/gpu/drm/radeon/r420.c
> +++ b/drivers/gpu/drm/radeon/r420.c
> @@ -474,7 +474,7 @@ int r420_init(struct radeon_device *rdev)
>  #if defined(CONFIG_DEBUG_FS)
>  static int r420_debugfs_pipes_info_show(struct seq_file *m, void *unused=
)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32(R400_GB_PIPE_SELECT);
> diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.=
c
> index dd78fc499402..382795a8b3c0 100644
> --- a/drivers/gpu/drm/radeon/r600.c
> +++ b/drivers/gpu/drm/radeon/r600.c
> @@ -4345,7 +4345,7 @@ int r600_irq_process(struct radeon_device *rdev)
>
>  static int r600_debugfs_mc_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>
>         DREG32_SYS(m, rdev, R_000E50_SRBM_STATUS);
>         DREG32_SYS(m, rdev, VM_L2_STATUS);
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/rade=
on/radeon_fence.c
> index 73e3117420bf..2749dde5838f 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -955,7 +955,7 @@ void radeon_fence_driver_force_completion(struct rade=
on_device *rdev, int ring)
>  #if defined(CONFIG_DEBUG_FS)
>  static int radeon_debugfs_fence_info_show(struct seq_file *m, void *data=
)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         int i, j;
>
>         for (i =3D 0; i < RADEON_NUM_RINGS; ++i) {
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index bdc5af23f005..5de99ffa072f 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -879,7 +879,7 @@ int radeon_mode_dumb_create(struct drm_file *file_pri=
v,
>  #if defined(CONFIG_DEBUG_FS)
>  static int radeon_debugfs_gem_info_show(struct seq_file *m, void *unused=
)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         struct radeon_bo *rbo;
>         unsigned i =3D 0;
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/=
radeon_ib.c
> index 6a45a72488f9..fb9ecf5dbe2b 100644
> --- a/drivers/gpu/drm/radeon/radeon_ib.c
> +++ b/drivers/gpu/drm/radeon/radeon_ib.c
> @@ -292,7 +292,7 @@ int radeon_ib_ring_tests(struct radeon_device *rdev)
>
>  static int radeon_debugfs_sa_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>
>         radeon_sa_bo_dump_debug_info(&rdev->ring_tmp_bo, m);
>
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/=
radeon_pm.c
> index cbc554928bcc..b73fd9ab0252 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -1916,7 +1916,7 @@ static void radeon_dynpm_idle_work_handler(struct w=
ork_struct *work)
>
>  static int radeon_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         struct drm_device *ddev =3D rdev->ddev;
>
>         if  ((rdev->flags & RADEON_IS_PX) &&
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeo=
n/radeon_ring.c
> index 7e207276df37..e6534fa9f1fb 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -464,7 +464,7 @@ void radeon_ring_fini(struct radeon_device *rdev, str=
uct radeon_ring *ring)
>
>  static int radeon_debugfs_ring_info_show(struct seq_file *m, void *unuse=
d)
>  {
> -       struct radeon_ring *ring =3D (struct radeon_ring *) m->private;
> +       struct radeon_ring *ring =3D m->private;
>         struct radeon_device *rdev =3D ring->rdev;
>
>         uint32_t rptr, wptr, rptr_next;
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index 2220cdf6a3f6..06a53ecc04a2 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -780,7 +780,7 @@ void radeon_ttm_set_active_vram_size(struct radeon_de=
vice *rdev, u64 size)
>
>  static int radeon_ttm_page_pool_show(struct seq_file *m, void *data)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>
>         return ttm_pool_debugfs(&rdev->mman.bdev.pool, m);
>  }
> diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs40=
0.c
> index 6383f7a34bd8..922a29e58880 100644
> --- a/drivers/gpu/drm/radeon/rs400.c
> +++ b/drivers/gpu/drm/radeon/rs400.c
> @@ -307,7 +307,7 @@ void rs400_mc_wreg(struct radeon_device *rdev, uint32=
_t reg, uint32_t v)
>  #if defined(CONFIG_DEBUG_FS)
>  static int rs400_debugfs_gart_info_show(struct seq_file *m, void *unused=
)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32(RADEON_HOST_PATH_CNTL);
> diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv51=
5.c
> index 63fb06e8e2d7..76260fdfbaa7 100644
> --- a/drivers/gpu/drm/radeon/rv515.c
> +++ b/drivers/gpu/drm/radeon/rv515.c
> @@ -221,7 +221,7 @@ void rv515_mc_wreg(struct radeon_device *rdev, uint32=
_t reg, uint32_t v)
>  #if defined(CONFIG_DEBUG_FS)
>  static int rv515_debugfs_pipes_info_show(struct seq_file *m, void *unuse=
d)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32(GB_PIPE_SELECT);
> @@ -237,7 +237,7 @@ static int rv515_debugfs_pipes_info_show(struct seq_f=
ile *m, void *unused)
>
>  static int rv515_debugfs_ga_info_show(struct seq_file *m, void *unused)
>  {
> -       struct radeon_device *rdev =3D (struct radeon_device *)m->private=
;
> +       struct radeon_device *rdev =3D m->private;
>         uint32_t tmp;
>
>         tmp =3D RREG32(0x2140);
> --
> 2.30.2
>
