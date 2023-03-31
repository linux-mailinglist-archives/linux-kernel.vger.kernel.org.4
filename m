Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28456D14AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCaBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCaBKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:10:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2ECC36
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:10:01 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230331010957epoutp01f8049bff2452be861ed6b111924e9461~RW7utcuKS0982609826epoutp01y
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:09:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230331010957epoutp01f8049bff2452be861ed6b111924e9461~RW7utcuKS0982609826epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680224997;
        bh=EhThxdvWYRZnuiv50zXOOQDb0YMreQfdHDr+74zalFI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=XVbmwE5QLfV69+IKWbn1xDA2j/ZohRLf8jJBK996wigwryX+oe1ic0v4be1AUYhRZ
         TFehjquMO4N/7ocZfb0VnzhiWJ6hyycXH7wLJiYynrj0ZTuSvhEH/v9r1W0BegOhWg
         cQOhlY/cuwY/TnlCUleqrqp5re/qIeQC6TaADSWE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230331010957epcas2p3fc31aadeaf65124deed2fea2aca44508~RW7uY2ibQ1566115661epcas2p3-;
        Fri, 31 Mar 2023 01:09:57 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pnhz85VxGz4x9QC; Fri, 31 Mar
        2023 01:09:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.FD.08750.4E236246; Fri, 31 Mar 2023 10:09:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230331010956epcas2p3376fc6fabe95b30c41e548bd7d692611~RW7tcMVR71567715677epcas2p30;
        Fri, 31 Mar 2023 01:09:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331010956epsmtrp254e82ff04fa070228176dbab0a3a6ca7~RW7tbSKXc2178021780epsmtrp2e;
        Fri, 31 Mar 2023 01:09:56 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-b1-642632e4314a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.8C.31821.4E236246; Fri, 31 Mar 2023 10:09:56 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331010955epsmtip289e59e04ced47c6a56673460e51a8ec4~RW7tIriRG1312313123epsmtip2S;
        Fri, 31 Mar 2023 01:09:55 +0000 (GMT)
