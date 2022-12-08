Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91361646D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLHKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:53:10 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B58C69B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:45:53 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221208104530euoutp018644416a34398bfb7b131f2cc3762ff9~uy4-tF-DC2095920959euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:45:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221208104530euoutp018644416a34398bfb7b131f2cc3762ff9~uy4-tF-DC2095920959euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670496330;
        bh=EFt1MCdFJBKOXDvapBZq9DMdJhm+bWZ3Guhr//o+RJk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sNqksYyuvJxCNyVfvnsVs1RttSwQAsux9gdDrQ/IsOMY9Lt4vkhaMcua23f3zazCD
         4+fXYUESYvDy4vYGUS1gzYe+x/I9KDUshrrPOlt2ryrszvRXqqv5ikQ69ZR3wXQiEe
         qubYttu9mN2PIDjkgtvW0qHKgWIPSloda9LT4n5M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221208104530eucas1p1f4fd3e4034be38fb023db1f1dc7656fa~uy4-ePhnX0427504275eucas1p17;
        Thu,  8 Dec 2022 10:45:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 43.0F.10112.A40C1936; Thu,  8
        Dec 2022 10:45:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221208104530eucas1p2b3a70431a8af07a6777b79400205ab07~uy4__yX_72455824558eucas1p2O;
        Thu,  8 Dec 2022 10:45:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221208104530eusmtrp281c8dc4fba9bc51968654e6d6a4ead36~uy4__GKEI2118421184eusmtrp2c;
        Thu,  8 Dec 2022 10:45:30 +0000 (GMT)
X-AuditID: cbfec7f4-cf3ff70000002780-6f-6391c04a07f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.9C.09026.940C1936; Thu,  8
        Dec 2022 10:45:29 +0000 (GMT)
