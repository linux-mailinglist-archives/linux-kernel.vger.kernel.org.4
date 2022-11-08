Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDC620976
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiKHGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiKHGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:19:23 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD240464
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:19:08 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221108061904epoutp02d17194b0691d347a6c9003154bd98b8d~lh5ze8BYL0377403774epoutp02D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221108061904epoutp02d17194b0691d347a6c9003154bd98b8d~lh5ze8BYL0377403774epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667888344;
        bh=7izSze1INgWQUcwWbybNeSSoXCzO8+NNdcOyipyeCaM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aOPtx/kzVxbqeQZFeHsxWXvYFCpRPOTgGf82UcOdvXzxgstTfib6naIzIiEKELFMS
         S5eNRC9mUPTwv+DdwWHuYbxhO967PfAaZHkhNyewrQE0cxq32XIrItKF+hz3j9bfRX
         O3S+rZggz3I3MXg3fm9Qi30F6gZGms+mQ4ZAREbw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221108061904epcas5p494647670058c765044eefc8f3b69ab6d~lh5zNlC9V2470224702epcas5p4h;
        Tue,  8 Nov 2022 06:19:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N5ybn5g26z4x9Q8; Tue,  8 Nov
        2022 06:19:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.68.39477.5D4F9636; Tue,  8 Nov 2022 15:19:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221108052642epcas5p20ccc09d0dd777b715aeeda44ef08a839~lhMEsqrf80455504555epcas5p27;
        Tue,  8 Nov 2022 05:26:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221108052642epsmtrp12bab3190c4fee545bc86c59a8a4d8364~lhMErpzwh2255322553epsmtrp1J;
        Tue,  8 Nov 2022 05:26:42 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-76-6369f4d5e399
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.DF.18644.298E9636; Tue,  8 Nov 2022 14:26:42 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221108052639epsmtip138c04f90c1db5a41cd7fd5d90b1ea606~lhMCW27IF0452004520epsmtip1M;
        Tue,  8 Nov 2022 05:26:39 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <22272f56-ba55-5725-2dc9-8012e5903eeb@linaro.org>
