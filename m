Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEE64BF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiLMWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiLMWXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:23:08 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6032633
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:23:06 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221213222303euoutp02ee1c437b747db413e8d35a66f5a2b7c8~weodkis870283402834euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221213222303euoutp02ee1c437b747db413e8d35a66f5a2b7c8~weodkis870283402834euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670970183;
        bh=2EZqbcx0W4vqGwh+HQvv99s9jy1fUMLoBIMNmNisezo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=vIwO5khUbwG3OuKUfHbgVQDFLgzBzE2/wFMJiIqvD66NlK5rIMJLufcFiza39vSkB
         +L1fDddX+/g4n5ePblph3pmp5kKPHVZPBO9cqolBkaKXbFGlUcwniPCMO7m+NSwabj
         DUSjB78s1AHWZg09T79mdMtsD+vah80a8sDADnbw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221213222302eucas1p13c33b2064912f308b52c50b6f7f0c892~weocY2bJN0957309573eucas1p1e;
        Tue, 13 Dec 2022 22:23:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 75.9F.09549.64BF8936; Tue, 13
        Dec 2022 22:23:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221213222301eucas1p1c7ef09661b9c127fc3fb2d76bbeba440~weobtXRXg2919029190eucas1p12;
        Tue, 13 Dec 2022 22:23:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221213222301eusmtrp2ab471d61bad2b6a99ef67e498f7ce15b~weobslrj42509225092eusmtrp2I;
        Tue, 13 Dec 2022 22:23:01 +0000 (GMT)
X-AuditID: cbfec7f5-f47ff7000000254d-33-6398fb464993
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.02.09026.54BF8936; Tue, 13
        Dec 2022 22:23:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221213222300eusmtip18c852a573ff877b224a1b093f69b1b2d~weoa1e1N82385523855eusmtip1N;
        Tue, 13 Dec 2022 22:23:00 +0000 (GMT)
