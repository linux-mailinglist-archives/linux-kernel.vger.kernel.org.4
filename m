Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584AF69F47F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBVM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBVM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:27:12 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE037712
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:26:50 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230222121732epoutp04062c244c27f8d3a21d114f129bce7946~GJLCi7b8w0046600466epoutp042
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:17:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230222121732epoutp04062c244c27f8d3a21d114f129bce7946~GJLCi7b8w0046600466epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677068252;
        bh=PSfpRN1ZrrDiozNhb/4WL/U0F9Nyc66kIfC4wuUaWIY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=W6Zzjc59QZV4mw3Cwu4oVkauCKscjlMjHCvjm5Em/zbp4abDwOpbx3d3FTwGcMMkI
         lAo3nIzMjv5w+NJjtam9vDc/dy1rGPUj4vZn5B3TnMpjtnqySYBe5Q/vpX3Xu8sNIA
         wC6IesTfrWiqNefeCReE92Jyd+mb1yHkTjebh+vY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230222121731epcas5p2b3d75265b03c429bb449141e873cd028~GJLB1kR_92233922339epcas5p2v;
        Wed, 22 Feb 2023 12:17:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PMFXT6MjMz4x9Q1; Wed, 22 Feb
        2023 12:17:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.70.06765.9D706F36; Wed, 22 Feb 2023 21:17:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230222091248epcas5p106a21c53641daa6173ed8b0c4d907f61~GGpwZ9b4f1901919019epcas5p14;
        Wed, 22 Feb 2023 09:12:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230222091248epsmtrp268eb4412e36cc41aada52e410bb65f1f~GGpwXhG2Y1700217002epsmtrp2-;
        Wed, 22 Feb 2023 09:12:48 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-88-63f607d99d3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.FD.17995.09CD5F36; Wed, 22 Feb 2023 18:12:48 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230222091245epsmtip267f5ba70273187d55ca7a71fd7f626ae~GGptSVn_70245402454epsmtip2H;
        Wed, 22 Feb 2023 09:12:45 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <1c5eae73-04fa-722c-b6b2-8a39576ad1c5@linaro.org>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Wed, 22 Feb 2023 14:42:43 +0530
