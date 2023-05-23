Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2570DB27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjEWLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEWLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:06:21 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B82FD;
        Tue, 23 May 2023 04:06:19 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523110614euoutp02a29bb60b1cf063096552cfef59dae07b~hwQesOLC22721527215euoutp02J;
        Tue, 23 May 2023 11:06:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523110614euoutp02a29bb60b1cf063096552cfef59dae07b~hwQesOLC22721527215euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684839974;
        bh=LvmWWTdeo8NJLJrvLCy+RlGOb++PIzwBjJtTyVBLH10=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qtGCPTn4Y35XnciMKMI+Uny1s8jweJ+WVIPwWn8ZCX8KPfOdPwxIgZih2lpXITu6r
         Ix6uirxVhIe2wGewH66sj7DY2/XJIOddnl38XZFZQIlpjG+nWZDwDnZRxE8mNXDafp
         V1wrW89TOwkEdMev92s1RaRkQNehPCjYODDQ6rZU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230523110614eucas1p267f629707538c7b6a62bb138ac8e0fb5~hwQejXmRq1639016390eucas1p2z;
        Tue, 23 May 2023 11:06:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.F4.11320.62E9C646; Tue, 23
        May 2023 12:06:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523110613eucas1p1d504533387155d7d1c5806f3259f7e89~hwQeH1DXy1101711017eucas1p1E;
        Tue, 23 May 2023 11:06:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230523110613eusmtrp105cdb87855f36718a4e4cd6adef47dcc~hwQeHSx-Z1820818208eusmtrp16;
        Tue, 23 May 2023 11:06:13 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-80-646c9e26d674
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.83.10549.52E9C646; Tue, 23
        May 2023 12:06:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523110613eusmtip1ea43fa603f782331e7202065fde06d05~hwQd5Mms92279622796eusmtip1T;
        Tue, 23 May 2023 11:06:13 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 12:06:12 +0100
Date:   Tue, 23 May 2023 13:06:11 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bott test warning
Message-ID: <20230523110611.ph22q32w3vhc5zhc@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="y7qniprnbfkodh4h"
Content-Disposition: inline
In-Reply-To: <20230523135739.73068c68@canb.auug.org.au>
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7pq83JSDD7dZrG4vGsOm8XBhW2M
        FjcmPGW02Lr3KrsDi0fjjRtsHptWdbJ5fN4kF8AcxWWTkpqTWZZapG+XwJVxYcI+1oI9whWb
        1kxnaWBcLNjFyMEhIWAi0fXcuIuRi0NIYAWjxOMdn1kgnC+MEuff90M5nxklulY9Y+xi5ATr
        uPhqJxuILSSwnFHiw0IpuKIZ57ZDJbYwSjTN0gaxWQRUJSbv/MkMYrMJ6Eicf3OHGWS1iIC2
        xIHfAiC9zAJzGCVeXXzCChIXFtCSaNpmAmLyCphLbFviBtLJKyAocXLmExYQm1mgQuLyumaw
        amYBaYnl/zhAwpxA1RNvfmOCuFJJYnXXHzYIu1bi1JZbTCCbJAS+cEhseb2FFSLhIrHqWQs7
        hC0s8er4FihbRuL05B4WiIbJjBL7/31gh3BWM0osa/wKtcJaouXKE6gOR4nbi3ewQIKUT+LG
        W0GIQ/kkJm2bzgwR5pXoaBOCqFaTWH3vDcsERuVZSF6bheS1WQivQYR1JBbs/sSGIawtsWzh
        a2YI21Zi3br3LAsY2VcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpqTT/45/2cG4/NVH
        vUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhPdEeXaKEG9KYmVValF+fFFpTmrxIUZpDhYlcV5t
        25PJQgLpiSWp2ampBalFMFkmDk6pBqaKhxOLfSwmiU46Wu+9dHH8reuLS9fMNxIUXa24JXt/
        UauUjfat1uxX6XIR83RT1Dg+C+9x/8TUJbzS42fth/X8IUFv9vDWLd2mVlhuXbTv4SHH4I/b
        9ddcurKgJdPGRkV4Xcu2CqMV09Zei7SbMbnb+cDCN6qeP9dsUMh+eyDh2sEdZ601GCxO34u7
        OWX6zuo6nyQT88PrPs9u9WKTUPOYGR/Lmp99qmTW09gcIz+dbeWbteWKDl58O/eve1a95rx9
        rVb8X+b09wV/mLXi15/IvRVbbxxZ81H0qtH7gNBmq5lHTZIjXtVZfu06fmW+ym72TZcCeaLZ
        pT/opVjqZYmpzp+uvdD5wbUHH4NWaLMrsRRnJBpqMRcVJwIALHQH6MQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7qq83JSDE60K1lc3jWHzeLgwjZG
        ixsTnjJabN17ld2BxaPxxg02j02rOtk8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4vG0qS8Eu4YqZ31cwNjAuFOxi5OSQEDCRuPhq
        J1sXIxeHkMBSRon1x5rYIRIyEhu/XGWFsIUl/lzrgir6yCixaO1vZghnC6NEz/VTYFUsAqoS
        k3f+ZAax2QR0JM6/uQNkc3CICGhLHPgtAFLPLDCHUeLVxSesIHFhAS2Jpm0mICavgLnEtiVu
        ECO7GCVW31zECDKGV0BQ4uTMJywgNrNAmcSUK+sYQeqZBaQllv/jAAlzArVOvPmNCeJOJYnV
        XX/YIOxaic9/nzFOYBSehWTSLCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3EunXvWRYwsq9i
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjM5tx35u3sE479VHvUOMTByMhxhVgDofbVh9gVGK
        JS8/L1VJhPdEeXaKEG9KYmVValF+fFFpTmrxIUZTYBhOZJYSTc4Hpo28knhDMwNTQxMzSwNT
        SzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamRsMbJVcmqN7OSXha0hnzf2ZuOKvS5bmd
        smc358dP9DjwkUGlvHLJ69tMGh8PTPqewXpv8l+z2duezjhX4Xnqrm/M7cTT+bFHOxvtH2Vc
        2M1XU2+dfbhsSb98mMpRnfyH9/Y92yopf3bn+ZWvSg8I72te8k7Uq3nNy/9udmHHP7VVT7W7
        2fg0LnnuhJ7m0sisWGOg7/ecn/p+0pzpeRFyZeevpiTPniQ4q9zAbzmftuQfw2OfHoTkLDDe
        +etq4ZcTx+oTJ1268sxxc+S01z2z45QPxWl+52KMbPU5NLlWfLlyUcDPH/tkPTL7nobu27Yv
        VF9B9dSfqydXc09Q4rFnnW461VE7KaNosfiSs2J5SizFGYmGWsxFxYkAyxBYXGMDAAA=
