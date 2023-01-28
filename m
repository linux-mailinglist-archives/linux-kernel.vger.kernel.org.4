Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF267F546
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjA1GtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjA1GtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:49:15 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56944761DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:49:12 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230128064908epoutp035cd643f8a8599eaf121e48ad3772f1be~_ZkLKBsjJ0325103251epoutp03P
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230128064908epoutp035cd643f8a8599eaf121e48ad3772f1be~_ZkLKBsjJ0325103251epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674888548;
        bh=VJ2pG+ckD9qFBF4Xx1wjHGh94yT/NcTTgKTru3uOzXw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Mlh/KMWV/9fpqfd17tZjoXSYdov+ATqZ9Az/azQ0sGpKe8GgctYGuZbzl+4Pj2bI9
         s4OsHUWPL7y75wUA+q+TnOOH2U5bjb1lZ94NOF2hCjpPHlfQODCSPtyD0NW+GqwhB0
         AunjFSubSECdQbX3aK+p/uMFeymM2zzOrr168HkY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230128064907epcas5p3ed12a8f4786ba781fb6067955e77fb0f~_ZkKlge9H2777827778epcas5p3R;
        Sat, 28 Jan 2023 06:49:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P3lR61vDvz4x9Pp; Sat, 28 Jan
        2023 06:49:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.B9.55678.265C4D36; Sat, 28 Jan 2023 15:49:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230128064905epcas5p44504190b5790d8d43c98ad802819e781~_ZkH998542328923289epcas5p4Z;
        Sat, 28 Jan 2023 06:49:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128064905epsmtrp103b9a4ff7b5c285b3a5e5d37a64994eb~_ZkH9NNXq0314003140epsmtrp1y;
        Sat, 28 Jan 2023 06:49:05 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-50-63d4c562f864
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.4F.17995.065C4D36; Sat, 28 Jan 2023 15:49:04 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128064902epsmtip134d350d422a8b39c8967a10c33c91de1~_ZkFUExmT1987319873epsmtip1C;
        Sat, 28 Jan 2023 06:49:02 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/6] arm64: dts: exynos: disable non-working GPU on
 Exynos7 Espresso
