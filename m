Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523795FECEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJNLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJNLKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:10:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2EF248FE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:09:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221014110953epoutp02cfbbd6083b28b559f7e437fb6cfb3849~d6vlEel971905819058epoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:09:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221014110953epoutp02cfbbd6083b28b559f7e437fb6cfb3849~d6vlEel971905819058epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665745793;
        bh=drQIuJSWxplbdrmSqi94xu4iCzrCrkKp7js1FjD7pio=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tq2I/IEhnKRodIHvVU21HPJmi8wKOd7mzFMii7B7Fq0l00pszo4m70Z3yHMULMM7n
         dsBKnNv8eAoWcTzFbzFGgh9XF5luRpmLHNCUmS7d2jkDuynT8MKvZep2mu8lADcVEk
         Whd/a+8OGdvEq1w+RffvcRwwOvRiW9VoMHJTcA+Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221014110952epcas5p11a5258e1f88485433db3d40d6e13ca86~d6vka0eVV0967309673epcas5p1_;
        Fri, 14 Oct 2022 11:09:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MpkDv0VCGz4x9Px; Fri, 14 Oct
        2022 11:09:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.01.26992.E7349436; Fri, 14 Oct 2022 20:09:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221014104843epcas5p47f6daaad2e67e0c9eedd68c2256c025b~d6dGHtdk61505115051epcas5p44;
        Fri, 14 Oct 2022 10:48:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014104843epsmtrp1f2e0545eff7515ee01a22945843d750c~d6dGFpebY3160431604epsmtrp1j;
        Fri, 14 Oct 2022 10:48:43 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-ae-6349437e3d6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.2C.18644.B8E39436; Fri, 14 Oct 2022 19:48:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221014104840epsmtip1fcd4e8faf2d2e9cdcaf053d95ed04d5a~d6dD78-cs2737027370epsmtip1S;
        Fri, 14 Oct 2022 10:48:40 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH 0/6] ASoC: samsung: fsd: audio support for FSD SoC
