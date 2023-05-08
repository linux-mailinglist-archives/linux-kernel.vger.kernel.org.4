Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2B6FB473
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjEHPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjEHPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:53:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4AE3;
        Mon,  8 May 2023 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1683561181; i=frank-w@public-files.de;
        bh=CiPg0zLB8L+Fhy9p4yBq3k46Y/eQla9+LhxYyup3Mwg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dQLwQptEuq97eHWwN/oBtXDkVAI+bQ66Ki0RfVPQW99ohn9/RcrtATS83Vaz00zGq
         NVAPCrNYDqk435LJxgQcRKj4wBrDSveAvDQypZ1MGaZZ/iVuRPX1DPSKdvQL5fykNm
         D+3NbR85WbwNOPy78YGHAinY9Cs5vuLRpdCd6rzzQEaS45TaJDOOPWSgxYMCE2bkJo
         pgEWRuYyW0UR7UU4zIib/9drdPUYD4OOplit4dXWf9fzjvzkR2QGkB5SNJHf2YF/rX
         ZSC+Wa5iIK0CQCdORFUQunGMgK3sksUqNUTC982AfLsDVfCed2zHvA7bH3LhegycEF
         wdGp8M0p7lDbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.116] ([217.61.152.116]) by web-mail.gmx.net
 (3c-app-gmx-bs01.server.lan [172.19.170.50]) (via HTTP); Mon, 8 May 2023
 17:53:01 +0200
MIME-Version: 1.0
Message-ID: <trinity-e35759d3-7de4-450c-b4a8-053c9617ac27-1683561181475@3c-app-gmx-bs01>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: Aw: Re: [PATCH v1 2/7] dt-bindings: iio: adc: Add support for
 MT7986
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 8 May 2023 17:53:01 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20230423140252.7b018c46@jic23-huawei>
References: <20230421132047.42166-1-linux@fw-web.de>
 <20230421132047.42166-3-linux@fw-web.de>
 <20230423140252.7b018c46@jic23-huawei>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:pdqX18kf14TXCeRRcIeZ0HL8CFTV1pCMhlfqHMq0UjxaXL88w8IY5Xau00mREZLySLpCX
 oXYfD1PHfjW7qxZRxZ/4z4TN4hYGRrH8duheEOGvCrvoB88QpXAY5+FBfk/gQsHcD6nNdIQuOyUz
 SUCALgWOrXm/Yudb4pYLg3QwVHJZCVVoemN4QhtwCovaXHFhVoUSnc1qCqBKr6bwrFItXpjAmwV3
 EQ3Yu1SzzDFDWfeiwbJKH0v4beuIQVaQhFx2VhBYOx0qQQ1VjqcRurtLQS4347etbaonmmMXVfRO
 8E=
UI-OutboundReport: notjunk:1;M01:P0:cksV9XsuSDk=;+YbD/ZkGsCaOhtlDn+Fv6zFt4a8
 57ipgbeNe6ZqZivTNZdpPWdpJNZgXRHtT9ayhxyHGCuxqAd6l4eOmcQ6WrjBFjpaOtCUpMa/x
 qvZ88Cdsu2if/m06Vb7JArRW72aGG3wtJlLt2kD1p4chRDIliHg//3pkqbdKl2lGI6/Q/ey+3
 X8XncX+CBpJOJ4+bI50qem1I8ajFP/U3eKy7btxXnul/MsRV7lki8xjsq/qxXDlGxR0PI+RQ8
 sgborse2e/lbBsDhHbCFbxT4wXlQCOHYB1Yj776YUVQlzUP8gYVXOsDxKLyw1rx1Xonlta1em
 UyTmYX3C5AOi08otOpIIQqg8uIttbPDHYsmxiPbkDIvohu6tcWyzTUl8ZAKIfld07CNjU1oPY
 D7UDM3QCdupYOIW5maXirITC5oThN0uwXlIuDQ5+6yDu57aFrA4dm5TZ/ZOeKWnQ/psGWpmid
 pYj3vupwpHQPxnXBXxdCKaZvj527Ytv5Z5SnJNk9PL3aB4RZWiQlDHSE7P4sS3ifRBM5nU3LO
 fcMLumgv/QVNJ1tSxB+pTwDaDcSzuPFEJe6LG95Qv+b8QiEzighDmFS8b4eNa2NkfbhWw92ve
 /CyjaxZ7Kfjya6iqAymLD/Du5azEtWX5qFGdiLGM+fIMbWRVydRZ/jtuqmqHz03pBIU6JddjG
 skqV0f1AhWvLPYrc170BBBHCrKq9+QGBpidcEv8jtVDVS915CDA1SOURvroqyYHWWyszVnpCu
 wLBpApKvvgNmGiASnnhk+pePSjqxwcpU5T6mXUz33Vz8sTbf9SJRWfPpDYjX88LfoM0fT3vv9
 UHsRYEFlRRM8OZDCydSJPMmQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



regards Frank


> Gesendet: Sonntag, 23. April 2023 um 15:02 Uhr
> Von: "Jonathan Cameron" <jic23@kernel.org>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Cc: linux-mediatek@lists.infradead.org, "Frank Wunderlich" <frank-w@publ=
ic-files.de>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh+=
dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,=
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"=
 <angelogioacchino.delregno@collabora.com>, "Srinivas Kandagatla" <sriniva=
s.kandagatla@linaro.org>, "Hui.Liu" <hui.liu@mediatek.com>, "Zhiyong Tao" =
<zhiyong.tao@mediatek.com>, "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>=
, "Lala Lin" <lala.lin@mediatek.com>, linux-iio@vger.kernel.org, devicetre=
e@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.in=
fradead.org, "Daniel Golle" <daniel@makrotopia.org>
> Betreff: Re: [PATCH v1 2/7] dt-bindings: iio: adc: Add support for MT798=
6
>
> On Fri, 21 Apr 2023 15:20:42 +0200
> Frank Wunderlich <linux@fw-web.de> wrote:
>
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add compatible string and specific clock property for mt7986.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
> Given how trivial this is, I'll apply it without waiting for the DT main=
tainers
> to get to it.
>
> Applied to the togreg branch of iio.git and pushed out as testing for 0-=
day
> to take a look at it.

Hi,

i cannot find it in next and here:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documen=
tation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml?h=3Dtogreg

was it dropped?

regards Frank

> Thanks,
>
> Jonathan
>
> > ---
> >  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 =
+
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701=
-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-a=
uxadc.yaml
> > index 7f79a06e76f5..6168b44ea72c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc=
.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc=
.yaml
> > @@ -26,6 +26,7 @@ properties:
> >            - mediatek,mt2712-auxadc
> >            - mediatek,mt6765-auxadc
> >            - mediatek,mt7622-auxadc
> > +          - mediatek,mt7986-auxadc
> >            - mediatek,mt8173-auxadc
> >        - items:
> >            - enum:
>
>
