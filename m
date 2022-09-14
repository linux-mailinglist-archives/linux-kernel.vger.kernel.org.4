Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA615B8565
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiINJof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiINJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:44:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB84D16D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:44:01 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220914094357epoutp04c7b1eab7cfa8fc628842cf5ea1d2641e~UsN-bkzTd0361703617epoutp04r
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:43:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220914094357epoutp04c7b1eab7cfa8fc628842cf5ea1d2641e~UsN-bkzTd0361703617epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663148637;
        bh=W9RNa9MHz9YzAadS3NEIg/sWSaw5xEX/ZRFp1FC5R5g=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=vZcE0LnDhsEqsWwdB018Ubgjx7Yv7zUoPxZaTtkr8yQBvyNVuoyjavgxLUIeKe0uy
         c8KIbTCQ1BC6MEL4Et7I6GUfmjvBq9tnRqDw4i0XByfKy0GvYoq8vxnCVTvyLOYtdn
         D/IBuYMy4jO/FWxS13847jLxLQTtDmS1LBoIXjAc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220914094357epcas1p1ed4b76d89dee6f724714c906c1a05c01~UsN-Jkdy32456324563epcas1p1z;
        Wed, 14 Sep 2022 09:43:57 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MSFlc4tzJz4x9Pw; Wed, 14 Sep
        2022 09:43:56 +0000 (GMT)
X-AuditID: b6c32a37-5b9ff70000003cc4-a0-6321a25cc890
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.8E.15556.C52A1236; Wed, 14 Sep 2022 18:43:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [RESEND] devfreq: governor: Save void *data in the governor
 userspace
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kant Fan <kant@allwinnertech.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allwinner-opensource-support@allwinnertech.com" 
        <allwinner-opensource-support@allwinnertech.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4@epcms1p8>
Date:   Wed, 14 Sep 2022 18:43:55 +0900
X-CMS-MailID: 20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmrm7MIsVkg4f7VC1O/e1ltLj+5Tmr
        xZONj5gtzja9Ybe4vGsOm8Xn3iOMDmwer9qeMXn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaEvvlsBVN0K87u6WZs
        YPyn3cXIySEhYCJxa00nYxcjF4eQwA5Gicu3l7F0MXJw8AoISvzdIQxSIywQIbH720E2EFtI
        QEmi4eY+Zoi4vkTHg22MIDabgK7E1g13WUBsEYEKiT/3mllBbGaBh4wSUxa6QezilZjR/pQF
        wpaW2L58K1gvp4CrxMfT95gg4qISN1e/ZYex3x+bzwhhi0i03jvLDGELSjz4uZsR5EyQOT+v
        6IOcLyEwmVHi5InjjBDOHEaJaRvesUE06EucmXsSzOYV8JV4Pf8b2HEsAqoSf6eshRrkIrGk
        Wx3iZm2JZQtfM4OEmQU0Jdbv0ocI80m8+9rDCvPKjnlPoE5Wkzi0ewnUyTISp6cvhDrTQ2LC
        kwWskKDdzygxY801xgmM8rMQoTsLybZZCNsWMDKvYhRLLSjOTU8tNiwwhkdocn7uJkZwstMy
        38E47e0HvUOMTByMhxglOJiVRHj7QhSShXhTEiurUovy44tKc1KLDzGaAr05kVlKNDkfmG7z
        SuINTSwNTMyMjE0sDM0MlcR59bQZk4UE0hNLUrNTUwtSi2D6mDg4pRqYnAQNtM/0X3gV98f9
        oWRHptrmtaLfuGKtT0+R/7apLPlW28owhx97Ky5OPRl55OGfanGWRxvvfdmYxcgd39a0q7bh
        s3RqpV6x5ExFZj211UZJgdpVZvM3bFWa+cJASs6z+N+qF/+epzdvZf0WLCjDavh8k7PjVyUZ
        +4K0L1JuPzn/cys0cIlWRDw+0zt1quxGi564FOlzJ6fraPlO+rPKmCv5U9S3uOUzalc5rvae
        +j95xSGzHf1sfSzfWZhDsrtdL4mkmryKqzjLvXXfEo4zcd/Lo/y6LWx+1PGXNT56dZdVsXzJ
        whj5KUXXdr09nl76q+yU/9Hf604+9A/vDj9+qd79KNuct0lTMsWLulyVWIozEg21mIuKEwFW
        p+9b/wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962
References: <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
        <20220329091449.105308-1-kant@allwinnertech.com>
        <CGME20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On=C2=A03/29/2022=C2=A05:14=C2=A0PM,=C2=A0Kant=C2=A0Fan=C2=A0wrote:=0D=0A>=
