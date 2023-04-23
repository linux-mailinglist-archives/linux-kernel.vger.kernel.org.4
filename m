Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DDE6EBD23
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 07:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDWFG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 01:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWFGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 01:06:25 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD11FE8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 22:06:21 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230423050617epoutp0299818740bfa438bfff56c46058a56ae7~Yd-o52CQk3082830828epoutp02O
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:06:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230423050617epoutp0299818740bfa438bfff56c46058a56ae7~Yd-o52CQk3082830828epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682226377;
        bh=uxiSEk/esPlWCRRTZnSGg1y8KEbrKWSrSrE4p9D0d4A=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=qfamblvhwYYQ11bYWBDNedtDjSUyjIR0dQIayDUeYkzUJcua6GnnBzsWD7l9a0zxI
         zsrUQqCaBJzaLzg4ceWoXnUMVK/9JqmPNR7gFSBVHWufLFca/DmSbspChwSKrvxuJJ
         Hmi61/iL4bf1SEf6+sAttda+L89SYG0NepE4R978=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230423050616epcas5p3aebf0eac048e389fc317deb6271e5290~Yd-oguGUG0894908949epcas5p3U;
        Sun, 23 Apr 2023 05:06:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q3x7B5zRvz4x9Pr; Sun, 23 Apr
        2023 05:06:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.45.09987.6CCB4446; Sun, 23 Apr 2023 14:06:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230423050614epcas5p3d55915ba1d10d112e71894107a7ca070~Yd-mO1RvN0894908949epcas5p3R;
        Sun, 23 Apr 2023 05:06:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230423050614epsmtrp1d3eb14916e7336fcaa1e046c55c5f955~Yd-mOIA0w1321413214epsmtrp1d;
        Sun, 23 Apr 2023 05:06:14 +0000 (GMT)
X-AuditID: b6c32a4b-7fbff70000002703-26-6444bcc68618
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.19.08279.6CCB4446; Sun, 23 Apr 2023 14:06:14 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230423050613epsmtip12d9b89458ab5ac84fe1c9c9e177cc1fa~Yd-lFRO_U2405324053epsmtip1B;
        Sun, 23 Apr 2023 05:06:13 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230421190202.15471-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] ARM: dts: s5pv210: remove empty camera pinctrl
 configuration
