Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEC6252AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiKKEfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiKKEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4C6C73A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:37 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111043435epoutp02988f79f9014c4e5efcd01aafc73fd7bc~mbabfyv6L1270612706epoutp02f
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111043435epoutp02988f79f9014c4e5efcd01aafc73fd7bc~mbabfyv6L1270612706epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141275;
        bh=51C2x8ao+2w3ZaOSqGOFYrSVYOFN67kJxI4m4GoDPAE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uScnefe2C3mKCXBo04Rj5k6kMAxScZJLfBDXXBXIeM2Ypdzr1/zNCxBmPBl8GfkDr
         MN/ouAQOJWjnRO7+IG3+SJARIBSVTENwscEJijTiU6LqWr9rPD2o6pZs6s9usAIVy3
         UugP3+fCztALiin1tc9yaTNuppk5dD/gyr2L5wA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221111043434epcas5p355ae0836b93695c95bcbabc2596515fe~mbaai3bNT0950509505epcas5p3u;
        Fri, 11 Nov 2022 04:34:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N7m7q0bJMz4x9Q2; Fri, 11 Nov
        2022 04:34:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.DD.39477.5D0DD636; Fri, 11 Nov 2022 13:34:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221111032043epcas5p31bbab6389aed46ccbe96a898d764e859~maZ70NqYR2752927529epcas5p3j;
        Fri, 11 Nov 2022 03:20:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221111032043epsmtrp17f489e3a4ea4a2a2d2b535fc6b30c783~maZ7v3y7B2380123801epsmtrp1j;
        Fri, 11 Nov 2022 03:20:43 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-7b-636dd0d583d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.D2.14392.B8FBD636; Fri, 11 Nov 2022 12:20:43 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221111032040epsmtip202bfa83ae653898394e8b55dafedb5aa~maZ4pl8AP0707507075epsmtip2L;
        Fri, 11 Nov 2022 03:20:39 +0000 (GMT)
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
In-Reply-To: <6707abae-39aa-0d1b-dc5e-cee1d87402ec@linaro.org>
Subject: RE: [Patch v2 1/3] arm: exynos: Add new compatible string for
 Exynos3250 SoC.
