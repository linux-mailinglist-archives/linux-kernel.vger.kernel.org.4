Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE4661DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjAIEdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAIEcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:32:12 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152AE00F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:16:55 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230109041653epoutp01b9f4e934d6c11e7ae6db4b3d24954fa4~4iO0twZC20372903729epoutp01Z
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:16:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230109041653epoutp01b9f4e934d6c11e7ae6db4b3d24954fa4~4iO0twZC20372903729epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673237813;
        bh=HXTSJf4b0RBli8gncBuMHnH5r/LI/9LtRvHtvntnnvQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UWWQd/ZyGPoB0g6VsLLwvFuHmnIfqCT2dRhWS3+Kcdi1HemS0+VtuR1fwAWybGIeK
         JW6CBzUgzbYopAhhqx0L5FPZ0jShlFhSGdNc6MEAi6tV4Uw9rbB88TO9I43wnuFPWJ
         HcfEcWso9F+BFt6QiIOSJN7sqPjKFKMKdDe8V75E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230109041653epcas5p48b5e1263a942012d7ee602af3d54b79f~4iO0EsCEN3264832648epcas5p46;
        Mon,  9 Jan 2023 04:16:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nr0yC10Z9z4x9Pt; Mon,  9 Jan
        2023 04:16:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.3C.03362.3359BB36; Mon,  9 Jan 2023 13:16:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230109040537epcas5p3a2f787c7d3dce00a29edbc5e71a47ba1~4iE_g0fdu0857808578epcas5p3h;
        Mon,  9 Jan 2023 04:05:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230109040537epsmtrp18e6dacf09b30b8769cfcef0e31cbaf49~4iE_fh8QY1945819458epsmtrp1e;
        Mon,  9 Jan 2023 04:05:37 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-d5-63bb953345fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.99.02211.0929BB36; Mon,  9 Jan 2023 13:05:36 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230109040534epsmtip143da8bfbbb3718bdad5f673545829356~4iE8T5nK70547905479epsmtip1V;
        Mon,  9 Jan 2023 04:05:34 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <2c6950c9-3489-c2d4-2ca8-cb723195f75b@linaro.org>
Subject: RE: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla
 FSD
Date:   Mon, 9 Jan 2023 09:35:33 +0530
Message-ID: <051601d923df$a0e7b840$e2b728c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5OglsonJNs2LrkABkwml8apZdSgIw2p9KAbd2VQACGX4hJ64lNt4g
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTdxzN9+56HIS6s8D4jgXXnSwOktZ2lHIl1LHRaIluwywzmYmDW3uh
        BGibXnHKsolj/JAITksJFALYOFw6EVZAGazMAAbnNgVXQIKokG6CCtHJQECStbRs/Pc+L+/l
        8973B4EKxvEoIltvZk16JpfCQ7BL/bFxonhrj0biHuHR9xsu4bR7uA+h+9o7g2jrlAenGwdu
        8OjKmSmUdj3ycovuMoT+o7sep2tu9iK0vXMhiD7RfYpH24a6eHSxayCI7n9cyqPbllpACqlu
        e/YVrv7RNhmkdjpO4Oo7oz/h6t65Zlxd2eEA6taOEUz9zLktnTiYk6xjGS1rErJ6jUGbrc9S
        Uns/zEjNSJBLpCKpgk6khHomj1VSqn3pot3Zud4KlPAwk5vvpdIZjqN27ko2GfLNrFBn4MxK
        ijVqc40yo5hj8rh8fZZYz5qTpBLJWwleYWaObnLegxjPRx5puNWBFYJmQTkIJiApg45SC14O
        QggB2QPg6Hgj6h/+BnD+wUXgHxYBPHfuBbJheW4vDqhcAA4PWRH/MAPgmN2+rsLJRGh3fbtu
        DyfdCFz+vhTzDShZAqBruAX4VMHkLnjz6hnUh8PIdFhXbFnHGBkDl1YWvbEIgk8qoOVGmo/m
        k1vhL7UezIdR8jV4ea4e9UcSwuU/m3k+HE7uhhecazy/JhJeXT65HhWSCwS89sQd5DeoYFWP
        LdAnDD4c7AjwUXD2VEkAG2D10yLcj4/AkqdtAf3b8Iq7HvNlQ8lY2Nq9009HQ+v1i4h/7xZY
        seoJyPmwq2EDvwFbzzuBH78Ke8dc4BtA2TZVs22qZttUwfb/tiaAOcArrJHLy2K5BGO8nv3s
        vyvXGPKcYP2Nx+3tAtP3n4j7AEKAPgAJlArn5zu7NQK+ljlawJoMGab8XJbrAwne4z6NRkVo
        DN5PojdnSGUKiUwul8sU8XIpFclnOxs1AjKLMbM5LGtkTRs+hAiOKkQ0ny9/UfFJf/ZYwaF9
        Wo95LUFZ+JfNca+qTMWbrUoOVj6YPMMvd41EkJl3v4tX5F1Bz6rEFpEYtYpizi69J1+4NjG6
        daxmfPvRjx3/1Ldnjikr5O3JS9NlX19u2a9TvRg6JKyR6E7GGu7a59+URTeFrn66/HpBGopx
        swfubJmyyxTT1damwT2/Jv6wxzMseJ/38/yBOmoGPJxuR8HqsW2heGj9B9WRL5WnpCUpXeVf
        loTWpkT8rlqpxSrfvXf9cGnIcfFC0nFG0XUrpmtNM9s0MDjBlT0Wp9bcXtlxge+pi+lPat8f
        9ltNT1FR6kTOwbXbYA5E73gnmTj96KNBy8toLYVxOkYah5o45l9dEC4mbAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnO7ESbuTDR6mWzyYt43N4srFQ0wW
        hzZvZbeY+vAJm8X8I+dYLfpePGS22PsaKPbtSgeTxeVdc9gsZpzfx2SxaOsXdovOXf2sFrMu
        7GC1aN17hN3i8Jt2VosN39cyOgh4bPjcxOaxc9Zddo9NqzrZPO5c28Pmse/tMjaPvi2rGD3W
        b7nK4vF5k1wARxSXTUpqTmZZapG+XQJXxt13T5gKlotXzLu0haWBcZlQFyMnh4SAicSPRa3M
        XYxcHEICuxkl5i08xgKRkJaY3r+HDcIWllj57zk7RNEzRonpm1+wgyTYBMwlFu1dygiSEBF4
        xCQxd/4jNhCHWaCLUeL435VQcz8zSrzccJEVpIVTwE7i/NFJzCC2sICfxOreXiYQm0VAReL7
        r29A3RwcvAKWEpPPeYKEeQUEJU7OfAJ2ErOAtkTvw1ZGCFteYvvbOcwQ5ylI/Hy6DGy8iICb
        xJpNf1khasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxgiNZS3MH4/ZVH/QOMTJxMB5ilOBgVhLhLd20K1mINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpo3Gc2t+L2Q+z7/v3282kYltl+SmO7rf
        /L22/8RiY9a67z6vO/Xv8IVe3FWYPvXnDolPa3i/cqq9XOS8TvtWnWz5dq7n/na8O/5OM7GV
        FXDqd5cTb5xrwXdXx111dW/jkfZDb6Y53y3kcri7X1Y5QZFlarLjLE5LkZafn77vWK7jLs5l
        ndXIdOXBE0vFSYcE5Cf5NbBqyUcv/Z7oZx70hl15au1Bnfgtk54wPbyxqmiObrFzs/DNX/vq
        TDTi5y/Yb2O6qPH98zCOJpfb+sr6M9bt/lcywblYYt50jVMvLxeUN64TiS4wsX1/eKmFZamt
        QF2P0LxLHF6Lv5v1/jdRMnmvNyM0oKpKOW9RIPNeJZbijERDLeai4kQAT9ZLZVMDAAA=
