Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9232B638965
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKYMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKYMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:08:21 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1222C65E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:08:18 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221125120816epoutp01c87940e787a2869262fc8813f6ed8566~q0ojRmObg2677526775epoutp01s
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:08:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221125120816epoutp01c87940e787a2869262fc8813f6ed8566~q0ojRmObg2677526775epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669378097;
        bh=2aWKS96B95u4DIAnCKkj2MXQspfdcX4iyGoQTSvU/A8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MHsl6hyhsWP1wDHa78YhPk4Njln5+ghuSCw5Dies9ZQBegV38W8i5331UU/9iqbnN
         swlahbz8aSjasHALC3qS0cHmwZ7p7TF3PD9MZKEuPlqRiWWuSZY7djV5sJJVD/OZ/H
         WyhsNVTrsA9GwLIC9zfA89kcG593eEL/4ci5ZuhE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221125120816epcas5p10cb8bc56df33d0c8c09e6edeb46b137f~q0oi4KBw51283312833epcas5p1Z;
        Fri, 25 Nov 2022 12:08:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NJYXt6vR5z4x9Pr; Fri, 25 Nov
        2022 12:08:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.3B.39477.E20B0836; Fri, 25 Nov 2022 21:08:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221125120412epcas5p2636bd23dc312da98f92e2db600f332ec~q0k-vm__V3214132141epcas5p26;
        Fri, 25 Nov 2022 12:04:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125120412epsmtrp2ccae729350c0034e54b22fc8577bca3c~q0k-u1m5j0163601636epsmtrp2s;
        Fri, 25 Nov 2022 12:04:12 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-fb-6380b02eb36f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.D1.18644.C3FA0836; Fri, 25 Nov 2022 21:04:12 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125120410epsmtip21948d96f8a694396b3be21be6e9a9e98~q0k9stt421727317273epsmtip2t;
        Fri, 25 Nov 2022 12:04:10 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <ravi.patel@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>
In-Reply-To: <8cd6fc0f-0824-46e3-2b4a-aca5d968c6a7@linaro.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Date:   Fri, 25 Nov 2022 17:34:09 +0530
Message-ID: <014d01d900c6$0834e870$189eb950$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFeDkT2Jbj5qkymxWDBxTod5Ti6VQIwtLmkAYRAV4UBlYLYRQFIZy3irxDTvrA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhq7ehoZkgxudxhYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW+x9vZXdYkfbQhaLy7vmsFks2vqF3eLhhz3sFq17j7BbPO/bx+TA7bFpVSeb
        x51re9g8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
        aV66Xl5qiZWhgYGRKVBhQnbG4v8fmQueCVccnN/N2sDYLdDFyMkhIWAi0bGkn7GLkYtDSGA3
        o8TlG69YIZxPjBLTfk+Gcj4zSsxvfsQG03Jj9UNmiMQuRom5q2ayQTjPGSV2bHzNAlLFJqAv
        8XrFfLCEiMBdJonLO/qBHA4OZgEliaun5EBMTgE7iRVtPCDlwgJxEk9PTQRrZRFQlThyazMT
        iM0rYCmx5voSdghbUOLkzCdgNcwC2hLLFr5mhjhIQeLn02WsILaIgJ/EtvZWZogacYmjP3vA
        DpUQWMshMfnUKagGF4l3PQ1Q3whLvDq+hR3ClpL4/G4vVDxdYvORzawQdo5ER1MzVK+9xIEr
        c1ggXtGUWL9LHyIsKzH11DomiL18Er2/nzBBxHkldsyDsdUkFj/qhLJlJNY++sQ6gVFpFpLX
        ZiF5bRaSF2YhbFvAyLKKUTK1oDg3PbXYtMAoL7UcHuHJ+bmbGMFpVstrB+PDBx/0DjEycTAe
        YpTgYFYS4RWxa0gW4k1JrKxKLcqPLyrNSS0+xGgKDO+JzFKiyfnARJ9XEm9oYmlgYmZmZmJp
        bGaoJM67eIZWspBAemJJanZqakFqEUwfEwenVAOTSNcexr+yZyz7/jYk2DzNnNKXElno/Nti
        8ZcHbziKGpxeLva3ezL51NO/W3Vv+t1JntyqleSQPzdH8fZ76cTCOo79h3nvPlVK697995DF
        lT1/Vyd3Ht7ldDlJJ9GipviJKv9lz0evDyXs19GNSVENZUpx+xzKnhLz27Wc68ys+Rv/bV71
        w+1eoOI3rXMCk7obdk5S+aAS1Ktmtr01VWqhV72QUPK9FKPyha8f+ve/eG+Q8TpR+/7fBxxG
        U64ozV7qfq++pu1ZjOQETatXmlpH1qXclDR97iDhqv/pTI+U1YaSzRIyt6o6NIsvXHTl8Ges
        mGSSY/szJkxm2k3WCX21acxTV6tG5wZKamy9+VCJpTgj0VCLuag4EQBbf+TNPAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXtdmfUOywdLTShYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW+x9vZXdYkfbQhaLy7vmsFks2vqF3eLhhz3sFq17j7BbPO/bx+TA7bFpVSeb
        x51re9g8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK2NrYw9LwTHhis8bZzA3MD7m72Lk5JAQ
        MJG4sfohcxcjF4eQwA5GicbXq9kgEjISJx8sYYawhSVW/nvODmILCTxllHi7zAjEZhPQl3i9
        Yj4bSLOIwHMmidMn7wMVcXAwCyhJXD0lBzF0KZPEjS1zWEDinAJ2EivaeEBMYYEYiUXfzUHG
        sAioShy5tZkJxOYVsJRYc30JO4QtKHFy5hMWEJtZQFui92ErI4y9bOFrqNMUJH4+XcYKYosI
        +Elsa29lhqgRlzj6s4d5AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07M
        LS7NS9dLzs/dxAiOMy2tHYx7Vn3QO8TIxMF4iFGCg1lJhFfEriFZiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiZjkbR2naR3hhOuxgQu52BL3HH9xssg
        q9vveLmncZlz2xesF1meM7vocbPNars18iqp1+Yv0W1lPfv6V+WkzRt2nxPs+2v68nOwxYt5
        VrHWi+KNVq5TcZ6z1PZthZt9jei8BPnykw8C1ma8rls951ma7LFC7Ylse+3u9ZRuUPLt8ls/
        rXeTq3CnSebGsw1dPQcM+XK/N3AaSedN3smjsMPZNu7EEeXmpVe8tszQ4c/VnZdSy1J8P++R
        xuEnb0RVp5TI3UnVdfOwm7UudbOCE3NcXNVO68/Gld8nSvGd583btGtNYu252XtUp0wUvuoQ
        9t9UxDPgfNvzY/cmPfmZsWvnCqGp6U1Csr5O1bvuxCuxFGckGmoxFxUnAgDqRmtHIgMAAA==