X-CMS-MailID: 20230523110613eucas1p1d504533387155d7d1c5806f3259f7e89
X-Msg-Generator: CA
X-RootMTR: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
References: <CGME20230523035747eucas1p2f10754f5eb6759d6665a35562c523841@eucas1p2.samsung.com>
        <20230523135739.73068c68@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--y7qniprnbfkodh4h
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 01:57:39PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next boot test (powerpc pseries_le_defconfig) produced
> this warning:
>=20
> sysctl table check failed: kernel/usermodehelper Not a file
> sysctl table check failed: kernel/usermodehelper No proc_handler
> sysctl table check failed: kernel/usermodehelper bogus .mode 0555
> sysctl table check failed: kernel/keys Not a file
> sysctl table check failed: kernel/keys No proc_handler
> sysctl table check failed: kernel/keys bogus .mode 0555
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc3-04222-g1999c5d1802e #1
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf00=
0004 of:SLOF,HEAD pSeries
> Call Trace:
> [c0000000028bfd40] [c00000000113ea2c] dump_stack_lvl+0x70/0xa0 (unreliabl=
e)
> [c0000000028bfd70] [c0000000006166f0] __register_sysctl_table+0x7f0/0x9e0
> [c0000000028bfe50] [c00000000204e650] __register_sysctl_init+0x40/0x78
> [c0000000028bfec0] [c00000000202d660] sysctl_init_bases+0x40/0xb4
> [c0000000028bfef0] [c00000000204e6dc] proc_sys_init+0x54/0x68
> [c0000000028bff10] [c00000000204dff4] proc_root_init+0xb8/0xdc
> [c0000000028bff30] [c0000000020045d8] start_kernel+0x7f8/0x834
> [c0000000028bffe0] [c00000000000e998] start_here_common+0x1c/0x20
> failed when register_sysctl kern_table to kernel
>=20
> I am not sure exactly which commit caused this.
Its probably this one 7eec88986dce2d85012fbe516def7a2d7d77735c

>=20
> --=20
> Cheers,
> Stephen Rothwell



--=20

Joel Granados

--y7qniprnbfkodh4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRsniEACgkQupfNUreW
QU8H3Qv+O7LmDVAl5XFm7jN6HwdRNxO1kRlV+SY0f+aoFrXEVVkXQFrWY0BrJwS2
J6ITNRRCSlQHGJXiaw8OAOnhVIOQm3KbY/JPT/EMkSLUp2k2dOn0X25lMBf3e9mE
VbG0X7kqFUVpvWvvzEQghW1ugEZENJXRvAlbQgSDEIkYE/JCkJbb86vAdFG032gX
Or72mUiSW1MtrKZSmkaOpv+F2eDxCKN4W9HyOBky3LajGZAEVCEJMZ80eKRMRp7e
xC87LTs30sZMTl0hKoVv4+R2CU0vOD13KTznL+6JeOado3c8Iz4RK6z/w0qBpNR5
yX4zs/fGRDHkVJSwxiQbte52L28SyFojUcqm72+JzuJmlGt57hwyvHrsK9K2+dMm
m198+JRfvHoT4hCIUcO92RmwMj/6UU0V7UyN1kiRqlCKJOQVmoXKkvEdpTf6ZkwA
Np0ROcFxwHc5EDxmbzcmsWl6GiMSvKou5TOvga3MumAKp74dpcITQ7Ufi4XjHx46
Hkp/+bQR
=Cvv6
-----END PGP SIGNATURE-----

--y7qniprnbfkodh4h--
