Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A91661DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjAIEcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjAIEcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:32:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38415DF15
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:16:54 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230109041650epoutp04f36f0ca04d1ff0ed347d96911b6dba3c~4iOxxUZJg1018310183epoutp04m
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:16:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230109041650epoutp04f36f0ca04d1ff0ed347d96911b6dba3c~4iOxxUZJg1018310183epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673237810;
        bh=eAd1NhnKkUpDBR09TwlKqpAQa5WXZk2eA0RjIrWm0H4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=F8AzRxoMGl3tAcz6EvZZ+8eGhhgJJMjckDEaL7UYdK+6Gx/zUKGMQwzVuBBtGVTaI
         IULZX8NIZCpHG9nv7X5faTiXR1/tZKvYfoYyiO10twRfOXS4JJWEfd4ThIDeIJmRMr
         bI75K6oMffHHq9SfG67dq5CqxmTYx1JNJbp33b4c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230109041650epcas5p1a1512596f215707b19c803d717dc912c~4iOxN8qAH0195301953epcas5p1B;
        Mon,  9 Jan 2023 04:16:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Nr0y82BvMz4x9Pr; Mon,  9 Jan
        2023 04:16:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.3C.03362.0359BB36; Mon,  9 Jan 2023 13:16:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230109040520epcas5p399ca66e8410b3d26dd38fee93ce2d9d2~4iEveFJDX0857808578epcas5p3J;
        Mon,  9 Jan 2023 04:05:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230109040520epsmtrp1bd896b2fcd574494d46ee3cde9647bc5~4iEvdLqbf1945819458epsmtrp1V;
        Mon,  9 Jan 2023 04:05:20 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-ca-63bb953040fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.F7.10542.0829BB36; Mon,  9 Jan 2023 13:05:20 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230109040518epsmtip26071d53c0a62b23059cd69d952d78a41~4iEtOLb982131421314epsmtip2T;
        Mon,  9 Jan 2023 04:05:18 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <b3ec1abe-7fb4-0c12-33b6-9f4e8d03f8b2@linaro.org>
