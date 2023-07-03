Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8196C745431
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGCDfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGCDfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:35:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149AE41
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:34:59 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230703033457epoutp018c9888bc28dfa266c6ce41e281552b52~uPjKNRGaV0494604946epoutp01E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230703033457epoutp018c9888bc28dfa266c6ce41e281552b52~uPjKNRGaV0494604946epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688355297;
        bh=M3yWmaCcpVbJ6X0EnPHIMjsHCQJ/+VRfqr9jpEj53Nc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=aBiskPJA6TCJZT2yk8SmDWP9QhK7aHOHe8xu41QKuVMdZBtHPSXXX81hO7rrFLmHp
         u3fEzjqgJroZYs/DSBYDkQcNPruJ2iVXc4sW+kpx5fiEeE/6p0K2+HhzRKvab6j16x
         TBIK0UCo9EA8ODXJx2y9RZJI1djFguZUVl18DOfA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230703033456epcas5p241e497fd63abbf0652b7b60734a3809d~uPjJvcknp2230422304epcas5p22;
        Mon,  3 Jul 2023 03:34:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QvWl246dbz4x9Q9; Mon,  3 Jul
        2023 03:34:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.E0.55522.ED142A46; Mon,  3 Jul 2023 12:34:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230703033454epcas5p3dadad7512a618188992f48a946ac685d~uPjHYiY9i1147911479epcas5p30;
        Mon,  3 Jul 2023 03:34:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230703033454epsmtrp114fc7a0e57ce5b4efe91e8e6e75f9694~uPjHXywD91745017450epsmtrp1T;
        Mon,  3 Jul 2023 03:34:54 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-4b-64a241de8ba0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.63.34491.DD142A46; Mon,  3 Jul 2023 12:34:53 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230703033452epsmtip16fc1d9fdd3940d1bde270500fcd54f21~uPjF9FOtE2434824348epsmtip1v;
        Mon,  3 Jul 2023 03:34:51 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>, <linux-fsd@tesla.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230702185012.43699-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/4] ARM: dts: exynos: minor whitespace cleanup around
 '='
Date:   Mon, 3 Jul 2023 09:04:50 +0530
Message-ID: <014e01d9ad5f$54a15d60$fde41820$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJK0TCEOAUhA3bp3DdQU92USEW3oQNPexlsAodUfx2ulmWqIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmpu49x0UpBtc/y1us2XuOyWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBYPX4VbXN41h81ixvl9TBate4+wO3B6bFrVyeZx59oeNo/NS+o9
        /jXNZff4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGw1f7GAv2iFV8aTvO0sB4VaiLkZNDQsBE4sjW12xdjFwcQgK7GSV+LH7K
        CuF8YpTouPqRBaRKSOAbo8SbQ+IwHd8aljFBFO1llDg7/TcLhPOSUaJpznRGkCo2AV2JHYvb
        wOaKCHxmkjjZeJMdJMEp4CLRtvAME4gtLBAg8WVCI9gKFgEVibPzX4M18wpYSpz78JsFwhaU
        ODnzCZjNLCAvsf3tHGaIMxQkfj5dBnQrB9ACJ4ktrWwQJeISL48eYQfZKyEwl0Ni6c0Z7BD1
        LhJnLqxghbCFJV4d3wIVl5J42d/GDjJHQsBDYtEfKYhwhsTb5esZIWx7iQNX5rCAlDALaEqs
        36UPsYpPovf3EyaITl6JjjZoiKpKNL+7ygJhS0tM7O6GWuoh0bn3LjSkLzJKHLw3gX0Co8Is
        JE/OQvLkLCTfzELYvICRZRWjZGpBcW56arFpgWFeajk8vpPzczcxghOrlucOxrsPPugdYmTi
        YDzEKMHBrCTC2/xwfooQb0piZVVqUX58UWlOavEhRlNgyE9klhJNzgem9rySeEMTSwMTMzMz
        E0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGphKVN/aLvMUvLN6tbaGPYN1AmfkvG8N
        /Tt1+n3vawRKze/yPeT4cleEW8T5C1KXM1NX3bp7Kt9vXZ2me+4b1QVnWEML5ALvfGZ5MdlB
        a/ZOwdyg7HS1emn3LX4bWB1f67y+cm7SNo437csfLok88uOBuaTdNiVGX93QeQ23/uRlq++b
        5rtn4YbiInbeSeYb88K2sOgGbdRhiygIOG8mcNoteu/RwqZGtbVN05fsjquz3nzpwRpuszcK
        vh0Zb6LnGKUIXGcPWBSlfedqVvmew1uNF4h0TVy5s7D67NGJfp8qN558mMM3a8aHxqN7PibO
        PLOl86TGv6/P/J7UZJ0PzNvwr0VltkZ8qeSX+pUrvpxTYinOSDTUYi4qTgQA1OPZgDUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO5dx0UpBqdeW1us2XuOyWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBYPX4VbXN41h81ixvl9TBate4+wO3B6bFrVyeZx59oeNo/NS+o9
        /jXNZff4vEkugDWKyyYlNSezLLVI3y6BK+Phq32MBXvEKr60HWdpYLwq1MXIySEhYCLxrWEZ
        UxcjF4eQwG5GiYk3p7NCJKQlrm+cwA5hC0us/PecHaLoOaPE3v/NzCAJNgFdiR2L29hAEiIC
        P5kk7nbOZ4OoOsso0fvjPBtIFaeAi0TbwjNMILawgJ9Ew9NFYN0sAioSZ+e/ZgSxeQUsJc59
        +M0CYQtKnJz5BMjm4GAW0JNo2whWwiwgL7H97RxmiIsUJH4+XcYKUiIi4CSxpZUNokRc4uXR
        I+wTGIVmIRk0C2HQLCSDZiHpWMDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziK
        tDR3MG5f9UHvECMTB+MhRgkOZiUR3uaH81OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0R
        EkhPLEnNTk0tSC2CyTJxcEo1MIlevfFLcelBkaMvHptFLQyMffLjre/aomLdilu67yZ73pN9
        OelZhZuJccMcUc59JgtC4ue4f114IUf7hMaH677BG2PMt7wUeXUl/e/qZeY7Zme0mHn9vnPJ
        ZkJCEjvD3Plunx0+2Pz4/Dhtgp/wGx4PteOPd8QcfHBsY/JTk6zrzfWFfx7d3Wm00rzlTs+9
        AxrtIqWXU5TDbs2LOlRW6tJrJy2Tu073SEjJRMOdfwq6WerWbihc3bND94Lol/h13q9DeFOT
        tlevf71DarG2+bKs8FuZjvyr/vby/vrFyJh8aqnatJVVlz0lGg3mP1vE4vRL/BPb2n/PuMUN
        H2xenP7vcN6vHRt4l2m9ELeWvq6txFKckWioxVxUnAgApK99hBEDAAA=
