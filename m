Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D06A7CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCBIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:33:22 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59517126F9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:33:19 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230302083315epoutp0250b3dd444fec221691222f90790af7ae~IjRgckI9h1402514025epoutp02P
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230302083315epoutp0250b3dd444fec221691222f90790af7ae~IjRgckI9h1402514025epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677745995;
        bh=T8RyhlDdaifqEagOpD0TWqG/7bMAHq9anrgvcNKNIw4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=E4um0Yv8r2M759AXcknBj+7LwOJIpsHG4vItMzuPL4PVQ2wchowMGKwSI8h/8nMH+
         //6pCA4SyQtD+tKQ2ByoWuB2K0TVL00TIooWRTH/g+3LLI4ryfBrQQ+ByspATGp9kG
         saw8wlXNfbOOnjWY9XeLmMpNAu7Rhe7eHqzbUIiQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230302083315epcas1p24618b7402d6c07a06c632d9668475735~IjRgB1taR2703227032epcas1p25;
        Thu,  2 Mar 2023 08:33:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.227]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PS4B23W1fz4x9QK; Thu,  2 Mar
        2023 08:33:14 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.C3.55531.94F50046; Thu,  2 Mar 2023 17:33:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230302083313epcas1p2287eebc4b4f1858e2844d85155be04aa~IjRdw3_M72175921759epcas1p2B;
        Thu,  2 Mar 2023 08:33:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302083312epsmtrp1f8cafc75b881a2b258622e9d95359745~IjRdv8cPv2124921249epsmtrp1V;
        Thu,  2 Mar 2023 08:33:12 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-cd-64005f498d65
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.2B.18071.84F50046; Thu,  2 Mar 2023 17:33:12 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302083312epsmtip2e2cf26948b2c458c1c1113c57d233580~IjRdmdXj61694216942epsmtip2g;
        Thu,  2 Mar 2023 08:33:12 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: 
Subject: RE: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to
 simplify extcon register function
