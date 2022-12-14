Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3564C340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiLNErb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiLNErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:47:24 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7662C1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:47:23 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221214044721epoutp028d65d7a79b59634257c8e707bb41682e~wj4ALHCqf2643626436epoutp02c
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:47:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221214044721epoutp028d65d7a79b59634257c8e707bb41682e~wj4ALHCqf2643626436epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993241;
        bh=ZmZoMOjOa4JMZn2uHWvONE/O2fvGS7cXjDU2uVfdc38=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PtW5yWDY+rwXgad+gk4hJnR20NzZ3cyv3bEFzRUiWvfyPUZhoK0vgrQeVnC+ISPQh
         4NBWW7MpJA1JW8MSRQJ0+baye3td3T/yrcMLlSGnX+/7MBzog+SX4B5043ZO5dVp7A
         CrsrbuNMoVFya3rZiTgIE3FR04b+Yqhz5VfPwI50=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221214044721epcas5p3c3514b71be610c97cd14a4311b94ccf1~wj3-0UxUW1018210182epcas5p3I;
        Wed, 14 Dec 2022 04:47:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NX2sM69jWz4x9Pp; Wed, 14 Dec
        2022 04:47:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.AB.39477.75559936; Wed, 14 Dec 2022 13:47:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221214044418epcas5p3c2708eda3abcf5b217eddacf533e0a0f~wj1U8xb1I2925929259epcas5p3E;
        Wed, 14 Dec 2022 04:44:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221214044417epsmtrp2cbe30cc23678cee3a9427019b58f46af~wj1U8A93p2211422114epsmtrp2e;
        Wed, 14 Dec 2022 04:44:17 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-3a-63995557f75e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.2C.14392.1A459936; Wed, 14 Dec 2022 13:44:17 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044416epsmtip29c37e8d4f33bc0bfe729861a367e5a41~wj1TX-NVv3149831498epsmtip2J;
        Wed, 14 Dec 2022 04:44:16 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 0/4] amr64: dts: exynos: add dedicated SYSREG compatibles
 to Exynos850 and Exynosautov9
Date:   Wed, 14 Dec 2022 10:13:38 +0530
Message-Id: <20221214044342.49766-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmlm546Mxkg039BhYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu8fDDHnaL1r1H2C2+HHnNaHH7zTpWB26PTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5YsG0+e8FP9oprP2UaGA+wdTFyckgImEjsfzeJvYuR
        i0NIYDejxJKb99ggnE+MEofvP2WFcL4xSrSd72GHabnauB0qsZdRYtmkL0wQTiuTxLWrN8Cq
        2AR0JVqvfQZLiAjsYJR4PekAmMMsMIVRovvbeqB+Dg5hgRyJo4tkQRpYBFQl9rzYAdbMK2Ar
        cfzDf6h18hKrNxxgBumVEDjFLjFlchsTRMJF4uyEZ8wQtrDEq+NboBqkJD6/2wv1XrrE5iOb
        WSHsHImOpmaoenuJA1fmsIDcwCygKbF+lz5EWFZi6ql1YOOZBfgken8/gVrFK7FjHoytJrH4
        USeULSOx9tEnqPEeEovmPAY7QUggVqLjbRvrBEbZWQgbFjAyrmKUTC0ozk1PLTYtMMpLLYfH
        VHJ+7iZGcIrT8trB+PDBB71DjEwcjIcYJTiYlUR4VTWmJQvxpiRWVqUW5ccXleakFh9iNAWG
        2URmKdHkfGCSzSuJNzSxNDAxMzMzsTQ2M1QS5106pSNZSCA9sSQ1OzW1ILUIpo+Jg1OqgWli
        7lHlwj0ztdrP1wht97+zVVjYY/etr5++CN94XO2usUDE53mmza4lGjcOTopp+KpkserI03u+
        UYFH454az9G89bz0GNPPoqCJdSHLnxjts2N+/zfUPer4ctsNQgzCehUrLx+8s+bVzdfce1pD
        LTg+Om1k6egvKVv4aOO+d1NVLYoWrT2hdiL07t5dvrZFTxSiu5sq9JqnvgnreC4eWPftwQrV
        nPfLlumo7leuqHFbbqm4u5m1ezO7dhwLR/Il1z2WW6TnyxyWken5H5M+iVvD71dP6dl5EXXG
        07dayEzbfU4v6tvpRsMTa17OKbN13O446YjwlQW8CcLKJjLv/p07lFydsfpCSLflEv7/O5WV
        WIozEg21mIuKEwGSwNjK+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSvO7CkJnJBjuemFk8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbf4cuQ1o8XtN+tYHbg9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbFg23z2gp/sFdd+yjQwHmDr
        YuTkkBAwkbjauJ21i5GLQ0hgN6PEm0+fGCESMhInHyxhhrCFJVb+e84OUdTMJHF87R+wbjYB
        XYnWa5+ZQBIiAgcYJXb3LmEEcZgFZjBK/F0/B2yUsECWxPS5O8E6WARUJfa82MEOYvMK2Eoc
        //CfHWKFvMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxuWpo7
        GLev+qB3iJGJg/EQowQHs5IIr6rGtGQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQn
        lqRmp6YWpBbBZJk4OKUamFwN7aQMb91O8bb2F5Y1X+2+OVihev+75+E1Ld6mkXdZojZ+Xs8j
        OEHk+krrjy33VotdeGu16+6bs22N7643fV9+hVnkvLVi1IVKmwY337NHr5tYcF/TOqbxbff0
        2pgvrxZ+LeybdHJ3WvK0u280T/R39b7huWK6PC1mxqanTTE/JIRYjy/OOfSVuVnZaLPQvVXZ
        UiasM3sildNs5nVHb/r70uZW3M8jllbLPdy3TQiOcMjziDjIppr14ci55Sp8F6ftncb+VK5V
        RftBNItwZaKKf0HgymOT7ZxUZPct8qx0NT9++2Sn+Tu9J04vGKfuTM38dNzg0iub5XPY5l4t
        5N/aeG99Dc+EKD0mIY2jn5RYijMSDbWYi4oTAWknhHKmAgAA
X-CMS-MailID: 20221214044418epcas5p3c2708eda3abcf5b217eddacf533e0a0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214044418epcas5p3c2708eda3abcf5b217eddacf533e0a0f
References: <CGME20221214044418epcas5p3c2708eda3abcf5b217eddacf533e0a0f@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 and Exynosautov9 has several different SYSREGs, so use dedicated
compatibles for them in dtsi file and add respective compatible in the
samsung exynos devicetree binding document.

Changes since v2:
1. Addressed the review comment from Rob and removed const from the enum
compatible list.

Changes since v1:
1. As per Krzysztof comment made an enum of deprecated compatibles.

Sriranjani P (4):
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynos850
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos850
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynosautov9
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynosautov9

 .../soc/samsung/samsung,exynos-sysreg.yaml    | 24 +++++++++++++++----
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  6 +++--
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |  9 ++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.17.1

