Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847BA6E753F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjDSIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjDSIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:32:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38D10271
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:31:46 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230419083144epoutp015de33e3a264d18d8d8a08031fd5d664f~XSN4uQWYF0224102241epoutp010
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:31:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230419083144epoutp015de33e3a264d18d8d8a08031fd5d664f~XSN4uQWYF0224102241epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681893104;
        bh=HdmfS/CTf2VtyHRtOzatd6OOK769CkZgw5DVqgOlFTE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=mzWzMUtEyjUAPrB/6BrnteO5+fIhCAuUfuMhPvrEOD1QumC1vXu6VL3nF/MVppc87
         uQBGNMzxOaT04u6JsixFR8FyU2w3r2DCxXN+i11gOZYIjoE6ppzI2UNoOO2DHxT8c9
         tWd0GLM+nRovy0FsXDuJBUlWaqMP/jimlC3Ky91U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230419083143epcas2p42b65783fbefb10097daf1e2843aa961a~XSN30NPa80144001440epcas2p4e;
        Wed, 19 Apr 2023 08:31:43 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q1Yt74RxSz4x9QM; Wed, 19 Apr
        2023 08:31:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.59.09650.FE6AF346; Wed, 19 Apr 2023 17:31:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419083143epcas2p1b8a04a72e602714b72f1541acb41b8af~XSN3FVLpI0953109531epcas2p10;
        Wed, 19 Apr 2023 08:31:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419083143epsmtrp125863126573399ecb707e4c38baaab15~XSN3EltQ93154631546epsmtrp1j;
        Wed, 19 Apr 2023 08:31:43 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-74-643fa6ef7fb1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.00.08609.EE6AF346; Wed, 19 Apr 2023 17:31:43 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419083142epsmtip12d0e29281d16f57a5d4fd5175e5e4f8a~XSN21r-YI0112801128epsmtip1X;
        Wed, 19 Apr 2023 08:31:42 +0000 (GMT)
