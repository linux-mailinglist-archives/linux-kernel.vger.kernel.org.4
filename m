Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249D6256E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiKKJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiKKJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:32:01 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A02AFA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:31:55 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221111093151epoutp042c5179fc1f5747f3a115cb0438651191~mfd_e-jDK0940209402epoutp04p
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:31:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221111093151epoutp042c5179fc1f5747f3a115cb0438651191~mfd_e-jDK0940209402epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668159111;
        bh=dEImC4wxpUkJ0KDy0kXIPLFqO9SSmsrGF34Mw85JE/c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Jn+yhIxaY2lC93HP+AGE5OfgfNgQ1M9q69dQ0Hha3/CSVu2NFgQPqoZUoFyy0YyON
         x9FRqmKQ50BnmXtn8nxevu89FPV7V9PF46RdQQWKwqU1ht96/4q9EHZty+pLRLI5i5
         t52f9GuIvIiobkkvvrd3/kBynkLz2pTSfdksSrr0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221111093150epcas5p2afb04af2fa5751d9e843966047de6ca0~mfd9prOIi0158901589epcas5p2m;
        Fri, 11 Nov 2022 09:31:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N7tkm48L1z4x9Q1; Fri, 11 Nov
        2022 09:31:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.4D.39477.0861E636; Fri, 11 Nov 2022 18:31:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221111092305epcas5p476b0205f0bfdf3ae3644b010e6165eed~mfWUeMaq51655816558epcas5p4a;
        Fri, 11 Nov 2022 09:23:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111092305epsmtrp2625df2da3f468db8db2a24df4d24bd57~mfWUdJ0HD0639406394epsmtrp2G;
        Fri, 11 Nov 2022 09:23:05 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-bd-636e1680edf6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.F7.14392.9741E636; Fri, 11 Nov 2022 18:23:05 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221111092301epsmtip2d1663a61d84302e4c62007c899827b3a~mfWRHnVeo0671506715epsmtip2e;
        Fri, 11 Nov 2022 09:23:01 +0000 (GMT)
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
In-Reply-To: <b766bd0b-aecc-3b9d-27df-2615d648d9bd@linaro.org>
Subject: RE: [Patch v3 3/3] ARM: dts: exynos: Rename compatible string
 property from version to SoC specific
