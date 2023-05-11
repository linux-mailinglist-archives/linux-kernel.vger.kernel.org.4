Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5546FF08A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjEKLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEKLa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:30:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0547A558D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:30:56 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230511113053epoutp0196bdf6e2893560ae268a6615ba8dfb35~eE2lHiuXR0789807898epoutp01s
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:30:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230511113053epoutp0196bdf6e2893560ae268a6615ba8dfb35~eE2lHiuXR0789807898epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683804653;
        bh=hxadvZ90jQwN3sY5u5NG5YSwP+69MHqwcLLQTKMC4no=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eCNByOUC0ZT6Q/T2mQtLJIVF5ws6nURlIax+pu8hAusHU8Y+s32yQghcOrpJp6iga
         ghra7+0qrWpt2ozIO4DB4xtEPvUIjc9SKBLFmU7PjcxS9Kwoupx9+eGO2AzM2aH5KS
         EvKB9SiEXwNbtF68BVN6zf+usBoAvp5hXp2C7mUo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230511113052epcas5p14977f5362f2296b6e3f3697cb1079f76~eE2kUmQQe1700717007epcas5p16;
        Thu, 11 May 2023 11:30:52 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QH8pf689dz4x9Q1; Thu, 11 May
        2023 11:30:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.23.55646.AE1DC546; Thu, 11 May 2023 20:30:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230511093509epcas5p19661fe238eb92ac71d23546b02debd1a~eDRhznWR82856128561epcas5p1c;
        Thu, 11 May 2023 09:35:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230511093509epsmtrp1f67f27b028b9d302e9ee2d83d0c52cf9~eDRhyoYwX1004110041epsmtrp1-;
        Thu, 11 May 2023 09:35:09 +0000 (GMT)
X-AuditID: b6c32a4b-913ff7000001d95e-ea-645cd1ea2b85
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.4C.27706.DC6BC546; Thu, 11 May 2023 18:35:09 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230511093506epsmtip2aa18a3df1915c916ae028b27f9a005d8~eDResfpW_2787127871epsmtip2d;
        Thu, 11 May 2023 09:35:05 +0000 (GMT)
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
        <pankaj.dubey@samsung.com>
