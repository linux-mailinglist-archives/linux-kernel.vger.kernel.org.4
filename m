Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF067B09C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjAYLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjAYLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:07:48 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7545F9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:07:43 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230125110740euoutp02e22236615322361f86eba32272f5a245~9iKDYTcRE0327703277euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:07:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230125110740euoutp02e22236615322361f86eba32272f5a245~9iKDYTcRE0327703277euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674644860;
        bh=2vjwEEq/5VMAJjTlv+k62l8D/m6KmWeNwADE5qcfrho=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=afkp2lIQzvQFR+Use247V92uKxbe0RSUexvw5cQbuSmM/h5TsDB6AX0MRdIvD/nBR
         GYHkAkQqV6b8M7Zy+WKU40KR/UstSk9cElLXJL1iK/GbVDHnYChYrrp66HYnoM/PjD
         81uxup8b/ryEs7HYTPZ7CTrhe/tRXmDEJfOUEYl0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230125110740eucas1p104eeeba1adc159e386379d30cedde9c9~9iKDGnr_G1707317073eucas1p1e;
        Wed, 25 Jan 2023 11:07:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4E.7B.13597.C7D01D36; Wed, 25
        Jan 2023 11:07:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230125110740eucas1p2e041fc9495bd3298f88f26bd5740671f~9iKCqwGEh1227312273eucas1p2B;
        Wed, 25 Jan 2023 11:07:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230125110740eusmtrp15fec67e039b28a883d173a1ff69a9019~9iKCp-lG90031400314eusmtrp1N;
        Wed, 25 Jan 2023 11:07:40 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-f7-63d10d7c7127
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.D4.02722.B7D01D36; Wed, 25
        Jan 2023 11:07:40 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230125110739eusmtip252e6f111cc6d8e9eefcde1b3600946d7~9iKCgzXD50416004160eusmtip2q;
        Wed, 25 Jan 2023 11:07:39 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 25 Jan 2023 11:07:39 +0000
Date:   Wed, 25 Jan 2023 12:07:38 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <darren@os.amperecomputing.com>,
        <catalin.marinas@arm.com>, <ndesaulniers@google.com>,
        <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: docs: embargoed-hardware-issues: add embargoed HW contact for
 Samsung
