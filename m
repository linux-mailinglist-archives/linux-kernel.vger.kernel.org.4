Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED36ABF45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCFMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCFMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:15:00 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD52241F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:14:28 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230306121425epoutp0382b0a7b1b408c9902a69a1196ec4c5d8~J03wOwizD1094710947epoutp03L
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:14:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230306121425epoutp0382b0a7b1b408c9902a69a1196ec4c5d8~J03wOwizD1094710947epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678104865;
        bh=uPAl6WOWJ+QSTldSO2+dAyX9ee/3fr2LwvxJT3RPSa0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tgg4ZdIdO59Bc+yh59xhVfcQclTgPGXxlQnqFb9LOS7/mPbBWNbr8+F6WsXVgzIJI
         vLNq28MDgad4/43ObwAYQtppAgYKJ3c1FIDxa+7fUoUjzzYO/1cnjIqBcdtLwRUqml
         2tUO7tL2Ih0uqcfkJwkzVclBL4toXrfy/VvIC8OQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230306121425epcas1p28f86956a021c78ee0728488922b38aff~J03vi9yQ-0187701877epcas1p2P;
        Mon,  6 Mar 2023 12:14:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.248]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PVcvN41Byz4x9Q8; Mon,  6 Mar
        2023 12:14:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.8C.12562.029D5046; Mon,  6 Mar 2023 21:14:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230306121424epcas1p4d8b8d4b98f3ef61a9bbf7c723a452c72~J03uhQCil2800228002epcas1p4r;
        Mon,  6 Mar 2023 12:14:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230306121424epsmtrp1df9b66e736a142228ef9976201c65174~J03ugfDeA2693926939epsmtrp1C;
        Mon,  6 Mar 2023 12:14:24 +0000 (GMT)
