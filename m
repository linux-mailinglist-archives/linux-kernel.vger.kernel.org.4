Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B966D7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjAQIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjAQIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:21:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CD25E09
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:21:44 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230117082142epoutp048cbf234517489fa9846af76c796c8b3e~7Cu2nqr9R0594905949epoutp048
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:21:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230117082142epoutp048cbf234517489fa9846af76c796c8b3e~7Cu2nqr9R0594905949epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673943702;
        bh=ENCE8uiLf8l1fHPrs46GI/aw9Xxe4V1T7lZO3YvNhXk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DFVfVAV+H6JKsKeHA+GJJQzt2uHWpRmzAc3PW9yGrYICk9GWX043UlIiKlcdiNP6K
         dObbPlFv01XjfZmt8i38eaaI5RWAOz/vVhJ4qEqUV+BIbu028kISvyXVwtRDiCX7aX
         mRTLgykmuMiDLU7lqP1WMZJs3G0G+9ZyHC6hrgc0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230117082141epcas5p476e44f422744ae1abd079e6b6313ee64~7Cu2Bm3Bl0211002110epcas5p4D;
        Tue, 17 Jan 2023 08:21:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nx2100zPDz4x9Pw; Tue, 17 Jan
        2023 08:21:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.49.02301.39A56C36; Tue, 17 Jan 2023 17:21:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230116103841epcas5p17b33f2b6567935d6be59b4d2b5d9f847~6w9KzjTOU1456314563epcas5p1q;
        Mon, 16 Jan 2023 10:38:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230116103841epsmtrp20600063219915088cf83f394d7256cb8~6w9KyrIlu0521705217epsmtrp2D;
        Mon, 16 Jan 2023 10:38:41 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-a1-63c65a93bf2e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.F8.10542.13925C36; Mon, 16 Jan 2023 19:38:41 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230116103835epsmtip13afc6816ffd45f4df958c248f3fee2ff~6w9F47GGD0462804628epsmtip18;
        Mon, 16 Jan 2023 10:38:35 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v4 0/5] ASoC: samsung: fsd: audio support for FSD SoC
