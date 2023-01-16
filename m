Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752466B758
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjAPGMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAPGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:12:23 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858EA26A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:09:56 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230116060954epoutp033ce0ea5a0f46d0cad7978ef6f1331a60~6tSf4bz_02349823498epoutp03N
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:09:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230116060954epoutp033ce0ea5a0f46d0cad7978ef6f1331a60~6tSf4bz_02349823498epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673849394;
        bh=9gvL9idkaGcmNbQzssHRGrdNsRLaMqUed16ixUCKeZw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kjCzWwms65GFrJbam4dyVuwssqQWq4UcsB7dmwDo6N7F9f6kZMNcDl+VSoNPhMKV8
         Qv6gQEydlf1lRPZfofuZlpVJ+ZqfrTVTZODTzexDmLGxIKHHjnhmJa4saBiSyxLLqN
         8POCHSf2GCSXr6ZHrcNlyY2O1uI2fxy1uQu0k044=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230116060953epcas5p476ae84b4e0fb46b8b1539551e0475d71~6tSfD2WcW2725727257epcas5p4V;
        Mon, 16 Jan 2023 06:09:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NwM7M6vrPz4x9Q8; Mon, 16 Jan
        2023 06:09:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.D6.62806.F2AE4C36; Mon, 16 Jan 2023 15:09:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230116060345epcas5p248d9bb568a7122bd8becc096f3762084~6tNH7j52p1331613316epcas5p2L;
        Mon, 16 Jan 2023 06:03:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230116060345epsmtrp26c31aa0e901ae2c622a0209a2a0ab260~6tNH6rCRx0487804878epsmtrp2O;
        Mon, 16 Jan 2023 06:03:45 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-19-63c4ea2f61e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.5D.10542.1C8E4C36; Mon, 16 Jan 2023 15:03:45 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230116060343epsmtip25fc21a710998207fca10eaefc85a3b17~6tNFuKuQ92862528625epsmtip2u;
        Mon, 16 Jan 2023 06:03:42 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <3c2c4da5-c63b-dd2a-c918-4b8163a52512@linaro.org>
Subject: RE: [PATCH v3 1/5] ASoC: dt-bindings: Add FSD I2S controller
 bindings
Date:   Mon, 16 Jan 2023 11:33:42 +0530
Message-ID: <03f901d92970$4ad8abd0$e08a0370$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHLbZyfFuOXMbrDWpBwvoqdO4xuvAINteJuAY/BJ08BexyC2K6TQHTQ
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmuq7+qyPJBpNbzSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW+x9DRT7dqWDyeLyrjlsFjPO72OyWLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AUlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGnA9/2ArOclRsfLCErYFxPXsXIyeHhICJxI4bTxhBbCGB3YwSN/YZdTFy
        AdmfGCVafy5ghHA+M0pcvX+FFaZj95r1bBCJXYwSz1dPgqp6wSjxfeVksLlsAuYSi/YuBUuI
        CFxhkvi5up0FxGEWaGOU2HtxLdhGTgE7iZ8z7jCD2MICARItH26A2SwCqhITdv9nAbF5BSwl
        GvYdYYSwBSVOznwCFmcWkJfY/nYOM8RNChI/ny5jhYiLSxz92QMWFxFwk9i+7jnYYgmBNxwS
        a+/ehXrCRWLrwn8sELawxKvjW6DBISXx+d1eNgg7X2Lax2You0Ki7eMGJgjbXuLAlTlAvRxA
        yzQl1u/ShwjLSkw9tY4J4gY+id7fT6DKeSV2zIOxVSXWL9/ECGFLS+y7vpdxAqPSLCSvzULy
        2iwk78xC2LaAkWUVo2RqQXFuemqxaYFRXmo5PMqT83M3MYLTuJbXDsaHDz7oHWJk4mA8xCjB
        wawkwuu363CyEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4HZpK8knhDE0sDEzMzMxNLYzND
        JXHe1K3zk4UE0hNLUrNTUwtSi2D6mDg4pRqYRHLX9WbwKSq3Lo6um9aXUPx+TzXbz3vTZGwf
        Tkib0Wvx7Ei0gcLPxbN8Q1uCzuf8CXjLof57cdqGu3ViLc1c3le+SnotZik9f8cyZ7toQKj7
        F+f3lq0zy233ZeReNsxenNq8QmvzW3XuYnv3Twf4T2q/s77zt3DFsbslNQGrxMprbP4kO+WE
        zWicM2/tccaYriiLlsmMC+ytvjlZcr5Wq5VZet1Yze67wY9IrvJoufdbulmXBAdVr5p0ew/n
        imWXcoXnqB1l0XZc0HxT6OPRgiq11AnXCzeJ/eO8ueq8e+/aMBb9iCV9jXuKtQKmxc1z3uU8
        0/9FZ9GE7ZV2Amx3LSyMPVjn3tt49P5Tsy9KLMUZiYZazEXFiQACkcBrbAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSvO7BF0eSDS5uEbV4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbLH3NVDs25UOJovLu+awWcw4v4/JYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI4oLpuU1JzMstQifbsErow5H/6wFZzlqNj4YAlbA+N69i5GTg4JAROJ3WvW
        s3UxcnEICexglHi+bS8bREJaYnr/HihbWGLlv+fsEEXPGCX+928B62YTMJdYtHcpI0hCROAR
        k8Tc+Y/ARjELdDFKHP+7khmi5T3Q3BmrWUBaOAXsJH7OuAOU4OAQFvCT6LmkDRJmEVCVmLD7
        P1gJr4ClRMO+I4wQtqDEyZlPwOLMAtoSvQ9bGSFseYntb+cwQ5ynIPHz6TJWiLi4xNGfPWBx
        EQE3ie3rnrNMYBSehWTULCSjZiEZNQtJ+wJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
        +bmbGMGxrKW1g3HPqg96hxiZOBgPMUpwMCuJ8PrtOpwsxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OsC5XngoNYlc+L7ChPeJBvbR/8eeXag1xZJV61
        MW6+U8Uq3z37L+1k8IvR+OOpL1OjeE8cmCQzh+3Lpw1X365JaBYw9E3cnhelbFn8Vnajf80z
        rqbleydsvGbz/15hzt7sxzEpfpyaVpk283ZzKMUcKEzzSz3PNF3s2HGt5IizGWaH/bh9Dk8w
        CL507rTjQn4HNq0v32cqRoWuvJhct8GM1WL6dMU3kzOyTmqpc5VNc4ljvehr52Je6qjj+iLG
        oWLRJgPd188UJr07mFeb8euK1f3MqSeOWB0SdftyRaLwoV/w/0XisrEMFRsCzlzY9Nb1/c6p
        MnNDotn+HWIW1thecSXg5nKrY7luqxRTopVYijMSDbWYi4oTAUTV6wxUAwAA
X-CMS-MailID: 20230116060345epcas5p248d9bb568a7122bd8becc096f3762084
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7@epcas5p4.samsung.com>
        <20230113121749.4657-2-p.rajanbabu@samsung.com>
        <3c2c4da5-c63b-dd2a-c918-4b8163a52512@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 15 January 2023 08:32 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: Add FSD I2S controller
> bindings
> 
> On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> > Add bindings for FSD CPU DAI driver which supports stereo channel
> > audio playback and capture on FSD platform.
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Thank you for reviewing the patch.

Regards,
Padmanabhan R.