Date:   Thu, 2 Mar 2023 17:33:12 +0900
Message-ID: <006f01d94ce1$a0751300$e15f3900$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMs5Xzd7TX9SfVksmmJQ2eqp0be4gEndo8vAX4NdCIBRRvN4gEPThYuAeHKeESsCP48gIAAGpzg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvq5nPEOKweerfBbXvzxntbi8aw6b
        xe3GFWwOzB59W1YxenzeJBfAFJVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfH32gK2ghaliv0bOpkaGOcpdDFyckgImEhc+LyVuYuRi0NI
        YAejxKSjB9ggnE+MElu+7mSFcL4xSlzc/Z4RpuX/li1gtpDAXkaJqdOgOp4D2Z/7mUESbAJa
        EgvnzGcDsUUEsiSu/HgNZHNwcArwSkz4Zw0SFhbIkDj0agpYOYuAisSLW4eZQUp4BSwl2iYa
        gYR5BQQlTs58wgJiMwtoSyxb+JoZ4gQFiZ9Pl7FCTI+S2Nvyhg2iRkRidmcb2DcSAtfYJaZf
        fsoKMlNCwEXiyj9TiF5hiVfHt7BD2FISL/vboOx0iZVX7kDZORKv77dDvWss8e7tWrDTmAU0
        Jdbv0ocIK0rs/D2XEWItn8S7rz1Qm3glOtqEIEqUJbofvGCCsCUlFj+9AzXRQ2LSuROsExgV
        ZyF5chaSJ2cheWYWwuIFjCyrGMVSC4pz01OLDQsM4TGdnJ+7iRGc9rRMdzBOfPtB7xAjEwfj
        IUYJDmYlEd6Ft/8kC/GmJFZWpRblxxeV5qQWH2I0BYb6RGYp0eR8YOLNK4k3NLE0MDEzMrEw
        tjQ2UxLnFbc9mSwkkJ5YkpqdmlqQWgTTx8TBKdXA5Pqp4lfVljZz7ohV98SCuo4JfJ6xTUDJ
        Xq7U9Nvt8IePTVfvmm10xcrR5ErMYoELz6sOpU8MeWL9PdaitWWpw+RF+p9eci+Next2uCC/
        +5jeZPGDvXtMfn6xz1gRPi0j6uY8prBjkv5xn3PCeZj9jQ77ZCn9tJFlOr8govqayLOdLnNa
        2SPXNUXy/73U8sbgz6yvs9L93c8/0qq6w+d70Sx+nax34lPN244/2hm+uLzTWnebpb2vx/Os
        jqqJ041zP+/4npr/QEjmz6WH9l7O2tkuM8qf3BF42a65yI9r7pe/k79N9K+8svxBtnLmZbsz
        j4z2LhXbcnjjYcYm99z7KnluTTzh9scFTgqFb/HXVGIpzkg01GIuKk4EAABOv/MEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvK5HPEOKwdOHFhbXvzxntbi8aw6b
        xe3GFWwOzB59W1YxenzeJBfAFMVlk5Kak1mWWqRvl8CV8XrBVLaCbvGKR+862BsYpwp2MXJy
        SAiYSPzfsoWxi5GLQ0hgN6PEqtczmSASkhJnlz9i72LkALKFJQ4fLoaoecoocelZGztIDZuA
        lsTCOfPZQGwRgRyJA+unsEMUPWKS+HvwEitIM6cAr8SEf9YgNcICaRK3f3aC9bIIqEi8uHWY
        GaSEV8BSom2iEUiYV0BQ4uTMJywgNrOAtsTTm0/h7GULXzNDnKYg8fPpMlaItVESe1vesEHU
        iEjM7mxjnsAoNAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
        NzGCg11Lcwfj9lUf9A4xMnEwHmKU4GBWEuFdePtPshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        C10n44UE0hNLUrNTUwtSi2CyTBycUg1MKt9N5HmDd/c9MF6s9vpwZ5JW9uVXy1+Ivj+Xnrxr
        QzjLLF/xNc1XZuovnVoSt1V/ibX89OT0n7kF0bZvxH22bDUN3bXNoHtjFt+q9vX/Ph/3vxFn
        xNL1ps520eRvrjzfHTWP3+2UW7i6uP/6jy1uvF8yGrfYfTpSVPgwOPb0+9sH/+34zL7zSU++
        dKK5dniZ3UWJ7lnSpV9m28woyo7wjsjYd+1H3+WGHza2XM57H26Zwr5WYfm7nX0Nwh/mxM05
        bXRC2avq+94nd4PeSh/4/EfB0Epf6uva7/O2CGziF9VIm5DqETTrQrVoFkvONY0PT3ews86c
        3b+MX8mf9bdDtegts12nrud9+7HU9+KNU0osxRmJhlrMRcWJAI4nOXHlAgAA
X-CMS-MailID: 20230302083313epcas1p2287eebc4b4f1858e2844d85155be04aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
References: <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
        <20230220054513.27385-3-bw365.lee@samsung.com>
        <20230220054513.27385-1-bw365.lee@samsung.com>
        <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
        <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcms1p1>
        <20230302063312epcms1p1e0cd1a2d74dbd3daa4c7b7407b975803@epcms1p1> 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Bumwoo Lee <bw365.lee=40samsung.com>