Date:   Mon, 16 Jan 2023 16:08:18 +0530
Message-Id: <20230116103823.90757-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ3dK1LFkg6ZZLBYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGo819jAW7eSrenZjK0sB4kbOLkZNDQsBEYu3s56wgtpDAbkaJtfuiuhi5
        gOxPjBKrD21nhEh8ZpQ42SUP03Dv6E52iKJdjBIvTh1ggnBamSR2vbsM1sEmYCqxak4jK0hC
        RKCJSaLtzUQWEIdZYCOjxOljD5lAqoQFXCWmf+9nBrFZBFQlfp7dARbnFbCR+Pq6gQlin7zE
        6g0HmEGaJQQ6OSTWTbvHBpFwkVgzdQ8rhC0s8er4FnYIW0ri87u9UDX5EtM+NkPZFRJtHzdA
        DbWXOHBlDtBFHEAXaUqs36UPEZaVmHpqHVgJswCfRO/vJ1DlvBI75sHYqhLrl29ihLClJfZd
        3wtle0i0b18CDa9Yieady5gmMMrOQtiwgJFxFaNkakFxbnpqsWmBYV5qOTymkvNzNzGCU6aW
        5w7Guw8+6B1iZOJgPMQowcGsJMLrt+twshBvSmJlVWpRfnxRaU5q8SFGU2CYTWSWEk3OBybt
        vJJ4QxNLAxMzMzMTS2MzQyVx3tSt85OFBNITS1KzU1MLUotg+pg4OKUamNQi+r9qKn298M9I
        yuJryXK+owu0hKyueGTzTptiEBe7aZug8L29/RYWTe2S74+lz91Zde4h55OKII1bG/dP3JYp
        NeFkin/h00OKza9rD0lunNxVrHGqVSY7dbJ4KUtp3qtar/mnlvnvc+F9tLR3yom1RbvDGRKZ
        +htXrxEz39tmui6ew8cz+a3JnTS/z5av2Y783r8zW8Rn3++cby+r4jaubeQzqakJtN7ht8bH
        lV98xuTAfWlWuQbs9+aYXrlpr6HuGzdhwyWR9TE+1gwal823msR/WOMsW5DXtHqf5hbG/ISf
        xVLckw1C2bRnLb40JYc9oN4sY5Py3/A9dnEG9blndsxsdjZpO+9mk9OhxFKckWioxVxUnAgA
        hEGw4CIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnK6h5tFkg74LnBYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK+PR5j7Ggt08Fe9OTGVpYLzI2cXIySEhYCJx7+hO
        9i5GLg4hgR2MEs8nH2aBSEhLTO/fwwZhC0us/PecHcQWEmhmkli8SRDEZhMwlVg1p5EVpFlE
        YAKTxMl3x8CamQW2MkpM/WwEYgsLuEpM/97PDGKzCKhK/Dy7gwnE5hWwkfj6uoEJYoG8xOoN
        B5gnMPIsYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLxaWjsY96z6oHeIkYmD
        8RCjBAezkgiv367DyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwLSmr6krWeTj/4dsJaT1ZjFWPjs9L5pD5PzH694oTqw338xgmR3WJ/GjlPhZT/8G4
        Pu9NVMo7aWGeIgFPt4B14WcWb372I0PuZpTumiOfFa78rDmsd6wvmVOlJP3AOmWHNo0T1xIi
        1Pf/rLVX/vI/I0Wi+Er+5Ou3bNW9ktO1jX7Hp/QWvNULmLB9XmbMrICf/YzHrRzqLlUumNSn
        IFa00+nGuiTVGCtz48KzR3uCDiov+RTYu+WputG8Ny/V0ll7Fv24uvfO1IuFC1RtDzjbX+W+
        K7M5NmLxjbL7PvoN+cwyR4Md82dP2vlojbuc4AZ+Dr7gqm2f/t7dd9svV+5rQJndZC/PPVPk
        IxYKTz6vxFKckWioxVxUnAgAJ7JgIc0CAAA=
X-CMS-MailID: 20230116103841epcas5p17b33f2b6567935d6be59b4d2b5d9f847
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230116103841epcas5p17b33f2b6567935d6be59b4d2b5d9f847
References: <CGME20230116103841epcas5p17b33f2b6567935d6be59b4d2b5d9f847@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables audio support on FSD SoC.

Changes in v4:
1. Rebased and addressed review comments provided for v3.

Changes in v3:
1. Addressed all the review comments provided for v2 patch.
2. Fixed compilation warnings reported by kernel test robot.

Changes in v2:
1. New compatible added in Exynos I2S driver for FSD platform.
2. Added Fixup support for Exynos I2S CPU DAI.
3. Migration of manual PSR, OPCLK configuration to Exynos CPU DAI driver as
fixup.
4. Migrated from dedicated sound card to simple audio card.
5. Support added for tlv320aic3x-i2c codec on FSD platform.

Changes in v1:
1. Add TDM support on samsung I2S interface.
2. Allow sound card to directly configure I2S prescaler divider instead of
calculating it from frame clock.
3. The sound card support for FSD SoC which utilizes samsung I2S interface
as CPU DAI.

Padmanabhan Rajanbabu (5):
  ASoC: dt-bindings: Add FSD I2S controller bindings
  ASoC: samsung: i2s: add support for FSD I2S
  arm64: dts: fsd: Add I2S DAI node for Tesla FSD
  arm64: dts: fsd: Add codec node for Tesla FSD
  arm64: dts: fsd: Add sound card node for Tesla FSD

 .../bindings/sound/samsung-i2s.yaml           |  8 +++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         | 53 +++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    | 14 +++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 34 ++++++++++++
 sound/soc/samsung/i2s-regs.h                  |  1 +
 sound/soc/samsung/i2s.c                       | 53 +++++++++++++++++++
 6 files changed, 163 insertions(+)

-- 
2.17.1

