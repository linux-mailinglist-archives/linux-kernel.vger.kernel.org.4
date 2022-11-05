Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA461DB88
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKEPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKEPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:06:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791692CC9C;
        Sat,  5 Nov 2022 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667660667;
        bh=9HRqnYYikNNPoD5ufxUfY6iw/kgmW0wRUIiv/To2cDw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pEdIySWYG/wUQainNcS2k3z5zM++LsIUvl5hkt4NpHiScpg9yGT0Tqgp100kaNMqs
         68Y9WQ6/6dx4iBAY0eIsV//aYuAFR+WLDdozM7UVZtVCYUPGd42sNQjCnenzWUuzGs
         I4bzU2AHjp1ltYD9AtQzD1n5B+PuHVSWUZxJPEgjlvtcRfMD2oPm1tlu5U15ftwVMB
         ZNecmkSGPbzrgWrVSSt+QxV2G3fZgzrOwrx85ASGxWCABdRcUJ+UxksOryimFgkcuv
         122uHSMYPI8UrVs8Y2w2r5aNlnj62tQ+BkbmIbpPh1D3Sp57OD9qn4U4McE2dKgmYh
         d0gI5IccBFnzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.50] ([217.61.159.50]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Sat, 5 Nov 2022
 16:04:27 +0100
MIME-Version: 1.0
Message-ID: <trinity-93c64b9b-8363-406b-aa0b-07e6802ec84b-1667660667233@3c-app-gmx-bap26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>
Subject: Aw: Re: [PATCH v3] dt-bindings: pinctrl: update uart/mmc bindings
 for MT7986 SoC
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 5 Nov 2022 16:04:27 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <166765939212.4158869.5881767839110614067.robh@kernel.org>
References: <20221105092500.12145-1-linux@fw-web.de>
 <166765939212.4158869.5881767839110614067.robh@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9i6nkkBvk3T5O3ufr7r4jiF+bmV1GKMrD01K5YQwqSEMvYaep/nf7+b+ZBktNGIFNaSWT
 k4rUG7O3gBAshWE1PcW0hdTJ7LRDYBKZDZaz5wOt4UjmCkNbnvtz8EkzGXxzCCAOBkzesai2NKAu
 kNwp5DEvI5JvXLsFZH2gMf6n6ZOA1vjRqAxv87RvdxDDBQQGj/man4mEqksVg3YiJle8dlen6A95
 NxBNsn4c3stFzaaZboDEJgNXZVZD3zkqyG0g/XIkzyrNvGJQB2/8rMtCrxZlcy1BfsvAszn6fYdS
 aI=
UI-OutboundReport: notjunk:1;M01:P0:3XgvP+Ek2cQ=;urkMPgTvJPxr4uarHrkP6J2gErj
 YjTDX6vZGD3PnvOBHnh1i7g21qceKgOr87hkr4xw8nv66qdF7x3O81XCNP/ov1KyBHDNHYVgs
 rCGX/iSGWEfZy/+1tIXLtIfOrlodzD6odIqaXO2n0uLaqrJ0VTn5IEsvVkFmt14D43JQVzDmz
 7KEmiB8gIW4P+Icj2GXZJCRHVp6p1DwjHZfnAS9mk2qjEYmI7YsWxnyDiPgt0/gjFYJlVayeZ
 QZOey+xl4kb98Wm+YHZ03wnBxWMxrbLK7XG8r7iNWUmhQL2y5buj0Hezp7BthKUaXK2AX53z2
 XiEQgE7Emp1fPhpRmMs1gnVSr7DKy+Wq/EaMu6A59ylSi0S9Aitj0jaFjT+hvnk/j04+c6XRY
 0+Enkk79ppwW3DsP/Wk/1fbAzRep2XB7B24wb54LwzwvPvMzH/dydigXEi1gLE8UVD7V3Z336
 k6ANT+s0hMBfmd5xa2CTPOYRl1cxYGT9Q5f9d8fg8iXzi56HdEJ4vQw86ImL9wPx6WrvweEL3
 i+Lg0gGR5VSxVNpmwc1TsSXfNV/SgoQgLeN++vM3VzppJWM9MR0pM8fBGXTpm+jIyEVY1/TjP
 TZKqQ1EqOTthP3me5UXPUB0aTJy7aA5mJnvFTZ9hQWcsRQ5ptc6JOT/RKueh5tm8bRFe8q9ZZ
 juCDjMRm3yl2VIdAdGDz04aPYqWjdyKsoH0JpZkFe6Qns0+iHlJfjNzE3mWnXuNq/7VkZ9MfL
 y785P36gtS+UFgj/BZVnoJl6PeqIPN289mmwFdC17LaLipTD4XjrgUHawvYXktxWZuTeSSGPi
 R9TWw0xuc8+oiYWsq9CueiT5vX4mlbDRYiSpmiIIM1fE4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Gesendet: Samstag, 05. November 2022 um 15:52 Uhr
> Von: "Rob Herring" <robh@kernel.org>


> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check=
'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: pcie-pins:m=
ux:groups: ['pcie_clk', 'pcie_wake', 'pcie_pereset'] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/device=
tree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: pwm-pins:mu=
x:groups: ['pwm0', 'pwm1_0'] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/device=
tree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: spi0-pins:m=
ux:groups: ['spi0', 'spi0_wp_hold'] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/device=
tree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml

these are handled by this Patch, sorry to not mention the depency

https://patchwork.kernel.org/project/linux-mediatek/patch/20221024074349.7=
777-1-linux@fw-web.de/

regards Frank
