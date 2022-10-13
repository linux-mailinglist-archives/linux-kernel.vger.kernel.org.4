Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB345FD84F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJML0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJML0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:26:07 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9F68894
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:26:00 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221013112557epoutp017e8d52567c0c62d0c0f01d05e108f646~dnUU2hGHs0381903819epoutp01g
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:25:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221013112557epoutp017e8d52567c0c62d0c0f01d05e108f646~dnUU2hGHs0381903819epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665660357;
        bh=bXc6udR61f6XxRHEaIHz9XqnZI3fIMKixi4lLxfME38=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RioK9c3ZnYyCMfwUj0lE1N1MRrUt1mZuanTQSCq/QMQY+SP8UV7VBvrvIhaCRA00d
         llGwRSV9YsrzWPihreCxfXE+21IEa8rmYYDXGGPug8BSf0Ugi/3+Tg3g5/fUaWL2Vb
         HZE2Va8u76BAb1PQgDnj2Knvv8iPkcFX6vxzYVKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221013112557epcas5p473ad8f80b8a683b1536524da1b01ea7e~dnUUkfAMQ0491104911epcas5p4j;
        Thu, 13 Oct 2022 11:25:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Mp6dt53NPz4x9Py; Thu, 13 Oct
        2022 11:25:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.8A.26992.2C5F7436; Thu, 13 Oct 2022 20:25:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5~dnD5S4HMS0785407854epcas5p3B;
        Thu, 13 Oct 2022 11:07:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221013110708epsmtrp1ed140343405838adcb06395c1f80bafe~dnD5SDtqN2651626516epsmtrp1h;
        Thu, 13 Oct 2022 11:07:08 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-71-6347f5c26541
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.95.14392.C51F7436; Thu, 13 Oct 2022 20:07:08 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110707epsmtip18a7b21cb1480c0fd80afb7d5332140bf~dnD30M0_n1695216952epsmtip1N;
        Thu, 13 Oct 2022 11:07:06 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 0/4] arm64: dts: fix drive strength macros and values for
 FSD Platform
