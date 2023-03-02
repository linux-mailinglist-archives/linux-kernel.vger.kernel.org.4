Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173CE6A7BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCBHMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:12:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75223B200
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:12:12 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302071209epoutp036176a1c5874ddf51eb6783d2ac91515f~IiKsC6Yhg0689806898epoutp03g
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:12:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302071209epoutp036176a1c5874ddf51eb6783d2ac91515f~IiKsC6Yhg0689806898epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677741129;
        bh=m2dR0zzJCRq+GA8hss70F6Tqq9Auz9ytXEK5AAcfIMQ=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=lseZAq8QtSbW3E66DVEtcqF6cejX/IzRga6RWRZFXFX0J2QuvxHskFOS33v9nh4TI
         nVe7FrfbAR7Xmc1TQFghUm9r1wcapUKxrziY06LDoPEMeCZbD7TQ/9K2+ZJUnG1LoN
         7l24GrEfAU8IWOd07WYIq1Cm9lVpldCork+4roRI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230302071208epcas1p3fc19c4c8dfbc6bfa3ac4832b246d5714~IiKry70Mz1935219352epcas1p30;
        Thu,  2 Mar 2023 07:12:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PS2NS096Bz4x9Pv; Thu,  2 Mar
        2023 07:12:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.28.52037.64C40046; Thu,  2 Mar 2023 16:12:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230302071206epcas1p45ede16ade6e4a5a089c645386ba04702~IiKprKoMM2654026540epcas1p4w;
        Thu,  2 Mar 2023 07:12:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302071206epsmtrp19dfcb37242aa358fd224cdbbe5db0bc3~IiKpqjHBd0546205462epsmtrp1o;
        Thu,  2 Mar 2023 07:12:06 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-a9-64004c46aa99
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.82.31821.64C40046; Thu,  2 Mar 2023 16:12:06 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302071206epsmtip27ea7a5186c09fa3d7559a2bffddaffbd~IiKpfZx_q0399403994epsmtip2D;
        Thu,  2 Mar 2023 07:12:06 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230302063312epcms1p1e0cd1a2d74dbd3daa4c7b7407b975803@epcms1p1>
Subject: RE: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to
 simplify extcon register function
Date:   Thu, 2 Mar 2023 16:12:06 +0900
Message-ID: <000001d94cd6$4beaed60$e3c0c820$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMs5Xzd7TX9SfVksmmJQ2eqp0be4gEndo8vAX4NdCIBRRvN4gEPThYuAeHKeESsCP48gA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmga6bD0OKwa17lhbXvzxntbi8aw6b
        xe3GFWwOzB59W1YxenzeJBfAFJVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yY
        W1yal66Xl1piZWhgYGQKVJiQnXHl50XmgpnyFcdnTWBsYPwp28XIySEhYCLRu+gDWxcjF4eQ
        wA5GiabmmcwQzidGiSk3JrFDOJ8ZJU69nM4O03J34k2oql2MEi1HulggnOeMEmvXXACrYhPQ
        klg4Zz4biC0ikCVx5cdrMJtTwE9i5ptbjCC2sECGxKFXU4AmcXCwCKhI/L7ODxLmFbCU6L47
        mx3CFpQ4OfMJC4jNLKAtsWzha2aIIxQkfj5dxgoxPkzi3aQZbBA1IhKzO9vAjpMQuMQusefq
        XDaIBheJI1cfQdnCEq+Ob4H6RkriZX8blJ0usfLKHSg7R+L1/XZGCNtY4t3btWB3MgtoSqzf
        pQ8RVpTY+XsuI8RePol3X3tYQUokBHglOtqEIEqUJbofvGCCsCUlFj+9AzXRQ2LSuROsExgV
        ZyH5chaSL2ch+WYWwuIFjCyrGMVSC4pz01OLDQuM4ZGdnJ+7iRGc/LTMdzBOe/tB7xAjEwfj
        IUYJDmYlEd6Ft/8kC/GmJFZWpRblxxeV5qQWH2I0BQb7RGYp0eR8YPrNK4k3NLE0MDEzMrEw
        tjQ2UxLnFbc9mSwkkJ5YkpqdmlqQWgTTx8TBKdXAVHCm90JhTp2+U0rVja4lm5cEx2rM47y5
        3+6m1pmeFwnHH0gVvQgzS963Yz+3cYW03fWMqdefqjv/Z1rppR2hUsa69ND81aqv5LqjXghE
        aZq6+jt9qv/Wx9B8ReFO7znXClnP99Ev3VKOK3sfeJnCt+S6xeO1vitspt4u0P7F2dJoFfRy
        E59z9qvcCxfvv4pX+Sf7/TeD37LfDaGaUst2dHZliYu89pZsjPi2SFFHS5LjiL/cwlWcid95
        166bfurkjyuBx24YGyaU636+eJ11O/eFHQL3v3Qui29IzvlX6z63wZjjtaEES35jVeSC3cst
        xJbZb7mi7rruudG1ubKnnIvfzlBs0gx1qv2+s/umEktxRqKhFnNRcSIAD/4FqQcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvK6bD0OKwfunKhbXvzxntbi8aw6b
        xe3GFWwOzB59W1YxenzeJBfAFMVlk5Kak1mWWqRvl8CV8eXUPsaC7cIVc/58ZG5gPM/bxcjJ
        ISFgInF34k3mLkYuDiGBHYwSrW9Os0EkJCXOLn/E3sXIAWQLSxw+XAxR85RR4vvda8wgNWwC
        WhIL58wHqxcRyJE4sH4KO4gtJPCQSeL3R7AFnAJ+EjPf3GIEsYUF0iRu/+wEm8kioCLx+zo/
        SJhXwFKi++5sdghbUOLkzCcsIDazgLbE05tP4exlC18zQ5ymIPHz6TJWiLVhEu8mzWCDqBGR
        mN3ZxjyBUWgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BAe7ltYOxj2rPugdYmTiYDzEKMHBrCTCu/D2n2Qh3pTEyqrUovz4otKc1OJDjNIcLErivBe6
        TsYLCaQnlqRmp6YWpBbBZJk4OKUamAKb5CpN/ZkzujMNIr02fpdao1KiJP6Qc+aL56pVdrGh
        q8PM84SW7TFWOLVVhWlK+jLZ92tDDHtDBOMCn50WUMq7fVBp2tZJczpF/uRHlm1PfWB+Pt52
        VXlx2VF+WyWLQpXzOo/eTZ+Q7Fondj/qhsHtpnnHzE3C42b2zE061K8yb968vtVWnw11xBhs
        ZGaVCXBfYeRwXLaa9VBDWky5ff0v/uLwZ8ynxW4IF8+sf9pyZqdBm4vv3Y0Xw0TNZXbz2t+Q
        U1NfmZtl49NbP2FvbfS05PypaY/7kmOvXUr3ZupVS3AsrO5YOW9lRM/8RTHfXz90rO51te6b
        0KJ7oePX/C/FwneWxJ75l8Va1KzEUpyRaKjFXFScCACOyW5C5QIAAA==
