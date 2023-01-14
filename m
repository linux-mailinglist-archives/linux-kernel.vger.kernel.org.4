Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6985166A8D3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjANDF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjANDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:05:25 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0D53725
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:05:19 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230114030517epoutp036dc1754079cc73408ab341d36dcab73a~6DevBZNiv0555905559epoutp03k
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 03:05:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230114030517epoutp036dc1754079cc73408ab341d36dcab73a~6DevBZNiv0555905559epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673665517;
        bh=IeqQbaPWBtDxvABSPWDoLsqWKGkzoZDDfcdY5Av+50k=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=seLl8HSN/hSgjE9hOCV/FPADwWeWXQbwlbFSy+o4wWvWe3dI0TLU1hJVroxmLK5OJ
         61jESYsUylWFMTrToWZPpG0+03Vcosu6Q0uHckzxbHl72uv/99EH3WJ1V/lcc17/ZX
         bDjXZLQYZx3tQVV7cZIJcizQABEgzb0KdeWBoJhA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230114030517epcas5p1798d76e29921d35a0d46a2a041677124~6Deui2Yom1872318723epcas5p1s;
        Sat, 14 Jan 2023 03:05:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nv37J15X2z4x9Pp; Sat, 14 Jan
        2023 03:05:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.C5.62806.BEB12C36; Sat, 14 Jan 2023 12:05:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230114030515epcas5p249dacbb910d5ee94ae4b9bbd3e48c86e~6DetFx96I0854008540epcas5p2T;
        Sat, 14 Jan 2023 03:05:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230114030515epsmtrp134de7d127472aa4e6d765299933e3c0e~6DetFET2_2313223132epsmtrp1x;
        Sat, 14 Jan 2023 03:05:15 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-73-63c21beb50df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.23.02211.BEB12C36; Sat, 14 Jan 2023 12:05:15 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230114030514epsmtip2b532f7f26ca50fb757f7460710078a5f~6Der1ObKR2311423114epsmtip2s;
        Sat, 14 Jan 2023 03:05:14 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230113104050.30856-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] MAINTAINERS: arm64: tesla: correct pattern for
 directory
