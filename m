Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78663E7B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLACUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLACT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:19:59 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0B9FEE7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:19:46 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221201021942epoutp02131028636ff4f72f99077cf4efece1f4~sieXodAms2719027190epoutp021
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:19:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221201021942epoutp02131028636ff4f72f99077cf4efece1f4~sieXodAms2719027190epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669861182;
        bh=iUAtliJ/Q0ldVY78BmxujLBJp2RDvdl0S+Gg+jikXA8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=giL1CUpYvRrECQhfxP1JX+zVGgKrANsln3uV2dJrVlAlP0ymdm1QKnLzApx5s9Jaa
         C+RqG7aeA8WZAhFRPv1zAfq9d2nWI6DN40MtHGeN8D4dC3iVRqfaaHn+ti7fhT5Ljr
         NM+lWSK26VjT4wT7pND0yFFEsLQAvElqJiIldJxE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221201021941epcas2p419c04f39f3da44eedd7df875f60d544e~sieWj_Ek01714917149epcas2p49;
        Thu,  1 Dec 2022 02:19:41 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NN0C06g6Mz4x9Q4; Thu,  1 Dec
        2022 02:19:40 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.CC.18762.C3F08836; Thu,  1 Dec 2022 11:19:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20221201021940epcas2p2073f25dad069314022471eaa16d26592~sieVyu0xr1899818998epcas2p2y;
        Thu,  1 Dec 2022 02:19:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221201021940epsmtrp237f445fc3a51f603d27ef8a010f46750~sieVw6YFV1711217112epsmtrp2H;
        Thu,  1 Dec 2022 02:19:40 +0000 (GMT)
X-AuditID: b6c32a48-8a7fa7000001494a-00-63880f3c20d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.7D.18644.C3F08836; Thu,  1 Dec 2022 11:19:40 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221201021940epsmtip2868bda81c18ce75a2d54367d35dc8280~sieVc7gl73012730127epsmtip2H;
        Thu,  1 Dec 2022 02:19:40 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES),
        linux-kernel@vger.kernel.org (open list), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: [RFC PATCH v1 0/2] add xhci-exynos to support Samsung Exynos SOCs