Message-ID: <be56fd97-08b5-8a7a-2630-371c83dcab18@samsung.com>
Date:   Tue, 13 Dec 2022 23:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>, djrscally@gmail.com,
        hdegoede@redhat.com, markgross@kernel.org, lgirdwood@gmail.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        yangyingliang@huawei.com, gene_chen@richtek.com,
        chiaen_wu@richtek.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Y5ipFd8BfU361QzN@sirena.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7puv2ckG6xbI2zx8+U0RoupD5+w
        Waw9qW/xZU8/q8W2w+9YLZ70nGO1eHN8OpPFtysdTBabHl9jtbi8aw6bRde1J6wWB6ZOY7aY
        93ctq8XqPS+YLSatu8dkseXTNSYHAY+n/VvZPXbOusvu0XLkLavHplWdbB6bl9R7vN93lc1j
        xqcpbB4H9xl6fN4kF8AZxWWTkpqTWZZapG+XwJVxs+sdW8E77opdH98xNzDu4+xi5OSQEDCR
        mL15A3sXIxeHkMAKRok133oZIZwvjBIzf7+Ccj4zSnTd+8EC0/J07jyoxHJGiYv9i5lBEkIC
        HxklfkyvArF5BewkvnR1MILYLAKqEvMPz2KCiAtKnJz5BGyQqECKxIGdZ8HiwgJpEs/2t7KB
        2MwC4hK3nswHi4sIKEtc/b6XBWQZs8BBZomtnfdYQRJsAoYSXW+7wBo4BXQltp6aB9UsL7H9
        7RxmkAYJge2cEuvPX2KFONtF4siiRmYIW1ji1fEt7BC2jMT/nSDbQBraGSUW/L4P5UxglGh4
        fosRospa4s65X0ArOIBWaEqs36UPEXaUOPr+GFhYQoBP4sZbQYgj+CQmbZvODBHmlehoE4Ko
        VpOYdXwd3NqDFy4xT2BUmoUULrOQ/D8LyTuzEPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqX
        rpecn7uJEZgCT/87/nUH44pXH/UOMTJxMB5ilOBgVhLhVdWYlizEm5JYWZValB9fVJqTWnyI
        UZqDRUmcd8WUjmQhgfTEktTs1NSC1CKYLBMHp1QDk1thwd4Ffgt26U+eMNXyld6Vfo3l9ma/
        Web7f3zuyrM7aMcPAxaTv6rltdc/7r3pnNrxsS+hlvmYDnvW95PR91jruXVWFU5qtVq/I8Pw
        s23vSWGlNYuv7l9xLlstYUe2vaO6z9U1kbcXKL8sz3W4b9w990jitPatrX2Oae/UrubtLTf+
        qHRiqWay9N2GrXuPcvQ9NTLb1HvmqdvbaQGt3yNyim1u/7DfK/vn+za30tXsAb+1TSpeWBr/
        reDbZWVaom9wTvheurRSwa5zhWeb626Yci/nazq4NJY56MjpyDDXs/Gt501+SlmITlrOHS4g
        /dBn+jMjlqMmXtWPn1osEUmetmmd2F0r4a+fZjl2KrEUZyQaajEXFScCAF81X4HwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7quv2ckG7xYLG/x8+U0RoupD5+w
        Waw9qW/xZU8/q8W2w+9YLZ70nGO1eHN8OpPFtysdTBabHl9jtbi8aw6bRde1J6wWB6ZOY7aY
        93ctq8XqPS+YLSatu8dkseXTNSYHAY+n/VvZPXbOusvu0XLkLavHplWdbB6bl9R7vN93lc1j
        xqcpbB4H9xl6fN4kF8AZpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJdxs+sdW8E77opdH98xNzDu4+xi5OSQEDCReDp3HiOILSSwlFFi34Z8iLiM
        xMlpDawQtrDEn2tdbF2MXEA17xkljl5+xASS4BWwk/jS1QHWzCKgKjH/8CyouKDEyZlPWEBs
        UYEUifaef2BxYYE0iWf7W9lAbGYBcYlbT+aDxUUElCWuft/LArKAWeAgs8TGBzOZIba9YpJY
        2bACrINNwFCi620XmM0poCux9dQ8qElmEl1buxghbHmJ7W/nME9gFJqF5JBZSBbOQtIyC0nL
        AkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIExv+3Yzy07GFe++qh3iJGJg/EQowQHs5II
        r6rGtGQh3pTEyqrUovz4otKc1OJDjKbA0JjILCWanA9MOnkl8YZmBqaGJmaWBqaWZsZK4rye
        BR2JQgLpiSWp2ampBalFMH1MHJxSDUzSfAyLXG9PTl6Zy+v6zHjZ34tNDrJVJ9ds++Xx2VTM
        6JRT65mpJUpSzFfiTl/QvHOt5OvG5u+nXRWr93+wC2T8etH1X+DqRPvni9cUTf8uVVt+/mmn
        gChPafhu058e2V85ElXzam9ssMt+vlqnTOdFrXS0nPK3NWsMM4Lm5515p7eucZbxqbD40ouJ
        dimzg42l13/erH9cU1C1+CGjrf3F+zMuKj+0eHRb1GF+jN2OXZsOXFsTwvGrj2HxehGNNU3Z
        LOyMTkLiYXvV7683vzqLb3bdds8tiiL3lSfUppY7BZxjTzMX3xQmYVSnVvR9sbqJ+u2cvH3n
        uOef/ZWRMj/Aa+arg0nhmUufNZzkylBiKc5INNRiLipOBABi/y0NggMAAA==
X-CMS-MailID: 20221213222301eucas1p1c7ef09661b9c127fc3fb2d76bbeba440
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
References: <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
        <1670311341-32664-1-git-send-email-u0084500@gmail.com>
        <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
        <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com>
        <dc6c80f1-f34d-eaab-d561-32caa7fa140c@samsung.com>
        <Y5ipFd8BfU361QzN@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2022 17:32, Mark Brown wrote:
> On Tue, Dec 13, 2022 at 03:29:00PM +0100, Marek Szyprowski wrote:
>> On 13.12.2022 15:19, ChiYuan Huang wrote:
>>> I don't have the board. Could you help to test this change to see
>>> whether it's been fixed or not?
>> The above change fixes the issue. Thanks! Feel free to add following
>> tags to the final patch:
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Thanks for jumping on this so quickly!  Marek, are these boards (or
> similar ones) generally available?  They seem great at showing up issues
> so it'd be good if I could get them into my CI and spot problems earlier
> (or something like kernelci.org would be about as good)?

Well, they are quite old, but I've seen some used ones on eBay. Just 
look for "Samsung Chomebook XE503C12" (Peach-Pit) or XE503C32 (Peach-Pi, 
very rare).

Getting it integrated into the CI requires a bit of manual work. You 
have to solder UART lines to the test points on the motherboard. The 
board can be fully controlled via so called Embedded Controller, what in 
practice means that you can turn power on/off by sending commands to the 
dedicated EC UART. The kernel console UART uses 1.8V, while the EC UART 
- 3.3V. Let me know if you need more details.

Peach-Pi was used on kernelci.org some time ago, but I have no idea what 
has happened to it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

