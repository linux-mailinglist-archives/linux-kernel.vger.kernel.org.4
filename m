Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023969C4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBTE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTE6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:58:00 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F25BA274
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:57:59 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220045757epoutp037389050fec52bbb18e81bfce99c269b8~Fb4qeqa6a2144921449epoutp03-
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:57:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220045757epoutp037389050fec52bbb18e81bfce99c269b8~Fb4qeqa6a2144921449epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676869077;
        bh=S/FZcfjItx4IRC6VaCaD+7ewnauXYcTKyKxsThLE0TM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=AyiLhJ2d4cUxx2RFA4p/ioj3+pk6Z7fOFyHVysuI+p1rMN9FsoRRaP6csJNaYRrqy
         JncUMDrQVJpXlR4Ie2ot7kAhifnEj8qpa8Rsq0nJx7AZV8UFg2pJ8R9l56SqF3NAfN
         7lSIYf4LSU2ps1BjgHzrR5GJXN3hvZLkpvNQv/0w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230220045757epcas1p3eb243c63a9e99d457719d85d2480a361~Fb4qO1bwq1987719877epcas1p3m;
        Mon, 20 Feb 2023 04:57:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PKqtD28QZz4x9Q1; Mon, 20 Feb
        2023 04:57:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.83.37890.4DDF2F36; Mon, 20 Feb 2023 13:57:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045755epcas1p28ca287c2c0524e3dbed3bbf009d69798~Fb4pE1WEh1895418954epcas1p2z;
        Mon, 20 Feb 2023 04:57:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220045755epsmtrp28992526e3a13656ea8e240146757f6c4~Fb4pEFyRG0980309803epsmtrp2Z;
        Mon, 20 Feb 2023 04:57:55 +0000 (GMT)
X-AuditID: b6c32a38-39fff70000029402-05-63f2fdd44a5b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.93.05839.3DDF2F36; Mon, 20 Feb 2023 13:57:55 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230220045755epsmtip2b55978d3d4508d20f19de65e7454a106~Fb4o6mDYt2798127981epsmtip24;
        Mon, 20 Feb 2023 04:57:55 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230220043833epcms1p77e8ebcbb3882f5ad13ecac138db19ee2@epcms1p7>
Subject: RE: [PATCH 2/4] extcon: added extcon_alloc_cables to simplify
 extcon register function
