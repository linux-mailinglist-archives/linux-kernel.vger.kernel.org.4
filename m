Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822F65BACF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjACGmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjACGlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:41:45 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64BD2C1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:41:12 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103064111epoutp02e7e89b47282b25054c846f6d9cce2feb~2uVF65k_L2422124221epoutp02k
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103064111epoutp02e7e89b47282b25054c846f6d9cce2feb~2uVF65k_L2422124221epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672728071;
        bh=1ReRAfpeh1MSSD77tI0zpKu9YMwmp16crnYuBUSqzqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkFUKjVTR7u5qWr6MkTYck2GYqiPsjDvBX/6FKCop2ybfMbSAkbGWCbN/CjhicO0v
         plwBwz7yb8J87OptjAXo7QnHLovQjbEyVRYHGC36FkrwelraIp0HXCsr5xtaGOWJeD
         JtRFZpEAr50YSCNltYhrzBe8hbfX4lGPkv4rVLA8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230103064110epcas5p261908bac01064dad001c6a9c10e5b0cb~2uVFX3qkU0184601846epcas5p29;
        Tue,  3 Jan 2023 06:41:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NmNRS5hyBz4x9Pv; Tue,  3 Jan
        2023 06:41:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.62.02301.40EC3B36; Tue,  3 Jan 2023 15:41:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08~2s6Ah5dF21484514845epcas5p45;
        Tue,  3 Jan 2023 04:56:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230103045651epsmtrp1239949080f05989e00cf6c1e8ab2383e~2s6AhD-mg0133401334epsmtrp1k;
        Tue,  3 Jan 2023 04:56:51 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-1c-63b3ce04b406
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.05.10542.395B3B36; Tue,  3 Jan 2023 13:56:51 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045649epsmtip2c01f9ae368ec09b98e847b94a0fd74b7~2s5_VBlcw0074100741epsmtip2r;
        Tue,  3 Jan 2023 04:56:49 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2 1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
Date:   Tue,  3 Jan 2023 10:26:09 +0530
Message-Id: <20230103045613.100309-2-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103045613.100309-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmpi7Luc3JBn23dS0ezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMB2famQoWcFZcX/GVqYFxF3sXIweHhICJxJkbGl2MXBxCArsZJSYcuwkU
        5wRyPjFKHFsaCpH4zChx5fRSNpAESMO+vftZIBK7GCX+b7jOBuG0Mkmsn/WSBaSKTcBUYtWc
        RlaQhIhAE5NE25uJYC3MAhsZJU4fe8gEUiUs4CXR+GgxWAeLgKrEq3XTwWxeAVuJoz+vMEHs
        k5dYveEAM4jNKWAn8afjAhPIIAmBuRwSEy+9YYL4wkXiT18ARL2wxKvjW9ghbCmJl/1tUHa+
        xLSPzVA/VEi0fdwANd9e4sCVOSwgY5gFNCXW79KHCMtKTD21DqyEWYBPovf3E6hyXokd82Bs
        VYn1yzcxQtjSEvuu74WyPSQW3LrICAnHiYwSb7eyT2CUm4WwYQEj4ypGydSC4tz01GLTAsO8
        1HJ4pCXn525iBCdSLc8djHcffNA7xMjEwXiIUYKDWUmEd9KLTclCvCmJlVWpRfnxRaU5qcWH
        GE2BwTeRWUo0OR+YyvNK4g1NLA1MzMzMTCyNzQyVxHlTt85PFhJITyxJzU5NLUgtgulj4uCU
        amBy9X/hrcp4ra/hxAV28UMrldujQr2vXUh/obnLy7L//L4Va/XiVNVd45OtK1/H/b/B2BLi
        v5iN8VDsR7tNV2NdjE9vbI6MWPlhIftG/9C8Pfmn1JQf7emoj4/WbTh7WsrWeeH2B9dubFy1
        t2pVQW7P2xYmroWTLIVWpS17KpdpvPXSyf2pHg+dArJipwVnTlEW7+T7ZF8WfPDb8j8ra54F
        H3PrmDSzYMbvTedWbZRXNfzZeLrOp3CD0wUvYe/3T8rCRMxDnFt3bn4c8Lnz+I/lLl87Zk0r
        YPgRlSw/lU2bo9G49LuRxts2JeZHPTxfPnpP98h/IfHP6tF6r6Abz6bvNxMTbLht94ldNlv+
        0jolluKMREMt5qLiRACGw/mlLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO7krZuTDeY1G1k8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI4oLpuU1JzMstQifbsErowHZ9qZChZwVlxf8ZWpgXEXexcjJ4eEgInEvr37
        WboYuTiEBHYwSpyceIoZIiEtMb1/DxuELSyx8t9zdoiiZiaJtpnbwYrYBEwlVs1pZAVJiAhM
        YJI4+e4YC0iCWWAro8TUz0YgtrCAl0Tjo8VgcRYBVYlX66aD2bwCthJHf15hgtggL7F6wwGw
        oZwCdhJ/Oi6AxYWAarY3fGKewMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cLhrae1g3LPqg94hRiYOxkOMEhzMSiK8k15sShbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qB6UBNknvm/6v3fK0FH7otb1B4UDtxs1p/0JuDSpxzppU9
        1nrEeal6H/fTs/b3t+vdypCZrbrcwD5i2W/ZTWe3t/2buDVnQeZzf91SwZsLmh5vNzqjcPwa
        p8d5pcyVrV7lN2SUixU/BeWmxNwv5n+2VTns8e+OsujSZYV79f9r1v16/0bSRujnhGaR5vey
        ykmr+z/IHOiJNw8JrpYumP/vUTBDb0xpuMntmAXTIqZY5+eyteXpHt5+onGRwmPDY4KTS58U
        bNizP7NNYIbmoa+LF57fvHVq6oHuGydXvgme2OPgK3D2s/KC1aUBNYzla4Wa5PayCbeLX5xj
        abLZUuRgVW7PgRMXFrz1f1F2e+cKNyWW4oxEQy3mouJEADEMf9DmAgAA
X-CMS-MailID: 20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for FSD CPU DAI driver which supports stereo channel
audio playback and capture on FSD platform.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 Documentation/devicetree/bindings/sound/samsung-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 8d5dcf9cd43e..ff187e16d301 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -37,12 +37,16 @@ properties:
       samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
       stereo channels. Exynos7 I2S1 upgraded to 5.1 multichannel with
       slightly modified bit offsets.
+
+      tesla,fsd-i2s: with all the available features of Exynos7 I2S,
+      supporting only stereo channel playback and capture.
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

