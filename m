Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100964C33C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiLNEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiLNEos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:44:48 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F962C1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:44:45 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221214044441epoutp0283f72b374dfcbbfc3edf6a2e5902f219~wj1rIjy_s2715827158epoutp02D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221214044441epoutp0283f72b374dfcbbfc3edf6a2e5902f219~wj1rIjy_s2715827158epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993081;
        bh=Nj4eOyaIYIxyFmCb03hT1yCV9IhQqWrapJ9UkMtcOI4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tUD7Oy9No8HQmSz9w6Me+8j5vLqSffcKgJewz2znK4PXtC6XpLdv/BEf2MnQXwgLm
         PpqXMkKKboV//q/gw+jJsrssu2U78daw4M4YvnWJ4o9XOr7cqT6OnK8/2z/ewoG5Wq
         pQo/tEsSDPG+pbLHK/RTw2TRVfGOioou9oNU+ylo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221214044441epcas5p1652b9874687e222ea4b932624ce30ba5~wj1q2ypPx1275912759epcas5p15;
        Wed, 14 Dec 2022 04:44:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NX2pH6WR1z4x9QK; Wed, 14 Dec
        2022 04:44:39 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.BA.39477.4B459936; Wed, 14 Dec 2022 13:44:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221214044118epcas5p1031923bfce745b90bd0930632d5e89c8~wjyta9UfF2054120541epcas5p13;
        Wed, 14 Dec 2022 04:41:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221214044118epsmtrp1f2da44ad34a93153b8ea1704d3361182~wjytaPVBc2718327183epsmtrp1O;
        Wed, 14 Dec 2022 04:41:18 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-6f-639954b47f0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.99.18644.DE359936; Wed, 14 Dec 2022 13:41:18 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221214044116epsmtip213ea867997d61490b86aa081fe9c4d5a~wjyryTwzv2904229042epsmtip2w;
        Wed, 14 Dec 2022 04:41:16 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <ravi.patel@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221209211004.GA3847427-robh@kernel.org>
Subject: RE: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Date:   Wed, 14 Dec 2022 10:11:13 +0530
Message-ID: <051901d90f76$4e557040$eb0050c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLZYKx+9pYBmb//OFyznS7+M00/rAEXh8oHAbCk0ccBkwrlWaxJUJxA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmlu6WkJnJBrNWCFs8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gt/u/Zwe7A6bFpVSebx51re9g8Ni+p
        9+jbsorR4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGe0dG1kKHgpW3H9xkaWB8SlvFyMnh4SAicTv6XNZuxi5OIQEdjNKzFr0
        jAnC+cQoMaF9KzuE85lRYtLTf+wwLWv2fmOBSOxilFjS2AzV/5xRYn77PCaQKjYBfYnXK+az
        gdgiAqoSTbMegHUwC3QySSy+eYUFJMEpYC7xYdYWMFtYoFRi95d5jCA2C1DDjWUvwZp5BSwl
        Wl6vYYewBSVOznwCVs8sIC+x/e0cZoiTFCR+Pl0GdAUH0DI3iW//LSBKxCWO/uxhBtkrIbCQ
        Q6Jx9TyoF1wkpl+/yQRhC0u8Or4FKi4l8bK/DcpOl9h8ZDMrhJ0j0dHUDLXLXuLAlTksILuY
        BTQl1u/ShwjLSkw9tY4JYi+fRO/vJ1DjeSV2zIOx1SQWP+qEsmUk1j76xDqBUWkWks9mIfls
        FpIXZiFsW8DIsopRMrWgODc9tdi0wCgvtRwe48n5uZsYwelVy2sH48MHH/QOMTJxMB5ilOBg
        VhLhVdWYlizEm5JYWZValB9fVJqTWnyI0RQY3BOZpUST84EJPq8k3tDE0sDEzMzMxNLYzFBJ
        nHfplI5kIYH0xJLU7NTUgtQimD4mDk6pBqYSJ/FprhG7JRkfl1ZlXoredWjLeUMPVsfssyJv
        8zaIHQp0+McSsqT83u/jK/Inl80xnXU+cuLptUZPpNM/Bp7RTvf+eILn7BcGdodOrqULxI8n
        lin2BId0ME6cF3Pokt2jnulMTLv7vL4V6nDtKMxbvjw+i2FmpeLsEMvDdQ3sz9+d+/JTL/C2
        9FmmhFXLJ9+fa1x0OST2/PYzvesSPuwU/n50hTWzxmf1jmVFJ22kjuzel1NtqrNls2Kc+vnr
        QSEzGO2cS28teGiRyej1RXbd+ZMBKqUukTvamYvcVEvvXBK8cG76Efu5fU+vemuvZXh17qKz
        wMlNnrMVVN1u92/cH6Rj1Jv3SHM1t9zJDDUlluKMREMt5qLiRADIw8PVOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXvdd8MxkgzsTmCwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewW//fsYHfg9Ni0qpPN4861PWwem5fU
        e/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAldGe8dGloKHghX3X1xkaWB8ytvFyMkhIWAisWbv
        N5YuRi4OIYEdjBKH589mhUjISJx8sIQZwhaWWPnvOTtE0VNGie6eRUwgCTYBfYnXK+azgdgi
        AqoSTbMegE1iFpjIJPH+/C9miI53jBJv2x6zgFRxCphLfJi1BcwWFiiW+PxgGZjNAtR9Y9lL
        sEm8ApYSLa/XsEPYghInZz4Bq2EW0JNYv34OI4QtL7H97Ryo8xQkfj5dBnQ2B9AVbhLf/ltA
        lIhLHP3ZwzyBUXgWkkmzkEyahWTSLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBMeYltYOxj2rPugdYmTiYDzEKMHBrCTCq6oxLVmINyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGpoqrmctTtNLKFxYvK8pjNc+b23bPZWtD+1WvM/qv
        HP161noofjD71DttzbJJTj6Xu2SaAw/NODstuWxKQqYUa9RtyU5nsR8CN/pXdPJmPJNZ83WH
        647mR0Wfpof3tpjeUrPcvVSnc2vcnOUbhAs37a5/3XAxnGumLqceZ5Os+sGOs1m+SaY/Jtww
        KOb7bqr4adsV5QvlT/gvfmSWE/qqr8nJdfG+xJkir8bpa4QerYkSyq+dLr+kiVdqyYIUOZW7
        6jfWX9j4YGf7J5sW95s/Dn+2PffskfK8BbWyZ7xCdq1V6pu2/eeS1axxhzt2hjHo5xudlTaL
        yazR6n786xGT+FRbW6tsnZgnnW2Xz54sUmIpzkg01GIuKk4EAIL9Os0gAwAA