Date:   Sat, 14 Jan 2023 08:34:57 +0530
Message-ID: <080501d927c5$066c9440$1345bcc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQG4ERUqFGGV5mQZ188jC0FkCBCfZwGtOJkZrtH8zzA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhu4b6UPJBidyLQ5t3spuMf/IOVaL
        vhcPmS32vgZyL++aw2ZxdGOwReveI+wWt9+sY3Xg8Ni0qpPN4861PWwefVtWMXp83iQXwBKV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdISSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
        57fKgpdcFTdP7WVuYNzI2cXIySEhYCKxa+V5dhBbSGA3o8ThA45djFxA9idGiVdNm5ggnG+M
        EmfPd7DAdEw4cZIZIrGXUeLyzGaoqpeMEs8mTWIGqWIT0JXYsbiNDSQhIvCNSeLywtdASzg4
        OAVcJPZtlAapERbwl9gyoR+snkVAVeLulh42kBJeAUuJL9/EQcK8AoISJ2c+AVvMLCAvsf3t
        HGaIIxQkfj5dxgoRF5d4efQI2AsiAlYSF560gN0jIdDLIbFtwmxGiAYXia5V11khbGGJV8e3
        sEPYUhIv+9vATpMQ8JBY9EcKIpwh8Xb5eqhWe4kDV+awgJQwC2hKrN+lD7GWT6L39xMmiE5e
        iY42IYhqVYnmd1ehQSUtMbG7G2qph8TOY69ZISE1nVHi+ddupgmMCrOQfDkLyZezkHw2C2Hz
        AkaWVYySqQXFuempxaYFRnmp5fDYTs7P3cQITqBaXjsYHz74oHeIkYmD8RCjBAezkgjvnqP7
        k4V4UxIrq1KL8uOLSnNSiw8xmgJDfiKzlGhyPjCF55XEG5pYGpiYmZmZWBqbGSqJ86ZunZ8s
        JJCeWJKanZpakFoE08fEwSnVwBT2/JPUqoCQgzIhH+zK/Fui9zhpPZ22sHF5/yzprJNzLHZs
        fJ6jb8t9PmYDh/J176fKhtwa2h+md0134nK5ouh65LLogn3LF4l8W9V68Ur966wbr/7NW63M
        P29L4NF1a6Kcb5xVWcp+8b5T5Z3ahKRl01i+XPROnP49XvqS1kGvR21MVcdnlEb8cq5ifT5F
        erfBJ75TJ3WdT4fMenutJVL5V7fb8cmCf3lz3jcePOXrbSj54fDchnOxPPuacv/f+Kld7ejr
        J/DTfDHL93kNbxXbP/6WWLnu6b2t7jZrpn6y5FgZEBsa/8nc6E2Suc7iBKY/UglaU+QTJiRY
        zHtkHj/34lbHGdfnZOs6Km/ndn+qxFKckWioxVxUnAgA1UcelykEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO5r6UPJBlNey1sc2ryV3WL+kXOs
        Fn0vHjJb7H0N5F7eNYfN4ujGYIvWvUfYLW6/WcfqwOGxaVUnm8eda3vYPPq2rGL0+LxJLoAl
        issmJTUnsyy1SN8ugSvj57fKgpdcFTdP7WVuYNzI2cXIySEhYCIx4cRJ5i5GLg4hgd2MEodW
        /GGGSEhLXN84gR3CFpZY+e85O0TRc0aJzu7DLCAJNgFdiR2L29hAEiICv5gkNnYuhxo1lVFi
        6uI2xi5GDg5OAReJfRulQUxhAV+J3dfdQHpZBFQl7m7pYQMJ8wpYSnz5Jg4S5hUQlDg58wkL
        SJhZQE+ibSMjSJhZQF5i+9s5UKcpSPx8uowVIi4u8fLoEbAzRQSsJC48aWGawCg0C8mkWQiT
        ZiGZNAtJ9wJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHRoqW5g3H7qg96hxiZ
        OBgPMUpwMCuJ8O45uj9ZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
        MFkmDk6pBqYr87aVfNr1LvAW7+v5f/rX31vdfU7I67L6xFOfXwt2HZ8b+PKnHtM9ZlnnpDNz
        qpZdWC52/uQZmddv5U6cSyr++Oi4x9RHF//4CottYZm8bfn071Mv/Vvm3HFKsfLpnL0dT4o1
        c1xLlvmUpzFzdP21iBOe/+3dRH9lMyvNGyvPsyg5HFacudO5n9NNrPho7ta7UsvDaw8eu3SL
        6/rZPfP65nhdF9kuMVdjo9iTw0tPhHGZG0ToyiXHxh22/yF9VKCNi9VEn0XgSfp0/1Kvn0FK
        yxu28Ry87BMXktCx6rts7FTzKRu//t9aYruPOfeJ7XnvhHcOvM7zLjz4Gbv0tUt7eObW18eO
        Ld5yOE552uzLVkosxRmJhlrMRcWJABfPktoFAwAA
X-CMS-MailID: 20230114030515epcas5p249dacbb910d5ee94ae4b9bbd3e48c86e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113104058epcas5p49e66f63291864f8837c0ea88cf06a951
References: <CGME20230113104058epcas5p49e66f63291864f8837c0ea88cf06a951@epcas5p4.samsung.com>
        <20230113104050.30856-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, January 13, 2023 4:11 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Sriranjani P <sriranjani.p@samsung.com>;
>Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>; Aswani Reddy
><aswani.reddy@samsung.com>; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH] MAINTAINERS: arm64: tesla: correct pattern for directory
>
>The path is actually not a pattern but a directory, so correct it to be
effective.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---
Thanks!

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 997e75dbca5c..2f0c17c15391 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -3010,7 +3010,7 @@ M:	linux-fsd@tesla.com
> L:	linux-arm-kernel@lists.infradead.org (moderated for non-
>subscribers)
> L:	linux-samsung-soc@vger.kernel.org
> S:	Maintained
>-F:	arch/arm64/boot/dts/tesla*
>+F:	arch/arm64/boot/dts/tesla/
>
> ARM/TETON BGA MACHINE SUPPORT
> M:	"Mark F. Brown" <mark.brown314@gmail.com>
>--
>2.34.1


