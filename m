Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D5F745434
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:36:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B01B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:36:29 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230703033626epoutp022e853423c85c071d216e8e0a98e2f062~uPkdZELQk0792507925epoutp02t
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:36:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230703033626epoutp022e853423c85c071d216e8e0a98e2f062~uPkdZELQk0792507925epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688355386;
        bh=iJHsnzuv/3P3c/sgg4qrhHAomf5LGAlPsBYm7dMoUZg=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=iau2pE31qxEJ2RUw7UFmLyU4U+6UELtc+Q4lejj7Xz0IevVYFkGpx3d0opoJOf1yW
         j+fIXmvowRPdTdlkk2IYC37kbTc//4uVOHLIzQnfGKCS8vn495tnK0mHWxR1s7iXjO
         wfT1Oz9YNtDjQypafrXF1OQrQ+jyzeEYwHGs8Y+A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230703033625epcas5p13c6102e5fa95aad265a560961462e44f~uPkcpum6f1851118511epcas5p1D;
        Mon,  3 Jul 2023 03:36:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QvWmm0776z4x9Q9; Mon,  3 Jul
        2023 03:36:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.6B.06099.63242A46; Mon,  3 Jul 2023 12:36:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230703033621epcas5p453ad7299c057693a149deee0862a150d~uPkY4jysa0345803458epcas5p4v;
        Mon,  3 Jul 2023 03:36:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230703033621epsmtrp2d59fc2a16ee74b1bf4179237504c8df4~uPkY34z_j1417014170epsmtrp2D;
        Mon,  3 Jul 2023 03:36:21 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-81-64a24236d398
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.91.30535.53242A46; Mon,  3 Jul 2023 12:36:21 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230703033619epsmtip28deebef965e47baf1e4ff7f33f76d642~uPkXMncK02600726007epsmtip2T;
        Mon,  3 Jul 2023 03:36:19 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>, <linux-fsd@tesla.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230702185012.43699-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 4/4] ARM: dts: s5pv210: minor whitespace cleanup around
 '='
