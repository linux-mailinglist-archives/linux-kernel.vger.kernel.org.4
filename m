Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE66D7BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjDELpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjDELpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:45:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE456191
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:45:15 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230405114448epoutp014932628edb8050eb340d840545a0ff27~TB0c_lqxB3157131571epoutp01D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230405114448epoutp014932628edb8050eb340d840545a0ff27~TB0c_lqxB3157131571epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680695088;
        bh=rVfuadgpm2r+fbODJBwW7FHg9iGMIKszhoNLes3w9/k=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=FA3CfjNuiS/4p0NaMWX8nDkK02qQZsd53jXmnWoskvT9M2wac9xwWn9Q3cJ/6Clh+
         7a9zYg9b4x/1zKkCNqZlsahuWDxDKWehGi1YyppF0tNugU21Hm4MX6k1pAtOp547ZK
         Z/cgRWMX2ZKpGZaBMYS079RsreUwSzcMS4zw5sCg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230405114447epcas2p437f613334472a210992fd02a52044d07~TB0cNqgjI1493614936epcas2p4L;
        Wed,  5 Apr 2023 11:44:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Ps2qM12Npz4x9Pt; Wed,  5 Apr
        2023 11:44:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.36.08750.F2F5D246; Wed,  5 Apr 2023 20:44:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230405114446epcas2p407c9cec3d428fd5108df91645a1088dc~TB0a3BlRE1493614936epcas2p4K;
        Wed,  5 Apr 2023 11:44:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230405114446epsmtrp10124bd5287285a01281511652f9c15c1~TB0a2RhRK2604326043epsmtrp1c;
        Wed,  5 Apr 2023 11:44:46 +0000 (GMT)
X-AuditID: b6c32a47-9f5fe7000000222e-59-642d5f2fdbc5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.D7.18071.E2F5D246; Wed,  5 Apr 2023 20:44:46 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230405114445epsmtip1c6f71047a0f6d677803115fad54d4f5b~TB0alHfz_1454714547epsmtip1T;
        Wed,  5 Apr 2023 11:44:45 +0000 (GMT)