>=C2=A0The=C2=A0member=C2=A0void=C2=A0*data=C2=A0in=C2=A0the=C2=A0structure=
=C2=A0devfreq=C2=A0can=C2=A0be=C2=A0overwrite=0D=0A>>=C2=A0by=C2=A0governor=
_userspace.=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Kant=C2=A0Fan=C2=A0<kant=
=40allwinnertech.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0=C2=A0drivers/dev=
freq/governor_userspace.c=C2=A0=7C=C2=A06=C2=A0+++++-=0D=0A>>=C2=A0=C2=A0=
=C2=A01=C2=A0file=C2=A0changed,=C2=A05=C2=A0insertions(+),=C2=A01=C2=A0dele=
tion(-)=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/devfreq/g=
overnor_userspace.c=C2=A0b/drivers/devfreq/governor_userspace.c=0D=0A>>=C2=
=A0index=C2=A0ab9db7adb3ad..dbbb448dcbcf=C2=A0100644=0D=0A>>=C2=A0---=C2=A0=
a/drivers/devfreq/governor_userspace.c=0D=0A>>=C2=A0+++=C2=A0b/drivers/devf=
req/governor_userspace.c=0D=0A>>=C2=A0=40=40=C2=A0-17,6=C2=A0+17,7=C2=A0=40=
=40=0D=0A>>=C2=A0=C2=A0=C2=A0struct=C2=A0userspace_data=C2=A0=7B=0D=0A>>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=
=A0long=C2=A0user_frequency;=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0valid;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void=C2=A0*saved_data;=0D=0A>>=C2=A0=C2=A0=
=C2=A0=7D;=0D=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0static=C2=A0i=
nt=C2=A0devfreq_userspace_func(struct=C2=A0devfreq=C2=A0*df,=C2=A0unsigned=
=C2=A0long=C2=A0*freq)=0D=0A>>=C2=A0=40=40=C2=A0-91,6=C2=A0+92,7=C2=A0=40=
=40=C2=A0static=C2=A0int=C2=A0userspace_init(struct=C2=A0devfreq=C2=A0*devf=
req)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto=C2=A0out;=0D=0A>>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A=
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->v=
alid=C2=A0=3D=C2=A0false;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0data->saved_data=C2=A0=3D=C2=A0devfreq->data;=0D=0A>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devfreq->data=
=C2=A0=3D=C2=A0data;=0D=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err=C2=A0=3D=C2=A0sysfs_create=
_group(&devfreq->dev.kobj,=C2=A0&dev_attr_group);=0D=0A>>=C2=A0=40=40=C2=A0=
-100,6=C2=A0+102,8=C2=A0=40=40=C2=A0static=C2=A0int=C2=A0userspace_init(str=
uct=C2=A0devfreq=C2=A0*devfreq)=0D=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=
=A0=C2=A0static=C2=A0void=C2=A0userspace_exit(struct=C2=A0devfreq=C2=A0*dev=
freq)=0D=0A>>=C2=A0=C2=A0=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0userspace_data=C2=A0*data=C2=A0=3D=C2=
=A0devfreq->data;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0void=C2=A0*saved_data=C2=A0=3D=C2=A0data->saved_data;=0D=0A>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=0D=0A>>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=
=A0Remove=C2=A0the=C2=A0sysfs=C2=A0entry,=C2=A0unless=C2=A0this=C2=A0is=C2=
=A0being=C2=A0called=C2=A0after=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0device_del(),=C2=A0which=C2=A0sh=
ould=C2=A0have=C2=A0done=C2=A0this=C2=A0already=C2=A0via=C2=A0kobject_del()=
.=0D=0A>>=C2=A0=40=40=C2=A0-108,7=C2=A0+112,7=C2=A0=40=40=C2=A0static=C2=A0=
void=C2=A0userspace_exit(struct=C2=A0devfreq=C2=A0*devfreq)=0D=0A>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysfs_remove_group(&devfreq->dev.kobj,=C2=
=A0&dev_attr_group);=0D=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(devfreq->data);=0D=0A>>=
=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devfreq->data=C2=A0=
=3D=C2=A0NULL;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0devfreq->data=C2=A0=3D=C2=A0saved_data;=0D=0A>>=C2=A0=C2=A0=C2=A0=7D=0D=
=0A>>=C2=A0=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0static=C2=A0int=C2=A0devfr=
eq_userspace_handler(struct=C2=A0devfreq=C2=A0*devfreq,=0D=0A>=0D=0A>Dear=
=C2=A0MyungJoo,=C2=A0Kyungmin=C2=A0&=C2=A0Chanwoo,=0D=0A>Gently=C2=A0ping=
=C2=A0this=C2=A0issue...=C2=A0Does=C2=A0this=C2=A0patch=C2=A0has=C2=A0a=C2=
=A0chance=C2=A0to=C2=A0be=C2=A0accepted?=0D=0A>This=C2=A0seems=C2=A0to=C2=
=A0be=C2=A0a=C2=A0bug=C2=A0in=C2=A0devfreq=C2=A0userspace=C2=A0governor,=C2=
=A0which=C2=A0affects=C2=A0the=C2=A0=0D=0A>switching=C2=A0between=C2=A0gove=
rnors=C2=A0--=C2=A0When=C2=A0switching=C2=A0from=C2=A0userspace=C2=A0to=C2=
=A0=0D=0A>ondemand,=C2=A0the=C2=A0ondemand=C2=A0governor=C2=A0would=C2=A0be=
=C2=A0invalid.=0D=0A>If=C2=A0there's=C2=A0any=C2=A0question,=C2=A0please=C2=
=A0let=C2=A0me=C2=A0know.=0D=0A>Thank=C2=A0you.=0D=0A=0D=0AYes,=20indeed.=
=20This=20is=20a=20bug.=0D=0A=0D=0AActually,=20it=20appears=20that=20alloca=
ting=20a=20new=20memory=20buffer=20for=0D=0Adevfreq->data=20itself=20is=20a=
=20bug=20for=20a=20governor,=20this=20is=20supposed=0D=0Ato=20be=20allocate=
d=20by=20a=20device=20driver.=20Thus,=20the=20comment=20of=0D=0A=22void=20*=
data=22=20of=20=22struct=20devfreq=22=20should=20be=20updated:=0D=0A=22/*=
=20private=20data=20for=20governors=20given=20by=20device=20drivers=20*/=22=
=0D=0A=0D=0AIt'd=20be=20better=20to=20have=20something=20like,=20=22void=20=
*internal_data=22=0D=0Afor=20governors=20to=20freely=20handle=20within=20it=
s=20context=20of=20init-exit,=0D=0Awhich=20is=20not=20touched=20by=20its=20=
users=20(device=20drivers).=0D=0A=0D=0A=40Chanwoo:=20what's=20your=20opinio=
n=20on=20this?=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A
