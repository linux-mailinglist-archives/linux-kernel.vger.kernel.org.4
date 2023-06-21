Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE47388C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjFUPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjFUPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE237271D;
        Wed, 21 Jun 2023 08:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1316157F;
        Wed, 21 Jun 2023 15:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD77C433C0;
        Wed, 21 Jun 2023 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687360651;
        bh=XeX3n2Ex4fOTZjDwqLGXcfRd6/4GgUf3KTctiEH8LGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxD2EJcFfTQ8e0cNCj5ca8stnZ+HWvu2Z6jfzHsH40oDNnGqGsGsTxUp7OZXR1bYn
         L2Cu5aduSVIyfzDJaQJ8LBD9PZPlimATgUAaYJhLHhjXuqjmSUDNZDfmXYdGkRXX1D
         SZuf5sWQDgcP9i//v6Js7lLFgh8H/1xh9l/iNPW3WQFx5xYhnSjBywD0RiJx3X3fxd
         HyY+OqhP0dKpoidf4iSM7md2bDRx2WcWd3MSgW6MeTKz3BM6w/fj3+jLyZNEB8eKL0
         /vSntbHj3I3fuwXmj9Oa+2Zbtg7OYxrqqWWHfc7MKnKkfDCKuJKfl0JkBGuJONuHey
         GHEFZKeNjMxwg==
Date:   Wed, 21 Jun 2023 16:17:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>,
        mark.rutland@arm.com, arnd@arndb.de
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
Message-ID: <20230621-stupor-violin-930ccc7d7593@spud>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy>
 <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lvXd4hUgqP0KdRuW"
Content-Disposition: inline
In-Reply-To: <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lvXd4hUgqP0KdRuW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnd, Perf people,

On Tue, Jun 20, 2023 at 11:14:32AM +0800, Eric Lin wrote:
> On Fri, Jun 16, 2023 at 6:13=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
> > > From: Greentime Hu <greentime.hu@sifive.com>
> > >
> > > This adds SiFive private L2 cache PMU driver. User
> > > can use perf tool to profile by event name and event id.
> > >
> > > Example:
> > > $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
> > >                 -e /sifive_pl2_pmu/inner_acquire_block_ntob/
> > >                 -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
> > >
> > >  Performance counter stats for 'CPU(s) 0':
> > >
> > >                300      sifive_pl2_pmu/inner_acquire_block_btot/
> > >              17801      sifive_pl2_pmu/inner_acquire_block_ntob/
> > >               5253      sifive_pl2_pmu/inner_acquire_block_ntot/
> > >
> > >        0.088917326 seconds time elapsed
> > >
> > > $ perf stat -C 0 -e /sifive_pl2_pmu/event=3D0x10001/
> > >                 -e /sifive_pl2_pmu/event=3D0x4001/
> > >                 -e /sifive_pl2_pmu/event=3D0x8001/ ls
> > >
> > >  Performance counter stats for 'CPU(s) 0':
> > >
> > >                251      sifive_pl2_pmu/event=3D0x10001/
> > >               2620      sifive_pl2_pmu/event=3D0x4001/
> > >                644      sifive_pl2_pmu/event=3D0x8001/
> > >
> > >        0.092827110 seconds time elapsed
> > >
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > > Reviewed-by: Zong Li <zong.li@sifive.com>
> > > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > > ---
> > >  drivers/soc/sifive/Kconfig            |   9 +
> > >  drivers/soc/sifive/Makefile           |   1 +
> > >  drivers/soc/sifive/sifive_pl2.h       |  20 +
> > >  drivers/soc/sifive/sifive_pl2_cache.c |  16 +
> > >  drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++++++=
++
> >
> > Perf drivers should be in drivers/perf, no?
> >
>=20
> Hi Conor,
>=20
> Yes, I see most of the drivers are in the drivers/perf.
>=20
> But I grep perf_pmu_register(), it seems not all the pmu drivers are
> in drivers/perf as below:
>=20
> arch/arm/mach-imx/mmdc.c:517:   ret =3D
> perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
> arch/arm/mm/cache-l2x0-pmu.c:552:       ret =3D
> perf_pmu_register(l2x0_pmu, l2x0_name, -1);
> ...
> drivers/dma/idxd/perfmon.c:627: rc =3D perf_pmu_register(&idxd_pmu->pmu,
> idxd_pmu->name, -1);
> drivers/fpga/dfl-fme-perf.c:904:static int
> fme_perf_pmu_register(struct platform_device *pdev,
> drivers/fpga/dfl-fme-perf.c:929:        ret =3D perf_pmu_register(pmu, na=
me, -1);
> ...
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =3D
> perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =3D
> perf_pmu_register(&pmu->base, pmu->name, -1);
> drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =3D
> perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
> drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =3D
> perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> drivers/iommu/intel/perfmon.c:570:      return
> perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
> drivers/nvdimm/nd_perf.c:309:   rc =3D perf_pmu_register(&nd_pmu->pmu,
> nd_pmu->pmu.name, -1);
> ...
>=20
> I just wondering what kind of pmu drivers should be in drivers/perf
> and what kind of pmu drivers should not be in drivers/perf.
> Thanks.

To be quite honest, I have no idea.
I'm just a wee bit wary of taking anything that appears to have another
home via drivers/soc. I'd rather break drivers out, using the aux bus or
similar if need be, so that people who are knowledgeable in an area are
CCed on patches.
Hopefully Arnd or the Perf people can offer some guidance here. If it
does go into drivers/soc, it'll need a review from someone knowledgeable
of perf anyway.

Cheers,
Conor.

--lvXd4hUgqP0KdRuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJMUhAAKCRB4tDGHoIJi
0gQPAP9NA5+xGxexqqs9oKDQy5JFuGFIRMNc1wrRkTfe1WpeaQEAnpjQJ6IBF65+
oBS810J/hKoiRXGWz+RIZLvb6+b7MQs=
=s8XO
-----END PGP SIGNATURE-----

--lvXd4hUgqP0KdRuW--
