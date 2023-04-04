Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8089C6D5CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDDKQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjDDKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:16:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89942139
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:16:10 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230404101607epoutp031712c8252f0100eb474301b62786666a~Ss9u9pd6o0245302453epoutp03R
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:16:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230404101607epoutp031712c8252f0100eb474301b62786666a~Ss9u9pd6o0245302453epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680603367;
        bh=/bvlJFcbHikkAZJy8AuiH8tizlWPs95xz6I7mjrIfM8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=BcEJlHU+YewGNNfvQxHQSqItI7oEjKbI+snR2E0G0op+eSaKM4FKkxfaNd8ucxU/n
         ckgGFkPqcQJuFMMnQ8X+5wbEuOI0omq5wxO8/a+N6Mri52ypojpNBHIPtXy1+EC1jt
         zr+0flGT2/03vN7wLsNIICCgr25qiXpOOfjqDrC0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230404101606epcas1p4af5476c2bb70ec4dc8ad0f93f8635961~Ss9unB2Wu0123101231epcas1p44;
        Tue,  4 Apr 2023 10:16:06 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PrNvV4B98z4x9Px; Tue,  4 Apr
        2023 10:16:06 +0000 (GMT)
X-AuditID: b6c32a35-d9fff7000000d8eb-42-642bf8e69bdc
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.15.55531.6E8FB246; Tue,  4 Apr 2023 19:16:06 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RFC] vsprintf: compile error on %09pK
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jaewon Kim <jaewon31.kim@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230403153458.GE12892@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230404101606epcms1p531389fe1e59013e6dd6e5abebe1fc226@epcms1p5>
Date:   Tue, 04 Apr 2023 19:16:06 +0900
X-CMS-MailID: 20230404101606epcms1p531389fe1e59013e6dd6e5abebe1fc226
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmnu6zH9opBqsuy1m8PKRpseX3G0aL
        7s0zGS16379isri8aw6bxb01/1kt/j/+ymqxe+MiNgcOj9kNF1k8ds66y+6x6dMkdo++LasY
        PdZvucri8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCswK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjB3vljAWPGatOH6th6mBcStLFyMnh4SAicTyLV/Zuhi5OIQEdjBKbDk4
        kbWLkYODV0BQ4u8OYZAaYQFjiRWHzzOD2EICShJnf1xhh4jrSjR1rwabwyagLfF+wSRWEFtE
        IEJi3Z2PrCAzmQUeMEr87XkItYxXYkb7UyhbWmL78q2MIDangIHE921XoeKiEjdXv2WHsd8f
        m88IYYtItN47ywxhC0o8+LmbEWbOn+PP2SDsYollnQ+YIOwaiRXnVkHFzSUa3q4Es3kFfCVm
        zzoFZrMIqEocWPEWqt5F4v7xhWA2s4C8xPa3c5hB4cAsoCmxfpc+RImixM7fcxlhXmnY+Jsd
        nc0swCfx7msPK0x8x7wnUOPVJFqefYWKy0j8/feMdQKj0ixESM9CsngWwuIFjMyrGMVSC4pz
        01OLDQsM4ZGbnJ+7iRGcNLVMdzBOfPtB7xAjEwfjIUYJDmYlEV7VLq0UId6UxMqq1KL8+KLS
        nNTiQ4ymQC9PZJYSTc4Hpu28knhDE0sDEzMjEwtjS2MzJXHeL0+1U4QE0hNLUrNTUwtSi2D6
        mDg4pRqYbn05mJ8Xd8Fu65PmSJMJqbPYeAz5/is6pMfXXNYPzUlccUhQTlO1OfPyyZ/zlD15
        vVMmXQ62MZrrqzfxXU3dr4Qkth9ss5iPcntXX/t9c9kUV7fq5fqBOpNlfx7b/r9rxxwP3heJ
        C+y+5/xb778yIOv5953SG1+XK8pJR3DmRR9edXl2+9KzCa0LmTqb+l4t0FP1iTnWvf2eQrAk
        r8odpytqOSeeuzzIdnln4r2CSUL7wXrbS4d51s30fsL3/ZNOuj2j4k3pGQ/M1CXOqy68tWXZ
        q7rpZk98Vvurct63E53z/qLA1Z7XNXtq3k6fNCFY7W2Q4CUjm+AnmSz+BtNnBCfuEmCf/JXp
        yLIodRVeJZbijERDLeai4kQAP/c0+iMEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42
References: <20230403153458.GE12892@google.com>
        <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
        <ZCrMMQt2xnnZIyz6@alley>
        <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
        <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p5>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>[..]
>> 
>> Okay, then we can't use %09pK. I've just wondered because %9pK works.
>
>This is not per printk / kernel, Wformat warnings come from the
>compiler.
>
>Per C11 (7.21.6 6):
> 0  For d, i, o, u, x, X, a, A, e, E, f, F, g, and G conversions, leading zeros
>    (following any indication of sign or base) are used to pad to the field width
>    rather than performing space padding
>    ...
>    For other conversions, the behavior is undefined.
>
>So using 0 for p should trigger an undefined behavior as far as the
>standard C concerned. Unless I'm missing something.

Thank your for the information about the leading 0 case. By the way do you know
if there is policy for none 0 digit like %9pK?

Jaewon Kim
