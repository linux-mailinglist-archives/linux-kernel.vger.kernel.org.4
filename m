Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317D6D5ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjDDLTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjDDLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:19:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5F1703
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:19:43 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230404111939epoutp02d25203ac53730033ed08f313fc8458af~St1NHgdDf2063420634epoutp02f
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230404111939epoutp02d25203ac53730033ed08f313fc8458af~St1NHgdDf2063420634epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680607179;
        bh=oGGO2Uu0KUQiuSoOtyNCqRDLlKQVmo49N5hywPvTeGc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qpibsN420B/9LrxXZuokukGmWbgfXSEsAGvgCbJwpvriVqzCMPOGsdHiTdcWiMt4S
         ebRxegvrRdKW0+eKkEbr00AhlglzxqsSLorl2b3qL5BxrPrqcikleLVG33Mh+VL3Wc
         udTA3yqiHg9bUyDfdWdWAtS5YH999dipx367PXQo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230404111938epcas2p207da7c4271046773bc437e2a67e9e174~St1Mhc_bt2672326723epcas2p25;
        Tue,  4 Apr 2023 11:19:38 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PrQJp0spcz4x9Px; Tue,  4 Apr
        2023 11:19:38 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.92.35469.AC70C246; Tue,  4 Apr 2023 20:19:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230404111937epcas2p25ae33c66401ba055e7d0478b945e9ffd~St1LrbHuY2672326723epcas2p23;
        Tue,  4 Apr 2023 11:19:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230404111937epsmtrp2997708b2390d2ede606223a41d70035f~St1LqjuNE0731007310epsmtrp2R;
        Tue,  4 Apr 2023 11:19:37 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-34-642c07c996f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.FE.18071.9C70C246; Tue,  4 Apr 2023 20:19:37 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230404111937epsmtip1127c42fff3119cac28d1077e8f2cf915~St1LZ7KO00428904289epsmtip1k;
        Tue,  4 Apr 2023 11:19:37 +0000 (GMT)
