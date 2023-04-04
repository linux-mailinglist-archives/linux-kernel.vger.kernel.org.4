Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9427F6D603A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjDDMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjDDMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:25:00 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC148D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:24:55 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230404122452epoutp04d116a1f5415841eaa51a6d88b51d63e0~SuuJYpCYu2161321613epoutp048
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230404122452epoutp04d116a1f5415841eaa51a6d88b51d63e0~SuuJYpCYu2161321613epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680611092;
        bh=uxxtqePbKqvEffYGyXtR+6fWc15Yn+30hmEWB9evnDc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=sL9AuY6x07+J9CAtaeqcwPA6uVDOxOGVr/SUN8F3AeawFOqyaACLpmtUm8G4dHE71
         edNHPaNdkWBNuzuJ/rVJ7gS1+zc+hZR8rNsMovNu3QBSrNMQ//N3bjUulRGKi5ajgi
         Lt+XmROrcNMK+eXc9XBKGyAFz6QebcWgGv6WLHtA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230404122450epcas2p25d65c4786c9ede1a0d136b211d71f3ba~SuuICMCGv2055820558epcas2p2V;
        Tue,  4 Apr 2023 12:24:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PrRm220xDz4x9Pt; Tue,  4 Apr
        2023 12:24:50 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.96.61927.2171C246; Tue,  4 Apr 2023 21:24:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230404122449epcas2p16d71a07d468ec9ecbd8ef91aaa6e6e3f~SuuGz-nDu1659116591epcas2p1G;
        Tue,  4 Apr 2023 12:24:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230404122449epsmtrp25243da029df43dea35bdb9db1212f62c~SuuGzK5-K1129811298epsmtrp2c;
        Tue,  4 Apr 2023 12:24:49 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-25-642c17128611
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.C2.18071.1171C246; Tue,  4 Apr 2023 21:24:49 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230404122449epsmtip2e0510011a0ea051409c70c9c01b3bef5~SuuGkhbkq1068210682epsmtip2E;
        Tue,  4 Apr 2023 12:24:49 +0000 (GMT)
Message-ID: <c227cbce-8b2d-41d7-122c-f271f8396349@samsung.com>
Date:   Tue, 4 Apr 2023 21:22:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] spi: s3c64xx: support spi polling mode using
 devicetree
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <aca77fe7-5fed-4ba1-ab28-8b66281224d2@sirena.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmma6QuE6KwanzPBYP5m1js1j84zmT
        xdSHT9gsLu/Xtph/5Byrxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y+eFNYwFP3grnu64zdzA+J+ri5GTQ0LAROLP
        5IeMXYxcHEICOxglrh3bwQaSEBL4xChxYEc+hP2NUWLzE+YuRg6who6VrhD1exkl3j14ww7h
        vGaUaJ58jAWkgVfATuLD12tgg1gEVCRWzlrDDhEXlDg58wlYjahAlETf7U2sILawQJDEyoP3
        wWxmAXGJW0/mM4HYIgLKEle/72UBWcAs8JFJ4tbMSWAJNgFtie/rF4M1cAo4SuxZuJkFolle
        YvvbOcwgDRICazkk/lxfzAJxtovEsb5MiJeFJV4d38IOYUtJfH63lw3CzpZon/6HFcKukLi4
        YTZU3Fhi1rN2RpAxzAKaEut36UNMVJY4cgtqK59Ex+G/7BBhXomONiGIRjWJ+1PPQQ2RkZh0
        ZCUThO0hcfTnNqYJjIqzkAJlFpLnZyH5ZRbC3gWMLKsYxVILinPTU4uNCgzhMZ2cn7uJEZxq
        tVx3ME5++0HvECMTB+MhRgkOZiURXtUurRQh3pTEyqrUovz4otKc1OJDjKbAqJnILCWanA9M
        9nkl8YYmlgYmZmaG5kamBuZK4rzStieThQTSE0tSs1NTC1KLYPqYODilGphk7v76wfEpdnqC
        vaeAgvI0+7Leezd65l60uKN+iz31tccGE/7lL1Qc9sVvVq4WWdZ6vlFdeHZOl6iA7LtfMyfZ
        +d0teWhZ212rYhfx94v/lFOKYlFr42OM5lwLTvwal/LxB8+iv7eTD2XZFv3+ello2sLJ/jv+
        iSgmv7CdOSc3QZmrsER352KX8g5t9oWG+acjJPkWzI3vVC04svlUpYrXBSGe3rySHxt4NppW
        pnlasEw5nDr3lmDENotdCWc0Cy5N/HM3vlrR4OflD6zdqQnJ3qpfHvrkbnSPUj47ya285nTu
        rNXqhs5TK/QK5jztSjJ8lh/+Qu1dz5XCOSkcP8Q/Zi/9eFomY6nZjWONU5VYijMSDbWYi4oT
        AeLNdqk+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXldQXCfF4PkOcYsH87axWSz+8ZzJ
        YurDJ2wWl/drW8w/co7VYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mS3aN17hN2B2+P6kk/M
        HptWdbJ53Lm2h81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4MrYeWENY8EP3oqnO24z
        NzD+5+pi5OCQEDCR6Fjp2sXIySEksJtR4ujFUBBbQkBGYvmzPjYIW1jifssR1i5GLqCal4wS
        C6bcYwVJ8ArYSXz4eg2siEVARWLlrDXsEHFBiZMzn7CA2KICURKfD7SAxYUFgiRWHrwP1sss
        IC5x68l8JhBbREBZ4ur3vSwQ8Y9MEpMmiEMc9IpJ4sH8YBCbTUBb4vv6xWC9nAKOEnsWboaq
        N5Po2trFCGHLS2x/O4d5AqPQLCRnzEKybhaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07M
        LS7NS9dLzs/dxAiOMC3NHYzbV33QO8TIxMF4iFGCg1lJhFe1SytFiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbtrNsqlu+6PbtXQbLl4Bs/uQM+F14c
        W8MxRcYp8tOlvjf/NDoN2FwmnFQuuXfh0+Gjzm0ZJWs71BUvTV6oLB//6dCUjXusVLOiP+XJ
        G3J6bJwlyvV8d8qr/1ueVXLfOpAheIP9oKuM5EM7fi6Ov1eeBS1+tGxl7gQXvx2s+/+duzvv
        aezXl4tk7Q7lFB1bJ638UOTkqbhWzxgu2d87cyx4/KeFeb5iaMuck1dmcHNbox6zgtpJxTeO
        PZrqjAf82iesvadZkLKuYpOH9rvyxwXOipwz99kybJigLtLJe1rRNvQKi6pmyRaOJ2sqTvHW
        H7kj1ZGmp9lVoX9kVk6tXM5Jdc/A52+tMiUexcV6hiixFGckGmoxFxUnAgD5Fp6cHwMAAA==
