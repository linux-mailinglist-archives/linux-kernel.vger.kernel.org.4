Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735066D7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjAQIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbjAQIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:21:53 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30827D64
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:21:51 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230117082149epoutp03f40973d603cfc5bee03433446e12a127~7Cu9UMZr81530015300epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:21:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230117082149epoutp03f40973d603cfc5bee03433446e12a127~7Cu9UMZr81530015300epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673943709;
        bh=bEHQlhP4xZUGfK43GB8zShAe9/8hsMiGXcAwQLQzu2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSm0JEbWrMdDuM9+ACe4qmtnD1fUIFqxLbi+xbOPJNUh65dUqPjH5AV8OJ43opNNN
         GdH2Abmd6Voo4zxGpYeN2yJMCerbkYdUmhxolTpngmXJctuCLiDOymYRXI70OubGXN
         N9Ei5c7KACZKcQP6KP5UOyLqGK/L15gWOAsRF1fA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230117082148epcas5p20720b76357942044e9dfb4400cf31917~7Cu8alT4c0689506895epcas5p2t;
        Tue, 17 Jan 2023 08:21:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nx21700Lpz4x9Pw; Tue, 17 Jan
        2023 08:21:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.EF.03362.A9A56C36; Tue, 17 Jan 2023 17:21:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230116103849epcas5p2197a50d3dd2bd55a9c73d0f30fc438a5~6w9SoMEZq2382723827epcas5p2B;
        Mon, 16 Jan 2023 10:38:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230116103849epsmtrp1f385fa309d6824c53f1fd6e9c8370e2b~6w9Sh_CMj2177121771epsmtrp1L;
        Mon, 16 Jan 2023 10:38:49 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-4c-63c65a9a66df
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.F8.10542.93925C36; Mon, 16 Jan 2023 19:38:49 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230116103846epsmtip165a90c1613615da8d03818a87d2dc004~6w9PuJzqX0462804628epsmtip1_;
        Mon, 16 Jan 2023 10:38:46 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v4 1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
Date:   Mon, 16 Jan 2023 16:08:19 +0530
Message-Id: <20230116103823.90757-2-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116103823.90757-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpu6sqGPJBldOmFo8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZC2//Yi6YylNx+cpU5gbGx5xdjJwcEgImEtt/97J3MXJxCAnsZpS4+nom
        C4TziVHi4dUGNgjnM6PE29ZXQBkOsJZzy2Qh4rsYJQ51nGcFGSUk0MoksfdFNojNJmAqsWpO
        IytIkYhAE5NE25uJYGOZBTYySpw+9pAJpEpYwEti57Jv7CA2i4CqxMfejWA2r4CNxMQDt9kg
        DpSXWL3hADOIzSlgK/F17w1mkEESAgs5JOb+2sQCUeQicXvFPSYIW1ji1fEt7BC2lMTL/jYo
        O19i2sdmqKEVEm0fN0DV20scuDIH7DVmAU2J9bv0IcKyElNPrQMrYRbgk+j9/QSqnFdixzwY
        W1Vi/fJNjBC2tMS+63uhbA+JI5P+QoNuAqNET8cxlgmMcrMQVixgZFzFKJlaUJybnlpsWmCc
        l1oOj7bk/NxNjOBkquW9g/HRgw96hxiZOBgPMUpwMCuJ8PrtOpwsxJuSWFmVWpQfX1Sak1p8
        iNEUGIATmaVEk/OB6TyvJN7QxNLAxMzMzMTS2MxQSZw3dev8ZCGB9MSS1OzU1ILUIpg+Jg5O
        qQamB6aOPdb/Pae+btCZx3jjyr0fHJlmjyL022f8PLTttVSxztr56mwTJk15F7zEOmA2W9wf
        57AdnY+S+zQva8YxfHjO2aBrz+jeMs/w8yP9lee5VvdcO2549Pvc3VzrD9/Y/FUsRfFZjvEq
        CbcjPbdenGIpE/Fo/rbY9u6L71OkrYI2HLg049Fn+0DG4FdC3Te3b//2e/5OzsAQP9N3OZf2
        NX956LKCdcmT24ksidKzDlknbO5UPFbIYvBwx5XyS3p6sU42Scw92+UXmu6MSKkv8Df/tsYh
        TudfQHLcMdFmVW33YBbLg1m/r1+OeHJy5b9083UtBcfWqrmE/TiUHcc0/U6Z1oTu5J7CN45V
        TaUPlFiKMxINtZiLihMB1nns9C8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnK6l5tFkgxXbJC0ezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8bC27+YC6byVFy+MpW5gfExZxcjB4eEgInEuWWy
        XYxcHEICOxglPj3+yd7FyAkUl5aY3r+HDcIWllj57zk7RFEzk8SK3ZMZQRJsAqYSq+Y0soIk
        RAQmMEmcfHeMBSTBLLCVUWLqZyMQW1jAS2Lnsm9gU1kEVCU+9m4Es3kFbCQmHrgNtUFeYvWG
        A8wgNqeArcTXvTfAbCGgmicTzjNOYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
        dxMjONi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFev12Hk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Xug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgyn6i1PFPX/bptaV1vWb/NlcKh78VmPp1fX9Q+/OI
        7dx31v6d9O35fp1XMp2Vk2NrXBaUff2Yd/xFTFNgXejT0nsPZXh8UmOKliZtlCmJc31nl7+E
        VeFLasoLuWhe+94sLu/J/3b8KHrn69kx59/cV7/CN+SvsSstmsq4gmWPZ9XBslkH3l2Qlr54
        d4bTpckKX/5/4bp25+LnBU5KVx3D2z9cbjUPPuU4+8FJI7W3H/7Hn1V9PNVvQx9r+q/kuvVv
        LXdEyyrluncH69iUP77FlHntdg9LzNn9zB9ESrM/qrhwhqUvsqpY+Jb/3LnKk/4BCX4CLmZ8
        82sLggQE1oWczhNK3Sz+Vmp/4srvXwXNlViKMxINtZiLihMBHjZn3uUCAAA=
X-CMS-MailID: 20230116103849epcas5p2197a50d3dd2bd55a9c73d0f30fc438a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230116103849epcas5p2197a50d3dd2bd55a9c73d0f30fc438a5
References: <20230116103823.90757-1-p.rajanbabu@samsung.com>
        <CGME20230116103849epcas5p2197a50d3dd2bd55a9c73d0f30fc438a5@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for FSD CPU DAI driver which supports stereo channel
audio playback and capture on FSD platform.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

