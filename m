Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3970E229
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjEWQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjEWQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:33:08 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153AB13E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:32:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523163254euoutp020dba507706f7b311190036ad941cf927~h0tse0NSq2729427294euoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:32:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523163254euoutp020dba507706f7b311190036ad941cf927~h0tse0NSq2729427294euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684859574;
        bh=6ly9wIL9GCnm3HKaNYcOLEDpYNmzAKCxkqchFnnDXMU=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=VphoBJOzcgVObfyJB957A8g8l5hIGtiA6KFuR5BUyC59GYm5F09dJ88Lbrtiq88Pq
         g0wyWWF9k2RjsHdIMujgspYCc8Xz//U/gFIqEag3y93VcGfzcIACGAPWx/GEOqGHJo
         pSVCTuIffc6jZMIN/0MSGG08VVVZBLYtoG9Ug8f0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230523163253eucas1p2c5177a1e7e93fe3d9fa87ee0fafc02a0~h0tsG0Z8V2905229052eucas1p2r;
        Tue, 23 May 2023 16:32:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D0.1C.42423.5BAEC646; Tue, 23
        May 2023 17:32:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523163253eucas1p1b0d2f9d80f322d73ab8e41f9e47e4ac8~h0trmMojV2723827238eucas1p17;
        Tue, 23 May 2023 16:32:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230523163253eusmtrp15f0e63a4a12cc61ec30b5ac77af49cd6~h0trleCw13139931399eusmtrp1F;
        Tue, 23 May 2023 16:32:53 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-0f-646ceab5b15c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.A5.10549.5BAEC646; Tue, 23
        May 2023 17:32:53 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523163252eusmtip136f83238e5596f3273d034aaa1a4a744~h0tq5Bcdx0414504145eusmtip1L;
        Tue, 23 May 2023 16:32:52 +0000 (GMT)
Message-ID: <6040ad05-2894-6302-20db-0b0ff3fb0f0c@samsung.com>
Date:   Tue, 23 May 2023 18:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl,
        Pengutronix Kernel Team <kernel@pengutronix.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230523145430.GB9943@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87pbX+WkGNz6qmmx5cpsZovWV8/Z
        LTa++MxicXHmXRaLzed6WC1WTd3JYnF51xw2i54NW1ktPj34z2yxbcU5Votlm/4wWez6co/N
        4u69EywWG992sDvweZz4f4TFY8fdJYwem1Z1snlsXlLv8WLzTEaP/r8GHl1HrrN5fN4k53Hq
        62f2AM4oLpuU1JzMstQifbsEroyXmw4wFRwXrZh0lL+BcYtgFyMnh4SAicTXR4uYuhi5OIQE
        VjBKrDnZB+V8YZRovf2MHcL5zCjxv6ObBaal5fccZojEckaJv7vns0I4Hxkl/qycD1bFK2An
        sW7XV0YQm0VAVWLN/T9MEHFBiZMzn4DViAqkSqzafJEZxBYW8JJYNm0LO4jNLCAucevJfLA7
        RARWs0hM3HkErIFNwFCi620XG4jNKWAsMefeZSaIBnmJ5q2zwU6SEJjPKXFywj1miFtdJKbu
        WswKYQtLvDoOsUFCQEbi9OQeFoiGdkaJBb/vM0E4ExglGp7fYoSospa4c+4X0DoOoBWaEut3
        6UOEHSXuP5nIDhKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUtQp3lIbL79
        mHkCo+IspHCZheT/WUhem4VwwwJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBCe/0
        v+OfdjDOffVR7xAjEwfjIUYJDmYlEd4T5dkpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8m
        CwmkJ5akZqemFqQWwWSZODilGpga9vyR+LpMIvDOO8ZDcpGuFWzPEzeWSjAs7HW2UPtt7Wo3
        KfHJthtfpn1L5HcWPGvG/VnhSNbFc/Hv0uUK7bgFjr2YoVBYaM6dfjQ46GTPom2hk29NXlDt
        fHbH/4vxJVq+1myOVfwM/zc8MXowU6kuM3Vefc2DCcunB3U73jWTa/BUs5BeobHS8qn+E5Y4
        u8Wxe4t38hZs4dnRcdVB2MIh4EBI1Kv0O6z1fL84bNYWt9eLRLZUGC969JuXXeWRycOP+3w6
        a8KFe8/0/P/oee+SxovS1axTWKLlV746aeP82pk74UOff9OpLxMeHZhzemK2n/SmVUc4d2//
        8vxDy/cz31U3vDXVvnHj17T+y4eUWIozEg21mIuKEwHKujr25wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7pbX+WkGKw4zmax5cpsZovWV8/Z
        LTa++MxicXHmXRaLzed6WC1WTd3JYnF51xw2i54NW1ktPj34z2yxbcU5Votlm/4wWez6co/N
        4u69EywWG992sDvweZz4f4TFY8fdJYwem1Z1snlsXlLv8WLzTEaP/r8GHl1HrrN5fN4k53Hq
        62f2AM4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYyXmw4wFRwXrZh0lL+BcYtgFyMnh4SAiUTL7znMXYxcHEICSxklFn9bzQiRkJE4Oa2BFcIW
        lvhzrYsNoug9o8TG+UvYQRK8AnYS63Z9BWtgEVCVWHP/DxNEXFDi5MwnLCC2qECqxMmlN8Bs
        YQEviWXTtoD1MguIS9x6Mp8JZKiIwFoWibvX1rBDbHjLJNG6ZC1YB5uAoUTXW5DVnBycAsYS
        c+5dZoLoNpPo2trFCGHLSzRvnc08gVFwFpLls5AsmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoT
        c4tL89L1kvNzNzECI3nbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd4T5dkpQrwpiZVVqUX58UWl
        OanFhxhNgSEwkVlKNDkfmErySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6
        mDg4pRqYEnbHcEhu/x59/Yz9N/Ge1L7kLYtudqc/uMszSyojK0eKk3dfJK9X0tpJ8w7Eddoe
        1N284ud8wdPPeaaZpjB/nm/3L6PAMETt+nGD01Xu9y4IOa7kmNoRMHdbE++K7JepQR73TkS+
        usF3pGE+99LiuWueRmxqmFS40cyOreLbtxUzGHr1LtvlBrjwrFEWjlp9aVn6N7PbRyYur12Z
        9q6myLZpd9jS3o2GX5y5zvzSdJo680LNQesw71T1H2kMcWdux7dbME5aeSRKfudDBW7O3tOs
        Rw5MTr+943Z5+5Pq0vPq8uKm87f+Mvy0+/fSY5tq5pw9u3mV+aFvvmpPOQo5PyjyL68y3jpZ
        UbO9qrOLTYmlOCPRUIu5qDgRAPks+idtAwAA