Date:   Thu, 13 Oct 2022 16:10:20 +0530
Message-Id: <20221013104024.50179-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmhu6hr+7JBn/naFg8mLeNzeLyfm2L
        +UfOsVr0vXjIbDHlz3Imi8u75rBZzDi/j8ni6MZgi0Vbv7BbtO49wu7A5bFpVSebx51re9g8
        +rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGv0dLmQu+clV8OvKTuYHxHkcXIyeHhICJxJTZLUxdjFwcQgK7GSX2NByC
        cj4xShw4uYAVwvnGKPFn0mc2mJbZJ1ayQCT2MkpM+HaXHcJpZZJ4sXQZC0gVm4CpxKo5jWDt
        IgJLGSX+f1rECOIwC0xhlNi67QaQw8EhLBAtMeUQM0gDi4CqxPXD/YwgNq+AjcTptceZINbJ
        S6zecIAZpFdCYBe7xNbTbSwQCReJY7f3MEPYwhKvjm9hh7ClJF72t0HZ+RLTPjZD3V0h0fZx
        A9RQe4kDV+awgNzALKApsX6XPkRYVmLqqXVgJcwCfBK9v59AlfNK7JgHY6tKrF++iRHClpbY
        d30vlO0hMWv+FbC1QgKxEs9332CawCg7C2HDAkbGVYySqQXFuempxaYFhnmp5fCoSs7P3cQI
        TmdanjsY7z74oHeIkYmD8RCjBAezkgivS4hbshBvSmJlVWpRfnxRaU5q8SFGU2CYTWSWEk3O
        BybUvJJ4QxNLAxMzMzMTS2MzQyVx3sUztJKFBNITS1KzU1MLUotg+pg4OKUamEw3+92znCxt
        s3mP9BmztWtCTfcbi1344LvD4uFyntfSR+K+WFw5EjJlQR9b2A/Dr5yfvwoYcd5mvVys9m5C
        xGbeM0fuF7ZOqepfl8tcKWcn8yLNbWLdQR7F84eDxG9N7rPITM/OUbFhtM2Ny5AIc5i4+nfH
        6bT9Bv+eTvQTrOK9t+lu+ZGqLQcy9MNCr+jZfNVxfii8M/dRuv4fjcOT79dYp5+3jNzQzeAw
        1+Vdbt/fT1z7Z186cpFhXVBcbbedgUxbplp7Z2xvT9tUxRsa26pM5f512/fxGharhP42fcB9
        n7fIQIVjt/sxyzsCfoExE6SuS3N/rpySP1fjCy/blqJ0Ja8bNZcnF4Zrld9TYinOSDTUYi4q
        TgQAOg5oUvADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJTjfmo3uywbsWRYsH87axWVzer20x
        /8g5Vou+Fw+ZLab8Wc5kcXnXHDaLGef3MVkc3RhssWjrF3aL1r1H2B24PDat6mTzuHNtD5tH
        35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVwZfx7tJS54CtXxacjP5kbGO9xdDFyckgImEjMPrGS
        pYuRi0NIYDejxKHeWWwQCWmJ6f17oGxhiZX/nrNDFDUzSXRdeMUKkmATMJVYNaeRFSQhIrCa
        UeJzfztYB7PANEaJXVPrQWxhgUiJBa+mgzWwCKhKXD/czwhi8wrYSJxee5wJYoO8xOoNB5gn
        MPIsYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHFhamjsYt6/6oHeIkYmD8RCj
        BAezkgivS4hbshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTByc
        Ug1MLF37uOOUpm649bIkPVBopbrXjpcVujf/L2tqVRM7nZNifNexgnPCHbNGkdqyneaBqpZP
        ZsyubsjTfHeQ78Cxo+tEz5anlVgrOKbbRRWwpGuWzZjtIHpJz/7T+sb9Zh/E3YpMHcNn6MQd
        eL72TttG/3PcO/ObuH3PzP75+k6FUsQ2F+UFujf3xUpdffaL6cSJR5Ffp/+obQu84jnnvtMp
        S27te7tWOn3sEzE69Kcg7PDcJ6ycosf3TpwaGbdq7uodKZZTl86+UfBL3WadhzLTHpvF+wTa
        P0xcvM+C6frD1313LnDPXSj7peTKt7XH/7J6tr3t+vtNZCqPDOOSpwtFK85wRh1dWq2TZVv2
        w3XteyWW4oxEQy3mouJEALvI9b2bAgAA
X-CMS-MailID: 20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5
References: <CGME20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With reference to FSD SoC HW UM, there are some deviations in the
drive strength macros names and macro values. Also the IPs are not
using the default drive strength values as recommended by HW UM.

FSD SoC pinctrl has following four levels of drive-strength and their
corresponding values:
Level-1 <-> 0
Level-2 <-> 1
Level-4 <-> 2
Level-6 <-> 3

The commit 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
used drive strength macros defined for Exynos4 SoC family. For some IPs
the macros values of Exynos4 matched and worked well, but Exynos4 SoC
family drive-strength (names and values) is not exactly matching with
FSD SoC.

The intention of this patch series is to:
1. Fix the drive strength macros to reflect actual names and values given
in FSD HW UM.
2. Ensure that the existing peripherals in device tree file is using
default drive strength values recommended in FSD HW UM.

Padmanabhan Rajanbabu (4):
  arm64: dts: fix drive strength macros as per FSD HW UM
  arm64: dts: fix HSI2C drive strength values as per FSD HW UM
  arm64: dts: fix UART drive strength values as per FSD HW UM
  arm64: dts: fix SPI drive strength values as per FSD HW UM

 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 34 +++++++++++-----------
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h    |  6 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.17.1

