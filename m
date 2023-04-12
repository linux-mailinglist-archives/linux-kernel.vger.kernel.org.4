Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD226DFC58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDLRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:12:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF34E76
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:12:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230412165334euoutp022969579b75bcdfd547ae22124a9c034e~VPjCoPdBe2181021810euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230412165334euoutp022969579b75bcdfd547ae22124a9c034e~VPjCoPdBe2181021810euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681318414;
        bh=wZO6Dqp5dPJCNRWb5bvNZmABWpcQ9lZ9Lbxzm7Lw6Mg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=C30NP/i6B4LSCFFElxa+dbjEeCx+ulslG4eLWi9JLlJ512e9VrLvLxt/wC2IBKkvR
         6FXdbDk1IZ9gNhnNqLWxO405Ah+PTSqAJ+QiTpWpqbnYOsUUpj42ZdtoY64am4CgTA
         sqleo+koxJGBXWjcNcCQvC/8cIWD7KjSqS886iMQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230412165334eucas1p2774826fb6fff814016a2b94defb89e2a~VPjCQVe5w1111611116eucas1p2w;
        Wed, 12 Apr 2023 16:53:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.2D.09966.E02E6346; Wed, 12
        Apr 2023 17:53:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230412165333eucas1p2109ca0d5e10efd132a04bbbe1b5c3d94~VPjB7uv-B1360113601eucas1p2E;
        Wed, 12 Apr 2023 16:53:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412165333eusmtrp2aca1d1ee844ff8e9932214de51f21860~VPjB7DZCG0393003930eusmtrp2O;
        Wed, 12 Apr 2023 16:53:33 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-23-6436e20e22f4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.0E.22108.D02E6346; Wed, 12
        Apr 2023 17:53:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230412165332eusmtip20d390bf7742454c6e312aefbc76f6966~VPjBDW_Wq0161001610eusmtip2e;
        Wed, 12 Apr 2023 16:53:32 +0000 (GMT)
