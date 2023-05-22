Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362870CE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjEVWi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjEVWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:38:53 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67CFA;
        Mon, 22 May 2023 15:38:49 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 02484E0003;
        Mon, 22 May 2023 22:38:45 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Date:   Tue, 23 May 2023 00:38:37 +0200
Message-ID: <12724349.O9o76ZdvQC@bagend>
Organization: Connecting Knowledge
In-Reply-To: <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <4995215.LvFx2qVVIh@bagend>
 <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6188399.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6188399.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Tue, 23 May 2023 00:38:37 +0200
Message-ID: <12724349.O9o76ZdvQC@bagend>
Organization: Connecting Knowledge
In-Reply-To: <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
MIME-Version: 1.0

On Monday, 22 May 2023 18:17:39 CEST Benjamin Gaignard wrote:
> Le 20/05/2023 =E0 00:34, Diederik de Haas a =E9crit :
> > On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
> >> Le jeudi 13 avril 2023 =E0 10:10 -0300, Ezequiel Garcia a =E9crit :
> >>> Benjamin,
> >>>=20
> >>> Please include the crash stracktrace in the commit.
> >>=20
> >> Careful with HTML message, they don't always make it in these ML and
> >> tooling might not play well with the tooling. Perhaps it can be edited
> >> while pulling ? Here's the info from Marek's bug report:
> >>=20
> >> hantro-vpu fdea0000.video-codec: Adding to iommu group 0
> >> hantro-vpu fdea0000.video-codec: registered rockchip,rk3568-vpu-dec as
> >> /dev/video0
> >> hantro-vpu fdee0000.video-codec: Adding to iommu group 1
> >> hantro-vpu fdee0000.video-codec: registered rockchip,rk3568-vepu-enc as
> >> /dev/video1
> >> Unable to handle kernel NULL pointer dereference at virtual address
> >> 0000000000000008
> >> Mem abort info:
> >> ESR =3D 0x0000000096000004
> >> EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >> SET =3D 0, FnV =3D 0
> >> EA =3D 0, S1PTW =3D 0
> >> FSC =3D 0x04: level 0 translation fault
> >> Data abort info:
> >> ISV =3D 0, ISS =3D 0x00000004
> >> CM =3D 0, WnR =3D 0
> >> user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000001f446f000
> >> [0000000000000008] pgd=3D0000000000000000, p4d=3D0000000000000000
> >> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> >> Modules linked in: hantro_vpu v4l2_vp9 v4l2_h264 v4l2_mem2mem
> >> videobuf2_dma_contig snd_soc_simple_card display_connector
> >> snd_soc_simple_card_utils videobuf2_memops crct10dif_ce dwmac_rk
> >> rockchip_thermal videobuf2_v4l2 stmmac_platform rockchip_saradc
> >> industrialio_triggered_buffer kfifo_buf stmmac videodev pcs_xpcs
> >> rtc_rk808 videobuf2_common rockchipdrm panfrost mc drm_shmem_helper
> >> analogix_dp gpu_sched dw_mipi_dsi dw_hdmi drm_display_helper ip_tables
> >> x_tables ipv6
> >> CPU: 3 PID: 171 Comm: v4l_id Not tainted 6.3.0-rc2+ #13478
> >> Hardware name: Hardkernel ODROID-M1 (DT)
> >> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >> pc : hantro_try_fmt+0xb4/0x280 [hantro_vpu]
> >> lr : hantro_try_fmt+0xa8/0x280 [hantro_vpu]
> >> ...
> >> Call trace:
> >> hantro_try_fmt+0xb4/0x280 [hantro_vpu]
> >> hantro_set_fmt_out+0x3c/0x278 [hantro_vpu]
> >> hantro_reset_raw_fmt+0x94/0xb4 [hantro_vpu]
> >> hantro_set_fmt_cap+0x23c/0x250 [hantro_vpu]
> >> hantro_reset_fmts+0x94/0xcc [hantro_vpu]
> >> hantro_open+0xd4/0x20c [hantro_vpu]
> >> v4l2_open+0x80/0x120 [videodev]
> >> chrdev_open+0xc0/0x22c
> >> do_dentry_open+0x13c/0x490
> >> vfs_open+0x2c/0x38
> >> path_openat+0x550/0x938
> >> do_filp_open+0x80/0x12c
> >> do_sys_openat2+0xb4/0x16c
> >> __arm64_sys_openat+0x64/0xac
> >> invoke_syscall+0x48/0x114
> >> el0_svc_common.constprop.0+0xfc/0x11c
> >> do_el0_svc+0x38/0xa4
> >> el0_svc+0x48/0xb8
> >> el0t_64_sync_handler+0xb8/0xbc
> >> el0t_64_sync+0x190/0x194
> >> Code: 97fe726c f940aa80 52864a61 72a686c1 (b9400800)
> >> ---[ end trace 0000000000000000 ]---
> >=20
> > When I booted into my 6.4-rc1 (but also rc2) kernel on my
> > Pine64 Quartz64 Model A, I noticed a crash which seems the same as
> > above, but I didn't have such a crash with my 6.3 kernel.
> > Searching for 'hantro' led me to this commit as the most likely culprit
> > but when I build a new 6.4-rcX kernel with this commit reverted,
> > I still had this crash.
> > Do you have suggestions which commit would then be the likely culprit?
>=20
> This patch fix the crash at boot time, revert it doesn't seem to be the
> solution. Maybe this proposal from Marek can help you ?
> https://patchwork.kernel.org/project/linux-media/patch/20230421104759.223=
646
> 3-1-m.szyprowski@samsung.com/

That helped :) After applying that patch I no longer have the crash.
Thanks!

Regards,
  Diederik
--nextPart6188399.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZGvu7QAKCRDXblvOeH7b
br2PAQDj5Bfj6kYYHjq/pdKmygrT72o07zj2ahEajN9V9ICBbgD/Y24+lrtBDJlf
0wtyQ6QF5oTL9Beq3+c97CE1nMAsegk=
=p9LE
-----END PGP SIGNATURE-----

--nextPart6188399.DvuYhMxLoT--