Message-ID: <000001d9469d$d537bd30$7fa73790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3kBi+ufA64koKHw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH8+u9fUBSuBQXfsNp8C7MAQFaLHAxoGYacuOTxWwamJam3FBC
        X+str+0PkMEYL4eKOjsEBewSxsCV90sZlDCq0TEcFVMQeQQLUVnrGCjOtVzY+O9zzvme3/ec
        3y8/HiK4zPXlpah0lFYlVeAcd7S1P+DD4DHukkx45o2QmKxs5RA1y3Ms4nGNAyX6mlq4RPOD
        7xHih8FeNlFluscm2n6ZQomfnzqrw1fGUWKuqgEQNv0Eh+hZcIqN06Ns4sn8CWKks4JDlNxs
        YRM/mca5xA3LMIswGFdZRHXLSy6R32PiEnlfm1j7fMj6ynpAto/XAtJSa0fIDv04l6zptrFI
        Y10hh7SOdnPIptpsMn/gFUqeba4D5D+5V7lkkcnCIR3G7aT5Lwc3ziM+NVpOSZMorR+lkqmT
        UlTJMfih45L9kvAIoShYFEVE4n4qqZKKwQ8cjguOTVE4bwD3S5cq0pypOClN46F7orXqNB3l
        J1fTuhic0iQpNGJNCC1V0mmq5BAVpdstEgrDwp3CxFT5865ioJnFMntt4hzQ5lEE3HgQE8Pi
        W3ZQBNx5AqwLwJwxA4cJ7ABO/lGwHjgAbBtZARst95YWWUyhE8DesQ6UCeYAPNv4O8ul4mCh
        8LG5hO0qbMEGnGc1P0FcAYL9jcDZ2zMcl8oN2wPLLxoQF3tjn8I80zLbxSjmD5vba1AX87Eo
        aL7QjzDsBYeuzKzlESwIGq4vIMxMfnBl1uDs5TndYuHL3COMxAcOrJSs+ULM7AYf3TGzGf0B
        aDYZuQx7w/nB5nX2hY7nPRyGZXC62rZ+vgI2dpejDO+FvQ8qUJcXggXAxs5QJr0NXjQ3sBhf
        D1j6eobF5PmwvXKDP4AV1uX1Ed6D/T/eAGUA12/aTL9pM/2mFfT/u10DaB14l9LQymSKDtfs
        UlEZ/724TK00grUfEnioHUxNLob0ARYP9AHIQ/At/Ld8h0zAT5JmfUFp1RJtmoKi+0C487rP
        Ib7vyNTOL6bSSUTiKKE4IiJCHLUrQoT78HfGDMkEWLJUR6VSlIbSbvSxeG6+OSw0aMq/7M/f
        jIlxSxhujpymLa2+NrF5+JrBUrWt3i3jk5GDUSdjKuRTdx3zBZJsTuwdIt0+MTf7ML+ksvZ1
        mOC74+MvrGOeixcsGQfPdJ/KLl0+r2rKP7bT8Kz6m6O7T7eshnWdTsp6dL7ae9Tff6utZOEg
        cvNzi+jbvMzQrUjrxEOl5wv3Nzs6qFuGu5F7g6LjvT5buF+u2N53tGLxtl3u8Wtzof1kPftZ
        gZK+9PY6bHg/5NxS3qR1VS6wDkg8yxJPTSasNg6+uhRwOHDo457ZBZxbuiPL+jSBvf+jI/ov
        ky1kenz5sVzrWCzsirXts1/t0qKF90985SXrNA8X1ydkXsZRWi4VBSJaWvovFT6ouKoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCSvO6EO1+TDZ7dMrV4MG8bm8XiH8+Z
        LO4v/sxicWjzVnaLLVdmM1ssP36A1WL+kXOsFtsPPmKx2PgCKHtx5l0Wi+fz1zFavJx1j81i
        72ug4k2Pr7FaPHwVbnF51xw2i54NW1kt1h65y26x9PpFJotlm/4wWSza+oXdonXvEXaLlrYj
        TA7iHmvmrWH02HF3CaPH9SWfmD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9R+vRXywefVtW
        MXr8a5rL7tF15Dqbx+dNch6nvn5mD+CL4rJJSc3JLEst0rdL4Mo4eXgCU8F8gYq9m44wNzB+
        5O1i5OSQEDCROPftA1MXIxeHkMAORon+DztZIBIyEv/bjrFD2MISK/89Z4coesooMXPWEyaQ
        BJuAvsT9Uz2sIAkRgZNA3WdawBxmgW4WicZXrVBzPzNKnDx8HWwWp4CdxJSpy5i7GDk4hAVC
        JHZ/qwMJswioSmzZsRhsNa+ApcSpyYeZIWxBiZMzn4DFmQW0JZ7efApnL1v4mhniPAWJn0+X
        sYKMFBFwk/jS5AtRIi5x9GcP8wRG4VlIJs1CMmkWkkmzkLQsYGRZxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRnEa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe/7yfk4V4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgurgvOTr1JtPGc0XT35rPZZ+2
        +OIPiSS9nBitncF/714tPxLfr+w6/f5a3/Ctn15vbW5+72rmcczL7KN4EZ+t/dlcdc1Uybjk
        a37iKZN2+Wtwm1dVMfC8vbHt9dSse1svdVRuT2h1NVm+/Ur5efWnnHy3y/yKi212x+7fF2Sa
        oKW9cqf6IyGPx5yXrNa5Lvw5T7BL09Qu28en9IWb+Z1b5pr2cv/3PD7kXL1j7ufl2k8CpH6t
        OfP2LK+mhcqH1Ql2AY4WhbzCXEbP/21udL3Ktzv9VbffZeYuZaaV5Yn3fj2Y22Wka3Dxme9h
        /uJX3FnR9/VvLptzcdICsw2LnD5+9LM0PNjgneHN/JopRDhZiaU4I9FQi7moOBEADCwZnpID
        AAA=
X-CMS-MailID: 20230222091248epcas5p106a21c53641daa6173ed8b0c4d907f61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
        <20221011122516.32135-2-aakarsh.jain@samsung.com>
        <1c5eae73-04fa-722c-b6b2-8a39576ad1c5@linaro.org>
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



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 21 February 2023 21:56
> To: aakarsh jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v3 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
>=20
> On 11/10/2022 14:25, aakarsh jain wrote:
> > From: Smitha T Murthy <smitha.t=40samsung.com>
> >
> > Convert DT schema for s5p-mfc in yaml format
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     =7C  75 --------
> >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 163
> ++++++++++++++++++
>=20
> Hi Aakarsh,
>=20
> Any plans for new version of this DT schema conversion? The Samsung MFC
> is one of last remaining bigger pieces for conversion. We already have 10=
0%
> bindings compliance for ARM64 but the MFC is missing for ARMv7:
>=20
> https://protect2.fireeye.com/v1/url?k=3D9661b377-f7eaa63c-96603838-
> 74fe485fb305-bc4c89dbd0204557&q=3D1&e=3D1485ea1d-43e8-4541-8078-
> 4d13ff6cc42f&u=3Dhttps%3A%2F%2Fpastebin.com%2FD8jXnjEe
> (that's on my pending branch with all patches from LKML collected).
>=20
> Best regards,
> Krzysztof

Hi Krzysztof,

I was little occupied with other stuff. I will fix all warnings and errors.=
 Will post the patch soon.

Thanks,
Aakarsh