Date:   Sun, 23 Apr 2023 10:36:11 +0530
Message-ID: <340901d975a1$53de6ad0$fb9b4070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGoG4MPsMzRMzzdGHd0mLCSi9wmTAIxB2sIr4mDHrA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmhu6xPS4pBk1fdC3mHznHatH34iGz
        xd7XW9ktNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8eda3vYPDYvqff4vEkugCUq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGrd6d
        zAU/uCsuvn/K2sD4k7OLkZNDQsBE4l/nRkYQW0hgN6PEwoVVEPYnRon7K7m6GLmA7G+MEi8n
        TmGBaTizdQkjRGIvo8SBv3PZIJyXjBJnJl0GG8UmoCuxY3EbWEJEYBOTxJf9e9m7GDk4OAVc
        JCZdkgExhQWCJX7cywQpZxFQlVjVdosJxOYVsJQ4vPQJK4QtKHFy5hOwxcwC8hLb385hhjhC
        QeLn02VgNSICVhIHzmxig6gRl3h59Ag7yFoJgVYOiZc3u6AaXCQeTrkA9YGwxKvjW9ghbCmJ
        l/1tYKdJCHhILPojBRHOkHi7fD0jhG0vceDKHBaQEmYBTYn1u/QhVvFJ9P5+wgTRySvR0SYE
        Ua0q0fzuKtQiaYmJ3d2sELaHxP7Ni1khITWdUeLb3AlsExgVZiH5chaSL2ch+WYWwuYFjCyr
        GCVTC4pz01OLTQuM81LL4bGdnJ+7iRGcOLW8dzA+evBB7xAjEwfjIUYJDmYlEV6PUqcUId6U
        xMqq1KL8+KLSnNTiQ4ymwKCfyCwlmpwPTN15JfGGJpYGJmZmZiaWxmaGSuK86rYnk4UE0hNL
        UrNTUwtSi2D6mDg4pRqYUs78/n7qkzOrUa9nddKCmfyHrxf2rFcQmLtvqoLQyaqCuCktLCVf
        v55/MaFs3ctf8xdl8izYIvH/o/QELu+pd1cI/VqYrab+kW/Le92qXVlbgyf7S32bWFy58ESA
        8pX6j3F8+70Ftnju0E6qdlCqn+s+tamm/MHC1IMy16dXOmyou3U7bkag/5UwE3eGM83r2ASZ
        P71ewcqev3unxfrX5lLvrJ4fPDjV1XDndWXjhuwvmeXhWi/+Hp6TsY03b63GR/P1OxwZaz++
        EXh3d/XTKw9C8tt6t95V9mZfZHrE66eC25xLnlZZalvP7b7+uyLiQ7PQ3XM3YiZ7N3kIb+JV
        M41dezi+WEtoisjyJK3JS5VYijMSDbWYi4oTARjoyc8lBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO6xPS4pBjdWSVrMP3KO1aLvxUNm
        i72vt7JbbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1j06pONo871/aweWxeUu/xeZNcAEsUl01K
        ak5mWWqRvl0CV8at3p3MBT+4Ky6+f8rawPiTs4uRk0NCwETizNYljF2MXBxCArsZJX7sPc0M
        kZCWuL5xAjuELSyx8t9zdoii54wSp95dYgJJsAnoSuxY3MYGkhAR2MYksar5DxtE1VRGiQ9X
        zwBVcXBwCrhITLokA9IgLBAocfnYDLANLAKqEqvaboEN4hWwlDi89AkrhC0ocXLmExaQVmYB
        PYm2jYwgYWYBeYntb+dAHacg8fPpMrByEQEriQNnNrFB1IhLvDx6hH0Co9AsJJNmIUyahWTS
        LCQdCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeKluYOxu2rPugdYmTiYDzE
        KMHBrCTC61HqlCLEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMH
        p1QD0+RENc4rK7j6HjIphbRGKyhdEXk56aylsudMLe2lt63cLurem/XV4ff3+ryA8xP8K5/b
        npjIyGIQs0rZ27Uy6OUKt6Z59zq+LTgulVZ/7/tF4/tTzugfN5cPtm+emKN/tqZ1u6p934tJ
        G1/KTOqb+ueH1eLO871/S/58WNt2b4m6ZUtf4fELcepMp1L/zH25py9nlfy6CSFCX7bKKW34
        dH7bJYeLrye/vBL6f5Lx+cx+iXS7DdoMv07PlDz531xsZmoJ/2a1HYk1XxWrujS2CSQ79XKz
        3Zpzukxapz22KUp0g1xBvXZO7DWbeAult+1XarMUNffZ7kiefqRfPW9i5DHd2SJS0s6W11d8
        eGFvrsRSnJFoqMVcVJwIAEsqoIUDAwAA
X-CMS-MailID: 20230423050614epcas5p3d55915ba1d10d112e71894107a7ca070
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230421190209epcas5p1ad0aa67d1b9d19f746f42412c4424f15
References: <CGME20230421190209epcas5p1ad0aa67d1b9d19f746f42412c4424f15@epcas5p1.samsung.com>
        <20230421190202.15471-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Saturday, April 22, 2023 12:32 AM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] ARM: dts: s5pv210: remove empty camera pinctrl
> configuration
> 
> The camera's pinctrl configuration is simply empty and not effective.
> Remove it to fix dtbs_check warnings like:
> 
>   s5pv210-torbreck.dtb: camera@fa600000: pinctrl-0: True is not of type
> 'array'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/s5pv210.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi
> b/arch/arm/boot/dts/s5pv210.dtsi index d9436bbf77c8..faa3682ab5dd
> 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -549,8 +549,6 @@ i2c1: i2c@fab00000 {
> 
>  		camera: camera@fa600000 {
>  			compatible = "samsung,fimc";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <>;
>  			clocks = <&clocks SCLK_CAM0>, <&clocks
> SCLK_CAM1>;
>  			clock-names = "sclk_cam0", "sclk_cam1";
>  			#address-cells = <1>;
> --
> 2.34.1


