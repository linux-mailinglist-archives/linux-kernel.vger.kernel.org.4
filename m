Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B9617628
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiKCF3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKCF3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:29:39 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0318399
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:29:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221103052936epoutp03c003f07f1433896e728ef04860c6b287~j-ALesIuR1535615356epoutp03J
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:29:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221103052936epoutp03c003f07f1433896e728ef04860c6b287~j-ALesIuR1535615356epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667453376;
        bh=yk0gzNNvyzYWTWiiBL/q0YCEEEOP0qJSawMKY7du018=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bbceF8pR9zquZGCxs8xd3V7Srt+kamCw+Ui7EeVCqvPlHAKiWGD3sjQ6OCAOSOOTh
         3SvxANYDtlYRXUuNHe/NppVKyqe+9wdqnxqSA/OG8Uy2DqAVz6zVerwxthUgcqboPz
         m8+p2zPHC8COM/5gjpPn9WSY3w2SY18ro0qWxL9g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221103052935epcas5p3fb7e1b3f0c62ff48af830dee70031c97~j-AK3p-Pe1058810588epcas5p34;
        Thu,  3 Nov 2022 05:29:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N2sl20JM2z4x9QL; Thu,  3 Nov
        2022 05:29:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.9B.56352.9B153636; Thu,  3 Nov 2022 14:29:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc~jxeit-Axi2760427604epcas5p3q;
        Wed,  2 Nov 2022 12:58:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221102125810epsmtrp195bbd5ddece8e028185a9f3abb3d3575~jxeirqWVw0619606196epsmtrp1C;
        Wed,  2 Nov 2022 12:58:10 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-dd-636351b9e830
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.BD.18644.16962636; Wed,  2 Nov 2022 21:58:10 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221102125806epsmtip1c8141a150bcf1a42bd23e065ab958e8b~jxefo-Nbg1911819118epsmtip1b;
        Wed,  2 Nov 2022 12:58:06 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [PATCH 1/3] arm64: exynos: Add new compatible string for Exynos3250
 SoC.