X-CMS-MailID: 20221125120412epcas5p2636bd23dc312da98f92e2db600f332ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3
References: <20221125070657.28335-1-sriranjani.p@samsung.com>
        <CGME20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3@epcas5p3.samsung.com>
        <20221125070657.28335-2-sriranjani.p@samsung.com>
        <13a33962-ac55-e3f1-933a-a9addf9bc10d@linaro.org>
        <8cd6fc0f-0824-46e3-2b4a-aca5d968c6a7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 25 November 2022 17:10
> To: Sriranjani P <sriranjani.p=40samsung.com>; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; lee=40kernel.org;
> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com; Sam Protsenko
> <semen.protsenko=40linaro.org>; Chanho Park
> <chanho61.park=40samsung.com>
> Cc: linux-kernel=40vger.kernel.org
> Subject: Re: =5BPATCH v2 1/2=5D dt-bindings: mfd: syscon: Add tesla compa=
tibles
> found on FSD SoC
>=20
> On 25/11/2022 12:29, Krzysztof Kozlowski wrote:
> > On 25/11/2022 08:06, Sriranjani P wrote:
> >> Add compatible for Tesla SYSREG controllers found on FSD SoC.
> >>
> >> Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> >> ---
> >
> > Thank you for your patch. There is something to discuss/improve.
> >
> >>  Documentation/devicetree/bindings/mfd/syscon.yaml =7C 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
> >> b/Documentation/devicetree/bindings/mfd/syscon.yaml
> >> index 4e4baf53796d..8c3334999bec 100644
> >> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> >> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> >> =40=40 -69,6 +69,7 =40=40 properties:
> >>                - samsung,exynos5433-sysreg
> >>                - samsung,exynos850-sysreg
> >>                - samsung,exynosautov9-sysreg
> >> +              - tesla,fsd-sysreg
> >
> > I think we made mistake starting from 5433. Before (Exynos3/4/5) there
> > was only one block called actually SYSREG. For example on Exynos5433
> > we have SYSREG_DISP, SYSREG_CAM1 and so on. These are different so we
> > should have dedicated compatibles. The same for Tesla - please provide
> > dedicated compatibles per each block.
> >
> > I'll fix Exynos5433. Maybe someone can also fix Exynos850 and Autov9.
>=20
> To clarify - in case of Tesla, you do not need the fallbacks, so you just=
 add few
> of:
>    - tesla,fsd-xxx-sysreg
> within the enum.

Thanks for improvement idea and clarification. I'll update accordingly in t=
he
next version.

>=20
> For Exynos850 and Autov9, just like for Exynso5433, we should keep it
> backwards compatible, so we need fallbacks.

I will update for Exynos850 and Autov9 as like Exynos5433 and post the patc=
h.

>=20
> Best regards,
> Krzysztof
Thank you.