Date:   Thu,  1 Dec 2022 11:13:29 +0900
Message-Id: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmma4Nf0eywdLvxhYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8WdBdOYLE4tX8hk0bx4PZvFnJtGFncf/mCx6HvxkNliyp/lTBab
        Hl9jtbi8aw6bxYzz+5gsFi1rZbZo3jSF1aJ17xF2i667N4DGHRS1+LXlFaODqMfvX5MYPXbO
        usvusXjPSyaPTas62TzuXNvD5rF/7hp2j81L6j36tqxi9Fi/5SqLx+dNcgFcUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAvKimUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM8794yvYwF5x
        7kFZA2MLaxcjJ4eEgInEpZ+f2UFsIYEdjBITNzF1MXIB2Z8YJdavmcUO4XxmlDje+gmuo+1p
        L1TVLkaJw+eboJwfjBIPV85m62Lk4GAT0JL4vpARJC4i8IlZ4l7nPUaQbmaBd8wS/VuiQWxh
        AS+Jqx9mM4PYLAKqEie/vwbbwCvgJnGr6SPUNjmJm+c6mUEGSQjs4JD4sPgFVMJFYnvXD0YI
        W1ji1fEt7BC2lMTnd3vZIOxsievfulkg7AqJFXthbGOJWc/aGUEOZRbQlFi/Sx/ElBBQljhy
        iwXiTD6JjsN/2SHCvBIdbUIQjcoS0y9PgDpAUuLg63PMECUeEu1nnEFMIYFYiUO/4iYwys5C
        mL6AkXEVo1hqQXFuemqxUYEJPH6S83M3MYITrJbHDsbZbz/oHWJk4mA8xCjBwawkwtvxuS1Z
        iDclsbIqtSg/vqg0J7X4EKMpMLAmMkuJJucDU3xeSbyhiaWBiZmZobmRqYG5kjhv1wytZCGB
        9MSS1OzU1ILUIpg+Jg5OqQYmPm6u+x5vuLc8FN2nFK7pFbX3l65NuJkyn/AmNtEHq5vCjxhq
        39rAxbdYiU9x4plDaSLJ3kv1GhaWf4pWVNI6J93r6fR5V1cNn2pgTQcz+5659l4yjTzf1pR+
        qbq4/gHL25b6N0782+LF9boLms+sYZ5X/37Xbot0PUPBhdalE6as+TBl95QYvYtT65bIv14n
        cNv1ZJOv1NYfJn/iV+34k7p9Rt75VT4JDjf8t/34oLGu8HPn/qlqHjv/lazZb8Qk0ZHgdrOz
        w33JzU0Vk/9aurQtTeNny81wLb+nwLtEws2lmVVCau5WiyWnqlwZ6wrfxnnGV9VdPVq37NKO
        ZlvnrW41Bknpm98Hr930rkCJpTgj0VCLuag4EQDm0eZTOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvK4Nf0eywb+d/BYP5m1js/g76Ri7
        xc0JaxgtJrV/YbWYf+Qcq8WdBdOYLE4tX8hk0bx4PZvFnJtGFncf/mCx6HvxkNliyp/lTBab
        Hl9jtbi8aw6bxYzz+5gsFi1rZbZo3jSF1aJ17xF2i667N4DGHRS1+LXlFaODqMfvX5MYPXbO
        usvusXjPSyaPTas62TzuXNvD5rF/7hp2j81L6j36tqxi9Fi/5SqLx+dNcgFcUVw2Kak5mWWp
        Rfp2CVwZ5/7xFWxgrzj3oKyBsYW1i5GTQ0LARKLtaS9TFyMXh5DADkaJyUt3M0MkJCWWzr3B
        DmELS9xvOcIKUfSNUeLlr9NsXYwcHGwCWhLfFzKCxEUEfjFLvPjdzAziMAt8YJY40rmBDaRb
        WMBL4uqH2WBTWQRUJU5+fw22mlfATeJW00eoM+Qkbp7rZJ7AyLOAkWEVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZw8Gtp7WDcs+qD3iFGJg7GQ4wSHMxKIrwdn9uShXhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDakpv0o1TgterFJ1eNMqfc
        j4k8+c11NXPfxwUHXk3VZ9hdFrE2NFTeY1nMHD8hlndT2uS+FWtUWp9/yp57bsLKmYY3nj34
        87J810MN7pUZjRuYFt5fOO9VbFtSfXpZ9osb3Ic3fjkTfT/iwOb//04+vHT663e9GUsT17A1
        8lgZWqzOUlCMtZ+g2/K7QG/bHcZ64ZSzn51LUy7vrb9V1ftI9o6GkkHZpi+HtS1jds17y1/f
        9vWmmtiKtvO6Vd8eLMwJvnbT7MCNvOalT63yvitzud7nvrJZ8rpNzr85NXbdkvvPhhv75J25
        GH+xKXp/5ZEZermO6/K55sy9t786OMghcEat6IttjnsEZJ//l/wWqcRSnJFoqMVcVJwIANwK
        yGztAgAA
X-CMS-MailID: 20221201021940epcas2p2073f25dad069314022471eaa16d26592
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021940epcas2p2073f25dad069314022471eaa16d26592
References: <CGME20221201021940epcas2p2073f25dad069314022471eaa16d26592@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to support xHCI Controller on Samsung Exynos SOCs.

Daehwan Jung (2):
  dt-bindings: usb: samsung,exynos-xhci: support Samsung Exynos xHCI
    Controller
  usb: host: add xhci-exynos to support Exynos SOCs

 .../bindings/usb/samsung,exynos-xhci.yaml     |  25 +++
 drivers/usb/host/Kconfig                      |   8 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-exynos.c                | 154 ++++++++++++++++++
 drivers/usb/host/xhci-hub.c                   |   2 +
 drivers/usb/host/xhci-plat.c                  |   6 +
 drivers/usb/host/xhci-plat.h                  |   2 +
 drivers/usb/host/xhci.c                       |   4 +
 drivers/usb/host/xhci.h                       |   2 +
 9 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
 create mode 100644 drivers/usb/host/xhci-exynos.c

-- 
2.31.1