X-CMS-MailID: 20230523163253eucas1p1b0d2f9d80f322d73ab8e41f9e47e4ac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230523145444eucas1p2fd56ca86c1c68abc89deec532a3588fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523145444eucas1p2fd56ca86c1c68abc89deec532a3588fb
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
        <4995215.LvFx2qVVIh@bagend>
        <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
        <12724349.O9o76ZdvQC@bagend>
        <5d871928-dcd5-3f27-e975-d1639525dad0@leemhuis.info>
        <CGME20230523145444eucas1p2fd56ca86c1c68abc89deec532a3588fb@eucas1p2.samsung.com>
        <20230523145430.GB9943@pengutronix.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2023 16:54, Michael Tretter wrote:
> On Tue, 23 May 2023 12:50:42 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> CCing the Regression list and a bunch of other people that were CCed in
>> threads that look related:
> Thanks!
>
>> On 23.05.23 00:38, Diederik de Haas wrote:
>>> On Monday, 22 May 2023 18:17:39 CEST Benjamin Gaignard wrote:
>>>> Le 20/05/2023 à 00:34, Diederik de Haas a écrit :
>>>>> On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
>>> [...]
>>>>> When I booted into my 6.4-rc1 (but also rc2) kernel on my
>>>>> Pine64 Quartz64 Model A, I noticed a crash which seems the same as
>>>>> above, but I didn't have such a crash with my 6.3 kernel.
>>>>> Searching for 'hantro' led me to this commit as the most likely culprit
>>>>> but when I build a new 6.4-rcX kernel with this commit reverted,
>>>>> I still had this crash.
>>>>> Do you have suggestions which commit would then be the likely culprit?
>>>> This patch fix the crash at boot time, revert it doesn't seem to be the
>>>> solution. Maybe this proposal from Marek can help you ?
>>>>
>>>> https://patchwork.kernel.org/project/linux-media/patch/20230421104759.2236463-1-m.szyprowski@samsung.com/
>>> That helped :) After applying that patch I no longer have the crash.
>>> Thanks!
>> That regression fix is now a month old, but not yet merged afaics --
>> guess due to Nicolas comment that wasn't addressed yet and likely
>> requires a updated patch.
> I agree with Nicolas comment on that patch and it needs to be updated.
>
>> Michael afaics a week ago posted a patch that to my *very limited
>> understanding of things* (I hope I don't confuse matters here!) seems to
>> address the same problem, but slightly differently:
>> https://lore.kernel.org/all/20230516091209.3098262-1-m.tretter@pengutronix.de/
> Correct, my patch addresses the same problem.
>
>> No reply yet.
>>
>> That's all a bit unfortunate, as it's not how regression fixes should be
>> dealt with -- and caused multiple people headaches that could have been
>> avoided. :-/
>>
>> But well, things happen. But it leads to the question:
>>
>> How can we finally address the issue quickly now to ensure is doesn't
>> cause headaches for even more people?
>>
>> Marek, Michael, could you work on a patch together that we then get
>> somewhat fast-tracked to Linus to avoid him getting even more unhappy
>> about the state of things[1]?
> Marek, if you have an updated patch, I will happily test and review it.
> Otherwise, please take a look at my patch.

Go ahead with your, my was just a blind try eliminating the oops during 
driver probe.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

