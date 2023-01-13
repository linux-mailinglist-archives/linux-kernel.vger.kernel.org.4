Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6F66983D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbjAMNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjAMNQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:16:03 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3A69B36
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:06:36 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230113130634epoutp03350ffba7d30775c68986a2280e0e7ae4~54Cb5zez73012130121epoutp03r
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230113130634epoutp03350ffba7d30775c68986a2280e0e7ae4~54Cb5zez73012130121epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673615194;
        bh=0XwGRAFMX1PSy7miOW2AcTEpgWzY73WjjNAbpysbZhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eL9tsfyMpyOcTM97KHRlMCsWfFM1pS50NOkhdaWPPPQHTzBn39hAcwprkpCILZKlP
         hIXRc4l4gEdfa7G7RhENouJNqO1gm+mc2XLWhpkz4h9HzzVmSxVLRZV6y7Nuz2zSfR
         ARTCO5akDcsgYd/iBDBKoYtN3Tt1ES5iRCRFNKzk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230113130634epcas5p3c94b4f866cb032d0596e3056ea0ed589~54CbZPdbp1099910999epcas5p37;
        Fri, 13 Jan 2023 13:06:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NthWX3FBtz4x9Pp; Fri, 13 Jan
        2023 13:06:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.94.62806.85751C36; Fri, 13 Jan 2023 22:06:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7~53YQ5EAYB0803308033epcas5p4E;
        Fri, 13 Jan 2023 12:18:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230113121816epsmtrp267fdec8d0b034de4cf536de8b355cc0e~53YQ4RnsW1441514415epsmtrp2e;
        Fri, 13 Jan 2023 12:18:16 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-a8-63c15758dc80
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.19.02211.80C41C36; Fri, 13 Jan 2023 21:18:16 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121813epsmtip2bf2ad7142481998e860fe65129d428ac~53YOVBxDd0850708507epsmtip2Y;
        Fri, 13 Jan 2023 12:18:13 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
Date:   Fri, 13 Jan 2023 17:47:45 +0530
Message-Id: <20230113121749.4657-2-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113121749.4657-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhm5E+MFkgzOfRCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMnovPWAsucVd82LKHpYFxKWcXIyeHhICJxIs9Mxm7GLk4hAR2M0pMPfSK
        HcL5xCjx/sxEJgjnG6PEjI8bWGFaGnfuYINI7GWUaDrxDcppZZJYNGcqG0gVm4CpxKo5jawg
        CRGBJiaJtjcTWUAcZoGNjBKnjz1kAqkSFvCSuL1pAzuIzSKgKjFx3howm1fAWqLz72OoffIS
        qzccYO5i5ODgFLCRWHo8F2SOhMBCDolD3Q+ZIWpcJG7d3MEEYQtLvDq+hR3ClpL4/G4vG4Sd
        LzHtYzOUXSHR9nEDVL29xIErc1hA5jMLaEqs36UPEZaVmHpqHVgJswCfRO/vJ1DlvBI75sHY
        qhLrl29ihLClJfZd3wtle0gcnHQGbJWQQD+jRP/E4AmMcrMQNixgZFzFKJlaUJybnlpsWmCU
        l1oOj7bk/NxNjOBkquW1g/Hhgw96hxiZOBgPMUpwMCuJ8O45uj9ZiDclsbIqtSg/vqg0J7X4
        EKMpMPgmMkuJJucD03leSbyhiaWBiZmZmYmlsZmhkjhv6tb5yUIC6YklqdmpqQWpRTB9TByc
        Ug1MWkylaR9W6b6xUOHc0ND732DRqSdegg/+7ourZ16xuyfr+NTnV3uXKv32cg/4XlUcUvP7
        utxkg3vHnNMei8SIbN5s8MV18e7ZV3VzFJLjl1ueaBF3ifxdt2b3NocVdwQCXs6bbr3mZFPI
        QpvGaxzrOTStGqde/XF2uYUbc0ujna7dhNkBMS9TjZLZ7lurfNsb+JrF+pe7+VWN5ucznA4H
        sv3QvKJ4fGXLnMophUZndtYZffZlSN5y6MntWQceyG2f43m9Z7KNxsSvDWcr35XWdDyZz8fW
        KrDn4rUa/5Ti0r5s59Q3HAvczic7TyqWqxfOeuUw45DMWmWXrr6a5md7nMU+qa7g3bFt7fSX
        LWs7lViKMxINtZiLihMBUYnYBi8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvC6Hz8Fkg57FUhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK6Pn4jPWgkvcFR+27GFpYFzK2cXIySEhYCLRuHMH
        WxcjF4eQwG5GiSOLm1ggEtIS0/v3sEHYwhIr/z1nhyhqZpJYfmAjE0iCTcBUYtWcRlaQhIjA
        BCaJk++OgXUzC2xllJj62QjEFhbwkri9aQM7iM0ioCoxcd4aMJtXwFqi8+9jVogN8hKrNxxg
        7mLk4OAUsJFYejwXJCwEVLL35WOmCYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn
        525iBAe7luYOxu2rPugdYmTiYDzEKMHBrCTCu+fo/mQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamJjcGZ42RIQdqPpl2ls39RrH/7ZTc3439bxY1bjh
        9sTbYkcOdfIfmHdGKzhe/kWr5ZT4DMOyo8duXGt4qmphs4T7gKq09MVaBvZdWy+/1ktV32D8
        eJeM/4JphtqT/64PiTa9rP9y4Wrz/nNFUU38l3lU7ks9nLGVkXuOjZGfud6jfUxxhglvamdf
        t+mZ68v40il/b1b2hKfHgipNZggvWndygXchwxdt1X1LrJM26HCZP8hqqv7960BdxkX/CK5l
        06o2s6vW/ZuUGjMx2ubMfPZZtyXaWno1S+ZaqS3lWRXgu8TC+9HFZPkffcdtZtRu3vxu5jaj
        1Dv/3Vb8XF/AxXqO2YN3sk78Pzb1t1Ke/5RYijMSDbWYi4oTAfE3dXHlAgAA
X-CMS-MailID: 20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for FSD CPU DAI driver which supports stereo channel
audio playback and capture on FSD platform.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 Documentation/devicetree/bindings/sound/samsung-i2s.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 8d5dcf9cd43e..7ae007591080 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -37,12 +37,20 @@ properties:
       samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
       stereo channels. Exynos7 I2S1 upgraded to 5.1 multichannel with
       slightly modified bit offsets.
+
+      tesla,fsd-i2s: for 8/16/24bit stereo channel I2S for playback and
+      capture, secondary FIFO using external DMA, s/w reset control,
+      internal mux for root clock source with all root clock sampling
+      frequencies supported by Exynos7 I2S and 7.1 channel TDM support
+      for playback and capture TDM (Time division multiplexing) to allow
+      transfer of multiple channel audio data on single data line.
     enum:
       - samsung,s3c6410-i2s
       - samsung,s5pv210-i2s
       - samsung,exynos5420-i2s
       - samsung,exynos7-i2s
       - samsung,exynos7-i2s1
+      - tesla,fsd-i2s
 
   '#address-cells':
     const: 1
-- 
2.17.1

