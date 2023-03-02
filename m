Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727586A7B62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCBGdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBGdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:33:21 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3932DE61
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:33:16 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302063314epoutp039f63479afccce707ee697000aca2f143~IhouDeRp90241102411epoutp03I
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302063314epoutp039f63479afccce707ee697000aca2f143~IhouDeRp90241102411epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677738794;
        bh=eOuPkQNe/DWIdgy5LMwVkWzUv/hbcc1qgAqf2n0WsSo=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=rLo7T/4vzK2WsA6A1SVBvTlyTe9+z4IXlr5dVFBqvQVlOBLIuOR8DU66R0Don9SUy
         GKqzNkqUS2Rzc+vmfxAoU+rGUCAA+EBPA//dV8iC2c1imR1JM+zeohdnvY6+CbC9Um
         qAh93Ars6t0FH/dMWJCJVQiklEliAeF0kT8A9M70=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230302063314epcas1p2f02bcd481a85940f9d4596c5069e5b36~IhotuB26c3266732667epcas1p2Y;
        Thu,  2 Mar 2023 06:33:14 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.133]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PS1WY1qD3z4x9QC; Thu,  2 Mar
        2023 06:33:13 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-d8-6400432801ef
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.D4.12562.82340046; Thu,  2 Mar 2023 15:33:12 +0900 (KST)
Mime-Version: 1.0
Subject: RE: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to
 simplify extcon register function
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230302063312epcms1p1e0cd1a2d74dbd3daa4c7b7407b975803@epcms1p1>
Date:   Thu, 02 Mar 2023 15:33:12 +0900
X-CMS-MailID: 20230302063312epcms1p1e0cd1a2d74dbd3daa4c7b7407b975803
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7bCmnq6GM0OKwZlvShYn1ixisrj+5Tmr
        xeVdc9gcmD36tqxi9Pi8SS6AKSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJ
        IS8xN9VWycUnQNctMwdoh5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgx
        t7g0L10vL7XEytDAwMgUqDAhO6N3ywXGgh1CFf3t11gaGH8JdjFyckgImEi8P/mGqYuRi0NI
        YAejxL5HO4EcDg5eAUGJvzuEQWqEBTIkDr2awgxiCwkoSTTc3McMEdeX6HiwjRHEZhPQldi6
        4S4LyBwRgX5GIOcvM8QCXokZ7U9ZIGxpie3Lt4I1cApYSTxes4MNIi4qcXP1W3YY+/2x+YwQ
        tohE672zUHMEJR783A0Vl5J4snMyG8gyCYHJjBInTxxnhHDmMEpM2/AOaqq+xJm5J8FsXgFf
        iT0vpjKB2CwCqhJ/57dDXeQi8ebOMbDNzALaEssWvmYG+Z5ZQFNi/S59iDCfxLuvPawwz+yY
        94QJwlaTOLR7CdTRMhKnpy+EOtRDYtK5E6yQEF3OJDHz7BSWCYxysxCBOgvJtlkI2xYwMq9i
        FEstKM5NTy02LDCCx2Nyfu4mRnDK0jLbwTjp7Qe9Q4xMHIyHGCU4mJVEeBfe/pMsxJuSWFmV
        WpQfX1Sak1p8iNEU6M+JzFKiyfnApJlXEm9oYmlgYmZkbGJhaGaoJM4rbnsyWUggPbEkNTs1
        tSC1CKaPiYNTqoHJkOn1b76Hj3gmNJ9r0VWu2/37xFLWVyX3bnvUqIZvm3DEKSZ9q+PFIwds
        JyXf0/ZN3HG8ujFrrZOwv+HVB6tT7noVpnz6FsOZ8LFW4RTzf+Yds67fUrzl+3rrg6WZPBsd
        Z5rYvtxb0hliUjIp/Zu0l47k/1MWn1YLyi7OEsu6veIaz5ETdrUVVhdXmmqEOJ7uO+jfECMT
        NedZoIGO5N7ERMG7CVd2ZVxkaFjBmfHryW/RlfZMKzbPX/OmaYHWI7+LH+4H57hfUNhz5Ypu
        iVDvzC2a/z/LensEV3F2LVFc296mkZPTu0BVscluYffJw0yHWOyWzGiJvBopb28kdr5leaWC
        3s87sxN8lP7Hei1WYinOSDTUYi4qTgQASlJ9VuIDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
References: <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
        <20230220054513.27385-3-bw365.lee@samsung.com>
        <20230220054513.27385-1-bw365.lee@samsung.com>
        <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
        <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=C2=A0=0D=0A>=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A=
>Sender=20:=20=EC=9D=B4=EB=B2=94=EC=9A=B0=C2=A0<bw365.lee=40samsung.com>Pro=
duct=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>Date=20:=20=
2023-03-02=2010:38=20(GMT+9)=0D=0A>Title=20:=20RE:=20=5BPATCH=20v2=202/4=5D=
=20extcon:=20Added=20extcon_alloc_cables=20to=20simplify=20extcon=20registe=
r=20function=0D=0A>=C2=A0=0D=0A>Hello.=0D=0A>=0D=0A>As=20you=20can=20see,=
=20edev->cables=20are=20freed=20if=20extcon_alloc_cables()=20function=20ret=
urn=20error=20handling=20in=20extcon_dev_register()=0D=0A>Other=20added=20f=
unctions=20are=20also=20same.=0D=0A>=0D=0A>Because=20it's=20functionalized,=
=20apart=20from=20this,=20do=20you=20want=20to=20mention=20that=20it=20shou=
ld=20be=20freed=20within=20the=20function?=20=0D=0A>Please=20let=20me=20kno=
w=20your=20opinion.=0D=0A>=0D=0A>extcon_dev_register(struct=20extcon_dev=20=
*edev)=7B=0D=0A>...=0D=0A>=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=
=3D=20extcon_alloc_cables(edev);=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
if=20(ret)=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0goto=20err_alloc_cables;=0D=0A>=0D=0A>...=0D=0A>=0D=0A>err_a=
lloc_cables:=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(edev->ma=
x_supported)=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0kfree(edev->cables);=0D=0A>=0D=0A>=0D=0A>Regards,=
=0D=0A>Bumwoo=0D=0A=0D=0AIn=20such=20a=20case,=20you=20are=20doing=20kfree(=
NULL);=20with=20the=20following:=0D=0A=0D=0A>+static=20int=20extcon_alloc_c=
ables(struct=20extcon_dev=20*edev)=20=7B=0D=0A...=0D=0A>+=20=20=20=20=20=20=
=20=20if=20(=21edev->max_supported)=0D=0A>+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20return=200;=0D=0A>+=0D=0A>+=20=20=20=20=20=20=20=20edev->=
cables=20=3D=20kcalloc(edev->max_supported,=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20sizeof=
(struct=20extcon_cable),=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20GFP_KERNEL);=0D=0A>+=20=
=20=20=20=20=20=20=20if=20(=21edev->cables)=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20return=20-ENOMEM;=0D=0A=0D=0A=0D=0A=0D=0A=0D=0AChee=
rs,=0D=0AMyungJoo=0D=0A=0D=0A