Date:   Sat, 28 Jan 2023 12:19:00 +0530
Message-ID: <001001d932e4$9ca8f0f0$d5fad2d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMdAgS5dZRQAkVO6hc3mtnWMtV85gHe9LN3rBzNBwA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmpm7S0SvJBuemcFtc3q9tMf/IOVaL
        vhcPmS32vt7KbrHp8TVWi8u75rBZzDi/j8mide8RdovnffuYHDg9Nq3qZPO4c20Pm8fmJfUe
        fVtWMXp83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITujc/FE1oKpfBXdq1cyNzB+5u5i5OCQEDCR+Nvj18XIxSEksJtRYu/yWUwQ
        zidGiUdn7rJCOJ8ZJXav72XrYuQE65hzsoMZIrGLUWLu2QlQLS8ZJf7NA2nh5GAT0JXYsbiN
        DSQhIrCJSeLL/r3sIAuZBRIlWo4wg9RwCrhK3J/2nQXEFhaIktj95i0bSAmLgKpEz3EnkDCv
        gKXEml+XGCFsQYmTM5+AlTMLyEtsfzuHGeIgBYmfT5eBrRURsJLY2HCOCaJGXOLl0SPsICdI
        CKzkkOh6tosFosFFYt6U+1C2sMSr41vYIWwpiZf9beyQcPGQWPRHCiKcIfF2+XpGCNte4sCV
        OSwQn2hKrN+lD7GKT6L39xMmiE5eiY42IYhqVYnmd1ehFklLTOzuZoUZ3vMheAKj4iwkf81C
        8tcsJPfPQti1gJFlFaNkakFxbnpqsWmBUV5qOTyyk/NzNzGCU6qW1w7Ghw8+6B1iZOJgPMQo
        wcGsJMK71fFSshBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OByb1vJJ4QxNLAxMzMzMTS2Mz
        QyVxXnXbk8lCAumJJanZqakFqUUwfUwcnFINTGwuIs2+J32KNk/9H6ZSkHZ0z9tI+aXaboeX
        391y/UNLeHryLrvquFXrW0STXbwmTL457c+PXsY3td4iDOfPdr7vYDLL9ysqZuLuPMt+1vqE
        60vvGQsuRN6N/c62oX9JxKwvMxMumpz9Za7ge0nk+OPXUoXuB2w0BGcV6v77stKXbfahq5W3
        T0ntED0luUXX6Nej6LDYn412DTIb99Wny856Y+GnaPJzVmDVxri2Cb9KAr4x8VxfLrFt8vyf
        66q4ZYzXHtvQdGBPFKvpjzy/V41XQ//Gfr18gne9lM4U31AnvZzpszi1zmaGr48V21jhpi9z
        9J7kv7At028/2F76fTPzNpXga02zbzM8C1wuUaDEUpyRaKjFXFScCAD1dMwHMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTjfh6JVkg0uvrSwu79e2mH/kHKtF
        34uHzBZ7X29lt9j0+BqrxeVdc9gsZpzfx2TRuvcIu8Xzvn1MDpwem1Z1snncubaHzWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgyuhcPJG1YCpfRffqlcwNjJ+5uxg5OSQETCTmnOxg
        7mLk4hAS2MEoMffwGSaIhLTE9Y0T2CFsYYmV/56zQxQ9Z5T4sWwFI0iCTUBXYsfiNjaQhIjA
        NiaJVc1/2EASzAKJEmtXtjJCdExjlOj//5AVJMEp4Cpxf9p3li5GDg5hgQiJb3ODQEwWAVWJ
        nuNOIBW8ApYSa35dYoSwBSVOznwCVs0soCfRtpERYrq8xPa3c5ghblOQ+Pl0GdhwEQEriY0N
        55ggasQlXh49wj6BUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxgmNLS2sH455VH/QOMTJxMB5ilOBgVhLh3ep4KVmINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpoi4aIGEE1PXb1hk09b9T9+j0mjVpTCz/skN
        udk5r6oeLOOZdaOSNSC4/W+hcvECsddT7m3x+t9Ru8Bn17Z7aQcTI25VrPu3cufT/z8Ohx2Q
        2jnlrL+J0Pu9ybtKdHat/Pljo7eh2EOxydzxU/0PG4kUW556/pLzdCuvql/zhj3Ldfx9+Tge
        HO75nXf8csiqN13Llux5M2HtGqOkCR+m7S95EJ7/efbr1emeG5gnfRJeN7fZgCl2zgcJtVKD
        yP/6zYdNlytIb2RbcdI7eNGMnUcnvb3B/fZT4OXHXKvNi+8+XXd3n75t4Ctl56qyix3zik1d
        jzSU+s/eZbrx28VtruFvns/b/N8kysI2TKJ5xl1RJZbijERDLeai4kQA5WdmnhwDAAA=
X-CMS-MailID: 20230128064905epcas5p44504190b5790d8d43c98ad802819e781
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120173124epcas5p319f4f913d455734edb1b63eec2120e77
References: <CGME20230120173124epcas5p319f4f913d455734edb1b63eec2120e77@epcas5p3.samsung.com>
        <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, January 20, 2023 11:01 PM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Sam Protsenko <semen.protsenko@linaro.org>; Chanho Park
> <chanho61.park@samsung.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 1/6] arm64: dts: exynos: disable non-working GPU on
> Exynos7 Espresso
> 
> The Panfrost GPU drivers require clock but such was not provided in
> Exynos7 DTSI.  The CMU_G3D clock controller was not upstreamed, thus
> consider GPU as non-working and simply disable it to silence warnings
> like:
> 
>   exynos7-espresso.dtb: gpu@14ac0000: 'clocks' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> 
> This patchset fixes remaining Exynos/Tesla ARMv8 dtbs_check warnings. No
> more excuses for not running dtbs_check on new patches.

Thanks Krzysztof for cleaning it up.

> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index b846c0be90e3..829657c9c7ca 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -61,7 +61,6 @@ &fin_pll {
> 
>  &gpu {
>  	mali-supply = <&buck6_reg>;
> -	status = "okay";
>  };
> 
>  &serial_2 {
> --
> 2.34.1


