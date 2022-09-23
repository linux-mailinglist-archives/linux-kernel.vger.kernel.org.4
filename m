Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7ED5E8588
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIWWDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiIWWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:03:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D4142E17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:03:03 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923220300euoutp01371b897f89190ecf184d0912fe3baccc~XnG1HkKCC0972909729euoutp01n
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:03:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923220300euoutp01371b897f89190ecf184d0912fe3baccc~XnG1HkKCC0972909729euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663970580;
        bh=OJv2e7DRA5VakNvI/plhp5ZQCba8KBiFMSejHWKqgX4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=FQxLPVE2f2nG9MkfHijzKsq4xz/KNYzSDEvAJUz09isR4FXB+OEZDFki5+fhu0jYW
         uoPQ+W75Y4Y3f1kmYhsV0qTYcEdPewkJ6ZZNlCOjvaYBJUwJuq1UKaMzGZ9RVoyXH7
         6Gwvg9wGUucA9xExaSoC3yJ+HUlGEIr/qNG+MpZQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220923220300eucas1p2eb3bb57c4f88c99243fd5c4d9ab7c056~XnG0vhQ2C1572415724eucas1p2j;
        Fri, 23 Sep 2022 22:03:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CE.E8.29727.31D2E236; Fri, 23
        Sep 2022 23:03:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923220258eucas1p1e6f76e8d3c70573da33c03f689d178dc~XnGzCPzgu0224602246eucas1p1R;
        Fri, 23 Sep 2022 22:02:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923220258eusmtrp1b1d643f69e69a7afe34697d8642a1e18~XnGzBjZPk0984109841eusmtrp1l;
        Fri, 23 Sep 2022 22:02:58 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-f7-632e2d139973
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.61.10862.21D2E236; Fri, 23
        Sep 2022 23:02:58 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220923220257eusmtip20810ed8b37d6767b10a55f674b707cfd~XnGyeDHDg3265632656eusmtip2B;
        Fri, 23 Sep 2022 22:02:57 +0000 (GMT)
