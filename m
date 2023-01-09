Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C23661DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjAIEdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjAIEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:32:14 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF6E019
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:16:58 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230109041657epoutp04b74cff2fb3d8d623dd39b5bf9bcd44bc~4iO4GU-IQ1018310183epoutp04p
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:16:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230109041657epoutp04b74cff2fb3d8d623dd39b5bf9bcd44bc~4iO4GU-IQ1018310183epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673237817;
        bh=94ESABnEYG2rv76V0vtqvXxgsfCD+B21vNH8V9t1i28=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Wc4U2cELcd+rC9M5m9z/K03f6/nmHqEjcKl/fVSD5BnTdFBonAKBruvWIm0/n7I61
         QhNYXQdKNlNau4lQYVSPzl56iZMs7SlV4SFgBGa2dXwSmGk5BR7uJZrs6Orph2V3pt
         a8MiEPD/MgpVJsQHQnVAX6895Ox/gS0eCfhhB/+s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230109041656epcas5p1116cb2bec49328974e7d5cb808912ccb~4iO3XjiG12962529625epcas5p1u;
        Mon,  9 Jan 2023 04:16:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nr0yH0HsYz4x9Q7; Mon,  9 Jan
        2023 04:16:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.3C.03362.6359BB36; Mon,  9 Jan 2023 13:16:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230109040551epcas5p2d5487bd8ca6ba7c1bb46636da17010f5~4iFL6Rgb71880818808epcas5p20;
        Mon,  9 Jan 2023 04:05:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230109040551epsmtrp25a2d1f4fc81436d2eab687cc2da131f7~4iFL5SsLl1699616996epsmtrp2D;
        Mon,  9 Jan 2023 04:05:51 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-e0-63bb95366cc5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.08.10542.F929BB36; Mon,  9 Jan 2023 13:05:51 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230109040549epsmtip1b09684e2b271f3e23b1813f34b1581d1~4iFJvDDO00547905479epsmtip1b;
        Mon,  9 Jan 2023 04:05:49 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <Y7RuMmvNnAx+oyyl@sirena.org.uk>
Subject: RE: [PATCH v2 1/5] ASoC: dt-bindings: Add FSD I2S controller
 bindings
