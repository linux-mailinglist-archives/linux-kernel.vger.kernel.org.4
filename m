Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222C617614
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKCFSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCFSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:18:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75C13D2F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:18:52 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221103051849epoutp03530c0f6d686e81e6d0db49b84e2bdbe5~j_2xDqxKB0419704197epoutp03P
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:18:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221103051849epoutp03530c0f6d686e81e6d0db49b84e2bdbe5~j_2xDqxKB0419704197epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667452729;
        bh=XRg9zOEBvsQLHS9XqCmNzeoHePhE0ZsD/kI1H7lW3MM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HtVlLuOU3zE0Hj/+150JHWAPaIMttpdKYBqhbylfZ6ijmZm/Z5ISot/QeQM6JSLV2
         Z3zgRz9IqBuZT7JOrPvcOEEdJkOs1n99u7VdQ9HdVKfm43Z3/nHF58U7YPSjTpkKJG
         6kmvsMFfVzcwISLAFuZ9WT13UIsXK+2VBGxGR27Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221103051848epcas5p1f3d9ee5755ca4aa318f6f8949728903f~j_2whypAz1490614906epcas5p15;
        Thu,  3 Nov 2022 05:18:48 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N2sVZ1qqGz4x9Q8; Thu,  3 Nov
        2022 05:18:46 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.50.39477.63F43636; Thu,  3 Nov 2022 14:18:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103051845epcas5p2e20e796b56316c6804eecc947faa652d~j_2tfY_iG2357823578epcas5p2J;
        Thu,  3 Nov 2022 05:18:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221103051845epsmtrp1df36d3813a84d43d144c5ef7d6451a85~j_2tdmKql0812108121epsmtrp1I;
        Thu,  3 Nov 2022 05:18:45 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-3e-63634f3699b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.FE.14392.53F43636; Thu,  3 Nov 2022 14:18:45 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221103051844epsmtip2b2e4d9b321034ed1409b96b4a18e1144~j_2sG-ymZ2050020500epsmtip2N;
        Thu,  3 Nov 2022 05:18:44 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Pierre Gondois'" <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>