X-CMS-MailID: 20230703033454epcas5p3dadad7512a618188992f48a946ac685d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230702185022epcas5p1650adea124e09234e42f1b46382f49df
References: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
        <CGME20230702185022epcas5p1650adea124e09234e42f1b46382f49df@epcas5p1.samsung.com>
        <20230702185012.43699-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, July 3, 2023 12:20 AM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>; linux-
> fsd@tesla.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 3/4] ARM: dts: exynos: minor whitespace cleanup around '='
> 
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>  arch/arm/boot/dts/samsung/exynos4210-trats.dts          | 8 ++++----
>  arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts | 4 ++--
>  arch/arm/boot/dts/samsung/exynos4412-midas.dtsi         | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/samsung/exynos4210-trats.dts
> b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
> index bfb04b31e11b..95e0e01b6ff6 100644
> --- a/arch/arm/boot/dts/samsung/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
> @@ -20,10 +20,10 @@ / {
> 
>  	memory@40000000 {
>  		device_type = "memory";
> -		reg =  <0x40000000 0x10000000
> -			0x50000000 0x10000000
> -			0x60000000 0x10000000
> -			0x70000000 0x10000000>;
> +		reg = <0x40000000 0x10000000
> +		       0x50000000 0x10000000
> +		       0x60000000 0x10000000
> +		       0x70000000 0x10000000>;
>  	};
> 
>  	aliases {
> diff --git a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
> b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
> index c84af3d27c1c..bdc30f8cf748 100644
> --- a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
> @@ -20,8 +20,8 @@ / {
> 
>  	memory@40000000 {
>  		device_type = "memory";
> -		reg =  <0x40000000 0x10000000
> -			0x50000000 0x10000000>;
> +		reg = <0x40000000 0x10000000
> +		       0x50000000 0x10000000>;
>  	};
> 
>  	aliases {
> diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
> b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
> index e6b949c1a00f..57836d5554d0 100644
> --- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
> @@ -990,7 +990,7 @@ &mshc_0 {
> 
>  &pmu_system_controller {
>  	assigned-clocks = <&pmu_system_controller 0>;
> -	assigned-clock-parents =  <&clock CLK_XUSBXTI>;
> +	assigned-clock-parents = <&clock CLK_XUSBXTI>;
>  };
> 
>  &pinctrl_0 {
> --
> 2.34.1


