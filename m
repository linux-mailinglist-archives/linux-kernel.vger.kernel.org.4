Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6361DB8B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKEPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKEPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:06:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365011178;
        Sat,  5 Nov 2022 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667660774;
        bh=n1U3A9SAcBnA+C+iil55xu82QnWztEgrMkdDHc+35tA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AjCMWVh0BIFUTqmoQfp7lRLnuGtkKG69KMZkOGi9fmas2hbXnIymztQPqPKniCPzu
         tc2FVPvr/68tXcVuU1en+xXydkBQC3IfJxo/ytMqAOVXc25SResmhgcWpAmkUSkGkm
         D4e8aFu/WhkrXmkYEemMASD+4GxcpL5FukzfNQNlIy4O5ae3LfPHmpR203ZQn1bJwn
         jw5qCDUn1xD7EZRiNTJIfxnag8EYx6w2HaZe9YPj/VF88rzTXQzI9gcVNYM79rZ7/h
         zUBL9Pik+cV0IhVhf2n/IlKNx9Sxh8kzZ3I/iqVXDIbNBhuofLmQvBB1xVL7vt1vdV
         yt6PPDhP7RF0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.50] ([217.61.159.50]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Sat, 5 Nov 2022
 16:06:14 +0100
MIME-Version: 1.0
Message-ID: <trinity-c732b826-2a12-4ab1-aaac-294ac5524926-1667660774779@3c-app-gmx-bap26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Sam Shih <sam.shih@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>
Subject: Aw: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mt7986: add generic
 bias-pull* support
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 5 Nov 2022 16:06:14 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <166765939131.4158830.8416727494529058690.robh@kernel.org>
References: <20221105084905.9596-1-linux@fw-web.de>
 <20221105084905.9596-2-linux@fw-web.de>
 <166765939131.4158830.8416727494529058690.robh@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9fTNNmdoC3U9t0q8xm2Ug5ZFFo0grHUmepRZAGw1MhDCqtX3M18QKeJzzXFiiiVS2S7Sk
 p67mKHnlzgsUM/uJUQBVYBQn5OhVPZTC2IqFecBXUgxb6RE+Jj6lyMYNbtJMhldk9gpL6yHpniMY
 VsuQ6C0lDgXc3lMsbhGv0IlXQ7OkxAVPSfhFNEVhtbFr3XZXr6h2BeIctzkG9bep5oCibVGgh0K+
 7o+KUzsAIzonlCzBkDPpZ7+nfbJOyA11CTZ91uls6ez/UMc/GiTf8vNc7HgVg1J1bW5EpgBjgzSR
 Io=
UI-OutboundReport: notjunk:1;M01:P0:ORwYdXrEkx8=;MkTnBmktZGm97zo4Cz1MuB1zExv
 QhXrJdLb/BuaVK+mKmyYmCSgq3xOJkrP9Qptx5qoVZFX6q2I1mkvtw/htlcv317gxC3JZWhTQ
 X5S1QXttGe0LNVlSfVDHTrn9PN+jLBUVwM4d3wnn5ECjmkJB76Of/za+ui5sm1PcLfchAlJNT
 NUp7uDkufGaqfKJXFZ055qYWjxCLv+rpmhWT78jHtWH0uaVnQcaN5Ek/mBkgEZ7pd77cgqe9Z
 tC0WIzbj8E7RNBo1wPJNCmZ1yml8ZWeVS5QsFPMoU34TPJOWHZk1RS8khjqJ2VCn0JWUbWhVi
 nkf+x8ZqDAxg9N2fFY7h/2x1+TBGvZX6kMsRKSb5n2P5D4fPuYnP2gZyGvEQZBcGIwbK4Y9Eg
 sOwolvOy2hD9h1hUoG9oC7h9lMZnoAn+YskxjZRRFHV8391r/MRbJWrobpF7rwXMRnGuUnL65
 ckalYf6Z833ZAhmx+hOKI8IOUzz+kTwG2B2WM+Taa4vZo5Fk6ITHb+o3vuOH0rAGPJSNQkw+R
 vB/yMeX6etXqlzkdApp8T1ysEIiaSHREwBP1yASDr/BC25hoeReWYWD9tNjdD+o/40/V4fq4T
 BPYGZm6liRW785dNUZxncP3AF0gQO+IPBHvH+FH0D2wQBBGKMhpLiEiTPAPolfNjW1EwjC1ln
 6hHo3SYaTpn9rJ9Ud6VzmTAqImuJ15BtWxFZXaOdEaTTv9PuYyTOjIzgG97ifW8Yrm2NO2weS
 AQI24fiL0z8B2xgW6QP+eGZBlDowMk8GxQvL7hAebLUwK7pX5IF/B70BwIT/ApoaNDHOEqWAX
 Lur/xERm4fs4gmswIg2UjYoTzK7iLILjtL62W1YNbDazM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Samstag, 05. November 2022 um 15:52 Uhr
> Von: "Rob Herring" <robh@kernel.org>

> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: mmc0-pins:m=
ux:groups:0: 'emmc_51' is not one of ['emmc', 'emmc_rst']
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/device=
tree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml

this is already solved by this Patch:

https://patchwork.kernel.org/project/linux-mediatek/patch/20221105092500.1=
2145-1-linux@fw-web.de/

i decided to send a v3 or if instead of including it into this series

regards Frank