Message-ID: <a8541b6c-953f-adf5-2f39-f35a8162657f@samsung.com>
Date:   Wed, 19 Apr 2023 17:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/4] Improves polling mode of s3c64xx driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <c49881dc-f283-6981-3e03-02fb02b5ce54@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmue77ZfYpBkffylk8mLeNzWLxj+dM
        FlMfPmGzuLxf22Lv663sFpseX2O1uLxrDpvFjPP7mCwaP95kd+D0uL7kE7PHplWdbB53ru1h
        89i8pN6jb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGfMv3+eueAcW8WCvbtZGhg7WbsYOTgkBEwkbq506mLk4hAS2MEo
        cXXxR3YI5xOjRPvOFkYI5zOjxNTNLWxdjJxgHU+/PWeBSOxilDjU8Biq5TWjxN+p7xhBqngF
        7CReXbnLBGKzCKhK3Fr3khUiLihxcuYTFhBbVCBaYvG+KWC2sICzxLSHm8GmiggsZpToe/yJ
        DcRhFtjIKLG5aSo7SBWzgLjErSfzwaayCWhLfF+/GGwqJ9C2B0+WMUPUyEtsfzuHGeLWmRwS
        d/+wQXzqIrGkjwUiLCzx6vgWdghbSuJlfxuUnS3RPv0PK4RdIXFxw2yol40lZj1rZwQZwyyg
        KbF+lz7ERGWJI7dYIJbySXQc/ssOEeaV6GgTgmhUk7g/9RzUEBmJSUdWMkGUeEi82lw1gVFx
        FlKYzELy4Swkn8xCWLuAkWUVo1hqQXFuemqxUYEJPKqT83M3MYITq5bHDsbZbz/oHWJk4mA8
        xCjBwawkwnvG1SpFiDclsbIqtSg/vqg0J7X4EKMpMGYmMkuJJucDU3teSbyhiaWBiZmZobmR
        qYG5kjjvxw7lFCGB9MSS1OzU1ILUIpg+Jg5OqQamsg/+L867TT/UqyfFfNng6O7Qa6nbdv75
        z+WhGXM06ttsw7q8w6af9zPqHJMr/9CTZzd377r2YplFUjPWpe2yPRHo/G6i4o3nu+w+z0re
        mPJnn9ls8bhPGov3FiSrnUtWPbP9VbbzFG7xzX3inPa7P1Rn3bgVdUAwcrnIq78fuu31f5zq
        aBNvD1J1Czwt907k3HROvcZdrIq7VXuN53WHyVvct/LYda7P1ueFgEx90G7uGes05obMTf3F
        saTq+XpeUaP8U9HHhHS4bh6eWrIx+nX6XMU7Dn5Hputt2H47yPT1j06Ge/Ojta7PzdOdvNxs
        x9G1X9ZJvux1+h2/k0nn5/Kek2f1XkbtfNNho7O0XImlOCPRUIu5qDgRALu93fQ1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTvf9MvsUg57ZzBYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujPn3zzMXnGOrWLB3N0sDYydrFyMnh4SA
        icTTb89ZQGwhgR2MEs3z5CDiMhLLn/WxQdjCEvdbjgDVcwHVvGSUuNm1BayZV8BO4tWVu0wg
        NouAqsStdS+h4oISJ2c+ARsqKhAtcWP5N7AaYQFniWkPN7OADBIRWMwo0XHpLTuIwyywkVFi
        5fX1zBArjgKtWHEUrJ1ZQFzi1pP5YO1sAtoS39cvBlvBCbT6wZNlzBA1ZhJdW7sYIWx5ie1v
        5zBPYBSaheSSWUhGzULSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFR
        paW1g3HPqg96hxiZOBgPMUpwMCuJ8J5xtUoR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8
        kEB6YklqdmpqQWoRTJaJg1Oqgckt0XcuQ4qi8NtDvzvPO1r9cklfxf00Z/4tw1kO/+61ZK7g
        OCgwuWeW81wJ1w+1B1ZemGB1yIHDWuF4yMVfXjdtBFz9el3ktbi9eLzza5065CZo6ihVnL8n
        ZJIrmO7Rtoy33Cyh1Jc58KAKU/scPnHtBo9Sy8tTHzR/SM9Y8URDNHKuwPRFPul3VGu52pke
        TX960fAem1LoJYm9rm86fdYKbP/k+6JKtlCYwyX9Oc/k84eLvz4vfah67/sD3WmzxSReFTb4
        vIjU/h13zOPVnMXmNertXWtvitSmKIVZ7HqwUdhC4XzalumLA45tEtLecd74z9wDz1RF+tae
        /DVXIXfhhPvaUUE80q89rrh5K7EUZyQaajEXFScCAIma6cUZAwAA
X-CMS-MailID: 20230419083143epcas2p1b8a04a72e602714b72f1541acb41b8af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91
References: <CGME20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91@epcas2p4.samsung.com>
        <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <c49881dc-f283-6981-3e03-02fb02b5ce54@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 19. 16:59, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
>> 1.
>> s3cx64xx driver was supporting polling mode using quirk for SOC without DMA.
>> However, in order to use PIO mode as an optional rather than a quirk, when DMA
>> is not described, spi operates with pio mode rather than probe fail.
>>
>> 2.
>> Fixed the problem of high CPU usage in PIO mode.
>>
>> 3.
>> If the transfer data size is larger than 32-bit, IRQ base PIO mode used.
>>
> What changed in the patches? You need to provide changelog.


Oh, I missed changes while copy/pasting.

I will add changes v2 from v3 together.

Changes in V2.
- DeviceTree property not used to change PIO mod.
- Add cpu_releax() in polling loop
- Add lower limit in IRQ mode


>
> Best regards,
> Krzysztof
>
>
Thanks

Jaewon Kim