Date:   Fri, 11 Nov 2022 08:50:38 +0530
Message-ID: <00ea01d8f57c$94e2f000$bea8d000$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH93wRx5mB7au8KVEFSf1YZqxrmqQIInJ4oAfiF0sWtzzHEoA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed87pBWbJ4eong1G76YQMaJWWrwSYmYQdxzKZi9syt7CuHFuk
        tE1b5uYlI8sgG5dOTVXoOnClKCKgQLkKkWucZFOQWxapwMpWkOAYeOFmXGlh89/zvs/z5Hnf
        98vHxn2KWIHsNKWO1iglCh7Tk2joCg0NH+rLkPJbmllovLiBiUoXHRgaK10gUGddPQtZB3/E
        0cUb7QxU0n2LgRo7/iBQzZST7S+yEchRUg3QtPEeE+mnJnDUNuN01NqHGWigxcRE+VfrGaiq
        28ZCZSP9GLpQu4ohc/1DFspu62YhW2sDQN/mdGO7IVVZXAmoJpsFUCOWeZxqNtpYVGnrNEbV
        VnzPpEaHW5lUneVrKrtnmaD01gpA5XaPMKmF2pep3kcLrGTOx+mxclqSSmu4tFKqSk1TyuJ4
        Se+n7EkRiviCcIEYRfO4SkkGHcdLeCc5PDFN4TwBj/uFRJHpbCVLtFpeZHysRpWpo7lylVYX
        x6PVqQp1lDpCK8nQZiplEUpaFyPg83cKncLP0uXXy/Ustd77y9t1D0AWmPTKBR5sSEbBidk8
        LBd4sn3IawAWT/cx3cU8gAs/VQN38RjA5SfZjA1Lxdxpwk20AVhmM7HchQPA8Tw7saZikpFw
        rDefsUb4kT1OwjqBrxU4WULA4W/mmGsqDzIeGis6nA4225f8COavBKy1CXIbrLx30SXhkGL4
        6Pc7DDf2hjeLJl0BOBkCG2dNuHskLlz684JL40e+Ce0POzC3ZjPsWcp35ULylgfMy68CbkMC
        fPJ0lOXGvvD+Des6DoTTP+SsYym0m6fXAxTwSquBcOM3YPugyTUzTobCKy2R7nYwPNNbvZ7r
        BQtWJjF3nwObijfwdmgaXVw/YxDsulwGTgKe8bnVjM+tZnxuBeP/aecBUQG20GpthozWCtU7
        lfSR/55cqsqoBa4/EvZ2E5gYn4voBBgbdALIxnl+nBd3pEt9OKmSr47SGlWKJlNBazuB0Hnv
        U3igv1Tl/GRKXYogSsyPEolEUeJdIgFvM6e0MEzqQ8okOjqdptW0ZsOHsT0CszCPvQXhB8uz
        BHO7sk6V3w4OTrh/7nTVs6EHnl4ykzc19JI3WUPoz37yaqF4iSEjC2Nm3kX+7PPXfl0offaW
        wf6hYeKEoYwesKwu/rX3uE/vPse+9zbJk3fbi5p3nHk9zxM7YHFEGNL8j+QeO2C+Hi28KT4Z
        s7xpm44yb583GbwiIi/d+SeoreDvAdzKOfH0ru9YQMjhvjCz9epkTw03P/5sU2/6b54BW/Yf
        7Q8dPIRMQzOTIaMvJFUH5UhbxJ87DsVy+6b8TK3L5wZfa2SNybsSH/erDr+y9ZfBkp8v6z4I
        t/BTzavRW+96HAsSJFGVXnVtIaL2lU9nuZe+89InCo9jjQf38witXCIIwzVayb+EjOczrAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZdlhJXrd7f26ywYd7PBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVn0
        vXjIbLH3NVDHpsfXWC0u75rDZtGzYSurxdojd9ktll6/yGSxbNMfJotFW7+wW7TuPcJucXfP
        NkaLlrYjTA4SHmvmrWH02HF3CaPH9SWfmD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9R+vR
        XywefVtWMXp0HbnO5vF5k5zHqa+f2QN4o7hsUlJzMstSi/TtErgy9q/oYy/oE6w4v/kdYwPj
        E74uRk4OCQETiVUfJrGA2EICuxkl1k1Nh4jLSPxvO8YOYQtLrPz3HMjmAqp5yijxcs9WVpAE
        m4C+xP1TPawgCRGBk4wS/WdawBxmgc0sEmtb97BAtBxklLh7ZhHYLE4BO4lZqw6C7RMWCJN4
        9rObEcRmEVCVWHNvORuIzStgKfH15iVWCFtQ4uTMJ2D1zALaEk9vPoWy5SW2v53DDHGfgsTP
        p8vA6kUEnCQefznIBFEjLnH0Zw/zBEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iRGcSrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV5ujexkId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpg8jn6XWPuHf/+kmaJtTh6h
        5y9EzncT1bn+73HB3oo1ChxqHAomTzj9TnO8nvHRItq/ZKWoUemqTvdIyfKtW+Ol9x5XXiAv
        r/a7vXq1XX321017/Cvv7DIOrllzbLbHx4o2Q+UgkQ/CoS7sBtealp9gOq+p7tF05ePU6wdf
        FkVdd3h0LouXS8FKYB1j7ZGpOXraGuqtV0Lydqis2iwsUrEk2jVvSsyt/opkJR6zrhV8z+KX
        HVia8X1PDuvio3P4LdJMVvifN7T4vO4961y7II5zc+Tnyhjau6/9f+tBJc+Ru4VFNc5zV5T7
        /Fv3Nldt9qnYE5uk+DbN+ptZwjzt0M3K354vVh24YfhAePmsnfFKLMUZiYZazEXFiQAjO7Mp
        lAMAAA==
X-CMS-MailID: 20221111032043epcas5p31bbab6389aed46ccbe96a898d764e859
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8
References: <CGME20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8@epcas5p2.samsung.com>
        <20221109035507.69086-1-aakarsh.jain@samsung.com>
        <6707abae-39aa-0d1b-dc5e-cee1d87402ec@linaro.org>
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
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 09 November 2022 14:43
> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
> david.plowman@raspberrypi.com; mark.rutland@arm.com;
> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; smitha.t@samsung.com
> Subject: Re: [Patch v2 1/3] arm: exynos: Add new compatible string for
> Exynos3250 SoC.
> 
> On 09/11/2022 04:55, Aakarsh Jain wrote:
> > Since,MFC v7 support was added for Exynos5420 and Exynos
> > 3250 SoC with same compatible string "samsung,mfc-v7".As both SoCs
> > having different hardware properties and having same compatible string
> > for both SoCs doesn't seems to be correct.
> > New compatible is added for Exynos3250 SOC which will differentiate
> > the node properties for both SoCs which support MFC v7.
> >
> > Reviewed-by: Tommaso Merciai
> <tommaso.merciai@amarulasolutions.com>
> > Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/media/s5p-mfc.txt | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> 
> Beside my previous comment, please include changelog. This is v2, right?
> 
Yes this is v2.
I have sent v3 along with cover letter.

> You should consider joining something like:
> https://protect2.fireeye.com/v1/url?k=bf47b121-dfa52c7c-bf463a6e-
> 000babd9f1ba-202e284cd3057a5d&q=1&e=009abfcf-7d3c-433c-8eea-
> 0f9d92caf6cc&u=https%3A%2F%2Fwww.linaro.org%2Fevents%2Fmember-
> training-upstream-kernel-development%2F
> 
> Best regards,
> Krzysztof

Thanks for review.