Message-ID: <d5627bf6-8cae-f260-f18e-6259a40237c3@samsung.com>
Date:   Wed, 5 Apr 2023 20:42:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] spi: s3c64xx: support spi polling mode using
 devicetree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <c1163417-16ea-63ee-5b8d-47cdff8069b1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmua5+vG6KwdIJLBYP5m1js1j84zmT
        xdSHT9gsLu/Xtph/5Byrxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE748j1D4wF67kqJq5+w9jAuI+ji5GDQ0LARGLz
        lcQuRi4OIYEdjBKzL51mg3A+MUrsnnGeEcL5xiixePI9pi5GTrCOSZ/fQiX2MkqcvbeCHcJ5
        zShxd9pzFpAqXgE7ifa2a4wgNouAisTbn3OZIOKCEidnPgGrERWIkui7vYkVxBYWCJJYefA+
        mM0sIC5x68l8JpChIgJHGSW273zLCuIwC5xnlLj8+T9YN5uAtsT39YvBOjiBtr298o4Rolte
        YvvbOcwgDRICazkkzrd+YIM43EWib/JmqCeEJV4d38IOYUtJvOxvg7KzJdqn/2GFsCskLm6Y
        DdVrLDHrWTsjKMiYBTQl1u/Sh4SessSRWywQa/kkOg7/ZYcI80p0tAlBNKpJ3J96DmqIjMSk
        IyuhDvCQOPpzG9MERsVZSMEyC8n7s5A8Mwth7wJGllWMYqkFxbnpqcVGBcbw2E7Oz93ECE65
        Wu47GGe8/aB3iJGJg/EQowQHs5IIr2qXVooQb0piZVVqUX58UWlOavEhRlNg5ExklhJNzgcm
        /bySeEMTSwMTMzNDcyNTA3MlcV5p25PJQgLpiSWp2ampBalFMH1MHJxSDUy17sv0U5dv+D9r
        fqX76/QlV2T0L/1vDJi8wYyt6LRprJ8zm3DNnyK+pqedrYdPMqzYd5g7PDJRavv+lxN50vce
        j5RfrJe0yXmm88qb5158juuevznxzOQDJfk8mYWr3d8/nxZRdFeqROyc5JRd29hmFR/MapW/
        +77gqbMEZ/Hd2TFfNlbO3KOn7Hel7H/qqU/dz5Zye72/I3ZubUxNv+7DvRcOLLrwY5v93uhZ
        r86WZfyYubY5Y9FJvcYJ9mZ/CkKXL+y7mpF/qST1AsNa9R9XSr4dZNdkUvaUrlunNk3knUSZ
        7ObNQnc4Fj/5kH315qfFixfXr8qcyhF/tf8m08TTC5ITV+neYjV4z+riPWPqYSWW4oxEQy3m
        ouJEAMYDeDhCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK5evG6KwZynrBYP5m1js1j84zmT
        xdSHT9gsLu/Xtph/5Byrxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJVx5PoHxoL1XBUTV79h
        bGDcx9HFyMkhIWAiMenzW8YuRi4OIYHdjBI7v/UxQSRkJJY/62ODsIUl7rccYYUoeskosW7W
        W3aQBK+AnUR72zVGEJtFQEXi7c+5TBBxQYmTM5+wgNiiAlESnw+0gNULCwRJrDx4nxXEZhYQ
        l7j1ZD5YvYjAUUaJ5UdqQRYwC5xllDh+bALUtt+MEtN3zQTrZhPQlvi+fjFYNyfQ5rdX3jFC
        TDKT6NraBWXLS2x/O4d5AqPQLCSHzEKycBaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07M
        LS7NS9dLzs/dxAiONC3NHYzbV33QO8TIxMF4iFGCg1lJhFe1SytFiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqY+E8mw7SqW/KxqpXOPWQXW2C5gXVge
        revNsYd5z+RTvwvOJk3JPHO68uJj7bd/lM8eODh/7mUtX+c+v7zg8hVi5d8YzzRurtUJlv9S
        9MvcTSDoQbm47YPLBZs/c6ecmHNnQdA9v3/yhTMWhcRoGdfyrFCo+HKCU3v+z8tvPs5t6avl
        m3rUV0tL2O79+Zv+RdsZZO9wqe/idLr84JzzUeNUprrlzXvWnak53jDlyf40lUdmiwKTFfS8
        Cg1vdG/ivffS+WzE3IIyjg3LcqZmvRWdoaNUxtFVv3D9s6L1DlnZW+M1JJiepCu3Ku+9zpS9
        VHbV7fiHqcf/mD3czFP0JfkHg27p9PlbFwhwRObekFNiKc5INNRiLipOBABc8m3NIwMAAA==
X-CMS-MailID: 20230405114446epcas2p407c9cec3d428fd5108df91645a1088dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
        <20230404060011.108561-2-jaewon02.kim@samsung.com>
        <c1163417-16ea-63ee-5b8d-47cdff8069b1@linaro.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 5. 14:42, Krzysztof Kozlowski wrote:
> On 04/04/2023 08:00, Jaewon Kim wrote:
>> This patch adds new 'samsung,spi-polling' property to support polling mode.
> Do not use "This commit/patch", but imperative mood. See:
> https://protect2.fireeye.com/v1/url?k=3cb451b1-5d3f4488-3cb5dafe-000babffae10-4326e9d41dfad262&q=1&e=1125b69d-6d9e-4c91-a8fd-3470cd2278e4&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17.1%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L95
>
> Also, binding should be before its usage.

thanks.

I will refer to it in next version.

>> In some environments, polling mode is required even if DMA is supported.
> Why? What are these environments? You need to explain all this in commit
> msg.
>

We are providing a VM environment in which several Guest OSs are running.

There are cases where DMA exist only in HostOS and not exist in GuestOS.
In this case, SPI in GuestOS runs with polling mode.

I thought it was correct that the polling mode was supported optional, 
not quirk.
I have plan to change the polling mode if there is no 'dmas' property.

How about your opinion?


>> Changed it to support not only with quick but also optinally with
> typo: optionally
>
>> devicetree.
>>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