Message-ID: <886e1f40-79d3-3e5f-bc11-06ce4a04ccec@samsung.com>
Date:   Fri, 31 Mar 2023 10:07:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH] spi: s3c64xx: add no_cs description
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <420495f8-b894-1665-bbc3-f5cab0f95301@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmhe4TI7UUgzkzlCwezNvGZrH4x3Mm
        i6kPn7BZ7H29ld1i0+NrrBaXd81hs5hxfh+TRePHm+wOHB7Xl3xi9ti0qpPN4861PWwem5fU
        e/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjH+7b7MV9HJUbN+xm72B8R1bFyMnh4SAicT8qa0sXYxcHEICOxgl9rx8
        AOV8YpR4uquBEcL5zChx9ncHK0zLrYbrUIldjBJtf18yQzivGSXWLD7ADlLFK2An0XRjDlgH
        i4CqxLv5q5gg4oISJ2c+YQGxRQWiJPpubwKrERawkNi27w2YzSwgLnHryXywehGBaImP91Yz
        gSxgFjjHKHFj/nlmkASbgLbE9/WLgRo4ODiBlp16UAXRKy+x/e0csIMkBKZySGxrOAF1tovE
        0b0zmSBsYYlXx7ewQ9hSEp/f7YWGRrZE+/Q/UPUVEhc3zIaKG0vMetbOCLKLWUBTYv0ufRBT
        QkBZ4sgtFoi1fBIdh/+yQ4R5JTrahCAa1STuTz0HNURGYtKRlVAHeEic+t/FNoFRcRZSoMxC
        8vwsJM/MQti7gJFlFaNYakFxbnpqsVGBMTyyk/NzNzGCk6qW+w7GGW8/6B1iZOJgPMQowcGs
        JMJbaKyaIsSbklhZlVqUH19UmpNafIjRFBg1E5mlRJPzgWk9ryTe0MTSwMTMzNDcyNTAXEmc
        V9r2ZLKQQHpiSWp2ampBahFMHxMHp1QD096/0Q+i29Zrxk+epn+X6dRyyW0rI19m2W4/rHTg
        Z8TswO+Ml7ecWpV+bM+G/SdOTLoa5rC8X4ntiFKkCs+LL6sT38mrPvkzh2Xe3uRIvzxepc7V
        5ntechfk8of6nhd9Pc9myn5jRn1eF+E1V+M8pjWGNv3k1nUIbnEq+7PeL8VAPX9nStnKO2/z
        GVZr/DsWaKSsceWtyJ9+/2me8r5q0qsUbPufFL0XcUxNMtOTmWnMmp1fELJ14af2734z+bXl
        np89dHZSufyc03NmvH508CZb1q/vM73/BeVPCWez7Lx0yUNyl2rv98nfr9wvKmF12n3NV126
        xmaW0Z6NSU33q10+H2G/dr45d9L2n3NZfyqxFGckGmoxFxUnAgBxkmwrMwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXveJkVqKweEJXBYP5m1js1j84zmT
        xdSHT9gs9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXYHDo/rSz4xe2xa1cnmcefaHjaPzUvq
        Pfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj3+7bbAW9HBXbd+xmb2B8x9bFyMkhIWAicavh
        OmMXIxeHkMAORokDC99DJWQklj/rg7KFJe63HGGFKHrJKHF96xl2kASvgJ1E0405rCA2i4Cq
        xLv5q5gg4oISJ2c+YQGxRQWiJD4faAGrFxawkNi27w1YPbOAuMStJ/OB6jk4RASiJU7uDwaZ
        zyxwjlHi6oSPTBDLfjFK7Gm8DdbAJqAt8X39YlaQBk6gxaceVEHMMZPo2trFCGHLS2x/O4d5
        AqPQLCRnzEKybhaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOJC2t
        HYx7Vn3QO8TIxMF4iFGCg1lJhLfQWDVFiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLp
        iSWp2ampBalFMFkmDk6pBqZjc53Fp84ITywM0zSw55nzVLDrQuy7WSG825icQ+ULP71oD9ya
        /CLspZrnvDXt76dH3Iuy/lKizMoz+2qzQ4eABNPHNaGiGto2T90133TyGEvFJ67rNNnuHuIn
        k8ic2Sy1LUP5ycMvv/9fzBdd80al9nxLxSt3pdtmpY/VHVs3Fjznjf90P3qz1e15fCe3bdrR
        abZvukBif4yUr0qkDqd94S6ON3O7Zp0yeWjiXsxk8UipvEvj1Obr64pe6MkWS07J2Pwr8KDH
        2uwyVralt20yKiv1Z53SSY6JWe49Z2XYtEeK9j5X5EtkOLivdvj/PeDee03aeX2468LnGVfY
        xS54snAoHpyW7X0sjnODEktxRqKhFnNRcSIANwZkKRMDAAA=
X-CMS-MailID: 20230331010956epcas2p3376fc6fabe95b30c41e548bd7d692611
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
        <20230306014239.80570-1-jaewon02.kim@samsung.com>
        <1b4f0367-a919-cd8a-17e1-a38998575e58@samsung.com>
        <420495f8-b894-1665-bbc3-f5cab0f95301@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof


I always appreciate your kind guide.


I used 'get_maintainers.pl' but the Mark was missing.

Because the changes in this patch are only in 
"include/linux/platform_data/".

There was no touch in SPI driver. So, script did not outputting the SPI 
Maintainer.


Thanks

Jaewon Kim

On 23. 3. 30. 23:46, Krzysztof Kozlowski wrote:
> On 30/03/2023 15:40, Jaewon Kim wrote:
>> Hello Mark
>>
>>
>> Could you apply this patch?
>>
>> I missed you in the mail recipient.
>>
>>
>> https://protect2.fireeye.com/v1/url?k=62c6672d-034d7217-62c7ec62-74fe4860008a-45c729ef051007d6&q=1&e=03453742-6822-4fdc-9ee7-bdb6bdb0fe4f&u=https%3A%2F%2Flkml.org%2Flkml%2F2023%2F3%2F6%2F34
>>
>> https://protect2.fireeye.com/v1/url?k=41253bbb-20ae2e81-4124b0f4-74fe4860008a-f6ba8ee97b64390d&q=1&e=03453742-6822-4fdc-9ee7-bdb6bdb0fe4f&u=https%3A%2F%2Flkml.org%2Flkml%2F2023%2F3%2F6%2F232
> I think you should resend. This time with entire output of
> scripts/get_maintainers.pl
>
> Best regards,
> Krzysztof
>
>