Date:   Mon, 20 Feb 2023 13:57:55 +0900
Message-ID: <001e01d944e7$e51c94d0$af55be70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMG6pzC76s2IaGOi86/lnOoVC794gLcDvaNAcHNJFcCbkdJD6xDmSTQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmvu6Vv5+SDX7O4be4/uU5q8XlXXPY
        LG43rmBzYPbo27KK0ePzJrkApqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3Ml
        hbzE3FRbJRefAF23zBygHUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScArMCveLE
        3OLSvHS9vNQSK0MDAyNToMKE7IyO3weZCnZxVTyffJ21gfEqZxcjB4eEgInE7G2RXYxcHEIC
        OxglFs1tYYRwPjFKTDs3jQnC+cYoMXHrKyCHE6yjac8PZojEXkaJC69/giWEBJ4zSszcJg5i
        swloSSycM58NxBYRyJK48uM1mM0p4CexZe8vMFtYIFFi4d9tzCA2i4AqUOt5sDm8ApYSP+ae
        YYawBSVOznzCAmIzC2hLLFv4mhniCAWJn0+XsULMd5N4tnYqI0SNiMTszjaw4yQELrFLzNj8
        nA2iwUVi6reVrBC2sMSr41vYIWwpic/v9kLVpEusvHIHKp4j8fp+OyOEbSzx7u1aZlB4MQto
        SqzfpQ8RVpTY+Xsu1F4+iXdfe1ghQcor0dEmBFGiLNH94AU03CQlFj+9AzXRQ2Lnv01sExgV
        ZyH5chaSL2ch+WYWwuIFjCyrGMVSC4pz01OLDQtM4HGdnJ+7iRGc+rQsdjDOfftB7xAjEwfj
        IUYJDmYlEV7pQx+ShXhTEiurUovy44tKc1KLDzGaAsN9IrOUaHI+MPnmlcQbmlgamJgZmVgY
        WxqbKYnzitueTBYSSE8sSc1OTS1ILYLpY+LglGpgkrbVbV3+K6LQn/NgfJan5MukG0FbcpIn
        drWsfWZSeMfPy7Q2PKg0bpaMXq+vwDwWLt7avD8r8xLmnBb6OyHnt221HIfnq859KjOvh37P
        05l0SUonjqe3S02x5OX9yO1bXpux3dd5fzx5+zOxzXYv9ebcytJf/+XCtDqOOwnVZ/rZlwfW
        FV6/ZWeRtmS9i/CnTNPboXylRumzjBZ3fH66OK31lOwjc5ltYm8F5i/5FWVX9uKGXRBj98n1
        3Zvi3N8yflz3xnTB9SONDw1dd9l3SEt5x/r8ULTb4Dp5k9q7ixxCHlOf161o0fQKWdE1SWan
        5oK4J5EhPauTchZU7pTlXzn/yq5jS8redWquyvmpxFKckWioxVxUnAgAORu9wAYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO7lv5+SDfp7jSyuf3nOanF51xw2
        i9uNK9gcmD36tqxi9Pi8SS6AKYrLJiU1J7MstUjfLoEr4/bkn8wFWzkq7ry7xNbA+Iuti5GT
        Q0LARKJpzw/mLkYuDiGB3YwSE+Y0MEEkJCXOLn/E3sXIAWQLSxw+XAxR85RR4u/3A2DNbAJa
        EgvnzAezRQRyJA6sn8IOUfSRUeJz6y1WkASngJ/Elr0Q24QF4iVadr1hBLFZBFQlZm47D7aM
        V8BS4sfcM8wQtqDEyZlPWEBsZgFtid6HrYww9rKFr5khjlOQ+Pl0GSvEYjeJZ2unQtWISMzu
        bGOewCg0C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYID
        XktzB+P2VR/0DjEycTAeYpTgYFYS4ZU+9CFZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBia57DPO0gcyV64M2P2QYXfla6uLXp81p2ZmHfrxUfVD8pyn
        FaIPrk1v5Fm8ufdElcSribU+ulJB9YvPrLRmeZd/LcZTTH9/8xGnTa7sN188CtK/eeerqqaV
        GGOrd//H/n3tugZRn/+EXpn3Pd7p7P+KjQG+Hyaeiq38nRIU+k1uzqE0TcdnHduP5P/MlDqx
        Sn3Dg02MP34GqgZdn7jwA5O0jHC9zbKek+fPaCvdveqotZk16Gb9X8XuJwn8j/ZY31Rx+rjQ
        0UhGLW574LNZB1vkrAJuLvWYUKX2etszkeyP/68JBr3TyY2Ycq/69NZjQp+f7fwxa3nEuuM7
        1lmlxl/etIfzc9LByLNiVrwWyhKKSizFGYmGWsxFxYkAkfzrGOcCAAA=
X-CMS-MailID: 20230220045755epcas1p28ca287c2c0524e3dbed3bbf009d69798
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p29ef858c842b18de89f1b034acb26086a
References: <20230217084613.25359-3-bw365.lee@samsung.com>
        <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p29ef858c842b18de89f1b034acb26086a@epcms1p7>
        <20230220043833epcms1p77e8ebcbb3882f5ad13ecac138db19ee2@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I Got it.

I will prepare new patch for return value.

Thank for your comment.

Regards,
Bumwoo.
-----Original Message-----
From: MyungJoo Ham <myungjoo.ham=40samsung.com>=20
Sent: Monday, February 20, 2023 1:39 PM
To: Bumwoo Lee <bw365.lee=40samsung.com>; Chanwoo Choi <cw00.choi=40samsung=
.com>; linux-kernel=40vger.kernel.org
Subject: RE: =5BPATCH 2/4=5D extcon: added extcon_alloc_cables to simplify =
extcon register function

>--------- Original Message ---------
>Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=20<bw365.lee=40samsung.com>Product=20=
S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=20Date=20:=20=0D=0A>2023=
-02-17=2017:48=20(GMT+9)=20Title=20:=20=5BPATCH=202/4=5D=20extcon:=20added=
=20=0D=0A>extcon_alloc_cables=20to=20simplify=20extcon=20register=20functio=
n=0D=0A>=20=0D=0A>The=20cable=20allocation=20part=20is=20functionalized=20f=
rom=20extcon_dev_register.=0D=0A>=0D=0A>Signed-off-by:=20Bumwoo=20Lee=20<bw=
365.lee=40samsung.com>=0D=0A=0D=0A...=0D=0A=0D=0A>+=20=20=20=20=20=20=20=20=
if=20(extcon_alloc_cables(edev))=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20goto=20err_alloc_cables;=0D=0A>=20=0D=0A=0D=0AYou=20are=20ab=
andoning=20error=20return=20values,=20here.=0D=0APlease=20return=20appropri=
ate=20error=20codes.=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A=0D=0A