Date:   Fri, 11 Nov 2022 14:52:59 +0530
Message-ID: <010e01d8f5af$340c1a80$9c244f80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI8m1Zcdyoy30tr4qXY7cEROuoJ0QEEBFDkAqmi7y0CiBy/9K1Ac1lg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRT27b29bUfq7qBur1VKrVMEArRY6mWBIQPxTo0hc/HHgumacvks
        bdNbEMwURFmAQTe26bYOCoUOEhiwlQ/5qkMoMthisvAVHR10GwJbJAzcBDbFljLl33Oe85z3
        Oee8OWzE+3sWn52m1lM6tUIlwnagHQMB/sH5u9VK8Wy5gJgxdWBE7eocg5iuXUGJ/tZ2FtE2
        dhEh6of6mESV/Rcm8cNPd1Hi6rwre+uCAyXmqpoBsWC8gxGGeSdC2B66Kqz3JpjEaHcFRpRe
        aWcSTXYHi7g0eYtB1FmfMYia9j9ZRKHNziIcvR2A+Pa4nfEuJC+bLgOy02EB5KRlGSG7jA4W
        Wdu7wCCtDcUYOTXRi5GtljyycHAdJQ1tDYAssU9i5IpVQI48XmElcI9kRKZSiiRKJ6TUSk1S
        mjolSvThJ/JYebhMLAmWRBDviIRqRSYVJYr7KCE4Pk3lWoFImK1QZbmoBAVNi0L3R+o0WXpK
        mKqh9VEiSpuk0kq1IbQik85Sp4SoKf0+iVgcFu4SHs1IrbhoQLWWvTnz5hNYPuj3LQFsNsSl
        cMngVQI4bG+8B8C5c8ISsMOFlwF83FuAeYInAFbfPsd0q9wFPxcuop6EDcD5xcatYA7Accdv
        mFuF4aFweqSU6U7w8EEAZ9qciDtA8CoUThQsbao4+H5orh9lubEProark3bgxij+BjSvzzHd
        DXLxCNjTke6mufguOHzhPurGCB4E68wPEU9LQrg2W7cp5+HxcHgM90j2wMG10k1biI9w4NpG
        PebRx8E/mv5iebAPfDDUtoX5cGXRtqVRwns1C1vvq2BL71nUg6Nh31gF6vZC8ADY0h3qoX3h
        dyPNDI/vi7Ds6X2Gh+fCTtNz/CasmFrd2uKrcKDxEjgFRMZtkxm3TWbcNoLxf7dqgDaAlykt
        nZlC0eHaMDX1+X//rdRkWsHmgQR+0AmcM0sh/YDBBv0AshERj+v1VobSm5ukyP2C0mnkuiwV
        RfeDcNe2yxH+S0qN68LUerlEGiGWymQyacTbMoloD7f2fKDSG09R6KkMitJSuud1DDaHn8/o
        qkpWPmHFp0jO+hkE7yfoh0hTxDAxvhEgdfzof/t6p+MwJ6Zply/Sej55d0hDTi2zuPS9aI4c
        mk4WVbYe+TSddzW37PVG7sZR39jpwlPqY4XzX/5Kx1zrOaw7Fu1T1zecyPM//dlkUHfJ1wcr
        /8kUGGZvCn6/q/oqbF/e1I36FyoOIMfZXnn8mCtjO5MrZfHp6ZHVvBxmZdmZv832rnWW/WPn
        nWcWp1Cefag467rzadGhb3Zq/VrM4gM2VaLxZuLebuUJjeqGTVc9mm1qq/Fe6jpTvpZLD7cn
        5McKTw404wa+ZGHZb9Dv4LUi8IqP4FF0UEGU8dGD1xrHOywcATPOKkLpVIUkENHRin8B3slx
        4akEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJXrdSJC/Z4NshNosH87axWSz+8ZzJ
        4v7izywWhzZvZbfYcmU2s8Xy4wdYLeYfOcdqsf3gIxaLjS+Ashdn3mWxeD5/HaPFy1n32Cz6
        Xjxkttj7Gqhj0+NrrBaXd81hs+jZsJXVYu2Ru+wWS69fZLJYtukPk8WirV/YLVr3HmG3uLtn
        G6NFS9sRJgcJjzXz1jB67Li7hNHj+pJPzB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeo/Xo
        LxaPvi2rGD26jlxn8/i8Sc7j1NfP7AG8UVw2Kak5mWWpRfp2CVwZF5Y/Zyv4o1TRsu4OSwPj
        NJkuRk4OCQETiWOt71i6GLk4hAR2M0psmXyCCSIhI/G/7Rg7hC0ssfLfc3aIoqeMEpcWdbCB
        JNgE9CXun+phBUmICJxklOg/0wLmMAtsZpFY27oHau5nRom/55rBZnEK2EksXH4ZzBYWyJGY
        2rWEFcRmEVCVWPjrOZDNwcErYCmxe1sWSJhXQFDi5MwnLCA2s4C2xNObT+HsZQtfM0OcpyDx
        8+kysFYRATeJk1cEIErEJY7+7GGewCg8C8mkWUgmzUIyaRaSlgWMLKsYJVMLinPTc4sNCwzz
        Usv1ihNzi0vz0vWS83M3MYITiZbmDsbtqz7oHWJk4mA8xCjBwawkwsutkZ0sxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5NXpMvXFvHs077e8UKdju62
        T9oPy/O6si+6XsLYYWf0+/i05YvXFDPtuRN2+urWNddY2yYGlYmuvPTR+7s+t2cOw/Y9JZxB
        AkLC0wt49GbOtP2o78W99W377TlO+f+fHNgWk3WsaH90klf60RuFIm8acq/X+DgfvCa64onL
        l89/94go3+tXeCSx8aVi6YXNXCbi+mIKlWs7cnb+ebPKI3fOLVvp86xsl/ffzC18eS3QVDHv
        kWL/xk32POdOtfaofMo55hSl9PLuVK3XvftMdIz8HwfFMS9KX6AUkhK7bIqpdZ6uT8ZW3uJT
        7Y+8JbrnK/xVjdJcz74tKfNL0E4nh26xW19Ez/yrMjuScn3zXSWW4oxEQy3mouJEANKctJiT
        AwAA