Subject: RE: [PATCH v2 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Mon, 9 Jan 2023 09:35:17 +0530
Message-ID: <050f01d923df$974019e0$c5c04da0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5OglsonJNs2LrkABkwml8apZdSgH2TZf9AYeLzk0BpGRP4q4sL3Cw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmuq7B1N3JBlO6+CwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW+x9DRT7dqWDyeLyrjlsFjPO72OyWLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AUlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbG/fOLWAoWCFTsXrmfrYFxLm8XIyeHhICJxLN/55m6GLk4hAR2M0q0rDjI
        DOF8YpRY/PUVK4TzmVFi/7UXLDAtW/eeY4dI7GKUuLa1Dar/BaPEtB3rGUGq2ATMJRbtXcoI
        khARuMIk8XN1OwuIwyzQxiix9+JasCpOATuJ5UumMoHYwgKeElN/HgLbwSKgIjH11nlmEJtX
        wFJi95PVrBC2oMTJmU/AapgF5CW2v53DDHGTgsTPp8uAajiAtrlJvP5RAVEiLnH0Zw/YQxIC
        Xzgk5p3phKp3kbhw7REThC0s8er4FnYIW0riZX8blJ0vMe1jMxuEXSHR9nEDVL29xIErc1hA
        djELaEqs36UPEZaVmHpqHRPEXj6J3t9PoMp5JXbMg7FVJdYv38QIYUtL7Lu+l3ECo9IsJJ/N
        QvLZLCQvzELYtoCRZRWjZGpBcW56arFpgXFeajk8ypPzczcxgtO4lvcOxkcPPugdYmTiYDzE
        KMHBrCTCW7ppV7IQb0piZVVqUX58UWlOavEhRlNgcE9klhJNzgdmkrySeEMTSwMTMzMzE0tj
        M0Mlcd7UrfOThQTSE0tSs1NTC1KLYPqYODilGphsJbbVTdvv9GDd+0P/vHx3Oe9tmOpxO+54
        5ULjJ1XFTfPFjX+fUm14O7OgXsHfZEVAxwx97bbWC8JPz4tdPVoZFnDaNSP3zP45TXPSpigv
        M2k70XbMydDGNPdkzrRdkwMcsvYGpN3eetnUlf99OZPNdj+55/M+r3f8fqLqxdZNf9ketj8Q
        lHyeuanXlsdVqvl4UYrR9AyGDF7OxDkX/6R5fWlQD805q61svfPycuugxP2d4ZIh/N8vsD6c
        p7r18oX2hczPFy+V92bsryoP3159/nSlwN7TEmrNx5e6cV+f8mjl5OI/etFfHPnXb+awOaBa
        pit17MxVjU0nL504zr5exuvmERNny6i67V7V8muUWIozEg21mIuKEwHVltBVbAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSvG7DpN3JBr9uWlg8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxkttj7Gij27UoHk8XlXXPYLGac38dksWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8b984tYChYIVOxeuZ+tgXEubxcjJ4eEgInE1r3n
        2LsYuTiEBHYwSkx/v5oNIiEtMb1/D5QtLLHy33OoomeMEhN//WIFSbAJmEss2ruUESQhIvCI
        SWLu/EdsIA6zQBejxPG/K5khWj4zSjw9cZoRpIVTwE5i+ZKpTCC2sICnxNSfh1hAbBYBFYmp
        t84zg9i8ApYSu5+sZoWwBSVOznwCVsMsoC3R+7CVEcKWl9j+dg4zxH0KEj+fLgOq5wA6w03i
        9Y8KiBJxiaM/e5gnMArPQjJpFpJJs5BMmoWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjOBY1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeEs37UoW4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWnW363bDZRPsEwx3VvNzWhQt1Lhuf7J2J5r
        m6ed7uZ073q96vuC+9YJhuZSrUGXHwXPdYp5qng14/mnTWKzrt7UY3e88/t/w6oth3+INZ3e
        2OZ0O5czunPhk9tf1JJfdaguC03cLb/5pa3I/Lx6s58cZa0PPauEb1q/Fy4Rua4tmO0QY/12
        zsdNUkWFvWfZkwRdOBa+YwxazcZgLOHG6fb2WfGu1dHTDt97uYlpUpXncodbgqf9ptq9DV/C
        zBiftffVlImph9p3rn8YkOS3Sn23WdF2exf223tu3Bc8JChnOzmigPNOxsxM3gBW3g8cl5he
        fLWTqMsuEvrzaNmDvuaGFduPi82rW8IhJvJEM0uJpTgj0VCLuag4EQClZnKIVAMAAA==
X-CMS-MailID: 20230109040520epcas5p399ca66e8410b3d26dd38fee93ce2d9d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045703epcas5p2344520777efa3c06321732e2784e6c6c
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045703epcas5p2344520777efa3c06321732e2784e6c6c@epcas5p2.samsung.com>
        <20230103045613.100309-5-p.rajanbabu@samsung.com>
        <b3ec1abe-7fb4-0c12-33b6-9f4e8d03f8b2@linaro.org>
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
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 03 January 2023 04:41 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH v2 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
> 
> On 03/01/2023 05:56, Padmanabhan Rajanbabu wrote:
> > Add device tree node support for codec on Tesla FSD platform.
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index cf5f2ce4d2a7..e2fd49774f15 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > @@ -10,6 +10,7 @@
> >
> >  /dts-v1/;
> >  #include "fsd.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> >
> >  / {
> >  	model = "Tesla Full Self-Driving (FSD) Evaluation board"; @@ -34,6
> > +35,18 @@
> >  	clock-frequency = <24000000>;
> >  };
> >
> > +&hsi2c_5 {
> > +	status = "okay";
> > +
> > +	tlv320aic3x: codec@18 {
> > +		#sound-dai-cells = <0>;
> > +		compatible = "ti,tlv320aic3104";
> > +		reg = <0x18>;
> 
> First compatible, then reg, then the rest.

Okay, I'll update the same in the next patch set.

> 
> > +		reset-gpios = <&gpg1 6 GPIO_ACTIVE_LOW>;
> > +		status = "okay";
> 
> It's by default. Why do you need it?

Okay, I understood that if there is no status entry, it is
treated as "okay". I'll update the same in the next
patch set.

> 
> Best regards,
> Krzysztof

Thanks,
Padmanabhan R.


