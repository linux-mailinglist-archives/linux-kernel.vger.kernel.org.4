Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563EC5FD339
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJMCZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMCZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:25:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D42C8203
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:25:38 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221013022533epoutp030bb7604f8da650f1ab925d69599c231f~df8e-lOQt0978609786epoutp03j
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:25:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221013022533epoutp030bb7604f8da650f1ab925d69599c231f~df8e-lOQt0978609786epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665627933;
        bh=wvrI+as4mJ8pD27eQvVa5xzfE08WqYPYlc77AD8yKmo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=XkJPR1x7I4m8TwhzVVxgaLyvvnMSIYGyrOs9EeEJO3FEJvEAVwvkriGqljBWgtiwy
         eCFEBi13SGFcJCSupqaUUc9FoklQ0Q2gHKBUb9zJeWYmVOW4NwBFAs6aSllcCTr+Q3
         4ulq3lLYciKoP0Cd4m96YpmFVlCK8uJ0ToXz88OM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20221013022532epcas1p35b3dfdbe834f1d6987d2b6abc6253f19~df8evkYhn0788007880epcas1p3X;
        Thu, 13 Oct 2022 02:25:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MntfM5cZ9z4x9Pv; Thu, 13 Oct
        2022 02:25:31 +0000 (GMT)
X-AuditID: b6c32a39-8d3fa7000001fddc-db-634777105c0e
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.32.64988.01777436; Thu, 13 Oct 2022 11:25:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] drivers/extcon: use simple i2c probe
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Stephen Kitt <steve@sk2.org>, Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20221012141846.3916480-1-steve@sk2.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221013022519epcms1p555f11b5f130e6991017dd76741ad583f@epcms1p5>
Date:   Thu, 13 Oct 2022 11:25:19 +0900
X-CMS-MailID: 20221013022519epcms1p555f11b5f130e6991017dd76741ad583f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmrq5AuXuywbuf/BbXvzxntbi8aw6b
        xa3XS1gdmD36tqxi9Jhw/jqTx+dNcgHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        pgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQeOHWcq2Khasan1FXsD40qVLkYODgkBE4mnt2S7
        GLk4hAR2MEp82XeVHSTOKyAo8XeHcBcjJ4ewgKXEsum3WEFsIQEliYab+5gh4voSHQ+2MYLY
        bAK6Els33GUBsUUE3CQerWwBizMLOErc3vuWCcSWEOCVmNH+lAXClpbYvnwrWA2ngKnEsb2N
        jBBxUYmbq9+yw9jvj82HiotItN47ywxhC0o8+LmbEeJ8aYmfV/RBzpcQmMwocfLEcUYIZw6j
        xLQN79ggGvQlzsw9CWbzCvhKHPl2FewIFgFVif0vmqCGukjc+X6YBeJobYllC18zgyxgFtCU
        WL9LHyLMJ/Huaw8rzC875j2B+ktN4tDuJVA3y0icnr6QGeI2D4njzYWQYKuRePW1i2UCo/ws
        RODOQrJrFsKuBYzMqxjFUguKc9NTiw0LTOHRmZyfu4kRnMq0LHcwTn/7Qe8QIxMH4yFGCQ5m
        JRFelxC3ZCHelMTKqtSi/Pii0pzU4kOMpkBfTmSWEk3OBybTvJJ4QxNLAxMzI2MTC0MzQyVx
        3oYZWslCAumJJanZqakFqUUwfUwcnFINTKVaN+QzrK/u3jX/t9Bxvj28mbJ9Tqd/FXLnH/uj
        E6yk433cVeHnu8XyokHx5rqZ/1pnnVv21OZz5Z7HydUpP+9eUndPqdry5V+GL1/bE6b66MtP
        uhl3RC8s5woLqeeewSqwW/PgvTmR2r4ry1/0zeE0X19bb1LTJKGea7zVmDG46I1qj/m1R6+8
        qi480o7I/+FYdOyUw/84SzX1CScnrncr0Xi4mePR6SqhmPSjcfy/7R4XpKuv0P8fZf5gp6ry
        4916i2a5v6tOuWz+eG56maBZusCmOcpHiid0RcYyqGzgCZCSUT/kOLF3eoAyx3v1uPx44W3V
        cd7dVWvK1y7tXpb7+O2MF7xOH2Ym1U9UYinOSDTUYi4qTgQAnr6/0+4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221012141859epcas1p16f5cfc50d6d0404e8fc07a4ac50f46a2
References: <20221012141846.3916480-1-steve@sk2.org>
        <CGME20221012141859epcas1p16f5cfc50d6d0404e8fc07a4ac50f46a2@epcms1p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> --------- Original Message ---------