Cc:     <Rob.Herring@arm.com>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        "'Shashank Prashar'" <s.prashar@samsung.com>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        <devicetree@vger.kernel.org>
In-Reply-To: <20221031092125.533621-1-pierre.gondois@arm.com>
Subject: RE: [PATCH 20/20] arm64: dts: Update cache properties for tesla
Date:   Thu, 3 Nov 2022 10:48:42 +0530
Message-ID: <000101d8ef43$befeb340$3cfc19c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpQYH2m4isuUE3KcYHWhTj/znegAEsq0TWrYKfAcA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmuq6Zf3KywZYeDotDm7eyW8w/co7V
        ou/FQ2aLy7vmsFk8WJVpcfPlPkaL1r1H2C3m7ZjLaHH7zTpWB06PNfPWMHpsWtXJ5nHn2h42
        j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdcX7zIqaCo9wVe1afZW9g/MTZxcjJISFgIrHybztbFyMXh5DAbkaJu51H
        WSCcT4wS//6tYIZwvjFK7DjRxQ7T8v3OFEaIxF5Gib/P30NVvWSUeLrpOCtIFZuArsSOxW1A
        gzk4RAQCJRZsSASpYRZYwSSxqa+VDaSGU8BW4tC9JjBbWMBD4ujbHrANLAIqEhsmNYLZvAKW
        Eitmb2ODsAUlTs58wgJiMwvIS2x/O4cZ4iIFiZ9Pl4HtFRGwkmht62WGqBGXeHn0CDvIYgmB
        lRwSKxdtATtIQsBF4t03e4heYYlXx7dAfSYl8bK/jR2ixENi0R8piHCGxNvl6xkhbHuJA1fm
        sICUMAtoSqzfpQ+xiU+i9/cTJohOXomONiGIalWJ5ndXWSBsaYmJ3d2sELaHxMcts5gnMCrO
        QvLXLCR/zUJy/yyEZQsYWVYxSqYWFOempxabFhjlpZbDozs5P3cTIzixanntYHz44IPeIUYm
        DsZDjBIczEoivPVno5OFeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4wteeVxBuaWBqYmJmZ
        mVgamxkqifMunqGVLCSQnliSmp2aWpBaBNPHxMEp1cDE4dkhKxvw13SKdrOYy9GNkV7fmpk4
        Loc6de36e+Pbj1sXXi5Qf6ulpK5XYPfnUsC+7wumV9/JZtY83rT2TuN3lQ9flvCt/c16bl7V
        FVaGbS8XWy1boPNEwJjHtGjfU3YejeOLdm+KEK/xkdg6wWXhmpeWPOfrc1vOPN1z43TQFQOt
        nWFGYUv655euDEqNPLxq/S+W8wwsHE9fnv7m6TjrM+uOvP6EVb7qqvXRiX0hSr1ry2/4vNBd
        5XRCcH+csEHf2Q1/eqWsvj9tVf3d9YhjpsbsZm3vCLmq40zTLi/2T3lT7xv1+dA5lwcbk/ym
        CP/fe87lTGhWzuvVU3Z9LeDTMrv67ELWEYnlqq9uveJ2VWIpzkg01GIuKk4EADAtc4Q1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXtfUPznZYO1vOYtDm7eyW8w/co7V
        ou/FQ2aLy7vmsFk8WJVpcfPlPkaL1r1H2C3m7ZjLaHH7zTpWB06PNfPWMHpsWtXJ5nHn2h42
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mo4v3kRU8FR7oo9q8+yNzB+4uxi5OSQEDCR+H5n
        CmMXIxeHkMBuRomnr6YwQySkJa5vnMAOYQtLrPz3nB2i6DmjxOubG1lAEmwCuhI7FrexdTFy
        cIgIBEos2JAIUsMssI5JYtrTBUwgNUICfYwSpz4LgdicArYSh+41sYHYwgIeEkff9oAtYBFQ
        kdgwqRHM5hWwlFgxexsbhC0ocXLmExaQ+cwCehJtGxlBwswC8hLb386BulNB4ufTZawgtoiA
        lURrWy8zRI24xMujR9gnMArPQjJpFsKkWUgmzULSsYCRZRWjZGpBcW56brFhgWFearlecWJu
        cWleul5yfu4mRnB0aWnuYNy+6oPeIUYmDsZDjBIczEoivPVno5OFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYBKwvXf3W9P3rnvRhm/lnQRv9TRMPSLX
        wrZY4AHPhypmbvaCPRFq5it9bvPqf2O7eOLdvWjL7M9XUu9FZhkYhesKTM9nkTZYF39Bqqs3
        kSsnLGzD0s0v30sEank+ti/4sl/YTd2ockKF00slnVcpfgfi3Wdt3aR4kKN2vu/ahQ5b9gps
        Cdd82m7VZLQiqHLqso8J+kecXxjMtlJOmnAu6MmBrooX+2L3bd7lrfo7OuBwht3f2afEDme/
        ruDV96xbo8wpOS2qzPI/74XjUik38hmObpybse6thDBb8r90N6WbNcvWZvpPPuSS9ll9wTMr
        YV/zzy5sz/OXB1yuTnY+HvhZ7qhLYqDnjJnz3m3jUmIpzkg01GIuKk4EABNYiqwdAwAA
X-CMS-MailID: 20221103051845epcas5p2e20e796b56316c6804eecc947faa652d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221031092138epcas5p3070cc1775dafebe8d4abffcecaa860b0
References: <CGME20221031092138epcas5p3070cc1775dafebe8d4abffcecaa860b0@epcas5p3.samsung.com>
        <20221031092125.533621-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Pierre Gondois [mailto:pierre.gondois@arm.com]
>Sent: Monday, October 31, 2022 2:51 PM
>To: linux-kernel@vger.kernel.org
>Cc: pierre.gondois@arm.com; Rob.Herring@arm.com; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Aswani Reddy <aswani.reddy@samsung.com>;
>Shashank Prashar <s.prashar@samsung.com>; Sriranjani P
><sriranjani.p@samsung.com>; devicetree@vger.kernel.org
>Subject: [PATCH 20/20] arm64: dts: Update cache properties for tesla
>
>The DeviceTree Specification v0.3 specifies that the cache node
'compatible'
>and 'cache-level' properties are 'required'. Cf.
>s3.8 Multi-level and Shared Cache Nodes
>
>The recently added init_of_cache_level() function checks these properties.
>Add them if missing.
>
>Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm64/boot/dts/tesla/fsd.dtsi | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index f35bc5a288c2..bfab040fc1e4 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>@@ -284,6 +284,7 @@ cpucl_l2: l2-cache0 {
> 			cache-size = <0x400000>;
> 			cache-line-size = <64>;
> 			cache-sets = <4096>;
>+			cache-level = <2>;
> 		};
>
> 		idle-states {
>--
>2.25.1


