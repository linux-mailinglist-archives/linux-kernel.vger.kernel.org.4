Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D755E6194EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiKDK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:56:53 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DBC2BB26
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:56:50 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221104105648epoutp019a86701db046d653e097816220de41b7~kXHJVG4Y_2811928119epoutp01V
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:56:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221104105648epoutp019a86701db046d653e097816220de41b7~kXHJVG4Y_2811928119epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667559408;
        bh=ByXREw6U9UT1fb8v/UjL6hHxBiGSezGiu+UpEJA3n18=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NTWy6irBUsGDnFJwafP2dGF8aYAtgwvsqXxMxhGJKJwi1fJ8XY1x1MYVMle2wYeOf
         MdpdEFHIyOFt9V6Xwf0OZ3R31bhpQ5ckkgdj5otBS/sd96bSNw1nslNjruaZoHQI6/
         ayJQ0btUkhJqihhZlEn1MhN+WXvOqxw8j3MmNwds=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221104105647epcas5p33945ca8e853b0a5d209c4f8b61370f1d~kXHIvOBXh1487914879epcas5p3Z;
        Fri,  4 Nov 2022 10:56:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N3cy43wFyz4x9Pw; Fri,  4 Nov
        2022 10:56:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.0E.56352.CEFE4636; Fri,  4 Nov 2022 19:56:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221104104928epcas5p1ba76f35fd33e3a68ced972d0489c98af~kXAwPxlxh3116031160epcas5p1s;
        Fri,  4 Nov 2022 10:49:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221104104928epsmtrp1a42a0fb098eadb759fba8e4670993741~kXAwNrjXu2514725147epsmtrp14;
        Fri,  4 Nov 2022 10:49:28 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-1c-6364efec4840
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.A9.14392.83EE4636; Fri,  4 Nov 2022 19:49:28 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221104104925epsmtip284347302a3441e4cd072520eda44e503~kXAtELaC42615726157epsmtip2W;
        Fri,  4 Nov 2022 10:49:25 +0000 (GMT)
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
In-Reply-To: <352e31de-cb79-f08e-b817-2712d97b84f1@linaro.org>
Subject: RE: [PATCH 3/3] arm64: dts: exynos: Rename compatible string
 property from version to SOC specific