> Sender : Stephen Kitt=C2=A0<steve=40sk2.org>=0D=0A>=20Date=20:=202022-10-=
12=2023:18=20(GMT+9)=0D=0A>=20Title=20:=20=5BPATCH=5D=20drivers/extcon:=20u=
se=20simple=20i2c=20probe=0D=0A>=20=C2=A0=0D=0A>=20All=C2=A0these=C2=A0driv=
ers=C2=A0have=C2=A0an=C2=A0i2c=C2=A0probe=C2=A0function=C2=A0which=C2=A0doe=
sn't=C2=A0use=C2=A0the=0D=0A>=20=22struct=C2=A0i2c_device_id=C2=A0*id=22=C2=
=A0parameter,=C2=A0so=C2=A0they=C2=A0can=C2=A0trivially=C2=A0be=0D=0A>=20co=
nverted=C2=A0to=C2=A0the=C2=A0=22probe_new=22=C2=A0style=C2=A0of=C2=A0probe=
=C2=A0with=C2=A0a=C2=A0single=C2=A0argument.=0D=0A>=20=0D=0A>=20This=C2=A0i=
s=C2=A0part=C2=A0of=C2=A0an=C2=A0ongoing=C2=A0transition=C2=A0to=C2=A0singl=
e-argument=C2=A0i2c=C2=A0probe=0D=0A>=20functions.=C2=A0Old-style=C2=A0prob=
e=C2=A0functions=C2=A0involve=C2=A0a=C2=A0call=C2=A0to=C2=A0i2c_match_id:=
=0D=0A>=20in=C2=A0drivers/i2c/i2c-core-base.c,=0D=0A>=20=0D=0A>=20=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=0D=0A>=20=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0When=C2=A0there=C2=A0are=
=C2=A0no=C2=A0more=C2=A0users=C2=A0of=C2=A0probe(),=0D=0A>=20=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0rename=C2=A0probe_ne=
w=C2=A0to=C2=A0probe.=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*/=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if=C2=A0(driver->probe_new)=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
status=C2=A0=3D=C2=A0driver->probe_new(client);=0D=0A>=20=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else=C2=A0if=C2=A0(driver->probe)=0D=0A=
>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status=C2=A0=3D=C2=A0driver->probe(client,=
=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_match_id(driver->id_table,=C2=A0client));=0D=
=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else=0D=0A>=20=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0status=C2=A0=3D=C2=A0-EINVAL;=0D=0A>=20=0D=0A>=
=20Drivers=C2=A0which=C2=A0don't=C2=A0need=C2=A0the=C2=A0second=C2=A0parame=
ter=C2=A0can=C2=A0be=C2=A0declared=C2=A0using=0D=0A>=20probe_new=C2=A0inste=
ad,=C2=A0avoiding=C2=A0the=C2=A0call=C2=A0to=C2=A0i2c_match_id.=C2=A0Driver=
s=C2=A0which=C2=A0do=0D=0A>=20can=C2=A0still=C2=A0be=C2=A0converted=C2=A0to=
=C2=A0probe_new-style,=C2=A0calling=C2=A0i2c_match_id=0D=0A>=20themselves=
=C2=A0(as=C2=A0is=C2=A0done=C2=A0currently=C2=A0for=C2=A0of_match_id).=0D=
=0A>=20=0D=0A>=20This=C2=A0change=C2=A0was=C2=A0done=C2=A0using=C2=A0the=C2=
=A0following=C2=A0Coccinelle=C2=A0script,=C2=A0and=C2=A0fixed=0D=0A>=20up=
=C2=A0for=C2=A0whitespace=C2=A0changes:=0D=0A>=20=0D=0A>=20=40=C2=A0rule1=
=C2=A0=40=0D=0A>=20identifier=C2=A0fn;=0D=0A>=20identifier=C2=A0client,=C2=
=A0id;=0D=0A>=20=40=40=0D=0A>=20=0D=0A>=20-=C2=A0static=C2=A0int=C2=A0fn(st=
ruct=C2=A0i2c_client=C2=A0*client,=C2=A0const=C2=A0struct=C2=A0i2c_device_i=
d=C2=A0*id)=0D=0A>=20+=C2=A0static=C2=A0int=C2=A0fn(struct=C2=A0i2c_client=
=C2=A0*client)=0D=0A>=20=7B=0D=0A>=20...when=C2=A0=21=3D=C2=A0id=0D=0A>=20=
=7D=0D=0A>=20=0D=0A>=20=40=C2=A0rule2=C2=A0depends=C2=A0on=C2=A0rule1=C2=A0=
=40=0D=0A>=20identifier=C2=A0rule1.fn;=0D=0A>=20identifier=C2=A0driver;=0D=
=0A>=20=40=40=0D=0A>=20=0D=0A>=20struct=C2=A0i2c_driver=C2=A0driver=C2=A0=
=3D=C2=A0=7B=0D=0A>=20-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=0D=
=0A>=20+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe_new=0D=0A>=20=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D=0D=0A>=20(=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fn=0D=0A>=20=7C=0D=0A>=20-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&fn=0D=0A=
>=20+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fn=0D=0A>=20)=0D=0A>=20=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0,=0D=0A>=20=7D;=0D=0A>=20=0D=0A>=20Signed-off-by:=C2=A0Stephen=C2=
=A0Kitt=C2=A0<steve=40sk2.org>=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myu=
ngjoo.ham=40samsung.com>=0D=0A=0D=0AChanwoo,=20PTAL.=0D=0A=0D=0ACheers,=0D=
=0AMyungJoo=0D=0A
