Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B361E7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKGAEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKGAEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:04:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D1BF42
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 16:04:06 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221107000402epoutp0490f83660db90e078d8f0ab7b72b313c7~lJJEu7Wy31293912939epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:04:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221107000402epoutp0490f83660db90e078d8f0ab7b72b313c7~lJJEu7Wy31293912939epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667779443;
        bh=yiy9+tK/kn9g0w+SJYCkGz8hXLmunRnS/MAznVjLMC0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=BCr9miUZJalpeBe7j8YEkG/5Rnz1lGnff6ciAU5BPlaihzzqt1qcbx4tQYe7KmI/q
         jQU08IHXjAVmId8f/ruJjMPJ5icP/A8tnIPhK18SbldHgtwX3Ps8rDp9/n06TtCBR1
         WnnFTncW2qMpp3glLbi4hjF29wjwI0ONOOaYaMI8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221107000402epcas2p46f7c6ac5789584e7c15f8c56594e67fc~lJJEImNDD0386203862epcas2p4v;
        Mon,  7 Nov 2022 00:04:02 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N5BKY5tRyz4x9Q2; Mon,  7 Nov
        2022 00:04:01 +0000 (GMT)
X-AuditID: b6c32a47-ac5b870000002127-7f-63684b711fce
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.BB.08487.17B48636; Mon,  7 Nov 2022 09:04:01 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] dt-bindings: clock: exynosautov9: fix reference to
 CMU_FSYS1 mmc card clock
Reply-To: chanho61.park@samsung.com
Sender: CHANHO PARK <chanho61.park@samsung.com>
From:   CHANHO PARK <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Inbaraj E <inbaraj.e@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        CHANHO PARK <chanho61.park@samsung.com>
CC:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PANKAJ KUMAR DUBEY <pankaj.dubey@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8f026f38-ef09-788e-7bd8-45683b074075@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221107000401epcms2p3eeeecbfb2b1cdfb30dcee99bbb48780c@epcms2p3>
Date:   Mon, 07 Nov 2022 09:04:01 +0900
X-CMS-MailID: 20221107000401epcms2p3eeeecbfb2b1cdfb30dcee99bbb48780c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmuW6hd0aywYn3WhYP5m1js7i8X9vi
        +pfnrBbzj5xjtbj7ZxKbxd7XW9ktNj2+xmrxseceq8XlXXPYLGac38dkcfGUq8WirV/YLVr3
        HmG3OPymndXi37WNLBardv1hdBDweH+jld1j56y77B6bVnWyedy5tofNY/OSeo++LasYPT5v
        kgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQK
        VJiQnXH2+DSWgqvsFfdadrI3MK5g62Lk5JAQMJHYvWQ3UxcjF4eQwA5Gibap54AcDg5eAUGJ
        vzuEQWqEBdIknt79yA4SFhJQlti4LRYirC/xvb+JBcRmE9CVmP/hEyvIGBGBQ8wSLT2PwBxm
        gQ5mie/X3jBDLOOVmNH+lAXClpbYvnwrI8hQTgE7iRdz4yHCGhI/lvVClYtK3Fz9lh3Gfn9s
        PiOELSLReu8sVI2gxIOfu6HikhL/l+1lAxkpIVAt8e9qBUS4QmL3+01MELa5xPWPU8DKeQV8
        JRZteAh2DYuAqkTv5aNQNS4SjyY8AbOZBeQltr+dwwwykllAU2L9Ln2I6coSR26xQFTwSXQc
        /ssO89+OeU+gpqhLHNg+HepXWYnuOZ9ZIWwPiak9X9gmMCrOQgTzLCS7ZiHsWsDIvIpRLLWg
        ODc9tdiowBges8n5uZsYwUlYy30H44y3H/QOMTJxMB5ilOBgVhLhveGWlizEm5JYWZValB9f
        VJqTWnyI0RToy4nMUqLJ+cA8kFcSb2hiaWBiZmZobmRqYK4kzts1QytZSCA9sSQ1OzW1ILUI
        po+Jg1Oqgcm35cecyH23X6/2/KtSsP6lzmnWgE0vH3w9t2eHbrzdBQ8JfT0dwSdPNfZtiVN7
        2sl21/Sfd7PWFK+9Cr/Z8g6uULQtuMQvk9mceHVnbslBPb0NXjV3+JJ/PNpc+8jC2fLbR9lq
        7TO7sj5tzxI6H77TgW32vDlN/7PnLPaakds1p3Z/dh3HEpET/kyqLpod6bNvvd97905Ocs89
        i/OSGZHpYmfnvtxUk/dY5gZPCtN8LrM7kUvkfk5+wjqvSP/r4dBrOvXPZN+47DpZFvvVU6Ti
        QOqkpZqbKvg3aEcGzqyUX9CT1+7J76apNcn1sOW/L20Cahc4H/b++1J/9m2YwpmpvCEHQq9+
        EXnz6W7zpWYlluKMREMt5qLiRAAkDlTUSwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221104085410epcas5p24d88f59001b739075e9e190e2c47841e
References: <8f026f38-ef09-788e-7bd8-45683b074075@linaro.org>
        <20221104090019.88387-1-inbaraj.e@samsung.com>
        <CGME20221104085410epcas5p24d88f59001b739075e9e190e2c47841e@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fix reference to CMU_FSYS1 mmc card clock to gout clock instead of dout.
> >
> > This fixes make dtbs_check warning as shown below:
> >
> > arch/arm64/boot/dts/exynos/exynosautov9-sadk.dtb: clock-
> controller@17040000:
> > clock-names:2: 'dout_clkcmu_fsys1_mmc_card' was expected From schema:
> > /home/inbaraj/mainline/linux/Documentation/devicetree/
> > bindings/clock/samsung,exynosautov9-clock.yaml
> 
> I don't understand:
> 1. Why bindings are wrong not DTSI?
> 2. What is "gout"? "dout" had a meaning as clock divider output.

"gout" is output of a gate clock, AFAIK.
Unlike any other clocks, the fsys1 mmc top clock does not have a divider. So, it should be "mout -> gout" instead of "mout -> gout -> dout".

> 
> >
> > Fixes: 4b6ec8d88623 ("dt-bindings: clock: exynosautov9: add schema for
> > cmu_fsys0/1")
> > Signed-off-by: Inbaraj <inbaraj.e@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park