Date:   Mon, 3 Jul 2023 09:06:18 +0530
Message-ID: <014f01d9ad5f$88cc5090$9a64f1b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJK0TCEOAUhA3bp3DdQU92USEW3oQIgPvh1AdVkXliupW9F0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuq6Z06IUg6ZfvBZr9p5jsph/5Byr
        Rd+Lh8wWe19vZbfY9Pgaq8XDV+EWl3fNYbOYcX4fk0Xr3iPsDpwem1Z1snncubaHzWPzknqP
        f01z2T0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5da
        YmVoYGBkClSYkJ3x+PsP5oLvAhUr3/1ma2Bs5Oti5OSQEDCRONuyj6mLkYtDSGA3o8SmvS+g
        nE+MEn2H2tghnG+MEqvPTGTrYuQAa/n/rwoivpdRYknjUaiOl4wS7X/3M4HMZRPQldixuI0N
        JCEi8JlJ4mTjTXaQBKeAi8SRWVvAbGGBQImWO6tYQWwWARWJe8/fMIPYvAKWErfurGWEsAUl
        Ts58wgJiMwvIS2x/O4cZ4nAFiZ9Pl4H1igg4SUycsIQJokZc4uXRI2BnSwjM5ZD49+QaO8TZ
        LhKfezUheoUlXh2HuEFCQEri87u9UJ95SCz6IwURzpB4u3w9I4RtL3HgyhwWkBJmAU2J9bv0
        ITbxSfT+fsIE0ckr0dEmBFGtKtH87ioLhC0tMbG7mxVmePNtdUhIXWSUmPtiBeMERoVZSH6c
        heTHWUh+mYWweAEjyypGydSC4tz01GLTAuO81HJ4dCfn525iBKdVLe8djI8efNA7xMjEwXiI
        UYKDWUmEt/nh/BQh3pTEyqrUovz4otKc1OJDjKbAgJ/ILCWanA9M7Hkl8YYmlgYmZmZmJpbG
        ZoZK4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTAZzPB5ZPbz7krTrLOPkniP36r89VhDX/S+
        /uf5fxYpya+Qcl9ac40raof7ppzuaXPKZzl/v1C/olCx/UHRyZC5Nmb/4ifWcJVzfCmXNPkq
        nyyXxOt5Umcfz7FJRQK/zZYsVk1eVHWXQYxPUGOxkrCYjorK052SMseEJUpKfk5Tld9yy+uE
        7uHNXLwfrfNYYiZM0uxP3X7yyt6WiO8tuv3sxW8awlmzlT8IPD38TGi5RNCWCYFut75PEpY9
        oh71tM6OrcUyZ03f0+3nbCpOn/t68NY2z865AQKsHUk/1C/MeyV6UqPa5ddRyzmc/NJxejaG
        bLWz3WfuMznUpWPN4PnIV1651fKkkPALOfZPPkosxRmJhlrMRcWJAMlCoqI0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvK6p06IUg9fz5S3W7D3HZDH/yDlW
        i74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+JovWvUfYHTg9Nq3qZPO4c20Pm8fmJfUe
        /5rmsnt83iQXwBrFZZOSmpNZllqkb5fAlfH4+w/mgu8CFSvf/WZrYGzk62Lk4JAQMJH4/6+q
        i5GLQ0hgN6PErI5Oli5GTqC4tMT1jRPYIWxhiZX/nrNDFD1nlNixoZsNJMEmoCuxY3EbG0hC
        ROAnk8TdzvlsEFVnGSV63l5jBqniFHCRODJrC9goYQF/ibunJ7CC2CwCKhL3nr8Bq+EVsJS4
        dWctI4QtKHFy5hMWkPOYBfQk2jaChZkF5CW2v53DDHGRgsTPp8vAxogIOElMnLCECaJGXOLl
        0SPsExiFZiGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4
        irS0djDuWfVB7xAjEwfjIUYJDmYlEd7mh/NThHhTEiurUovy44tKc1KLDzFKc7AoifN+e92b
        IiSQnliSmp2aWpBaBJNl4uCUamDackF90Y6Jz6Q3pp6N9uMoXVtsM+HFV2aTK1+m6zWyrO/p
        iIt9Kpizx5ZJZtKBjRMlshUOLcs9mvikz3xnqdvZA49ueO1jFPT8kLLAUvgc1zzB1Bm7FCu7
        Z9WfSVv7WyLS9FaLmpNkxJdDVQrCUrNKz63ael6z7+ChAJ85gQ/vqz3rjbdw8/jstjNypbFm
        6pL0NXeeFCi98Pg3RfvlDlEXY0Xb+49vPnr+4RUT071COaY/K2Juct4VNhb17GzaIOt/7PF/
        njNhbi+ZNjdLXfCZprvJlv/79GV2XpcUqyY9ik/z+1/Zk+xuHhL8ckFY5Uc2raTVc6zSDteL
        v2h+tvSxoNkbY6afM6+7a9isfvlQiaU4I9FQi7moOBEAluWAGhEDAAA=
X-CMS-MailID: 20230703033621epcas5p453ad7299c057693a149deee0862a150d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230702185024epcas5p34b4c4d222ef1e0a3c1cd56604a46c485
References: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
        <CGME20230702185024epcas5p34b4c4d222ef1e0a3c1cd56604a46c485@epcas5p3.samsung.com>
        <20230702185012.43699-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> Subject: [PATCH 4/4] ARM: dts: s5pv210: minor whitespace cleanup around
> '='
> 
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Thanks!

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>  arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
> b/arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
> index af740abd9e0f..6ecdd504e5f4 100644
> --- a/arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/samsung/s5pv210-pinctrl.dtsi
> @@ -832,12 +832,12 @@ lcd_clk: lcd-clk-pins {
>  	};
> 
>  	lcd_data24: lcd-data-width24-pins {
> -		samsung,pins =  "gpf0-4", "gpf0-5", "gpf0-6", "gpf0-7",
> -				"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3",
> -				"gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7",
> -				"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
> -				"gpf2-4", "gpf2-5", "gpf2-6", "gpf2-7",
> -				"gpf3-0", "gpf3-1", "gpf3-2", "gpf3-3";
> +		samsung,pins = "gpf0-4", "gpf0-5", "gpf0-6", "gpf0-7",
> +			       "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3",
> +			       "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7",
> +			       "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
> +			       "gpf2-4", "gpf2-5", "gpf2-6", "gpf2-7",
> +			       "gpf3-0", "gpf3-1", "gpf3-2", "gpf3-3";
>  		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
>  		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
>  		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
> --
> 2.34.1


