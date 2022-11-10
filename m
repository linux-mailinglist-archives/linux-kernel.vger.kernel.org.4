Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D90624477
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKJOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKJOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:36:49 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E3BE27
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:36:48 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221110143641euoutp028092b905ca73de8a1668c7d98ad779d9~mP_19nQ_Z1016610166euoutp02j
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:36:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221110143641euoutp028092b905ca73de8a1668c7d98ad779d9~mP_19nQ_Z1016610166euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668091001;
        bh=gj/AdkxUzVsV/0YdznJkyQoyP7aZyvShh6RaRWo2Jic=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=l4aVBFHo8+gzJIxqjUsfcyniSyJtxPy8gDAmKCV2FMCckJUg/rTOzRxoCb+LO94w5
         5SqLTZXJNY1MhuU/dn2jnrTXiL3x65adn2mjgFUzRrLnqQ0j0tEEZfFBqCp4CCtEBS
         PU74uUMJgTv+uut0htpvwiXuAgFhlDaSUNNx0fQY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221110143640eucas1p1c457cfded6007504a0763fbac8215380~mP_1rDX-11437514375eucas1p1b;
        Thu, 10 Nov 2022 14:36:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.3A.09561.87C0D636; Thu, 10
        Nov 2022 14:36:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221110143640eucas1p11e1b4044fef739ba2939d68c67908b95~mP_1HxL7x1847618476eucas1p1d;
        Thu, 10 Nov 2022 14:36:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221110143640eusmtrp114a1bc6b3cc7f9e514d5c09ff68b1ba4~mP_1HBs0M2762727627eusmtrp10;
        Thu, 10 Nov 2022 14:36:40 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-ac-636d0c785119
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.85.09026.87C0D636; Thu, 10
        Nov 2022 14:36:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221110143639eusmtip1c2028e6091f26dd1db26bc74b365e1a0~mP_0ONUGY1845918459eusmtip1u;
        Thu, 10 Nov 2022 14:36:39 +0000 (GMT)