In-Reply-To: <ad96f28a-7b2d-a58b-50fb-648063ed0b18@linaro.org>
Subject: RE: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 11 May 2023 15:04:57 +0530
Message-ID: <000001d983eb$e0692280$a13b6780$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2qCSoqzmQPtjJ4D91uRJfLAIcDAIowXKcAjqO7m2u92w9wA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPffePkBZ7jpIzwjOeg0aYDwKpV5mO5fJ8JqajIRk7ikr7Q0g
        faUPpmgCOBgbYRUWwdAxNqCgII+uwKgrHa+yZWhmmATMpIMBC9BZnYDupZmlLcp/n9/je76/
        3zk5bJRTzQpn56r0tFYlVRDMYOzKSFRUrHv8qDzB0hJPztZfYZJNjxcRcqZpFSOHu3tZZM/E
        eZT8+sYgg7zovMUg+4bmMPLykrc6XuvCyMWLnYBcNt1lksaleyjpeOBVWOcnGeRPV+uYZIWl
        l0F2OF0ssnlqHCFbrH8jZGPvGossdThZZMkpJ7KHS7XXtwPK5jIDasq8glLfmVwsqql/GaGs
        bWeY1PRkP5PqNhdSpaNPMcrY0waocucUk1q17qDG/lxlpYcczhPl0FI5reXRKplanqvKFhOS
        jMx3MpOFCfxYfgr5JsFTSZW0mEh9Pz02LVfh3Z7g5UsVBm8qXarTEfG7RVq1QU/zctQ6vZig
        NXKFRqCJ00mVOoMqO05F63fxExISk72Nx/NyakpnUI2Z83GNu5FVBE7j5SCIDXEBbJjtZJSD
        YDYHtwM4XGXD/MEKgPaGKsQf/AVgmbWMsSEpnZ4JFBwADtUVB/SLALoXrrHWu5h4PJwZq/AV
        QvFRAGd77qHrAYqXYbDqdhFY7wrCd8Pi82Z0nbfhB+DahXM+xvBIaP+9wXdSCJ4CL9U4ED9v
        hTdrF7B1RvEY2NLwAPXPxINP7rf45gvF90JnwyrL38OFo08qfMYQHwmCXd1ull+QCu///CjA
        26D7Rk+Aw+HyF6cCLIPzjcsBAwXs6v8S8/PbcHCizstsr0EU7Loa70+/DKvHOhG/7xZ49tkC
        4s+HQFv9Br8O66YfB+4xAo582wwqAWHatJpp02qmTSuY/ne7BLA2sJ3W6JTZtC5Zk6SiT/z3
        5jK10gp8/yNaYgNzsw/jhgHCBsMAslEiNMRjPiLnhMilnxTQWnWm1qCgdcMg2XvfVWh4mEzt
        /WAqfSZfkJIgEAqFgpQkIZ/ghrwhvinj4NlSPZ1H0xpau6FD2EHhRUjPwWs7t4TdWnn47Kv9
        rVnGfYU7pZJv8l+YZPcZ96fFjLcXAOTQoKfM9BpQCIqXPNdtOzyap7JzBw4bhBa7+FU0y2iP
        T6yOvfMj4A7ILvwQt7Xk+30ljtTLMWFg4vpItft2hkf4Xgf3D9R2VzKYP7ndkmYxyzh3XHtR
        yCx2/0Y9l2h+nX838uzRyIiFrFXHwCRr5ZcPZz89MaFsbRYRnaPPK+fWuC8dYT6K7jgjRjtC
        S1zBGVSl7WSrJ7MiIjlO9Hl3bWF1DG/Opn8ldPDQfMbAsQ/Gk+zK46KuqZNvfcZolhQYwOJ0
        n3Don4/27JorajoWGdslSnTW2Y2nLVEHhS8SmC5Hyo9GtTrpv3EkZ+OoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCSvO7ZbTEpBj9n8lk8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2bR
        9+Ihs8Xe10Admx5fY7W4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7RUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9uo5cZ/P4vEnO49TXz+wBvFFcNimpOZllqUX6dglcGe23n7EWzBesuNh8jL2B8SlfFyMn
        h4SAiUTrnftMXYxcHEICuxklDn6ayQaRkJH433aMHcIWllj57zk7RNFTRokJBy6BFbEJ6Evc
        P9XDCpIQETjJKNF/pgXMYRaYySJxdcIxqLkHGSUervvFBNLCKWAn0Th7CTOILSwQInF95ikW
        EJtFQFVi9/uFYPt4BSwlFkzbywRhC0qcnPkErIZZQFvi6c2ncPayha+ZIe5TkPj5dBkriC0i
        4CRxZOFndogacYmjP3uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE
        3OLSvHS95PzcTYzgFKKluYNx+6oPeocYmTgYDzFKcDArifC+XRKdIsSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTxGOvjsNyIVWpCosE1uwpnG6dXHHB
        4bl1ZajBwb86AW0Xd+f6qR9/nXt7drXkmXXrsgIm7Irq+JBmuHHdj6XO7RqmC7czMads7w57
        f0j1ybkCH5U/LXO+u6yaGPjStOrDkk8PNT/pb9RYUXblQn6z/uOtdT6yE9rPKxp0VbkybXh8
        8csaJgXef+KSp90XLJKUjvv9PTVQLGX9/KlXM9J4Cqaqv5T3nb3skayjK99qP15l+ZrEKsa4
        4twwb9G+U1p3tt+6dK0zoebPhVlNdz8wPBKLfCTKmSLFmhfhOoup0CbuxtVa/fN9mzL7tqe0
        JDQHcnUm+V3+o7bkQdqqdZnOJhXNM1c5rjbcL+8YVaPEUpyRaKjFXFScCABdDv9OkAMAAA==
X-CMS-MailID: 20230511093509epcas5p19661fe238eb92ac71d23546b02debd1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com>
        <20230328114729.61436-1-aakarsh.jain@samsung.com>
        <ad96f28a-7b2d-a58b-50fb-648063ed0b18@linaro.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 28 March 2023 20:06
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
> pankaj.dubey=40samsung.com
> Subject: Re: =5BPatch v7=5D dt-bindings: media: s5p-mfc: convert bindings=
 to json-
> schema
>=20
> On 28/03/2023 13:47, Aakarsh Jain wrote:
> > Convert s5p-mfc bindings to DT schema format using json-schema.
> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> > changes since v6:
>=20
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the versi=
on
> they apply.
>=20
> https://protect2.fireeye.com/v1/url?k=3D03601d03-62eb0848-0361964c-
> 74fe485fb305-ca0023b5279dd925&q=3D1&e=3D9490b51d-9547-4566-bb76-
> 8c1401745ae1&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17%2Fs
> ource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L540
>=20
> If a tag was not added on purpose, please state why and what changed.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
>=20
> Best regards,
> Krzysztof


Hi Krzysztof,

I don=E2=80=99t=20see=20this=20patch=20in=20linux-next.=20It's=20been=20mor=
e=20than=20a=20month=20now.=20=0D=0APlease=20let=20me=20know=20if=20any=20o=
ther=20changes=20required.=0D=0A=0D=0A=0D=0AThanks,=0D=0AAakarsh=0D=0A=0D=0A
