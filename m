Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619D69C4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBTEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:38:41 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF144A262
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:38:39 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230220043837epoutp045bf417aea3fc4f2ffa080900843640c9~FbnyCnM9S0101301013epoutp04N
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:38:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230220043837epoutp045bf417aea3fc4f2ffa080900843640c9~FbnyCnM9S0101301013epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676867917;
        bh=O4KxnltndqcYrd2EyqagkdQB3Wqxw+9X/LSshQQ2ya0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=vh83R3FQCW+SF3hlxAunEtH2M8KmQPU3n6lTb5C7+0SNV9UPesr4qXXhUySNHtkzK
         tD+Ot92UboUBXYNWLLHpcaa6Q5xOSU2F/yyfLAa+79qflaG0XxhxF1oyQtnZVq3/QR
         SaqgL6JASrUSo1+WomwefiUO2TA7iLMUsgh6dk+A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230220043837epcas1p31b46ddb07b7a5f5f39397b3ca4de4a19~FbnxxaakM2220022200epcas1p3a;
        Mon, 20 Feb 2023 04:38:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.231]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKqRv4jhsz4x9Pt; Mon, 20 Feb
        2023 04:38:35 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-33-63f2f9498e5c
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.7C.37890.949F2F36; Mon, 20 Feb 2023 13:38:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/4] extcon: added extcon_alloc_cables to simplify
 extcon register function
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230217084613.25359-3-bw365.lee@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230220043833epcms1p77e8ebcbb3882f5ad13ecac138db19ee2@epcms1p7>
Date:   Mon, 20 Feb 2023 13:38:33 +0900
X-CMS-MailID: 20230220043833epcms1p77e8ebcbb3882f5ad13ecac138db19ee2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmvq7nz0/JBrOeWVqcWLOIyeL6l+es
        Fpd3zWFzYPbo27KK0ePzJrkApqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3Ml
        hbzE3FRbJRefAF23zBygHUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAtMCveLE
        3OLSvHS9vNQSK0MDAyNToMKE7Iybs86zFkxnr9gx5RhTA+MPti5GTg4JAROJVT8vsncxcnEI
        CexglJhw9B9rFyMHB6+AoMTfHcIgNcICiRIL/25jBrGFBJQkGm7uY4aI60t0PNjGCGKzCehK
        bN1wlwVkjohAPyOQ85cZYgGvxIz2pywQtrTE9uVbwRo4BawlDl4+xgoRF5W4ufotO4z9/th8
        RghbRKL13lmoOYISD37uhopLSTzZOZkNZJmEwGRGiZMnjjNCOHMYJaZteAf1mr7Embkn2SC+
        8ZVon5gBEmYRUJVYM+8D1FAXiTmPzoHZzALaEssWvmYGKWcW0JRYv0sfIswn8e5rDyvMLzvm
        PWGCsNUkDu1eAnWzjMTp6QuhRnpI7Py3iQ0SoJsZJbZtncA6gVFuFiJMZyHZNgth2wJG5lWM
        YqkFxbnpqcWGBSbwaEzOz93ECE5YWhY7GOe+/aB3iJGJg/EQowQHs5IIr/ShD8lCvCmJlVWp
        RfnxRaU5qcWHGE2B/pzILCWanA9MmXkl8YYmlgYmZkbGJhaGZoZK4rzitieThQTSE0tSs1NT
        C1KLYPqYODilGpiiS7vtIwX0Xj179qhk5bT9fWXqjx/8uXX06HHn/RaKOSd81LmyBDYq8Jk9
        DpG3dn2pz7R17rSNPuXTph0R9thWf/1fptyzB9XXAi57utcl+LHI3foYZPWoLunE1jK9HWYV
        b/95cn493hSvs9e6s73qaEDOxLgTXgcCefMajfSsPU5903rwQfe5pVCo9hNt5R2n93Ivcql8
        9/JU1Kdjs45evzTlUYbZ+9/KFn77fhYpFt6+v0ySb7pt0U7pxJgH61y6XputZ+yb3R2qYHkr
        //SCdyYMdVMsbPY+jH16PfQx4xatgO+rjd/pH8utWMLp/qvWbr8p//VU6QM/chxkL+y4eGBB
        zFp23iV3G+8ETHdXYinOSDTUYi4qTgQAJnSLaOEDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p29ef858c842b18de89f1b034acb26086a
References: <20230217084613.25359-3-bw365.lee@samsung.com>
        <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p29ef858c842b18de89f1b034acb26086a@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>--------- Original Message ---------
>Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=C2=A0<bw365.lee=40samsung.com>Product=
=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>Date=20:=202023=
-02-17=2017:48=20(GMT+9)=0D=0A>Title=20:=20=5BPATCH=202/4=5D=20extcon:=20ad=
ded=20extcon_alloc_cables=20to=20simplify=20extcon=20register=20function=0D=
=0A>=C2=A0=0D=0A>The=20cable=20allocation=20part=20is=20functionalized=20fr=
om=20extcon_dev_register.=0D=0A>=0D=0A>Signed-off-by:=20Bumwoo=20Lee=20<bw3=
65.lee=40samsung.com>=0D=0A=0D=0A...=0D=0A=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(extcon_alloc_cables(edev))=0D=0A>+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20err_alloc_cables;=
=0D=0A>=C2=A0=0D=0A=0D=0AYou=20are=20abandoning=20error=20return=20values,=
=20here.=0D=0APlease=20return=20appropriate=20error=20codes.=0D=0A=0D=0AChe=
ers,=0D=0AMyungJoo=0D=0A