Message-ID: <b7ad6444-e7d2-1150-6134-3dae8129dcdb@samsung.com>
Date:   Thu, 10 Nov 2022 15:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>
In-Reply-To: <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87oVPLnJButXGVo8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMlr837OD3eLghyesFl2H
        /rJZPO8DSpy6+5nd4vj7x4wWLXdMHQQ9nhycx+SxZt4aRo+ds+6yeyzYVOqxaVUnm8eda3vY
        PDYvqfd4sXkmo0ffllWMHp83yQVwRXHZpKTmZJalFunbJXBl7Hy6kLlghUZFV/8spgbG44pd
        jJwcEgImEr8eHmQFsYUEVjBKzPkd1MXIBWR/YZQ4dO0EM4TzGSjx+TQ7TMf7hUfYIRLLGSVa
        nt1gg3A+MkpMWH+OEaSKV8BOYte9C0A2BweLgKrE8p/GEGFBiZMzn7CA2KICKRILt9xgArGF
        BWwlWuecAFvALCAucevJfLA4m4ChRNfbLjYQW0QgTeLqv/usILuYBVawSJzfuwkswSlgL7Ft
        8g8miGZ5ieats8HOlhA4xSkxccZedpAjJARcJJbe4YP4QFji1fEtUN/ISJye3MMCUd/OKLHg
        930mCGcCo0TD81uMEFXWEnfO/WIDGcQsoCmxfpc+RNhR4sG1o4wQ8/kkbrwVhLiBT2LStunM
        EGFeiY42IYhqNYlZx9fBrT144RLzBEalWUjBMgvJ+7OQfDMLYe8CRpZVjOKppcW56anFhnmp
        5XrFibnFpXnpesn5uZsYgenw9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRFebo3sZCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8bDO0koUE0hNLUrNTUwtSi2CyTBycUg1MXO+2L11Qd7XJYdaKlzoq
        BtZ3gtlu9jMKz5towfy0IFX4P5+wzMY75spq955+/Cn4J7mzsHEvwypGHYYJATuTOyd/4fT9
        flt7pfHHyVNflSSc3jrzUtTU060NM0sWztPP0nh7RpJx79Vzl0vct8ptj7L7uPzzprtlh+Ri
        LHyTGXiOXJkwYcZt5qz2LrbZVeYaBj0LGNdy11cd8HJxy3HwM0i+a1h8aNft1uSTZQd95/yr
        /BJn36cptaEnKl91TYbhEi8Zzdjvdfu6+fu0vC7/XBNR4TOzuy7h4pntvpWR/keY2iJlr1vZ
        +brIvqn7Y31o4ray2ilHPK4523Q9ThTIjZ96L/Vvzpcp5yNb93cosRRnJBpqMRcVJwIAexww
        JPYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7oVPLnJBg++81g8mLeNzWJCRyuT
        xa8vFhab5xRbdM7ewG6x9/VWdotNj6+xWlzeNYfNYsb5fUwW/3oPMlr837OD3eLghyesFl2H
        /rJZPO8DSpy6+5nd4vj7x4wWLXdMHQQ9nhycx+SxZt4aRo+ds+6yeyzYVOqxaVUnm8eda3vY
        PDYvqfd4sXkmo0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8da
        GZkq6dvZpKTmZJalFunbJehl7Hy6kLlghUZFV/8spgbG44pdjJwcEgImEu8XHmHvYuTiEBJY
        yijxfs4+RoiEjMTJaQ2sELawxJ9rXWwQRe8ZJWYe2cUOkuAVsJPYde8CUAMHB4uAqsTyn8YQ
        YUGJkzOfsICERQVSJNYdiQIJCwvYSrTOOQHWySwgLnHryXwmEJtNwFCi6y3IeE4OEYE0iX2T
        XjOCrGIWWMUisejjSyaIvScYJVp+vgE7jlPAXmLb5B9MEJPMJLq2djFC2PISzVtnM09gFJqF
        5I5ZSBbOQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIEJYNuxn1t2MK589VHv
        ECMTB+MhRgkOZiURXm6N7GQh3pTEyqrUovz4otKc1OJDjKbAsJjILCWanA9MQXkl8YZmBqaG
        JmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUw+p5KztnlozHGUjWZfefDTv/w/
        qfP/+t4NvfP71OfrzROtF8y9yOf+Y8L/Rka9ZWdZPt1Z09ZmnWRoPMnVR22LwzKVFVqi6nHC
        OubxaaFef+6d3muziOFyxevLrzLnTch1mLvsvuids9uLeutCDVutql9HHSyZtP18URmrqYDN
        2kPfF1oJ8rjN5T8n/vDRpVue7hHXlP6+TEtf6+3g1GjZ9fxj8mGH/82LlrU1f2+MdL+SHbX/
        4JlYTy+RrMPbXhU1/4sslnDp3tx3YGeu8APd0uS2/w1OS67xmBfM4nv66BL/jb74O+ql7LKe
        Vv//NBj1lZsJ6b88l7HoZPA2N+Xg3Qtu9YlJCZzWeCB0ykeJpTgj0VCLuag4EQBDMGOCiQMA
        AA==
X-CMS-MailID: 20221110143640eucas1p11e1b4044fef739ba2939d68c67908b95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
        <20221103195154.21495-1-semen.protsenko@linaro.org>
        <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.2022 13:10, Marek Szyprowski wrote:
> On 03.11.2022 20:51, Sam Protsenko wrote:
>> As exynos-iommu driver is not a critical platform driver, it can be
>> converted to a loadable module to avoid loading it on non-Exynos
>> platforms in order to improve the RAM footprint. This patch series
>> converts it to a module and does some related cleanups. IOMMU/DMA
>> specifics were taken into the account, so remove/exit methods weren't
>> added.
>>
>> There are two drivers using CONFIG_EXYNOS_IOMMU in their code:
>> DRM_EXYNOS and S5P_MFC. Both were checked, and only a slight change was
>> needed for S5P_MFC driver (patch #6).
>
> Funny, compiling this driver as a module revealed an issue in the 
> driver initialization sequence, here is a fix that need to be applied 
> before this patchset:
>
> https://lore.kernel.org/all/20221104115511.28256-1-m.szyprowski@samsung.com/ 
>
>
> Besides that, the driver nukes with NULL pointer dereference in 
> exynos_iommu_of_xlate() when compiled as a module on ARM 64bit 
> Exynos5433 based TM2e board. ARM 32bit based board works fine. I'm 
> checking this issue now.
>
I've finally made Exynos IOMMU working as a module on Exynos5433 based 
TM2e board. It looks that this will be a bit longer journey that I've 
initially thought. I've posted a simple update of the fix for the driver 
initialization sequence, but the real problem is in the platform driver 
framework and OF helpers.

Basically to get it working as a module I had to apply the following 
changes:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3dda62503102..f6921f5fcab6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -257,7 +257,7 @@ static int deferred_devs_show(struct seq_file *s, 
void *data)
  DEFINE_SHOW_ATTRIBUTE(deferred_devs);

  #ifdef CONFIG_MODULES
-int driver_deferred_probe_timeout = 10;
+int driver_deferred_probe_timeout = 30;
  #else
  int driver_deferred_probe_timeout;
  #endif
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 967f79b59016..e5df6672fee6 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1384,7 +1384,7 @@ static struct device_node *parse_interrupts(struct 
device_node *np,
  static const struct supplier_bindings of_supplier_bindings[] = {
         { .parse_prop = parse_clocks, },
         { .parse_prop = parse_interconnects, },
-       { .parse_prop = parse_iommus, .optional = true, },
+       { .parse_prop = parse_iommus, },
         { .parse_prop = parse_iommu_maps, .optional = true, },
         { .parse_prop = parse_mboxes, },
         { .parse_prop = parse_io_channels, },

Without that a really nasty things happened.

Initialization of the built-in drivers and loading modules takes time, 
so the default 10s deferred probe timeout is not enough to ensure that 
the built-in driver won't be probed before the Exynos IOMMU driver is 
loaded.

The second change fixes the problem that driver core probes Exynos IOMMU 
controllers in parallel to probing the master devices, what results in 
calling exynos_iommu_of_xlate() and exynos_iommu_probe_device() even on 
the partially initialized IOMMU controllers or initializing the dma_ops 
under the already probed and working master device. This was easy to 
observe especially on the master devices with multiple IOMMU 
controllers. I wasn't able to solve this concurrency/race issues inside 
the Exynos IOMMU driver.

Frankly speaking I don't know what is the rationale for making the 
'iommus' property optional, but this simply doesn't work well with IOMMU 
driver being a module. CCed Saravana and Rob for this.

Without fixing the above issues, I would add a warning that compiling 
the driver as a module leads to serious issues.


>> Changes in v2:
>>    - Extracted the "shutdown" method addition into a separate patch
>>    - Added MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
>>    - Added MODULE_ALIAS("platform:exynos-sysmmu")
>>    - Added fix for S5P_MFC driver to work correctly with EXYNOS_IOMMU=m
>>    - Fixed checkpatch coding style suggestion with "--strict" flag
>>    - Rebased on top of most recent joro/iommu.git:next
>>
>> Sam Protsenko (6):
>>    iommu: Export iommu_group_default_domain() API
>>    iommu/exynos: Fix retval on getting clocks in probe
>>    iommu/exynos: Modularize the driver
>>    iommu/exynos: Implement shutdown driver method
>>    iommu/exynos: Rearrange the platform driver code
>>    media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc
>>
>>   drivers/iommu/Kconfig                         |   2 +-
>>   drivers/iommu/exynos-iommu.c                  | 355 +++++++++---------
>>   drivers/iommu/iommu.c                         |   1 +
>>   .../platform/samsung/s5p-mfc/s5p_mfc_iommu.h  |   4 +-
>>   4 files changed, 191 insertions(+), 171 deletions(-)
>>
> Best regards

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