X-CMS-MailID: 20230302071206epcas1p45ede16ade6e4a5a089c645386ba04702
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: MyungJoo Ham <myungjoo.ham=40samsung.com>
> Sent: Thursday, March 2, 2023 3:33 PM
> To: Bumwoo Lee <bw365.lee=40samsung.com>; Chanwoo Choi
> <cw00.choi=40samsung.com>; linux-kernel=40vger.kernel.org
> Subject: RE: RE: =5BPATCH v2 2/4=5D extcon: Added extcon_alloc_cables to
> simplify extcon register function
>=20
> >
> >
> >--------- Original Message ---------
> >Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=20<bw365.lee=40samsung.com>Product=
=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=20Date=20:=0D=0A>=20>=
2023-03-02=2010:38=20(GMT+9)=20Title=20:=20RE:=20=5BPATCH=20v2=202/4=5D=20e=
xtcon:=20Added=0D=0A>=20>extcon_alloc_cables=20to=20simplify=20extcon=20reg=
ister=20function=0D=0A>=20>=0D=0A>=20>Hello.=0D=0A>=20>=0D=0A>=20>As=20you=
=20can=20see,=20edev->cables=20are=20freed=20if=20extcon_alloc_cables()=0D=
=0A>=20>function=20return=20error=20handling=20in=20extcon_dev_register()=
=20Other=20added=0D=0A>=20functions=20are=20also=20same.=0D=0A>=20>=0D=0A>=
=20>Because=20it's=20functionalized,=20apart=20from=20this,=20do=20you=20wa=
nt=20to=20mention=20that=0D=0A>=20it=20should=20be=20freed=20within=20the=
=20function?=0D=0A>=20>Please=20let=20me=20know=20your=20opinion.=0D=0A>=20=
>=0D=0A>=20>extcon_dev_register(struct=20extcon_dev=20*edev)=7B=20...=0D=0A=
>=20>=0D=0A>=20>=20=20=20=20=20=20=20=20ret=20=3D=20extcon_alloc_cables(ede=
v);=0D=0A>=20>=20=20=20=20=20=20=20=20if=20(ret)=0D=0A>=20>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20goto=20err_alloc_cables;=0D=0A>=20>=0D=0A>=
=20>...=0D=0A>=20>=0D=0A>=20>err_alloc_cables:=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20if=20(edev->max_supported)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20kfree(edev->cables);=0D=0A>=20>=0D=0A>=20>=0D=0A>=
=20>Regards,=0D=0A>=20>Bumwoo=0D=0A>=20=0D=0A>=20In=20such=20a=20case,=20yo=
u=20are=20doing=20kfree(NULL);=20with=20the=20following:=0D=0A=0D=0AYes,=20=
you=20are=20right.=0D=0ABut=20Kfree()=20is=20checking=20NULL=20internally.=
=20So=20it=20does=20not=20a=20problem=20I=20think.=0D=0AAnyway=20I=20added=
=20kfree(edev->cables)=20before=20exit=20extcon_alloc_cables()=20like=20bel=
ow=20on=20v3=20patches.=0D=0A=0D=0Astatic=20int=20extcon_alloc_cables(struc=
t=20extcon_dev=20*edev)=20=7B=0D=0A...=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20for=20(index--;=20index=20>=3D=
=200;=20index--)=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20cable=20=3D=20&edev->=
cables=5Bindex=5D;=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20kfree(cable->attr_g.name);=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=7D=0D=0A=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20kfree(edev->cables);=0D=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20-ENOMEM;=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A=0D=0A=0D=0A=0D=
=0A>=20>+static=20int=20extcon_alloc_cables(struct=20extcon_dev=20*edev)=20=
=7B=0D=0A>=20...=0D=0A>=20>+=20=20=20=20=20=20=20=20if=20(=21edev->max_supp=
orted)=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20=
0;=0D=0A>=20>+=0D=0A>=20>+=20=20=20=20=20=20=20=20edev->cables=20=3D=20kcal=
loc(edev->max_supported,=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20sizeof(struct=20extco=
n_cable),=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20GFP_KERNEL);=0D=0A>=20>+=20=20=20=20=
=20=20=20=20if=20(=21edev->cables)=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20return=20-ENOMEM;=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=
=20=0D=0A>=20Cheers,=0D=0A>=20MyungJoo=0D=0A>=20=0D=0A=0D=0ARegards,=0D=0AB=
umwoo=0D=0A=0D=0A
