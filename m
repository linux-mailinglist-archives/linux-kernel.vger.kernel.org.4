Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C627966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiKNJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiKNJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:48:22 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987AC1E3E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:48:18 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221114094814epoutp011c7dbe3c3ea413fd48db4c2cf27e3638~naoJTmWhs2562725627epoutp01D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:48:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221114094814epoutp011c7dbe3c3ea413fd48db4c2cf27e3638~naoJTmWhs2562725627epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668419294;
        bh=NDVNcV7l0x/huwXbJ7pX5DpD2X4I2MT/2OeqNYR2xkI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=YVwnfS6z9pQHM6em4Zk5FaBSmYsHF2LNPcvp1wZddRJ05EsDwr6pLt4E6Y7lbJcNu
         UP23tn4SsF3hKHapDFZ6ihxAlGHO/pCWpyl705tQeqwV7yx1p8blczL1iylxChbQwd
         uWx5kPxgzga0xCDDgVkw6l3XMLQbQygsFdgdUdk4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221114094813epcas5p4e3d7f305c11960c1019382e414a1f101~naoIRYD5Z1612416124epcas5p4S;
        Mon, 14 Nov 2022 09:48:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N9kyM21nLz4x9Pv; Mon, 14 Nov
        2022 09:48:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.AF.56352.BDE02736; Mon, 14 Nov 2022 18:48:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221114094451epcas5p3a3a204af8f5612eab678411f8f54b02b~nalL6-Otj3262432624epcas5p34;
        Mon, 14 Nov 2022 09:44:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221114094451epsmtrp238c38965079530270487ffd4bd85cfa5~nalL5kW1g0248002480epsmtrp2p;
        Mon, 14 Nov 2022 09:44:51 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-5a-63720edbe2c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.3C.14392.31E02736; Mon, 14 Nov 2022 18:44:51 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221114094447epsmtip2526bcacdf34c3e79d80b14aac4690256~nalIgDyqI0602106021epsmtip2T;
        Mon, 14 Nov 2022 09:44:47 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <smitha.t@samsung.com>
In-Reply-To: <ec5beb10-25b8-8c14-f5d4-4a8f5241edb7@linaro.org>
Subject: RE: [Patch v4 2/3] media: s5p-mfc: Add variant data for MFC v7
 hardware for Exynos 3250 SoC