Date:   Mon, 9 Jan 2023 09:35:47 +0530
Message-ID: <051d01d923df$a96ea460$fc4bed20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5OglsonJNs2LrkABkwml8apZdSgNMbZkqANhEDZkCsq2Xp64ei3kg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmpq7Z1N3JBhMfWVg8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7JYtPULu0Xnrn5Wi1kXdrBa
        tO49wm5x+E07q8WG72sZHfg9NnxuYvPYOesuu8emVZ1sHneu7WHz2Pd2GZtH35ZVjB7rt1xl
        8fi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoeiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGB
        gZEpUGFCdsaWrn+MBe85K5pvzWZvYJzC0cXIySEhYCKx7VMvI4gtJLCbUWLaexkI+xOjxJfP
        3F2MXED2Z0aJR3snsMM0vG48yAaR2MUocezZJGaIjheMEvN+ZYDYbALmEov2LgWbKiKgLnF0
        00ZWkAZmgS5miQ1H3rGAJDgFdCWufJsCViQsECDxb/UesEEsAioSL859YAOxeQUsJVb9eM4I
        YQtKnJz5BKyXWUBeYvvbOcwQFylI/Hy6jBVimZvEibPv2SBqxCWO/uxhBlksIfCGQ+LShFWs
        EA0uEjd3vWaCsIUlXh3fAvWalMTnd3vZIOx8iWkfm6HsCom2jxug6u0lDlyZA3QEB9ACTYn1
        u/QhwrISU0+tY4LYyyfR+/sJVDmvxI55MLaqxPrlmxghbGmJfdf3Mk5gVJqF5LVZSF6bheSF
        WQjbFjCyrGKUTC0ozk1PLTYtMM5LLYfHd3J+7iZGcNrW8t7B+OjBB71DjEwcjIcYJTiYlUR4
        SzftShbiTUmsrEotyo8vKs1JLT7EaAoM74nMUqLJ+cDMkVcSb2hiaWBiZmZmYmlsZqgkzpu6
        dX6ykEB6YklqdmpqQWoRTB8TB6dUA1PY3aKWB/6OsevFTyddPb5qF8tNNUkWX/t71b6CXrs2
        zw9bOSG+RP/WWb8NEQf2dPTND3QUXWny9VJDxIaPy75ejbPxeCnvklYsm/txi7sDa7Bmmtr5
        l1G69qGrmZ4KzvZIKM431Z9qdHVrzdGi2hstjx517uP+93aivmvVwRPq2h/rHZNv7Oj/qvYl
        7+2yKfaNrO8/zDnky/vQIHKG4TGv2sCjfgumq2g5T/7Lmv4k9LpMQ1cRX/ly2zMmB2dJXOgR
        WOlpd7/g2HMtniDN9hXHeIunHOrXmGL7Z/a+t28sYoRTJnaFvT/i+/v0AuOUciYm7e4r3Ktj
        TH/qa9vxJbyukhBUnFXPutXASTItS4mlOCPRUIu5qDgRAHntTeBkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO78SbuTDd6tkrJ4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2SxaOsXdovOXf2sFrMu7GC1
        aN17hN3i8Jt2VosN39cyOvB7bPjcxOaxc9Zddo9NqzrZPO5c28Pmse/tMjaPvi2rGD3Wb7nK
        4vF5k1wARxSXTUpqTmZZapG+XQJXxpauf4wF7zkrmm/NZm9gnMLRxcjJISFgIvG68SAbiC0k
        sINRYsXGKoi4tMT0/j1sELawxMp/z9m7GLmAap4xSsw7s4gVJMEmYC6xaO9SRhBbREBd4uim
        jawgRcwCM5glDt26xArR8YhR4m3LerAOTgFdiSvfpoB1CAv4SXzpbgBbwSKgIvHi3Acwm1fA
        UmLVj+eMELagxMmZT1i6GDmApupJtG0ECzMLyEtsfzuHGeI6BYmfT5exQhzhJnHi7Hs2iBpx
        iaM/e5gnMArPQjJpFsKkWUgmzULSsYCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4m
        RnDsamntYNyz6oPeIUYmDsZDjBIczEoivKWbdiUL8aYkVlalFuXHF5XmpBYfYpTmYFES573Q
        dTJeSCA9sSQ1OzW1ILUIJsvEwSnVwDR1Y+T6k08ORP+qKfHmvW3dGzeVQ7fCtNZo76WZc0zs
        Aqq+6XzL4Wiqvfh/g+xPc+9FWxZMjdf4H2nAsW9P/Vm36/PZPE4uF/l826krR7uD1+JdqbPM
        PgGbS7P3/JLde/BV6a1fbjEKb6XEWx89iP6kWVnC+6rg76PtmW93yJjrvHW++Nnk+uOnjHmZ
        D5Nceq4dCr2tfPfnjdJjSwU+X3xwiPOkUNvmqjOd84JzX8x5olV0x3FN/r43Ip/WMJ/5XWng
        onwpQSE+4ZGSYVn+G8UJIbOctt+q45FiuWyoGFvexGw76VfCot8HenS+lP6bv521qS7t3ie1
        z6tlkjll3hcfm7zLUq/nrk9exzbVA/ZKLMUZiYZazEXFiQCCSRn8TAMAAA==
X-CMS-MailID: 20230109040551epcas5p2d5487bd8ca6ba7c1bb46636da17010f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08@epcas5p4.samsung.com>
        <20230103045613.100309-2-p.rajanbabu@samsung.com>
        <Y7RuMmvNnAx+oyyl@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 03 January 2023 11:35 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Cc: lgirdwood@gmail.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH v2 1/5] ASoC: dt-bindings: Add FSD I2S controller
> bindings
> 
> On Tue, Jan 03, 2023 at 10:26:09AM +0530, Padmanabhan Rajanbabu wrote:
> 
> > +
> > +      tesla,fsd-i2s: with all the available features of Exynos7 I2S,
> > +      supporting only stereo channel playback and capture.
> 
> The driver claims that 7.1 is also supported.

For I2S mode, data lines for channel 3 to 6 are not routed out of the SoC.
i.e FSD SoC has only SDO0 line routed out. SDO1 and 2 are floating pins. 

So Exynos7-I2S in FSD SoC supports only stereo playback and capture in
I2S mode. I'll reword the description in the next patch set to reflect the
above information.

Thanks,
Padmanabhan R.