Message-ID: <20230125110738.usal6uqtns65gw7r@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y89myzKiwJEeRNiW@kroah.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87o1vBeTDY7dlLN4v6yH0eLJgXZG
        i6UvNjNZrL65htGiefF6NouFbUtYLC7vmsNmcWPCU0aLDxP+MzlweqyZt4bRY8GmUo9NqzrZ
        PPbPXcPusbhvMqtH9+Ub7B5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJXRtTG94DdLRefix+wN
        jB0sXYycHBICJhJvu16xdzFycQgJrGCUmDtnDROE84VRYkPTKWYI5zOjxPVN35hgWr6tucEC
        kVjOKDF/3Tl2uKoF7e+gnC2MEhun3GYDaWERUJX4NG0LO4jNJmAvcWnZLWYQW0RAQ+Ll0Vtg
        o5gFTjFJbP7yhBUkISwQIvFv832wE3kFbCX+Na5kgrAFJU7OfAIWZxawkuj80ARUzwFkS0ss
        /8cBEZaXaN46G2w+p4CmxKxfx1khzlaSePziLSOEXStxasstsEclBCZzSnycuRYq4SLRN7cf
        6k9hiVfHIY6WEJCROD25Bxpk2RIXz3QzQ9glEovfH2MGuUFCwFqi70wORNhRYtXJU1BhPokb
        bwUhTuOTmLRtOlSYV6KjTWgCo8osJH/NQvLXLIS/ZiH5awEjyypG8dTS4tz01GKjvNRyveLE
        3OLSvHS95PzcTYzAhHX63/EvOxiXv/qod4iRiYPxEKMEB7OSCG/P7PPJQrwpiZVVqUX58UWl
        OanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGpj080qi06LWf7gXucxFPSR/2uEF
        dRZPd0RruCfZr+Gt6F3/8ZHJVHaXb0z8M70LxdyacyJnhTddy24p1zJ+FqGV+vl8jLLj0fjD
        xU2rN+1l/VSZUBfoHPL/06/t74Ivz3D79HTD7qCEqTcrZQ6aG5Wu8fv6bcZHy7v6+/XPsO3Y
        fef8isoZu5jY/25PLd/f23XXls9nwVFrm5fPJ+1Kyv6a/VGNpad5lvHitbpu76extOxoSk/q
        DpfamdM72740WEymLXx7lNjv7qdh/2732vZvY+rlPejrrlLxWeB9TZ+g0tGMrGxnyXohlh+G
        3O6XJ6//q/G/X4Fb5E/0U6crwhO0rznIOf90TO81WvFhkRJLcUaioRZzUXEiAE0iPDLHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7o1vBeTDc4uZ7J4v6yH0eLJgXZG
        i6UvNjNZrL65htGiefF6NouFbUtYLC7vmsNmcWPCU0aLDxP+MzlweqyZt4bRY8GmUo9NqzrZ
        PPbPXcPusbhvMqtH9+Ub7B5TZ9d7fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
        Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRtTG94DdLRefix+wNjB0sXYycHBICJhLf1twAs4UE
        ljJK9E6OhIjLSHy68pEdwhaW+HOti62LkQuo5iOjRMOdBqiGLYwSW/bYg9gsAqoSn6ZtAWtg
        E7CXuLTsFjOILSKgIfHy6C0WkGZmgRNMEu97/zKBJIQFQiT+bb4PNohXwFbiX+NKJogNqxgl
        tjVcYYdICEqcnPkErIhZwEJi5vzzjF2MHEC2tMTyfxwQYXmJ5q2zwZZxCmhKzPp1nBXiaiWJ
        xy/eMkLYtRKf/z5jnMAoMgvJ1FlIps5CmDoLydQFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
        czcxAuN527Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHentnnk4V4UxIrq1KL8uOLSnNSiw8xmgLD
        aCKzlGhyPjCh5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MLm7
        HH8iyf/pcd99xh0zRZefaYnudbvdyvjF0T/tscQ0xlXftifmfn6RdiDF1ew83+2JDJ1bJsga
        rkg8znpo1bpTLrMbzN6/ebK4TNXx+6E3x+c/udt4JKniU+i1sy3nz8i/6Ns0Q2qasUC7r1dO
        9c2YWYUvfzIz2KkH7wtu2M6meDuk/fvrlIPJLzintVReZFItVk4+7nQsbPH6a2Jct+d2Gxtl
        5fwtOMPw64Lchbry/+t/vL2pZ+Es8yVlZcJ2txn9kVOTLHl4m2Ynr4g9M2Vds0faaz/W7Gdr
        ZY2rZoe0L7Q99cZoXaYxy8cjUur5ctueznbk/3iouP2+lhvTUQ//7Co1w2723zLtzk7NN5VY
        ijMSDbWYi4oTAVrriVlwAwAA
X-CMS-MailID: 20230125110740eucas1p2e041fc9495bd3298f88f26bd5740671f
X-Msg-Generator: CA
X-RootMTR: 20230124050419eucas1p2a2d25b233dfcbe600b846e324bc07460
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230124050419eucas1p2a2d25b233dfcbe600b846e324bc07460
References: <20230123215255.381312-1-mcgrof@kernel.org>
        <CGME20230124050419eucas1p2a2d25b233dfcbe600b846e324bc07460@eucas1p2.samsung.com>
        <Y89myzKiwJEeRNiW@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2023 06:04, Greg KH wrote:
>On Mon, Jan 23, 2023 at 01:52:55PM -0800, Luis Chamberlain wrote:
>> After discussions internally at the company, Javier has been volunteered
>> and is willing to be the embargoed hardware contact for Samsung.
>
>If I didn't know better, that sounds like you are signing someone else
>up for something :(
>
>> Cc: Javier González <javier.gonz@samsung.com>
>
>I would need an ack from Javier here, and will discuss this with them
>off-list as to the responsibilities here to ensure that you all know
>what this actually entails.

Acked-by: Javier González <javier.gonz@samsung.com>
