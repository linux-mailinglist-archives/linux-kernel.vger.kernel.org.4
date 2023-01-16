Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3706166B6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjAPEoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjAPEnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:43:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D88A49
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 20:43:49 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230116044347epoutp02b26d961539b2f4a25c722b1feffec708~6sHTd_X841359513595epoutp02E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:43:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230116044347epoutp02b26d961539b2f4a25c722b1feffec708~6sHTd_X841359513595epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673844227;
        bh=KirXBT6ZP0szW+a5Gpp7gID69ByyoBTylvK8HFRXtAU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ZU6WdfaVOHBPdobtMyO4/xKWvrlBPAXJnscFHtL16E8E3Xgu67q6hz+gfL3gFUm22
         olwuUV1aAqEGm4S8inaLB1oulZVqOnY44H0PCn+M3EZEl5IBWhWEIJDgO/5si/Cn/l
         vzYfrDlPfpQy5Pnogunke81egPotCRBE87MtDhJ4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230116044346epcas5p113e74e8b8e44041a9e97d9879729f5ed~6sHSzgFDX3000830008epcas5p1L;
        Mon, 16 Jan 2023 04:43:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NwKD114V5z4x9Pw; Mon, 16 Jan
        2023 04:43:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.C9.62806.006D4C36; Mon, 16 Jan 2023 13:43:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230116042307epcas5p10477cb96bb2daa850a0477a585188a7d~6r1Q4Yt7N1722717227epcas5p1R;
        Mon, 16 Jan 2023 04:23:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230116042307epsmtrp25281f56f6ee4186642c16e5501cf6b29~6r1Q3bKce0891508915epsmtrp2c;
        Mon, 16 Jan 2023 04:23:07 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-4f-63c4d600186c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.84.02211.B21D4C36; Mon, 16 Jan 2023 13:23:07 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230116042305epsmtip1853ec2a881894ca048434d72d1f65415~6r1OsbbYh1277212772epsmtip1T;
        Mon, 16 Jan 2023 04:23:05 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <a4982e06-a6a4-a8c9-3b24-24f798c61f73@linaro.org>