X-CMS-MailID: 20230404122449epcas2p16d71a07d468ec9ecbd8ef91aaa6e6e3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
        <20230404060011.108561-2-jaewon02.kim@samsung.com>
        <a4a9d1d1-c5cd-460e-96e0-6db8048518c6@sirena.org.uk>
        <4b652b3c-20e1-1d87-1ee3-3aab43507100@samsung.com>
        <aca77fe7-5fed-4ba1-ab28-8b66281224d2@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,


On 23. 4. 4. 20:41, Mark Brown wrote:
> On Tue, Apr 04, 2023 at 08:17:13PM +0900, Jaewon Kim wrote:
>> On 23. 4. 4. 19:54, Mark Brown wrote:
>>> On Tue, Apr 04, 2023 at 03:00:09PM +0900, Jaewon Kim wrote:
>>>> This patch adds new 'samsung,spi-polling' property to support polling mode.
>>>> In some environments, polling mode is required even if DMA is supported.
>>>> Changed it to support not only with quick but also optinally with
>>>> devicetree.
>>> Why would this be required if we can use DMA?  If this is a performance
>>> optimisation for small messages the driver should just work out when to
>>> choose PIO over DMA like other drivers do.  It is hard to see this as a
>>> hardware property which should be configured via DT.
>> We are providing a VM environment in which several Guest OSs are running.
>> If Host OS has DMA, GuestOS should use SPI as polling mode.
> This sounds like some sort of virtualised environment with passthrough?
> If that's the case then the host OS will be in control of the device
> tree provided to the guest so it simply shouldn't be describing the DMA
> configuration if it doesn't want the guest to use DMA for some reason.
> There's no value in describing the DMA the guest shouldn't use then
> providing an additional property telling the guest not to pay attention
> to the DMA when we could simply not do the first step.


Is it correct in your opinion to change to polling mode if there is no 
DMA describing in DeviceTree?

Currently, if there is no DMA, the probe failed in s3c64xx driver.
So I added the "samsung,spi-polling" property not to check DMA.

If your opinion is to switch to Polling mode if there is no DMA, I will 
fix it in the next version.


Thanks

Jaewon Kim