X-AuditID: b6c32a36-e59fa70000023112-30-6405d920a3a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.85.31821.F19D5046; Mon,  6 Mar 2023 21:14:24 +0900 (KST)
Received: from js07lee02 (unknown [10.175.110.233]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230306121423epsmtip13736935143ee2424242b339f78863c49~J03uUir270798107981epsmtip1a;
        Mon,  6 Mar 2023 12:14:23 +0000 (GMT)
From:   "Jungseung Lee" <js07.lee@samsung.com>
To:     "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc:     <linus.walleij@linaro.org>, <amit.kachhap@arm.com>,
        <ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <js07.lee@gmail.com>
In-Reply-To: <ZAXKHDb4QY1awyRA@shell.armlinux.org.uk>
Subject: RE: [PATCH 2/2] arm/mm : Report actual image regions in /proc/iomem
Date:   Mon, 6 Mar 2023 21:14:23 +0900
Message-ID: <076401d95025$305fb150$911f13f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIF31RLkCDN3LUTPBYQD4C7TMInfgIsEUnhAdUtgl8BYfP19K5pcRkQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmga7CTdYUg2e7ZS2mfNjBavHzy3tG
        i79z3jFZnOnOtZjyZzmTxabH11gtLu+aw2ZxaOpeRgcOjzXz1jB6XL52kdljdsNFFo+ds+6y
        e2xa1cnmcefaHjaPzUvqPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFag
        V5yYW1yal66Xl1piZWhgYGQKVJiQnfHv8Qy2gpd8FbNaZjI1MPbxdDFyckgImEhcnbWIrYuR
        i0NIYAejRNP+RYwQzidGiSdNXcwQzmdGiXt/TrHAtEw9eIAJIrGLUeLQ76vsEM4LRok/S74x
        g1SxCehIbDqwAaxDRMBcYmrnEVaQImaBI4wSez9BJDgFTCX2/pzGBmILC/hIPLhwECzOIqAi
        8f3AYkYQm1fAUuLejD9MELagxMmZT8BqmAXkJba/ncMMcZKCxM+ny1ghlrlJrG9byw5RIyIx
        u7MN7AcJgR0cEjfubof6wUWi9cd0dghbWOLV8S1QtpTEy/42KLtcYkPfNCaI5hZGiUXb37JB
        JIwl3r1dCzSVA2iDpsT6XfoQYUWJnb/nMkIs5pN497WHFaREQoBXoqNNCKJESeLNgxaoEyQk
        LjzuZZ3AqDQLyWuzkLw2C8kLsxCWLWBkWcUollpQnJueWmxYYASP7+T83E2M4GSrZbaDcdLb
        D3qHGJk4GA8xSnAwK4nw8pSypAjxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGC6zyuJNzSx
        NDAxMzKxMLY0NlMS5xW3PZksJJCeWJKanZpakFoE08fEwSnVwJRuVzb37Oy9HlIPT6ms9mm+
        qdJzkk86q+qpmI7ldrPOhP3nPuzaFahg+ueEfQf/G/3TOd9ac0/P+bHh07nGR78ezznVfNX5
        dN6Hh84CE74YPo/os+zkk2mqzlXZ++hrtMTMbxfEDZeFLFvim3fPLmY6b+V63aU8F3p2fX9f
        0NAyaX5cfNEtJeWSGec8hU2KuTMUq81djKPWncl86WmzorxQPkX0vvCnrn5r/wPGr/jY1unn
        uTbYPF2RvvZ5l+/3jB2HLj89sP6vxVzrW8tzOMX5QraUGgarXHvlEatVkfPi8c+1/25t8LL5
        UBYZYLWwYZm35VoX4bCMGFV29Rv2R31fbXp23D40OP00n9qUD0osxRmJhlrMRcWJAPsaaa0/
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnK7CTdYUgwt9jBZTPuxgtfj55T2j
        xd8575gsznTnWkz5s5zJYtPja6wWl3fNYbM4NHUvowOHx5p5axg9Ll+7yOwxu+Eii8fOWXfZ
        PTat6mTzuHNtD5vH5iX1Hp83yQVwRHHZpKTmZJalFunbJXBl/Hs8g63gJV/FrJaZTA2MfTxd
        jJwcEgImElMPHmDqYuTiEBLYwSjxf+1bVoiEhMSjnV9Yuhg5gGxhicOHiyFqnjFKdJ66xgRS
        wyagI7HpwAYWEFtEwFxiaucRVpAiZoEzjBIT+k9CTf3BKPFl6yWwqZwCphJ7f05jA7GFBXwk
        Hlw4CNbNIqAi8f3AYkYQm1fAUuLejD9MELagxMmZT8CuYBbQk2jbCFbCLCAvsf3tHGaIQxUk
        fj5dxgpxhJvE+ra17BA1IhKzO9uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZwxGlp7WDcs+qD3iFGJg7GQ4wSHMxKIrw8pSwpQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCt377l08HauxrPTp0wNfjx
        1Sfx+on/ZVvFDvIufZMtcqxKaGL0xRD1VWzOnzm7l2j/vpBYf2q/humKZfZin3QlJreKif5X
        y+Vg2HXk78HDhxxYJpo2Vx6RZeE/p2EuveIq86urUekzK5ZHKbk2nhBt7/y4Nl8izvNtwJfp
        YmKRj/8/nL2RTySx2qBjxvpkaY3jvwztZqQ+WOSiss7n1947N1/IBDvo+tXObxZ+HPnooKQS
        09QDktY7m7Z1lR/WV9aNN09jP+DLYld84eci0S0LWLa/TdrEyDrJiLfj32ejozZcLIlT+Rc0
        eFetMmSPirsh/s43tSx8uencAx7LcuY9S5zwNu9ofd9Bzs0PmRcosRRnJBpqMRcVJwIAfKTx
        MCcDAAA=
X-CMS-MailID: 20230306121424epcas1p4d8b8d4b98f3ef61a9bbf7c723a452c72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306061057epcas1p17def087649be56b75c7830385ff2fb2f
References: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
        <CGME20230306061057epcas1p17def087649be56b75c7830385ff2fb2f@epcas1p1.samsung.com>
        <1678081915-12599-2-git-send-email-js07.lee@samsung.com>
        <ZAXKHDb4QY1awyRA@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Russell

> -----Original Message-----
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Sent: Monday, March 6, 2023 8:10 PM
> To: Jungseung Lee <js07.lee@samsung.com>
> Cc: linus.walleij@linaro.org; amit.kachhap@arm.com; ardb@kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> keescook@chromium.org; js07.lee@gmail.com
> Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in
> /proc/iomem
> 
> On Mon, Mar 06, 2023 at 02:51:55PM +0900, Jungseung Lee wrote:
> >  The resource reservations in /proc/iomem made for the kernel image
> > did  not reflect the gaps between text, rodata, and data.
> >  Add the "rodata" resource and update the start/end calculations.
> >
> >  Before :
> > 04000000-2f7fffff : System RAM
> >   04100000-04cfffff : Kernel code
> >   04e00000-05369a27 : Kernel data
> >
> >  After :
> > 04000000-2f7fffff : System RAM
> >   04100000-049fffff : Kernel code
> >   04a00000-04cb2fff : Kernel rodata
> >   04e00000-05369a27 : Kernel data
> 
> NAK. This is API, and programs do read and parse this file. It is
> important that this file reports these parameters in a similar way to
> other architectures. Other architectures do not split up the
> individual regions.
> 

Sounds like an important point, but I failed to find which programs use it
as an API. Could you tell me which program uses it as an API?

In fact, x86 architecture also split up the individual regions in this way.
In addition, most architectures separate the "Kernel bss" area, but arm does
not.

> --
> RMK's Patch system: https://protect2.fireeye.com/v1/url?k=e44d6839-
> 85c67d00-e44ce376-000babffae10-dcec955b544dea43&q=1&e=b53fe1bc-de29-
> 4c29-a20d-
> e39d10be6f3e&u=https%3A%2F%2Fwww.armlinux.org.uk%2Fdeveloper%2Fpatches
> %2F
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

