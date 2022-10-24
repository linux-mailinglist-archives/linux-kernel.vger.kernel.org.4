Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1446D60B400
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiJXRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiJXRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:23:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DF9DDA7;
        Mon, 24 Oct 2022 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666626968;
        bh=38vTFzrZKf3FVvekYXAM+9K/QQ7KdRjbBzJUpJt6VgA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GHipPWegnSsSMUsQisbWiaRtJD9PHUgzMX2cbNuQPrEQxKEzWbrdXUdzHyma2Dv2b
         lEGOzp2Up1OONWonVr9MTVaXE4qCMKKc3S3XChw9B4SHAQcQmx2pEh4Vy7qgOJR7nA
         3vXxV9MFrxQEs+UnHgKVrkZFaL4UD2NIYQOLnef8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.75.40] ([80.245.75.40]) by web-mail.gmx.net
 (3c-app-gmx-bap55.server.lan [172.19.172.125]) (via HTTP); Mon, 24 Oct 2022
 16:55:20 +0200
MIME-Version: 1.0
Message-ID: <trinity-95441a68-0025-49de-8c73-9730fb9cec42-1666623320110@3c-app-gmx-bap55>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Oct 2022 16:55:20 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-4-linux@fw-web.de>
 <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IcIPaVgbRpByh7zwpXh4z9zY0VuCVJ0BaE6por2d9gpyO8zxW3t1fgd81QSE28VxLcD1u
 HkBl2H0ZLbUdRlcLxl9izmQuyB026eQFlnKdge9hDQBmNNJnN8hcAkNsaGap/6Ipdg280JwgdDsv
 z0t7GEoaowPjoBCs4a4gZcMVfxgSeFNFJukhgYCAxPgYN1LH4nZyf2rnyPbMZ6c6aSjVCcSVlIC/
 qeP+pr3BIEib7wR8/YVe/RFL/biv5BgnYFn/FDdVNvwui01qtL3tn/LD6zhyh13fQLNf0LEYBhQ4
 VA=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ARJ9dboFzH4=:xEplBRIg61P9GDoxzDcos4
 nyw8DtuIVlBW56G4hBBvxf8ZvCqTTuYFbALZIIOegC4rIrSywPAUk2oi9XzD5jzvbvF5Jratn
 22/DW+q1ZmGyCBP70hCDbVwPTmdKbcOYCtPxYNKqKGFtyFVa5hQvtwI6Va7ZnZCXlRd1UbTvg
 PBdsHNvJH+3+l+89Y6A1dyKi29z4DSnpEAF0w8GbuLuJzDDYILP3R3jT8QBF57J++5YR2wZrs
 DGzKdKUP3jYC3JZONj1a/+jJfavdO4MNLGQmzpCJs01j9WO5JmEXdo425xhZVEppauE1bXhzY
 LL26KEyB/SjURdt8ZNzKIqx+vkbtc2OrdB3VmNBC1gYMdTAzy9HPofA5s4gORgXnQJPKruF+z
 xZECcyg6BscsbsvOs7gMcJfavs+43hGhPPl0WFTzK2ZymnOKNcJOZxe4sZYljW1smrlRhygO9
 BbysSr3Ge9qKAoviOEfQadA+xHw1+zPVA3mD8EyfJkn9LuelS6Z49AWnnsDr3uoEoQ41B7uFW
 RT5Q3Z8DYjCdNVz2ctpcu4U+8sZIIvC+jRQkusRg4lbqdexAqXFTznlzhi50v3ium78+8U1UU
 /BFSP3xx7/uz/Tujift/rdM4BUCRA3m8NLjT5Q3LtzW44akTh4Ijcgp8Cpjf0qlO/6wZznoD7
 CRdssc0DROYejVlLG9WOnk1vEN1ggxOwvbxyb6VufeSHSAsy/r3M0w7r2jxFiXM07Fzy8XGyv
 /lMTMxKhsu30p/4ixzIz0K98xH+tgMhHdIamSHe7Jdnq2F49iqjKXPvgRwVNA6D4N8pSU+Pel
 JvGrpNls3T3KdszmaiOPB5ghHQWYIVmGXmp+N57GHBXNFDaLOuK6Oaa30M04ddNJQ0NA+Ro81
 7Hu1Ys7FNc/qCoYEuOA6IQvgASLonGDLCILvH2zLFcJGOHgRw6edLcDiYHkfrPK9ALF/IgYVr
 pgRCKVV6TZ30RG+Z4Ilce0NbMqmDwDR+lhC51W+AYKj/DWH3FY3hsPJTBjd04xZ1wtU55F2qN
 KG3LKUroZxbs1nvA3XgI/3TWbYBotyev3FQssH5WW6FWj+vbVWP4ymMW1CHrDHSjCnawita6Y
 rKdtv9b4DjbiHwSHXLH/KyRLtYmrkU900Zj2c+W6cpc7n7UW44lryvDt/UmsRQZLo6YQz3pWw
 DuFb3hCofEJvRjDTWePTqpTYiAg9b13QhJDo18HaQLEDZLr9aFD3xsna79IWrtGXMdtG0p3J3
 ENF6+RoLG3zhviIOjx++hg3TB0XOFCl2mziFxPQ4tb9WC/eUuBYxVxLg8YU6esLRPyZ2GTHTo
 Z0ZU/dMX
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Sonntag, 23. Oktober 2022 um 14:56 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> An: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead=
.org
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Chaotian Jing" <chaot=
ian.jing@mediatek.com>, "Ulf Hansson" <ulf.hansson@linaro.org>, "Rob Herri=
ng" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@li=
naro.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Wenbin Mei" <wenb=
in.mei@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.or=
g, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> Betreff: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
>
> On 23/10/2022 05:12, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add SoC specific section for defining clock configuration.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi,

got another config from mtk which requires changing binding a bit

                       clocks =3D <&topckgen CLK_TOP_EMMC_416M_SEL>,
                                <&infracfg CLK_INFRA_MSDC_HCK_CK>,
                                <&infracfg CLK_INFRA_MSDC_CK>,
                                <&infracfg CLK_INFRA_MSDC_133M_CK>,
                                 <&infracfg CLK_INFRA_MSDC_66M_CK>;
                       clock-names =3D "source", "hclk", "source_cg", "bus=
_clk",
                                     "sys_cg";
in binding:

+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -241,15 +241,17 @@ allOf:
           items:
             - description: source clock
             - description: HCLK which used for host
-            - description: AXI bus clock gate
-            - description: AHB bus clock gate
+            - description: independent source clock gate
+            - description: bus clock used for internal register access (r=
equired for MSDC0/3).
+            - description: msdc subsys clock gate
         clock-names:
           minItems: 3
           items:
             - const: source
             - const: hclk
-            - const: axi_cg
-            - const: ahb_cg
+            - const: "source_cg"
+            - const: "bus_clk"
+            - const: "sys_cg"

will send an updated v4...old version was working but i should use the new=
 one.

@Krzysztof can i take your RB here or should i leave it as Patch was chang=
ed?

regards Frank