X-CMS-MailID: 20221214044118epcas5p1031923bfce745b90bd0930632d5e89c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207105043epcas5p306086213835a5287f39de9016dcd43d2
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
        <CGME20221207105043epcas5p306086213835a5287f39de9016dcd43d2@epcas5p3.samsung.com>
        <20221207105032.103510-2-sriranjani.p@samsung.com>
        <20221209211004.GA3847427-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 10 December 2022 02:40
> To: Sriranjani P <sriranjani.p@samsung.com>
> Cc: krzysztof.kozlowski+dt@linaro.org; devicetree@vger.kernel.org;
> alim.akhtar@samsung.com; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
> dedicated SYSREG compatibles to Exynos850
> 
> On Wed, Dec 07, 2022 at 04:20:29PM +0530, Sriranjani P wrote:
> > Exynos850 has two different SYSREGs, hence add dedicated compatibles
> > for them and deprecate usage of generic Exynos850 compatible alone.
> >
> > Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> > ---
> >  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.
> > yaml
> > b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.
> > yaml index 4954790eda6c..a37452965100 100644
> > ---
> > a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
> sysreg.
> > yaml
> > +++
> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sys
> > +++ reg.yaml
> > @@ -17,7 +17,6 @@ properties:
> >                - samsung,exynos3-sysreg
> >                - samsung,exynos4-sysreg
> >                - samsung,exynos5-sysreg
> > -              - samsung,exynos850-sysreg
> >                - samsung,exynosautov9-sysreg
> >                - tesla,fsd-cam-sysreg
> >                - tesla,fsd-fsys0-sysreg @@ -33,9 +32,17 @@ properties:
> >            - const: samsung,exynos5433-sysreg
> >            - const: syscon
> >        - items:
> > -          - const: samsung,exynos5433-sysreg
> > +          - enum:
> > +              - const: samsung,exynos5433-sysreg
> 
> This says the compatible entry is "const: samsung,exynos5433-sysreg".
> 
> That should be a schema warning. You did test this, right?
Thanks for pointing it out, somehow dtbs check not showed any error. Will
fix it in the next version.
> 
> Rob