Message-ID: <7af4b1f0-2757-4016-cb48-5fc5bc9f6bc2@samsung.com>
Date:   Sat, 24 Sep 2022 00:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <cdbe5e4b-b0b1-3539-2a9a-bbf87a4d8e92@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7oiunrJBucqLB7M28ZmcXh+hcX3
        LdeZLOZ9lrXY+3oru8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzmfpnKbPHkYR+bA7fHzll32T0W
        73nJ5LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQD2KC6blNSczLLUIn27BK6MPz/PMxXsZKvY
        smwLWwNjC2sXIyeHhICJxJ6pHUxdjFwcQgIrGCUuTbjGCOF8AXIOv2OBcD4zSvy6/BjI4QBr
        OT7bDCK+nFHi+/1GqI6PjBIdmz+ygxTxCthJPD7uDLKCRUBVon/3fDYQm1dAUOLkzCcsILao
        QLLErGPHGEFsYYFSibkXVzOD2MwC4hK3nsxnArFFBBwlvvxdxA4yn1lgL7PEgf4LYM1sAoYS
        XW+7wIZyAu26vXwdG0SzvMT2t3OYIX7r5pQ49s4YwnaRWHvgARuELSzx6vgWdghbRuL05B6w
        LyUE2hklFvy+zwThTGCUaHh+ixGiylrizrlfbCCfMQtoSqzfpQ8RdpSYvGc+OyRU+CRuvBWE
        uIFPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSMEyC8n7s5B8Mwth7wJGllWM4qml
        xbnpqcWGeanlesWJucWleel6yfm5mxiBaev0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd6Ui7rJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHnZZmglCwmkJ5akZqemFqQWwWSZODilGpjsCmYlOqzZ
        /2taPM+OP8vD/3OJ67GeN/w2Qau9z6o8Kd/+N9uUZM7v9V9MFixYd7HhpFFo6tatEzUiJ9W/
        u7tBhrPEqX7rI8eljwL9jm5cMPVw0BUZDn07s9XuLV/ShZiFFi/7+DXX/6+0S/SFzGdTY/9f
        1luf/ytya0dI1GTtmxO/MK9KnOJYzcscGRnZN8+C87v9zPmecY4sjtX13z8ydJtbHqxb9OpJ
        8YfbG49OsvMT/bz1QDrzBlfBMlOf5t4XSxKrGW5lKNgeXqb4+9s1tVVtUjl87i8XCH7iP1TA
        8VKKZfJjWYm3077OzDWpSvl6uPGuJuOMi8xnMqe+/+y4fGWYs0Pc1+5PBbLfZ09WYinOSDTU
        Yi4qTgQA7phausoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7pCunrJBncXc1s8mLeNzeLw/AqL
        71uuM1nM+yxrsff1VnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZzP0yldniycM+Ngduj52z7rJ7
        LN7zkslj06pONo871/aweWxeUu/Rt2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
        ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX9+nmcq2MlWsWXZFrYGxhbWLkYODgkBE4nj
        s826GLk4hASWMkoc3nKDuYuREyguI3FyWgMrhC0s8edaFxtE0XtGidOHr4I18wrYSTw+7gxS
        wyKgKtG/ez4biM0rIChxcuYTFhBbVCBZYknDfbA5wgKlEnMvrgabzywgLnHryXwmEFtEwFHi
        y99F7CDzmQX2Mkv0PG9nhli2mUlie8czsElsAoYSXW+7wDZwAi2+vXwdG8QkM4murV2MELa8
        xPa3c5gnMArNQnLILCQLZyFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAWN12
        7OeWHYwrX33UO8TIxMF4iFGCg1lJhDflom6yEG9KYmVValF+fFFpTmrxIUZTYGhMZJYSTc4H
        Jou8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmn8DHvG7Npd3G
        5v/vKTPb8uo6XZT/y+5skS29SffSJRHf7Ga7GdEvMvcnG7HL3p8y49W5gjzPXRsels2rYZq3
        Y8/0NXW3nsW8PuRjYazutsIq/mpt/rwe28Un+l81c05MjlxiFLBXO+RzxJWjN+LmvX9QZufi
        XrD9RouSiOjWnrJPnxu5rIJkTW/9vcd9tHHKoa+7TH6FXtgmXiUVOPttZcnGDwYGmYn/cx49
        TRFr3PWwKurNJZ7LDdfmtS3sbdD+XP/fKbal5H75TQ3GGJNrLu0W7ywzt7B+6mmR2HI6d9XC
        q6Lsc37P8Wm74L/+xMyowFv5j7XvGgfJGrKrVmtdtW0RsTJboJg0a/fX9oNKLMUZiYZazEXF
        iQD1RzivXgMAAA==
X-CMS-MailID: 20220923220258eucas1p1e6f76e8d3c70573da33c03f689d178dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923140903eucas1p180002df0deb308d5148cc6004aef7efe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923140903eucas1p180002df0deb308d5148cc6004aef7efe
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
        <20220921094244.606948-11-daniel.lezcano@linaro.org>
        <CGME20220923140903eucas1p180002df0deb308d5148cc6004aef7efe@eucas1p1.samsung.com>
        <bc3a5137-b2be-0bfe-003a-db201a7a50e8@samsung.com>
        <cdbe5e4b-b0b1-3539-2a9a-bbf87a4d8e92@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 23.09.2022 19:40, Daniel Lezcano wrote:
>
> Hi Marek,
>
> thanks for reporting
>
> On 23/09/2022 16:09, Marek Szyprowski wrote:
>
> [ ... ]
>
>> Exception stack(0xf082dfb0 to 0xf082dff8)
>>
>> [deadlock]
>>
>> Something is wrong in locking in the functions from the above 
>> stacktrace.
>
> Are you sure this deadlock is coming from this patch? Does a revert of 
> this patch solve the issue ?
>
Ups, my fault. It looks that I've copied SHA from the wrong window while 
preparing the report. The bisection pointed to the 78ffa3e58d93 
("thermal/core: Add a generic thermal_zone_get_trip() function") commit 
and I've already found how to fix the deadlock. I will report it again 
under the proper patch.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