Subject: RE: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Tue, 8 Nov 2022 10:56:38 +0530
Message-ID: <01c001d8f332$af038ef0$0d0aacd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwIMhU34AXuYdz8DFSTEIAHaZpHuAajle5ysixjp0A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmpu7VL5nJBrOuqlk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxkttj7Gij27UoHk8XlXXPYLGac38dksWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AtKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMU8d72AsO8FQ0f7nE0sC4n6uLkZNDQsBEYsmlNpYuRi4OIYHdjBKTnu9i
        BkkICXxilHgwqRwi8ZlR4ueHRsYuRg6wjj29cRDxXYwSjau2QnW/YJTofwTicHKwCZhLLNq7
        lBEkISJwhUni5+p2sCpmgTZGib0X1zKCVHEK2En8nTIHrENYwEOi6c9eVhCbRUBFYuXDCWA2
        r4ClxJ2eN+wQtqDEyZlPwOqZBeQltr+dwwzxhILEz6fLwOpFBMIkDp9oYYOoEZc4+rOHGWSx
        hMAXDomVx34wQTS4SLS9P8gIYQtLvDq+hR3ClpJ42d8GZedLTPvYzAZhV0i0fdwA1WsvceAK
        yNEcQAs0Jdbv0ocIy0pMPbWOCWIvn0Tv7ydQ5bwSO+bB2KoS65dvglorLbHv+l7GCYxKs5C8
        NgvJa7OQvDALYdsCRpZVjJKpBcW56anFpgVGeanl8BhPzs/dxAhO4lpeOxgfPvigd4iRiYPx
        EKMEB7OSCK9ITWayEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H5pG8knhDE0sDEzMzMxNL
        YzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqY3KeGRemtjJyRmlsSks39pL66tOfF5NIr
        c/SW/Z3jYj1zTcq/mZo19WttwyW/TFitnF/8oyFNW3n33sj9l9Td54kZujrv9Z3kLzyx6uMk
        hV+HlFMnR/5f8ab1+Xvbm2YTupI0Y/PKfz45tCc59Ua2qfHq4Lu7m+0+qB98I1/tmX7g8Dm3
        k+ln+sW3sU55s/tigFK0ev26ya0zBVzmCbXobL+6ZIfg1yyZ5WuDvLufBh75LszSvv/hmyUZ
        7yewz7I2P17xcOqi6XGME09danv6zlND2tCvet550w2OTlrbNuRs+72/PeKeUZlVS4TCDsPG
        dWwST8yZmnVDYyfWT36U+ZHteHX24VNvAwqbr36tUWIpzkg01GIuKk4EAKcsESZrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO6kF5nJBkeXsVo8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxkttj7Gij27UoHk8XlXXPYLGac38dksWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8ap4z3sBQd4Kpq/XGJpYNzP1cXIwSEhYCKxpzeu
        i5GLQ0hgB6PEx1+PmLsYOYHi0hLT+/ewQdjCEiv/PWeHKHrGKDFvxQOwIjYBc4lFe5cygiRE
        BB4xScyd/4gNxGEW6GKUOP53JTNEy2UmiRvH/7CCtHAK2En8nTKHBcQWFvCQaPqzFyzOIqAi
        sfLhBDCbV8BS4k7PG3YIW1Di5MwnYPXMAtoSvQ9bGSFseYntb+dA3aog8fPpMrBeEYEwicMn
        WtggasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxgmNZS2sH455VH/QOMTJxMB5ilOBgVhLhFanJTBbiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaWN/3w4LX+9TNQ6NWyNu6W36f7PYmuP1c6Vv
        2ztsPXmfTZQ4cPH7oTmc3B/zl6edT23pyYnzW1f6KG/VRXOmaRlrDR6oRSz8EbV15y1dg0yt
        7/vOLA65Vpj6q+BU36aSnfMO2msaCRRcv16rw6u1sbV6z52bKTUMbattLlw2ddZwCjSvMrnZ
        fuVZTdikD45ZP48yvTtroVe8WrFpiUv/g+mOUUembPtxpJh9iYhC2Lrzl4037PI0zP693L+V
        c34740XzhkbevuX8Qhpf/C7W7PL/48C06q3grK27eO0iv1usEXkpdvf1XU7hOoeVB1Xizd++
        fztd8O/r9n3fn69Mkd/f9//nFqVD84vPtlsnvlNiKc5INNRiLipOBACF4MfQVAMAAA==
X-CMS-MailID: 20221108052642epcas5p20ccc09d0dd777b715aeeda44ef08a839
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
        <20221014102151.108539-6-p.rajanbabu@samsung.com>
        <c11f92be-1d86-17e4-e3bb-05e7b17d5fc8@linaro.org>
        <04ba01d8e52a$0d55bee0$28013ca0$@samsung.com>
        <22272f56-ba55-5725-2dc9-8012e5903eeb@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 21 October 2022 06:32 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
> 
> On 21/10/2022 04:49, Padmanabhan Rajanbabu wrote:
> >>>
> >>>  	cpus {
> >>> @@ -809,6 +811,42 @@
> >>>  			status = "disabled";
> >>>  		};
> >>>
> >>> +		tdm_0: tdm@140e0000 {
> >>
> >> Node names should be generic, so this looks like i2s.
> >> https://protect2.fireeye.com/v1/url?k=2cfaa5af-4d874de8-2cfb2ee0-
> >> 74fe485fff30-cb16acc0c0c574e9&q=1&e=fc8e3b54-a0ef-475e-a4f2-
> >> 83626a86ac8a&u=https%3A%2F%2Fdevicetree-
> >> specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-
> >> basics.html%23generic-names-recommendation
> >
> > Thank you for the link. I could only find audio-controller in the list
> > and not i2s. so I believe I can use audio-controller node name. Please
> > correct me otherwise.
> 
> All I2S controllers use node name "i2s", so if this is I2S, then use "i2s".

Okay, I'll ensure the next version will use "i2s" node name

> 
> 
> Best regards,
> Krzysztof