Date:   Fri, 14 Oct 2022 15:51:45 +0530
Message-Id: <20221014102151.108539-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTU7fO2TPZ4OgnS4sH87axWVy5eIjJ
        4tDmrewWUx8+YbOYf+Qcq0Xfi4fMFt+udDBZXN41h81ixvl9TBZHNwZbLNr6hd2ic1c/q8Ws
        CztYLVr3HmG3OPymndViw/e1jA4CHhs+N7F57Jx1l91j06pONo871/aweex7u4zNo2/LKkaP
        9Vuusnh83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtjw+I9LAVveSoetys3MJ7l7GLk5JAQMJHo/P6NtYuRi0NIYDejxMU1XYwQ
        zidGidUvupggnM+MEjfen2HrYuQAazl1URsivotR4vfyeewQTiuTxKuD61hA5rIJmEqsmtMI
        NldEoIlJou3NRBYQh1lgI6PE6WMPmUCqhAWcJL4cfMQIYrMIqEp8bd8J1s0rYCsx/+ZdVogL
        5SVWbzjADNIsIdDJIdE/8TULRMJF4ufnKYwQtrDEq+Nb2CFsKYmX/W1Qdr7EtI/NbBB2hUTb
        xw1MELa9xIErc1hA/mEW0JRYv0sfIiwrMfXUOrASZgE+id7fT6DKeSV2zIOxVSXWL98EtVZa
        Yt/1vVC2h8TdG3/BbhYSiJU4fPEB+wRG2VkIGxYwMq5ilEwtKM5NTy02LTDMSy2Hx1Ryfu4m
        RnDK1PLcwXj3wQe9Q4xMHIyHGCU4mJVEeF8reSYL8aYkVlalFuXHF5XmpBYfYjQFhtlEZinR
        5Hxg0s4riTc0sTQwMTMzM7E0NjNUEuddPEMrWUggPbEkNTs1tSC1CKaPiYNTqoHJ5aOTPM+b
        t9pHbaMr2A9NL2SL1Wi74tvzRUesiGdZW3fW64fTXt3wvnK369w3D//dX2z9HytLzpc8UWl7
        Zf3nWQnM6zjiGU7tsi9dUhddfeREmcCe/wXfWf5L2OubGvMFvZ224ax66iGjzhdvwhP0Qpyz
        F3msin37XDNTV8Ytau++tTUuAqf7ZizKiHhiFScYadF968Q6Z8X+RYeNy88wtRoEzFxyVXpL
        ffHk9NkzGr27M/jLVTYGLbSSlt5vqfX40I9utqfLV/e5G7TcLZxw9unZqC18S/Lqb3/sWfsw
        umwp00+HSpbWF8HbTftPa4aIvAye+Fr8sdbx0/rLtc8dqZ/TFCX58qSfmGjf0g9KLMUZiYZa
        zEXFiQDpFQPNIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnG63nWeywYGZXBYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK2PD4j0sBW95Kh63KzcwnuXsYuTgkBAwkTh1UbuL
        kYtDSGAHo8Tjy8uYuhg5geLSEtP797BB2MISK/89Z4coamaSeLF0KSNIgk3AVGLVnEZWkISI
        wAQmiZPvjrGAJJgFtjJKTP1sBGILCzhJfDn4CKyBRUBV4mv7TrAaXgFbifk377JCbJCXWL3h
        APMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCQ1dLawfjnlUf9A4xMnEw
        HmKU4GBWEuF9reSZLMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgs
        EwenVANTuMzFVr8LG19fdqosP7Eov+vSRBvTN8uilj82SteuKOg0O3FqZ1BhTHOE8xZP0dIz
        u9dl2ysc2Bwze9OKXae9b+ZdSGvvKl9a/Znt8IZ79gtNPWY/eCk+u9AtJbvtn3rC5BOv9ptI
        fZpYuPrI88ci7cw7OxzWb5jM8N9j8Yqpa0O87bwXfU/2tmfu+MpzRPVpSpTa9WOuZS9Fzv/7
        e7rmqITZMv81l235JE3k1oVoblPVu8+VvlPcwqtx3hJ3hqrZnNpqeucvbayz7bnZqfRCJuwM
        /70V55vjFErnVi4X/HoxJn1V8H9hJ+71gVYfDHI37MjPCj/1/uTCCI1+Oem4rgO/b09XXLw8
        1+ujy9uzSizFGYmGWsxFxYkA8X98b8wCAAA=
X-CMS-MailID: 20221014104843epcas5p47f6daaad2e67e0c9eedd68c2256c025b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104843epcas5p47f6daaad2e67e0c9eedd68c2256c025b
References: <CGME20221014104843epcas5p47f6daaad2e67e0c9eedd68c2256c025b@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of this patch series is to enable audio support on FSD SoC.

The following features are added in samsung I2S interface:
1. Add TDM support on samsung I2S interface
2. Allow sound card to directly configure prescaler divider instead of
calculating it from frame clock

Also the sound card support for FSD SoC is added, which utilizes samsung
I2S interface as CPU DAI.

This patch is dependent on fsd-pinctrl fixes patch series [1]
[1]: https://lkml.org/lkml/2022/10/13/257

Padmanabhan Rajanbabu (6):
  ASoC: samsung: i2s: TDM Support for CPU DAI driver
  ASoC: samsung: i2s: configure PSR from sound card
  dt-bindings: sound: Add sound card bindings for Tesla FSD
  ASoC: samsung: fsd: Add FSD soundcard driver
  arm64: dts: fsd: Add I2S DAI node for Tesla FSD
  arm64: dts: fsd: Add sound card node for Tesla FSD

 .../bindings/sound/tesla,fsd-card.yaml        | 158 ++++++++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |  57 +++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  14 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  41 ++
 sound/soc/samsung/Kconfig                     |  12 +
 sound/soc/samsung/Makefile                    |   2 +
 sound/soc/samsung/fsd-card.c                  | 349 ++++++++++++++++++
 sound/soc/samsung/i2s-regs.h                  |  17 +
 sound/soc/samsung/i2s.c                       | 120 +++++-
 sound/soc/samsung/i2s.h                       |   1 +
 10 files changed, 766 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
 create mode 100644 sound/soc/samsung/fsd-card.c

-- 
2.17.1