Date:   Mon, 14 Nov 2022 15:14:46 +0530
Message-ID: <000001d8f80d$bdf7b320$39e71960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG9taFgtZ7ToHcbVMYpRg1LfBBDaAJWSJlOAkxE9P4B1AupCa5A8Mlg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+z7Ps2cDmz4gxBdC2e3O7lwHYzLGgwHaZfaY3sGddXRkrDUe
        2WK/bhuiVLgi6uCI9EyDgaDyw24i4hgIyDocWxiZnvzsUgQU4mdoIAVE0NiDxX+vz8/3vT/f
        +3JQ3yJ2EEepMdJ6jUzFx72xhrbtgtB7G/XycKeVSw6WNuBk+fwoQg6Uz2Kko66eTdq6i1Hy
        Ynsriyxz3maR1248xMirY+7q3aJ+jBwtqwHkuPkBThaMDaGkfdI9YX3UyyK7mktwMr+2nkVe
        dvazycq+uwhZZV1CyAv1T9lkjt3JJvtbGgD5+RdOZDekqkurAdXYXwGovooZlGoy97Op8pZx
        hLJacnHqfm8LTtVVHKdyXIsYVWCzACrP2YdTs9atVMfcLDuBm5QWo6BlKbSeR2vk2hSlJjWW
        v/+g9DVppCRcFCqKJqP4PI1MTcfy9xxICN2rVLlPwOcdkanS3akEmcHAF8bF6LXpRpqn0BqM
        sXxal6LSiXVhBpnakK5JDdPQxp2i8PAdke7G99MUU50uRHeLe7Rr+jrbBHo25AEvDiTEcOKx
        Cc0D3hxf4jqAY381IUwwA+Dtn09hTPAngLblP1h5gOMZKRrewOTtANaemsKZYBTA/PO52Ope
        nBDCgY581mrBj3ABOGgb8oigRBkGez97gq92eRFx8DdLoYc3E4dh99SvHsaIbXDkl1nPJi4R
        DcdzJ3CGfeCPRcOePEq8DKvOT6KMCx5cGKlirbIfsRde7JpEmJ4A6FrI9whDosMLls1kI8zA
        Hri0Mr/Gm+FEu43NcBCcnbbjDMvhowvjawIqeKXlG4zhXbC1uwRbvQVKbIdXmoVMegs83VGz
        prsRfvX38Np6LmwsfcYvwZL78yyGg2HbpUpwAvDN66yZ11kzr7Ng/l/tHMAsIJDWGdSptCFS
        F6GhM/57crlWbQWePyLY3wgeDj4JcwCEAxwAclC+H7c0WCv35abIjmXSeq1Un66iDQ4Q6b73
        STTIX651fzKNUSoSR4eLJRKJODpCIuIHcMsLBXJfIlVmpNNoWkfrn80hHK8gExJ9y0+47xC9
        76r3Nb3wREjEx4uLb/Rk35krGLRUCb5eSeqIM72YfHxg9IU3I7mHd2859sFJi396G7nceujd
        qN8VtjP49+0DC5OOeF2xxD/wp5nH1m/rKhYW4409ijsHbJfeVtYmbk0MuVlZlTmdc9T1oaqZ
        b8iK9elZMvF+eFBYq9x5buTTUAQ5M7konR/SJj73NPnVHUl5roKPSrICt6njpf/U7BL0tilN
        ik1RBwuXi0NCXtdwi5+n7UOpA6drOQsx4urvYkRbv6wOLi86ojYn+w42ZaKQdjnOftJpmXtP
        +dZEp1f9O457MRmam5dHG+wBKzmWyKyMG9mvyIRnhVyfTSE1fMygkIkEqN4g+xd0BPjbrAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTWRTHc99OTc2TolyUOFoVFbVIgslVEXEczRNDYkQxcQlWeFKUpWnF
        PQJKHekQRIgGyiYUqjaA2rIpxWitIigqooDBygxYW8RhDHVDiQ60mQnffuf8l3s/HAb3TCWn
        M3GJB3hFojReTAmIurviX5aIJiuil2an+6I/i+sopP1qx1Cv1kkgs7GWRjXPC3B0qfk2iUos
        j0lUf6ePQNcdY2p7vpVA9pJqgAY0rymU5fgLR02DYwlDfyeJOm4WUijzWi2JqixWGlV0tWNI
        ZxjFUFntRxqpmiw0sprqAEo/bcFCIVdZXAm4Bms54LrKh3HuhsZKc1rTAMYZ9BkU96rTRHHG
        8hROde8bwWXV6AGntnRRnNMwk2v95KQ3CbcLgmP4+LiDvCIgZLdA9uP3G5g8Q3jY9DksFWRP
        UgOGgWwQzH8zhgLGk20EMCdVT6iBx9jeF/48fZ92swhe+WGn3SYbgH11OS4TxQbA3tZMclzw
        YlsAPPso3TXgrJGAVSoT4Y44Aax1mKjxiAcbAt/q81wsYmPg9bQrrjcIdh60dTtdtUJ2ORzI
        eEe5eQpsyX/j2uPsImh7afufdaWDuPt/s+CITUeOsxe7Hl7qGMTcHm94byQTzwYizYQqzYQq
        zYQqzYTIRUDogQ8vVybEJigD5YGJ/CGJUpqgTE6MlUQnJRiA60j8FzaAev0HiRlgDDADyOBi
        L2Gxb1K0pzBGeuQor0iKUiTH80ozmMEQYm/hU3VLlCcbKz3A7+d5Oa/4T8UYj+mpWJp9cdpA
        r1NWcv64Y9WUInXTucEFO1N252U9CT/2Tma0n7m2pa2nMvdI9dz56768r28Yag0LuMs/Ttaj
        JsK/YnnBJMGFvMhtcX33/y5cE/rPSdWGycECxO9IL53KPSiSvOix+TG69ps5EaWRjSLbxqt+
        RfCbllXBn9PkuQ+Dfl175muYxZLRJpp361XDqZXNK7jVsooa50iB5uOykM3HfDv3fQ99lrP3
        bPdw5C6fthiR9eiOJ8ZOvHr2y6Bd7JKt9J6hnvA1cy5X+SUtiNgzSmVu7Gg2ef9Wxs22fSFX
        LLYf6h6KCqAkPuo/LphP7B81pQQTw+v6tVkLSZ3jeOPzImJTv5hQyqSB/rhCKf0XzMJcfJMD
        AAA=
X-CMS-MailID: 20221114094451epcas5p3a3a204af8f5612eab678411f8f54b02b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
        <CGME20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b@epcas5p3.samsung.com>
        <20221114054655.68090-3-aakarsh.jain@samsung.com>
        <ec5beb10-25b8-8c14-f5d4-4a8f5241edb7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 14 November 2022 13:22
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v4 2/3=5D media: s5p-mfc: Add variant data for MFC =
v7
> hardware for Exynos 3250 SoC
>=20
> On 14/11/2022 06:46, Aakarsh Jain wrote:
> > commit =225441e9dafdfc6dc40fa=22 which adds mfc v7 support for
>=20
> Please run scripts/checkpatch.pl and fix reported warnings.
>=20
Do you mean warnings on =225441e9dafdfc6dc40fa=22 commit? Or on this patch?
=20
I am running like this :  ./scripts/checkpatch.pl patch_file, it does not s=
how any warnings.

or am I missing anything while running checkpatch on the current patch?

> > Exynos3250 and use the same compatible string as used by
> > Exynos5240 but both the IPs are a bit different in terms of IP clock.
> > Lets add variant driver data based on the new compatible string
>=20
> Just =22Add variant=22
>=20
> Best regards,
> Krzysztof