> Sent: Thursday, March 2, 2023 4:12 PM
> To: 'myungjoo.ham=40samsung.com' <myungjoo.ham=40samsung.com>; 'Chanwoo C=
hoi'
> <cw00.choi=40samsung.com>; 'linux-kernel=40vger.kernel.org' <linux-
> kernel=40vger.kernel.org>
> Subject: RE: RE: =5BPATCH v2 2/4=5D extcon: Added extcon_alloc_cables to
> simplify extcon register function
>=20
>=20
> > -----Original Message-----
> > From: MyungJoo Ham <myungjoo.ham=40samsung.com>
> > Sent: Thursday, March 2, 2023 3:33 PM
> > To: Bumwoo Lee <bw365.lee=40samsung.com>; Chanwoo Choi
> > <cw00.choi=40samsung.com>; linux-kernel=40vger.kernel.org
> > Subject: RE: RE: =5BPATCH v2 2/4=5D extcon: Added extcon_alloc_cables t=
o
> > simplify extcon register function
> >
> > >
> > >
> > >--------- Original Message ---------
> > >Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=20<bw365.lee=40samsung.com>Produc=
t=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=20Date=20:=0D=0A>=20=
>=20>2023-03-02=2010:38=20(GMT+9)=20Title=20:=20RE:=20=5BPATCH=20v2=202/4=
=5D=20extcon:=20Added=0D=0A>=20>=20>extcon_alloc_cables=20to=20simplify=20e=
xtcon=20register=20function=0D=0A>=20>=20>=0D=0A>=20>=20>Hello.=0D=0A>=20>=
=20>=0D=0A>=20>=20>As=20you=20can=20see,=20edev->cables=20are=20freed=20if=
=20extcon_alloc_cables()=0D=0A>=20>=20>function=20return=20error=20handling=
=20in=20extcon_dev_register()=20Other=20added=0D=0A>=20>=20functions=20are=
=20also=20same.=0D=0A>=20>=20>=0D=0A>=20>=20>Because=20it's=20functionalize=
d,=20apart=20from=20this,=20do=20you=20want=20to=20mention=0D=0A>=20>=20>th=
at=0D=0A>=20>=20it=20should=20be=20freed=20within=20the=20function?=0D=0A>=
=20>=20>Please=20let=20me=20know=20your=20opinion.=0D=0A>=20>=20>=0D=0A>=20=
>=20>extcon_dev_register(struct=20extcon_dev=20*edev)=7B=20...=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20=20=20=20=20=20=20=20ret=20=3D=20extcon_alloc_cables(=
edev);=0D=0A>=20>=20>=20=20=20=20=20=20=20=20if=20(ret)=0D=0A>=20>=20>=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20goto=20err_alloc_cables;=0D=0A=
>=20>=20>=0D=0A>=20>=20>...=0D=0A>=20>=20>=0D=0A>=20>=20>err_alloc_cables:=
=0D=0A>=20>=20>=20=20=20=20=20=20=20=20=20if=20(edev->max_supported)=0D=0A>=
=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20kfree(edev->cabl=
es);=0D=0A>=20>=20>=0D=0A>=20>=20>=0D=0A>=20>=20>Regards,=0D=0A>=20>=20>Bum=
woo=0D=0A>=20>=0D=0A>=20>=20In=20such=20a=20case,=20you=20are=20doing=20kfr=
ee(NULL);=20with=20the=20following:=0D=0A>=20=0D=0A>=20Yes,=20you=20are=20r=
ight.=0D=0A>=20But=20Kfree()=20is=20checking=20NULL=20internally.=20So=20it=
=20does=20not=20a=20problem=20I=20think.=0D=0A>=20Anyway=20I=20added=20kfre=
e(edev->cables)=20before=20exit=20extcon_alloc_cables()=20like=0D=0A>=20bel=
ow=20on=20v3=20patches.=0D=0A>=20=0D=0A>=20static=20int=20extcon_alloc_cabl=
es(struct=20extcon_dev=20*edev)=20=7B=20...=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20for=20(index--;=20ind=
ex=20>=3D=200;=20index--)=20=7B=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20cable=20=
=3D=20&edev->cables=5Bindex=5D;=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20kfree(cab=
le->attr_g.name);=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20=0D=0A>=20+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20kfree(edev->cables);=0D=0A>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20return=20-ENOMEM;=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=7D=0D=0A>=20=0D=0A=0D=0AIn=20order=20to=20avoid=20unnecessary=20kfre=
e(NULL),=20the=20position=20will=20be=20moved=20like=20below=20on=20v4=20pa=
tch.=0D=0A=0D=0Aerr_alloc_muex:=0D=0A=09for=20(index=20=3D=200;=20index=20<=
=20edev->max_supported;=20index++)=0D=0A=20=20=20=20=20=20=20=20=09kfree(ed=
ev->cables=5Bindex=5D.attr_g.name);=0D=0A+=09if=20(edev->max_supported)=0D=
=0A+=09=09kfree(edev->cables);=0D=0Aerr_alloc_cables:=0D=0A-=09if=20(edev->=
max_supported)=0D=0A-=09=09kfree(edev->cables);=20=0D=0A=20=20=20=20=20=20=
=20=20return=20ret;=0D=0A=0D=0A=0D=0A>=20Regards,=0D=0A>=20Bumwoo=0D=0A=0D=
=0A