Date:   Wed,  2 Nov 2022 18:36:00 +0530
Message-Id: <20221102130602.48969-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHPffe3lZm2Q1odlaU1RtBxACtQjksotswyw2CwTnNIltYLXcU
        6Mve4itkYCY+UFE3MeWROspjBESQZ4GyIXQDFVyYYF2kEwRGYQ8XEabMkLUUtv8+5/f7fs/5
        5nfOEeA+/aRIkKoxsHqNXEWTXkRz96agkNY9CoWkd1iGJiwFPDRiaiZR6YtJDD0unSFQV0MT
        HzUOFuHom55OHrpmu8dDLbeeEOim09UdKHAQaPLaDYCmCn8hUZ5zFEf1Yw946H5bMYnO1zXx
        UI3NwUfl9gEMVdS/wpC56Tkf5XTY+MhhbQbo5Ckb9g5krpuuA8biKAOMvewZzrQWOvhMqXUK
        Y+qrzpLM8AMryTSUZTE5388TTF5jFWBybXaSman3Z+7MzvAThAfStylZeTKrF7MahTY5VZMS
        Te/amxSTFCGTSEOkUSiSFmvkajaa3hmXEPJ+qso1Alp8WK7KcJUS5BxHh23fptdmGFixUssZ
        omlWl6zShetCObmay9CkhGpYw9tSiWRLhEv4abry/PM5vu6c91FT109kNph9LResFEAqHH47
        6cTc7EO1A1g7sy8XeLn4GYCzZ/4AnsYMgBNGYtkwMD1BekRtAF56fILwLHIw2Dfv4OcCgYCk
        QmB/i8ptWE2dAHDsjMGtwanLBHyU58TdDV9qL+wxNZFuJqgAOLhQuBhDSEXDBkcxz3PaW7C6
        rhN3myHlFMDmp8sxdsKRnCu4h33hdE8j38MiOHXx1BIr4Jh5akmjgrXWK0veHbBzsJhwB8Wp
        TbC2LcxTXgfz79xYzIBT3vDCP+OYpy6EFtMyB8Li4RdL2dbC7upy4N4GUgyc/3WNZ1ifwBLr
        bewSWFf4/wFfA1AF3mR1nDqF5SJ0WzXskf+uSaFV14PFdx28ywKejPwV2gUwAegCUIDTq4VZ
        /YkKH2Gy/NhxVq9N0meoWK4LRLhGdhkXrVFoXR9DY0iShkdJwmUyWXjUVpmUfkNYagxW+FAp
        cgObzrI6Vr/swwQrRdmY42hamIB2jA/l+NeRx1ps3O45LviDH++umvZrMtd0CsTm71rjlZUn
        r86927FRfWCD+UIjG1fOVhT5SZ1bjld3BPT9kP/Z56v8srwPGh1xG4Fp0F4Qu8LsFVlxqHx9
        yUHjZt/Ui18cMQ4NWfJihHhQ5mn7/XjvTtG+98Ybf45r/7PC4Mx3vP70y5vtQSMRvcM7Ik+L
        R29lV0jS/y55tCe7ckxaFPuxfXtlr175MPHDgA3EqK7Ga79theqj3zrSYo0vZfJew8LAw82H
        avb7zyYq+Wvtd9fHxI29TJXtnrj91VVrfOvhMmLhXGB3v0pcYklJKAxMO6sW3WOoVwN9mb6/
        j2Rk0gSnlEuDcT0n/xdsJZq3YAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnG5SZlKywatLzBZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3eLu
        nm2MFi1tR5gcJDzWzFvD6LHj7hJGj+tLPjF77Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/W
        o79YPPq2rGL06Dpync3j8yY5j1NfP7MH8EZx2aSk5mSWpRbp2yVwZfR8+cZe0M1XMe/QJbYG
        xq/cXYycHBICJhIXXz1lA7GFBHYwStz4YwcRl5H433aMHcIWllj57zk7RE0zk8SstZVdjBwc
        bAK6Eme353QxcnGICLQySlxf2ckE4jALrGSRuL2xhwmkQVggUOL/yitgNouAqsSVf7PAbF4B
        W4nNd+ewQiyQl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNH
        S2sH455VH/QOMTJxMB5ilOBgVhLhrT8bnSzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QDk5i8ju9Hk4ev83+aPnh8x+zLmr8Lmw45cAXI5ZWy5NbcuppT
        qFJTXqDWu1T1msk2nTs9dkeXqs+91XFTpFV+Mp/2R/mptT5XiytzFl9YbVq9/eLLC30zMtgT
        T1uZZRi2TJKeN5P3b3VF01HPJZPvywgv8J/8atImzdmW5yJiVvgFWVjrxTW7l2jXbzvldLJo
        zcKOpeZOu9NlV939r+6Ysi6nZmfY6o3zrO+J51q//nFsCaOMzYmJOxlrD3+copAru2Rb2fRC
        3q924Ru9Lp5lLnm89/YhMecFbJLW9xfpPY4wvbPo/TYHwe+HmvqqG58e2pu35t78nhtiyxdf
        /mRt19EVdO+EO8P1jVPf/lHR+K7EUpyRaKjFXFScCAD8RHmvDQMAAA==
X-CMS-MailID: 20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc
References: <CGME20221102125810epcas5p36e6caf41f602debe17f25f13969fd6dc@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos3250 uses the same compatible as Exynos5420, but both
the MFC IPs found in these SoC are different interms of clock
property. So using same compatible for both SoC is not correct.
Lets have a separate compatible for Exynos3250 and Exynos5420
to differentiate these SoCs.

Suggested-by: Alim Akhtar <alim.akhtar@samsung.com> 
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 Documentation/devicetree/bindings/media/s5p-mfc.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

We are already in process of converting this txt file to yaml.
https://patchwork.kernel.org/project/linux-media/patch/
20221011122516.32135-2-aakarsh.jain@samsung.com/
modifying this txt binding for completeness.

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..4ff1898e5a51 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -11,9 +11,10 @@ Required properties:
 	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
 	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
 	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
+	(d) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC
+	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
+	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
+	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