Message-ID: <4b652b3c-20e1-1d87-1ee3-3aab43507100@samsung.com>
Date:   Tue, 4 Apr 2023 20:17:13 +0900
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
In-Reply-To: <a4a9d1d1-c5cd-460e-96e0-6db8048518c6@sirena.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhe4pdp0Ug1/PmC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xqkdexgLergq5j49w9TA+JO9i5GTQ0LAROLH
        pPusXYxcHEICOxglvu3byAbhfGKUOHv8PhOE841Rouf7XCaYlrtLj7JAJPYySjy+eYsNJCEk
        8JpRYtkEWxCbV8BO4t+nrSwgNouAisSsAxeYIOKCEidnPgGLiwpESfTd3sQKYgsLBEmsPHgf
        zGYWEJe49WQ+WL2IgLLE1e97wZYxC3xkkrg1cxJYgk1AW+L7+sVADRwcnAKOEn1rOCB65SW2
        v53DDFIvIbCSQ2LB1MlsEFe7SDw/NpMFwhaWeHV8CzQApCQ+v9sLVZMt0T79DyuEXSFxccNs
        qLixxKxn7Ywgu5gFNCXW79IHMSWAbjtyiwViLZ9Ex+G/7BBhXomONiGIRjWJ+1PPQQ2RkZh0
        ZCU0CD0kjv7cxjSBUXEWUqDMQvL8LCTPzELYu4CRZRWjWGpBcW56arFRgQk8rpPzczcxgtOt
        lscOxtlvP+gdYmTiYDzEKMHBrCTCq9qllSLEm5JYWZValB9fVJqTWnyI0RQYNROZpUST84EJ
        P68k3tDE0sDEzMzQ3MjUwFxJnPdjh3KKkEB6YklqdmpqQWoRTB8TB6dUA9OUSb9crI4IbV+8
        T9lg9lkVU6M9W70nt2d7b2ubJ/Dm6vyE6XWn/jFkzFNel2h0QqZsTsYBaanr6seKzdZYZP04
        /XveQpH7LtfO52R8Tp/TVj9dNSe3+E3728/LlDOfX4yMyjs753xdURrTdKGo24ZPfLfM9jjy
        eunCdbdL3jFdnLRiXl1ep8Hm5bX5RvL/HU2mTdO9xpzZox/du3vyPPZlvtxr+eYt2pNSoilb
        e+/i5QR36+lfur/J2J74qbJ+6STfLe17+eoyZirPS98bID/95dmNqklC/5j2f09/qu66mv+G
        TA1nS8o92f0nji2Sf/66QyyC9c3xg7PNSyfo9G4IY23Zq/mnrDX4kZ0cU1WiEktxRqKhFnNR
        cSIAkSYmwkAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTvcku06KQcNeJYsH87axWSz+8ZzJ
        YurDJ2wWl/drW8w/co7VYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mS3aN17hN2B2+P6kk/M
        HptWdbJ53Lm2h81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mo4tWMPY0EPV8Xcp2eY
        Ghh/sncxcnJICJhI3F16lKWLkYtDSGA3o8Tkl6vYIBIyEsuf9UHZwhL3W46wQhS9ZJQ4eWY1
        I0iCV8BO4t+nrSwgNouAisSsAxeYIOKCEidnPgGLiwpESXw+0AK2TVggSGLlwfusIDazgLjE
        rSfzwepFBJQlrn7fywIR/8gkMWmCOMSyf4wS05YsAytiE9CW+L5+MVAzBwengKNE3xoOiHoz
        ia6tXYwQtrzE9rdzmCcwCs1CcsYsJOtmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4CjT0tzBuH3VB71DjEwcjIcYJTiYlUR4Vbu0UoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgOr85pdlW933srugz9p81V1jdWKUs2VcY
        rXXLzqXmsthMw66FX52mcL0tCP16ROByy6qzIs17/7gG8G46a+lySTXqj6TUfV+eRP0b3sYC
        LmcPvNrv+vxymaJn49LCi4zX1gk27zeeMjGrxv67gZnkIYcDms8vMq570iYzReHvYpslDL5m
        /PsNtXp/RX8t+VjhmPY6es78ZackpczueWpfTGePePGK6WSlQm/4ljf7zrEddr9ZKBu7uGK3
        ScynIGGjl2dFBZ9P33bw7t+7Abdapj3JMy7ZPkvv5wZN7rzq224dRe5ZmoKJTo036t8r3MtL
        bj70S1+e+xRvmrlc8bUz+qxVChkX4qee3fx6+brJSizFGYmGWsxFxYkAdCGC9CEDAAA=
X-CMS-MailID: 20230404111937epcas2p25ae33c66401ba055e7d0478b945e9ffd
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,


On 23. 4. 4. 19:54, Mark Brown wrote:
> On Tue, Apr 04, 2023 at 03:00:09PM +0900, Jaewon Kim wrote:
>> This patch adds new 'samsung,spi-polling' property to support polling mode.
>> In some environments, polling mode is required even if DMA is supported.
>> Changed it to support not only with quick but also optinally with
>> devicetree.
> Why would this be required if we can use DMA?  If this is a performance
> optimisation for small messages the driver should just work out when to
> choose PIO over DMA like other drivers do.  It is hard to see this as a
> hardware property which should be configured via DT.


We are providing a VM environment in which several Guest OSs are running.
If Host OS has DMA, GuestOS should use SPI as polling mode.

In order to support s3c64xx in a DMA-less environment, it must be 
separated with a quirk.
However, there is DMA in the Host OS and no DMA in the Guest OS,
it is not correct to separate them with quirk.

I'm considering supporting this systems with DeviceTree rather than qurik.
If 'samsung,spi-polling' looks to be a SW configuration, how about 
'samsung,no-dma'.

This is not to simply change the mode using DeviceTree, but to support 
an environment without DMA.



Thanks

Jaewon Kim