Date:   Fri, 4 Nov 2022 16:19:24 +0530
Message-ID: <000001d8f03b$1cd111f0$567335d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIVsoyS1LfNYjvTRsU3iIkRJvur6AJ2XG6BApeHKxICO7c5fa16oSiA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH97v39gGuemFFfqvM1CpEikALFC/yckKWS9gcwTgNIZau3ADS
        V9oiMpc4CZvIGLMqC3RYYGUYnpsMOthKBFbYaBiOjMeidLymUEocoUOZW5wtBeW/z/me7/md
        3zm//Jio7zkGh5mn0FJqhUTGo3tjphvBwaErD7OlgsnyfcSswUQnjBuLCDFjdGLEwJUuBtE5
        fh4lfrjZRyNqLaM04mr/PEb8uOTKjlXbMGKxth0Qdv19OlGxNIcSvQ5XRcfCJI24e62GTpRf
        7qIRbRYbg7g4NYYQjR1PEeJC1yMGcbLXwiBsZhMgSk5ZkLch2WpoBWS3rQGQUw1rKNmjtzFI
        o9mOkB3NX9HJ6UkznbzS8Dl5cvBvjKzobAZkmWWKTjo7Xiat605GGisjPy6XkmRTai6lkCqz
        8xQ58bzU98RJYlG0QBgqjCHe5HEVEjkVz0s+mBZ6IE/mWgGP+4lEVuCS0iQaDS88IU6tLNBS
        3FylRhvPo1TZMlWUKkwjkWsKFDlhCkr7llAgiBC5jFn5ubW3ZhDVWb9P7/UtME4Ah08Z8GJC
        PAq2NRXT3OyLXwfw7mhRGfB28RqATT06hif4E8DBn/9ibFcMPW2iexK9AK6a2rfKFwFsK/dy
        Mx0PhzPWcprbxMYHAZztnEPdAYrXYnCyeJXudnnhCbBuo8TlYjL34HJotr3hljH8Ndha8Tvm
        ZhYeA68OlSAe9oHD1Q82dRQPgY31DtRzIy58/Fvj5jFs/ACsLQ7yWPzh4OPyzbYQt3rBZ3/c
        3vInw/mWbd4Dl292bk3Ggfazp7ZYChcu2Lc8MnjJ/B3m4UTYN16DuXuheDC8dC3cI++DldZ2
        xNP3eXjmyQPEo7Ngt2Gbg2DN9AbNwwHwRstF8DXg6XdMpt8xmX7HCPr/u9UBrBnspVQaeQ6l
        EakiFVThf+8tVco7wOYH4ad2g/nZ1bABgDDBAIBMlMdmrZmkUl9WtqToGKVWitUFMkozAESu
        detQjp9U6fphCq1YGBUjiIqOjo6KiYwW8vxZxiq+1BfPkWipfIpSUertOoTpxTmBNBStZNHl
        CLm7wifReSz9Nj6exup+d+a0Rfdxj2A9dr0yJetIysEXU3JnAwIbHjm837nOiSvQix7eYYP0
        Umdglc5sJxtfXda+1PKRMXbvkmQIcPqLIzITUvlziUlhxxvRI0f9A4yHL3+wHJfq9zo37d6w
        wRw5PLZRmBkakPHsl5HytV8LV0y3+tvbFr7sEyZ02fdvGKyV91l1Od+GVMGajIUXztH+MXwR
        PM86NOYQT1j5ERPUE35z6OGjPk3CTvZPVGacZVegbPdI9ffTVeuH6v2S75QG6XS29JDjPs+x
        haNJi212EnGWfhiv1taPiCvPTJw+/5ljYlfsKzLR+4Oqb3iYJlci5KNqjeRfngN2vKkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJXtfiXUqywd8zOhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVn0
        vXjIbLH3NVDHpsfXWC0u75rDZtGzYSurxdojd9ktll6/yGSxbNMfJotFW7+wW7TuPcJucXfP
        NkaLlrYjTA4SHmvmrWH02HF3CaPH9SWfmD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9R+vR
        XywefVtWMXp0HbnO5vF5k5zHqa+f2QN4o7hsUlJzMstSi/TtErgy5q9+xFawSqTi8Pt/TA2M
        HYJdjJwcEgImEsf+rGTrYuTiEBLYzSixa+MxNoiEjMT/tmPsELawxMp/z9khip4ySkzf9pUR
        JMEmoC9x/1QPK0hCROAko0T/mRYwh1lgM4vE2tY9LBAtnxklVszfDtbCKWAnseAHSBUHh7BA
        tsTO7gyQMIuAisSavmcsIDavgKXE9mMtTBC2oMTJmU/A4swC2hJPbz6Fs5ctfM0McZ6CxM+n
        y8BGigi4ScxvUoMoEZc4+rOHeQKj8Cwkk2YhmTQLyaRZSFoWMLKsYpRMLSjOTc8tNiwwzEst
        1ytOzC0uzUvXS87P3cQITiRamjsYt6/6oHeIkYmD8RCjBAezkgjvp23JyUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw6dedFbPwnaPBofE5SMR5h32T
        k/vdlSKbLj5w3uVwttvmFV/3vA5hta/uNxf9uZptu/vOGvt/93deu5n4o+Lde7++781VU2Nv
        Sop9l22bXf+MIcv2VO/3faovMjcsKCmxO/BdeEPNGe6sK98X/BKu5nQriUxqVbkbl+5YNl1r
        02XRA8flZNOvb3CtDBNlvDqPcaJ1Xry8meye3Ocv6v+eE9DcHH5zF2NT6KFI9oudSf/WqIo8
        2/7p6FWHKY3PVrdatzw0Xn7stChffkcLz2FxiV6juEB5QcOGyfYviiMXb3b4Y+z/4PrVtlVp
        cm6HkpfvtRM8Z+f2W+2+QmMY+9vsP2sX6TyXYU/0VrZfc/ahEktxRqKhFnNRcSIA1WgV4JMD
        AAA=
X-CMS-MailID: 20221104104928epcas5p1ba76f35fd33e3a68ced972d0489c98af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
        <CGME20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d@epcas5p2.samsung.com>
        <20221102130602.48969-3-aakarsh.jain@samsung.com>
        <352e31de-cb79-f08e-b817-2712d97b84f1@linaro.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 03 November 2022 18:04
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
> Subject: Re: =5BPATCH 3/3=5D arm64: dts: exynos: Rename compatible string
> property from version to SOC specific
>=20
> On 02/11/2022 09:06, Aakarsh Jain wrote:
> > commit =22752d3a23d1f68de87e3c=22 which adds MFC codec device node for
> > exynos3250 SOC. Since exynos3250.dtsi and exynos5420.dtsi are using
> > same compatible string as =22samsung,mfc-v7=22 but their node propertie=
s
> > are different.As both SoCs have MFC v7 hardware module but with
> > different clock hierarchy and complexity.
> > So renaming compatible string from version specific to SOC based.
> >
> > Suggested-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > Fixes: 752d3a23d1f6 (=22ARM: dts: add MFC codec device node for
> > exynos3250=22)
>=20
> There is no bug to fix and backporting is forbidden as it breaks the usag=
e of
> DTS in older kernel.
>=20
Okay will remove this Fix tag in next series.
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
> The change is non-bisectable and breaks using DTS in older kernel.
>=20
Right, so what is your suggestion on this?
I can see two ways here:
1> To squash patch2 and patch3 in one?
2> Have a warning about this breakage in the patch-3 commit message?

> Best regards,
> Krzysztof


Thanks for the review.