Message-ID: <69a90fd7-e76a-4257-8263-57d333b60dad@samsung.com>
Date:   Wed, 12 Apr 2023 18:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        robert.mader@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <a0a00172-ce86-dfa2-267d-b318a9c076dc@collabora.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87p8j8xSDCZeZLfYcmU2s8XGF59Z
        LB5e9be4OPMui8Xmcz2sFqum7mSx2PT4GqtF16+VzBaXd81hs+jZsJXV4tOD/8wWyzb9YbLo
        XDGRzeLuvRMsFt/eLGa0+Lt9E4vFiy3iDoIef59fZ/HYcXcJo8fOWXfZPTat6mTz2Lyk3mPj
        ux1MHv1/DTy6jlxn8/i8Sc7j1NfP7AFcUVw2Kak5mWWpRfp2CVwZhxo+shb85quY+HIfWwPj
        ep4uRk4OCQETiV8df5m7GLk4hARWMEq8ut/GApIQEvjCKLHzRA1E4jOjxOIF+xhhOr7cPArV
        sZxRYuXWqWwQzkdGic7WbvYuRg4OXgE7iTu7IkFMFgFViXWXa0B6eQUEJU7OfAK2QFQgRWL3
        yafsILawQLrE/kPdTCA2s4C4xK0n85lARooInGWS6Lt/kAXEYRZYyCjxvGkDM0gVm4ChRNfb
        LjYQm1PAUeLV7KUsEN3yEs1bZ4NdJyFwiVPi/uZVUGe7SKz9+IwNwhaWeHV8CzuELSPxfyfE
        OgmBdkaJBb/vQzkTGCUant+C6raWuHPuFxvIP8wCmhLrd+lDhB0lvn1eCxaWEOCTuPFWEOII
        PolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiEFzCykAJiF5J1ZCHsXMLKsYhRPLS3O
        TU8tNspLLdcrTswtLs1L10vOz93ECEyJp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nw/nAxTRHi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXAtKQlPJZFv3bV
        PLbI1u3/e9xiVy0SeqIcVD3fYvPEPOtbip/9OnM+T5+210cr8xzPnl+sykHTsor+rUxJzDrf
        Wfp7TvJ2tnfajmXnQzYccV5irc/P98/k/+r6P+dc5PRE/r1Q/Gqy8vaMBdKuyxYWzJLmdKqK
        +qQoZrhl0zRGXa7Dq7qu/fHev4/jgMPmi7M1QpwuHTnbFCxh+Tg4oPrUmeNVWkGz+dkWPuLq
        eGr+VflRzpJVPNaMv5lnKxSvkV4gstBCgWPZFdHLP47uaKxUeH84g/uYcMvNOY7S2a/+vln6
        bYrFvL/115eIpK3x9t9+Xfymhu4iK6tMfWa1rOudN6wNM/ZM27RV5Zpdvf2Dl0osxRmJhlrM
        RcWJAAYppgf4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7q8j8xSDNa+0bbYcmU2s8XGF59Z
        LB5e9be4OPMui8Xmcz2sFqum7mSx2PT4GqtF16+VzBaXd81hs+jZsJXV4tOD/8wWyzb9YbLo
        XDGRzeLuvRMsFt/eLGa0+Lt9E4vFiy3iDoIef59fZ/HYcXcJo8fOWXfZPTat6mTz2Lyk3mPj
        ux1MHv1/DTy6jlxn8/i8Sc7j1NfP7AFcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
        5rFWRqZK+nY2Kak5mWWpRfp2CXoZhxo+shb85quY+HIfWwPjep4uRk4OCQETiS83jzKD2EIC
        Sxkltqwqg4jLSJyc1sAKYQtL/LnWxdbFyAVU855RYu6TqyxdjBwcvAJ2End2RYKYLAKqEusu
        14CU8woISpyc+YQFxBYVSJHYNWEpE4gtLJAusf9QN5jNLCAucevJfCaQkSICZ5kk9s8/zA7i
        MAssZJT4ufwrK8Syg0wS/y70gF3BJmAo0fUW5ApODk4BR4lXs5eyQIwyk+ja2sUIYctLNG+d
        zTyBUWgWkktmIdk4C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSmgG3Hfm7e
        wTjv1Ue9Q4xMHIyHGCU4mJVEeH+4mKYI8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5HxgEsor
        iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamA6fGaGIJPS2lkM36LW
        2N6IlGjXbih/cu/BkZmzT0dnMjj/M+VfEjjx6NZbx068Cz+qJli7mc363kKH2z0HT+lzs585
        +murco29kOjrxzW3YlpF5p7i/N9pc/7xxmL5RqPgw5kO2w7O6cnJzFsV1N9vOnf5hYnSt29+
        O/HqxX7zp1IcBrtKHt4I0ot8fLnB+Yd6cmRF1624Ex5rDoXazCsMuNB2skta4WxS3YIb+jzs
        zt+zRdM0NwZ+uut3STH54dNDEu1bmt/qCM+qCP8n9tizITvgHZvHm7yXhyuWbk8/LBnZmygt
        zyvM6puy1t9h0n7z2TKLvpuyGPzqmpk4t/oc59+jstvcTQonlAlVfuRUYinOSDTUYi4qTgQA
        dnKUTIoDAAA=
X-CMS-MailID: 20230412165333eucas1p2109ca0d5e10efd132a04bbbe1b5c3d94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-2-benjamin.gaignard@collabora.com>
        <CGME20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9@eucas1p1.samsung.com>
        <5fda9b2f-a339-8a23-dc7b-f1bac2c385b6@samsung.com>
        <a0a00172-ce86-dfa2-267d-b318a9c076dc@collabora.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.04.2023 18:40, Benjamin Gaignard wrote:
>
> Le 12/04/2023 à 18:14, Marek Szyprowski a écrit :
>> Hi,
>>
>> On 20.02.2023 11:48, Benjamin Gaignard wrote:
>>> Setting context source and destination formats should only be done
>>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>>> the targeted queue is not busy.
>>> Remove these calls from hantro_reset_encoded_fmt() and
>>> hantro_reset_raw_fmt() to clean the driver.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> This patch landed recently in linux-next as commit db6f68b51e5c ("media:
>> verisilicon: Do not set context src/dst formats in reset functions").
>
> Hi,
>
> I do not have this board up and running with Hantro encoder but
> I think the attached patch may solve the issue.
> Could you tell me if it works ?

Yep, it fixes the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


It looks that the code could be a bit more cleaned up, as with the 
attached patch, there is such construction:

         if (coded) {
                 pix_mp->num_planes = 1;
                 vpu_fmt = fmt;
         } else if (ctx->is_encoder) {
                 vpu_fmt = fmt;
         } else {
                 vpu_fmt = fmt;
                 /*
                  * Width/height on the CAPTURE end of a decoder are 
ignored and
                  * replaced by the OUTPUT ones.
                  */
                 pix_mp->width = ctx->src_fmt.width;
                 pix_mp->height = ctx->src_fmt.height;
         }

Common 'vpu_fmt = fmt' can be moved out of the above if-else block.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