X-CMS-MailID: 20230109040537epcas5p3a2f787c7d3dce00a29edbc5e71a47ba1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b@epcas5p1.samsung.com>
        <20230103045613.100309-6-p.rajanbabu@samsung.com>
        <2c6950c9-3489-c2d4-2ca8-cb723195f75b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 03 January 2023 04:43 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla
> FSD
> 
> On 03/01/2023 05:56, Padmanabhan Rajanbabu wrote:
> > Add device tree node support for sound card on Tesla FSD board
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts | 37
> > +++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index e2fd49774f15..ce726bddfb50 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > @@ -29,6 +29,43 @@
> >  		device_type = "memory";
> >  		reg = <0x0 0x80000000 0x2 0x00000000>;
> >  	};
> > +
> > +	sound {
> > +		compatible = "simple-audio-card";
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		simple-audio-card,name = "FSD Audio Card";
> > +		simple-audio-card,widgets =
> > +			"Line", "Line Out",
> 
> I don't think you need to break the line after '='.

Okay, will change the same in the next patch set.

> 
> > +			"Line", "Line In";
> > +		simple-audio-card,routing =
> > +			"Line Out", "LLOUT",
> > +			"Line Out", "RLOUT",
> > +			"MIC2L", "Line In",
> > +			"MIC2R", "Line In";
> > +
> > +		status = "okay";
> 
> Why?

Okay, I understood that if there is no status entry, it is
treated as "okay". I'll update the same in the next
patch set.

> 
> > +
> > +		simple-audio-card,dai-link@0 {
> > +			reg = <0>;
> > +			format = "i2s";
> > +			bitclock-master = <&tlv320aic3x>;
> > +			frame-master = <&tlv320aic3x>;
> > +
> > +			cpu0 {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).

I did not encounter any error while running dtbs_check for fsd-evb.dts

This is the command I executed
make dtbs_check > output.txt 2>&1

dt-mk-schema --version: 2022.11

Please let me know if I'm missing anything here.

> 
> > +				sound-dai = <&i2s_0 0>;
> > +			};
> > +			cpu1 {
> > +				sound-dai = <&i2s_0 1>;
> > +			};
> > +			codec {
> > +				sound-dai = <&tlv320aic3x>;
> > +				system-clock-frequency = <33000000>;
> > +			};
> 
> Best regards,
> Krzysztof

Thanks,
Padmanabhan R.