Received: from AMDN3677 (unknown [106.120.8.17]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221208104529eusmtip1cf7ebc8bfa4ce7036b96ca15478eeaf8~uy4_dFOmK0136101361eusmtip1j;
        Thu,  8 Dec 2022 10:45:29 +0000 (GMT)
From:   =?UTF-8?Q?Micha=C5=82_Lach?= <michal.lach@samsung.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <ming.lei@canonical.com>, <tiwai@suse.de>
In-Reply-To: <20221123111455.94972-1-michal.lach@samsung.com>
Subject: RE: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Date:   Thu, 8 Dec 2022 11:45:28 +0100
Message-ID: <000901d90af2$309b7c80$91d27580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJJ6E+zfdaFORO17aRh9qp0ZMDCaQIgon1nrXEK0JA=
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7peByYmG8y4LGPRvHg9m8XlXXPY
        LG5MeMposevhd3aLuV+mMlssnbmC2eLl5jdMDuwesxp62TwW73nJ5LFpVSebx/65a9g9Np+u
        9vi8SS6ALYrLJiU1J7MstUjfLoEr4/jvl8wFs+QqJvzfw9LAuF62i5GTQ0LAROLfxA+MXYxc
        HEICKxglzn25AeV8YZR4+HQrK0iVkMBnRokPXxNhOrZe/MICUbScUeJ93w0mCOcpo0Tz7LVg
        HWwCNhJ/TyxmBrFFBJQkvl/rBhvLLDCdUeLW7s9gCU4BW4mTZ04xgtjCAqESf1pmsYPYLAIq
        Eud6V4LV8ApYSkzasp0NwhaUODnzCQuIzSygLbFs4WtmiJMUJH4+XcYKscxK4tXEP+wQNSIS
        Nx61gC2WEHjDIXF87QwmiAYXiaur37FA2MISr45vYYewZST+75wPVVMscefJfDYIu0bi2+8O
        qGXWEqu23gCKcwAt0JRYv0sfIuwoMfvuP2aQsIQAn8SNt4IQJ/BJTNo2HSrMK9HRJgRRrSrx
        v/ET+wRG5VlIHpuF5LFZSB6YhbBrASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBU
        dPrf8S87GJe/+qh3iJGJg/EQowQHs5II77JlE5OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ866Y
        0pEsJJCeWJKanZpakFoEk2Xi4JRqYOo0uHhFuWJz2ueGljOJs3911a9k0D/I61S9Ylt6cPhc
        +6PqKbNToiZmC6c1F+6KMvkm35Z0Pk0gVpFjfs4JP831UdZf2dzjMqZsTN54Z94fnpDiwLyy
        Sfw2qpZ7NVrOql67LasjwrD06JIdxtNFtvzZtPrwpD7OY0Ghl+yfqzmYVszfrPJY4tY7Fgv7
        TrfQmYbFbJfc+z8eWib1Ja2gZCJjqcWkbzV5sYtPLK3lmFGTOL3yiYFD1DebBJ/9E0V6rfSr
        Q/cX13Y9mjDzs//l16e6ds6Wbs8/s07+dsu7HRuFfDR18jcvncIX8IJ3+5EXL90Oc2302x+j
        8/W6LJ+nhnkvr3vO/bCtpnfa9h7iVmIpzkg01GIuKk4EAF4OC4K0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7qeByYmG7y5ZWbRvHg9m8XlXXPY
        LG5MeMposevhd3aLuV+mMlssnbmC2eLl5jdMDuwesxp62TwW73nJ5LFpVSebx/65a9g9Np+u
        9vi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEv49nUCYwFnWIV5+5WNzDuEOpi5OSQEDCR2HrxC0sXIxeHkMBSRomDvbuBHA6ghLRE1zxp
        iBphiT/Xutggah4zSlzfvIUdJMEmYCPx98RiZhBbREBJ4vu1bkaQImaBuYwS93dtZgNJCAn0
        MUpcPGEJYnMK2EqcPHOKEcQWFgiWmDbhHBOIzSKgInGudyXYIF4BS4lJW7azQdiCEidnPmEB
        sZkFtCV6H7YywtjLFr5mhrhOQeLn02WsEEdYSbya+IcdokZE4sajFsYJjMKzkIyahWTULCSj
        ZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwJrcd+7llB+PKVx/1DjEycTAeYpTg
        YFYS4V22bGKyEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucDk0JeSbyhmYGpoYmZpYGppZmx
        kjivZ0FHopBAemJJanZqakFqEUwfEwenVAMTh8yR3wsv6Oo8vC1W+OObi5rs522fzp30b3E2
        mjutQUbA4dq52vV9y/4x+sqIK5uliN6S2rlBsE9FwH3K0m5Oqb1lL48tnJp/21845lsQ/zeP
        fb1rn9wtds8IFHgr1qljfEy25PLlLt2uClu/q+cT/xpXrevNPSMY6qesfbAxyrk0860/V53r
        fe5YKWPRAx19O1/I6tV2t3nL99Y0hZ9bs+H6z3Ptk36s8WPT6Tt03ODxUk7F/H7Ocv6GyU/c
        u1d+bYqwCgoI6y8KyyzqKt6gs2pWvqPiPV6u6GNPFwVKbc4+rz/53CpL7e+bS2W/RJn/XnFv
        qyxfzP9Pa3bHON0Ii6iVOK1zp+W0/SbjnUosxRmJhlrMRcWJAH+iyo9SAwAA
X-CMS-MailID: 20221208104530eucas1p2b3a70431a8af07a6777b79400205ab07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
        <20221123111455.94972-1-michal.lach@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinging

With regards,
Micha=C5=82=0D=0A=0D=0A>=20-----Original=20Message-----=0D=0A>=20From:=20Mi=
chal=20Lach=20<michal.lach=40samsung.com>=0D=0A>=20Sent:=20=C5=9Broda,=2023=
=20listopada=202022=2012:15=0D=0A>=20To:=20linux-kernel=40vger.kernel.org=
=0D=0A>=20Cc:=20mcgrof=40kernel.org;=20russell.h.weight=40intel.com;=0D=0A>=
=20gregkh=40linuxfoundation.org;=20rafael=40kernel.org;=20ming.lei=40canoni=
cal.com;=0D=0A>=20tiwai=40suse.de;=20michal.lach=40samsung.com=0D=0A>=20Sub=
ject:=20=5BPATCH=5D=20drivers/firmware_loader:=20remove=20list=20entry=20be=
fore=20deallocation=0D=0A>=20=0D=0A>=20If=20CONFIG_FW_LOADER_USER_HELPER=20=
is=20enabled,=20it=20is=20possible=20to=20interrupt=20the=0D=0A>=20loading=
=20process=20after=20adding=20pending_list=20to=20pending_fw_list.=0D=0A>=
=20Subsequently,=20if=20user=20calls=20release_firmware()=20which=20dealloc=
ates=20the=20fw_priv=0D=0A>=20structure=20which=20pending_list=20is=20a=20m=
ember=20of,=20the=20entry=20in=20the=20list=20is=20not=20deleted.=0D=0A>=20=
This=20causes=20a=20use-after-free=20on=20further=20attempts=20to=20add=20a=
n=20entry=20to=20the=20list=20or=20on=0D=0A>=20list=20traversal.=0D=0A>=20=
=0D=0A>=20While=20not=20problematic=20in=20most=20drivers=20since=20this=20=
function=20is=20mainly=20used=20in=20probe=0D=0A>=20or=20init=20routines,=
=20some=20drivers=20expose=20firmware=20loading=20functionality=20via=20use=
r-=0D=0A>=20accessible=20functions=20like=20write()=20etc.=0D=0A>=20In=20th=
is=20case=20during=20the=20sysfs=20loading=20process,=20we=20can=20send=20S=
IGKILL=20to=20the=20thread=0D=0A>=20which=20is=20then=20in=20kernel,=20leav=
e=20the=20entry=20in=20the=20list=20and=20then=20free=20the=20structure.=0D=
=0A>=20=0D=0A>=20Example=20kernel=20panics=20with=20CONFIG_DEBUG_LIST=20tur=
ned=20on:=0D=0A>=20=0D=0A>=20kernel=20BUG=20at=20lib/list_debug.c:25=21=0D=
=0A>=20/*=20...=20*/=0D=0A>=20Call=20trace:=0D=0A>=20=20__list_add_valid+0x=
7c/0x98=0D=0A>=20=20fw_load_sysfs_fallback+0xd4/0x334=0D=0A>=20=20fw_load_f=
rom_user_helper+0x148/0x1f8=0D=0A>=20=20firmware_fallback_sysfs+0xe0/0x17c=
=0D=0A>=20=20_request_firmware+0x1a0/0x470=0D=0A>=20=20request_firmware+0x5=
0/0x78=0D=0A>=20/*=20...=20*/=0D=0A>=20=0D=0A>=20or=0D=0A>=20=0D=0A>=20kern=
el=20BUG=20at=20lib/list_debug.c:56=21=0D=0A>=20/*=20...=20*/=0D=0A>=20Call=
=20trace:=0D=0A>=20=20__list_del_entry_valid+0xa0/0xa4=0D=0A>=20=20fw_load_=
abort+0x38/0x64=0D=0A>=20=20fw_load_sysfs_fallback+0x354/0x468=0D=0A>=20=20=
fw_load_from_user_helper+0x17c/0x1c0=0D=0A>=20=20firmware_fallback_sysfs+0x=
c0/0x11c=0D=0A>=20=20_request_firmware+0xe0/0x4a4=0D=0A>=20=20request_firmw=
are+0x20/0x2c=0D=0A>=20/*=20...=20*/=0D=0A>=20=0D=0A>=20Fixes:=20fe304143b0=
c3=20(=22firmware:=20Avoid=20deadlock=20of=20usermodehelper=20lock=20at=0D=
=0A>=20shutdown=22)=0D=0A>=20Signed-off-by:=20Michal=20Lach=20<michal.lach=
=40samsung.com>=0D=0A>=20---=0D=0A>=20=20drivers/base/firmware_loader/main.=
c=20=7C=204=20++++=0D=0A>=20=201=20file=20changed,=204=20insertions(+)=0D=
=0A>=20=0D=0A>=20diff=20--git=20a/drivers/base/firmware_loader/main.c=0D=0A=
>=20b/drivers/base/firmware_loader/main.c=0D=0A>=20index=207c3590fd97c2..38=
1997c84e4f=20100644=0D=0A>=20---=20a/drivers/base/firmware_loader/main.c=0D=
=0A>=20+++=20b/drivers/base/firmware_loader/main.c=0D=0A>=20=40=40=20-209,6=
=20+209,10=20=40=40=20static=20void=20__free_fw_priv(struct=20kref=20*ref)=
=0D=0A>=20=20=09=09=20__func__,=20fw_priv->fw_name,=20fw_priv,=20fw_priv->d=
ata,=0D=0A>=20=20=09=09=20(unsigned=20int)fw_priv->size);=0D=0A>=20=0D=0A>=
=20+=23ifdef=20CONFIG_FW_LOADER_USER_HELPER=0D=0A>=20+=09list_del(&fw_priv-=
>pending_list);=0D=0A>=20+=23endif=0D=0A>=20+=0D=0A>=20=20=09list_del(&fw_p=
riv->list);=0D=0A>=20=20=09spin_unlock(&fwc->lock);=0D=0A>=20=0D=0A>=20--=
=0D=0A>=202.25.1=0D=0A=0D=0A=0D=0A