X-CMS-MailID: 20221111092305epcas5p476b0205f0bfdf3ae3644b010e6165eed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
        <CGME20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5@epcas5p3.samsung.com>
        <20221111032337.79219-4-aakarsh.jain@samsung.com>
        <b766bd0b-aecc-3b9d-27df-2615d648d9bd@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 11 November 2022 13:41
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
> Subject: Re: =5BPatch v3 3/3=5D ARM: dts: exynos: Rename compatible strin=
g
> property from version to SoC specific
>=20
> On 11/11/2022 04:23, Aakarsh Jain wrote:
> > commit =22752d3a23d1f68de87e3c=22 which adds MFC codec device node for
> > exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are using
> > same compatible string as =22samsung,mfc-v7=22 but their node propertie=
s
> > are different.As both SoCs have MFC v7 hardware module but with
> > different clock hierarchy and complexity.
> > So renaming compatible string from version specific to SoC based.
> >
> > Reviewed-by: Tommaso Merciai
> <tommaso.merciai=40amarulasolutions.com>
> > Suggested-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos3250.dtsi =7C 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos3250.dtsi
> > b/arch/arm/boot/dts/exynos3250.dtsi
> > index 326b9e0ed8d3..98105c64f7d9 100644
> > --- a/arch/arm/boot/dts/exynos3250.dtsi
> > +++ b/arch/arm/boot/dts/exynos3250.dtsi
> > =40=40 -485,7 +485,7 =40=40
> >  		=7D;
> >
> >  		mfc: codec=4013400000 =7B
> > -			compatible =3D =22samsung,mfc-v7=22;
> > +			compatible =3D =22samsung,exynos3250-mfc=22;
>=20
> No improvements. Changeset is non-bisectable. I said it in v1, then in v2=
. So
> now third time... Don't send a new version if you are not going to fix it=
 or
> resolve discussion.
>=20
My bad, misunderstood, now I understood your concerns around bisectability.

I hope you mean the below:
------
diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Document=
ation/devicetree/bindings/media/s5p-mfc.txt
index cb166654fa81..734e53445eb5 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
=40=40 -10,7 +10,8 =40=40 Required properties:
   - compatible : value should be either one among the following
        (a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
        (b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
-       (c) =22samsung,exynos3250-mfc=22 for MFC v7 present in Exynos3250 S=
oC
+       (c) =22samsung,exynos3250-mfc=22,=22samsung,mfc-v7=22 for MFC v7
+            variant present in Exynos3250 SoC.
        (d) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
        (e) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
        (f) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433 S=
oC
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos32=
50.dtsi
index 98105c64f7d9..a2d6ee7fff08 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
=40=40 -485,7 +485,7 =40=40
                =7D;

                mfc: codec=4013400000 =7B
-                       compatible =3D =22samsung,exynos3250-mfc=22;
+                       compatible =3D =22samsung,exynos3250-mfc=22, =22sam=
sung,mfc-v7=22;
                        reg =3D <0x13400000 0x10000>;
                        interrupts =3D <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
                        clock-names =3D =22mfc=22, =22sclk_mfc=22;
-----

Where mfc-v7 will be used as fallback for the older kernel which might use =
new dtb.

Let me know if this is not what you meant or am I still missing something?


> In cover letter you said =22Addressed review comments from Krzysztof
> Kozlowski=22, so please explain me, how did you resolve my comments about
> fallback for this patch and for bindings patch?
>=20
My bad, I just explained the misunderstanding above.

> Best regards,
> Krzysztof