Subject: RE: [PATCH v3 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Mon, 16 Jan 2023 09:53:04 +0530
Message-ID: <03a301d92962$3c1a2320$b44e6960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHLbZyfFuOXMbrDWpBwvoqdO4xuvAHRtuXQAlPUijoCxLwDyq6ElpYg
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTZxjG+c5pTw9uHWeFxU/MsJ5EnUSQalsPCIw5pFV0YZmJGWPBYzlp
        kdJ2vUwwmWMQrhuIf8BmZSosQFa5NB2XDixBqDHKAjo7WLgNkhK6KSsXo0FItpZTNv77vc/7
        vHm/55zvw1HBOBaOZ2uMjF5Dq0lsG6drcH9kVNCoUxHzh4tHzdzowijX4wGEGvipk0fVzLox
        6qZzmEtVeWZRyvHUp71wlSHUk546jPpupA+hGjqf86jynitcyvzIzqWKHU4eNfislEtZX7aC
        JEJuXSnE5D+bp3hym6Uck0+O3sHkfQtNmLyqwwLk7R2/ceQrtog0PD0nXsXQWYxeyGgU2qxs
        jTKBTP0o8/1MiTRGFCWKpY6QQg2dyySQyafSolKy1b4IpPBzWm3ySWm0wUAeTIzXa01GRqjS
        GowJJKPLUuvEumgDnWswaZTRGsYYJ4qJOSTxGc/lqNbrnRxdfUje/f4hbgHofb0CBOOQEMO5
        O16kAmzDBUQvgM+sVRhbLAPYOF0Z6LwAsLhoHNscedhVyGMbDgC9lnHAFh4AR10u1O/CiCOw
        wdG40QgjXAhcvV3K8RcoUQKg43Er8LuCiUR4taeY4+dQ4gRc/tbD8zOH2AObS3/Z0PlELHTO
        VPNYfhM+uObe0FFiF+xeqEPZMwnh6lwTl9W3w3ur32zoYUQKLOtrQf2LIfEchwXlc4EQydDT
        7+CwHAr/ut/BYzkcrvztCHi0sHapKMB5sGTJirD8Lux31flmcd+y/bC95yArvw1rHrYh7Bne
        gJVr7oCdD+03NnkPbG+2AZZ3wr4xB6gGpHlLNPOWaOYtccz/b7sFOBawg9EZcpWMQaI7pGEu
        /vfPFdpcG9i45JEn7WB2ZjF6ACA4GAAQR8kw/gc9gwoBP4vOv8TotZl6k5oxDACJ73tfRcPf
        Umh9r0RjzBSJY2PEUqlUHHtYKiK385nOmwoBoaSNTA7D6Bj95hyCB4cXIGcSPGV2N0UkLZxd
        DMVeXmqY78jLmDYdG156JFihLL/G19n0Qb2vpoycpBNnv+q2vVZYs1zbbe4eLtc2adX5x1ur
        LgaNpMrG5hpODdln1q4fpX+UnDnWSSWm1wvmLE36y+M7T57zOvb+M/1ny7qMzEeYTyJqFp1D
        lXET65Oe/GrZRMSFDJOQ36ZsjB9rtr9qOR1fOvFZ25pb8qDka6XenXLYLR+Z8tYeCL1+bde+
        HUVDXy4M3pUWflg6+d4t28hx5qkl9ah0/oDMrvb+XpFCnP8+GV4ovp2xW5aU/kSkHe0NaZHs
        /YKav3c5BFV9WjQ99g6+Hr12xTuy+HHXD9a75+NIjkFFiyJRvYH+F1aAOIttBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnK72xSPJBpf3qlk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxkttj7Gij27UoHk8XlXXPYLGac38dksWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8afhUdYChbyVxw/cJq1gXE3TxcjJ4eEgInEqW1N
        7F2MXBxCArsZJQ5OeMAMkZCWmN6/hw3CFpZY+e85O4gtJPCMUeLqbCMQm03AXGLR3qWMIM0i
        Ao+YJObOf8QG4jALdDFKHP+7khli7HtGiQMHtzGCtHAK2ElM3NXKAmILC3hKfJr+Amwsi4Cq
        xPL2M2BxXgFLiSMPJrBD2IISJ2c+AYszC2hL9D5sZYSw5SW2v50DdaqCxM+ny1gh4uISR3/2
        gMVFBNwkOvatYZ7AKDwLyahZSEbNQjJqFpL2BYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgmNZS3MH4/ZVH/QOMTJxMB5ilOBgVhLh9dt1OFmINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpoPSbdcElH+wbrbYO4XhtGGU7rkNh55cNN0U
        utY4Ztb9FD5Z2TQ7u/C+gNXM32aphW4uDlDTuhARdq3cWCZ9xyJ5N8O3rf+m6G3dtvfcrk+a
        YmeP2dR0ZxyR9T7ptl03e//KlI0fmjo3lqy8c0inrS3toVb10YDLlcvMhZfdcljJ8+ewgCHD
        OSeHO6+WXn654cu6+zufVDW+2i9Yxjit1uCflVy3u9ZS2Wkylfv+9+R/ejsv1Xjv302bL668
        f5rhxB6da1/rjK2ljilyB71a7bbhqvasPQ8eWGdIz/TRET6rL//x71fuitp4I/FXc65uO2O9
        yVNrk61d+5kv29X+vfj+/fe5277FQiLexek+rzOVWIozEg21mIuKEwGWu0u6VAMAAA==
X-CMS-MailID: 20230116042307epcas5p10477cb96bb2daa850a0477a585188a7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75@epcas5p4.samsung.com>
        <20230113121749.4657-5-p.rajanbabu@samsung.com>
        <a4982e06-a6a4-a8c9-3b24-24f798c61f73@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 15 January 2023 08:37 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH v3 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
> 
> On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> > Add device tree node support for codec on Tesla FSD platform.
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index cf5f2ce4d2a7..2f211a1ad50d 100644
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
> > +35,17 @@
> >  	clock-frequency = <24000000>;
> >  };
> >
> > +&hsi2c_5 {
> > +	status = "okay";
> > +
> > +	tlv320aic3x: codec@18 {
> > +		compatible = "ti,tlv320aic3104";
> > +		reg = <0x18>;
> > +		#sound-dai-cells = <0>;
> > +		reset-gpios = <&gpg1 6 GPIO_ACTIVE_LOW>;
> > +	};
> > +};
> > +
> 
> Why there is i2s here? What was the base of this patch?

Sorry, I could not get what you were asking for. Would be really
helpful if you can elaborate on this query.

> 
> 
> Best regards,
> Krzysztof


