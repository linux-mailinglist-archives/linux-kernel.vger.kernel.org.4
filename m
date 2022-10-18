Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9007F602F40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJRPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJRPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:11:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01B8F25A;
        Tue, 18 Oct 2022 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666105879;
        bh=dl9lGu7SPkUR7djUfbzQOkXUdnM7a5s07lDMtc/WNS0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fMUdfT8RFUILRE1z/CIWvQAdS/VIKxUJ2XacIrogzAPY9C3Us9qWncNmwbcuOcj3Z
         UWJdwzCoX+A73OuTThmwxvRlKwYxlN34pvjq8k+tRZ072/caVjQGTI0EelJgJUseba
         eXPMmvbUisvPrJICOZzYFmtXTx+kEbzFUacxjMlI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.116] ([80.245.77.116]) by web-mail.gmx.net
 (3c-app-gmx-bap38.server.lan [172.19.172.108]) (via HTTP); Tue, 18 Oct 2022
 17:11:18 +0200
MIME-Version: 1.0
Message-ID: <trinity-ed7d279a-ec3c-41f4-95b3-8480790f82fd-1666105878851@3c-app-gmx-bap38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Jieyy Yang <jieyy.yang@mediatek.com>
Subject: Aw: [RFC v1 07/12] arm64: dts: mt7986: add pcie related device
 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Oct 2022 17:11:18 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221017104141.7338-8-linux@fw-web.de>
References: <20221017104141.7338-1-linux@fw-web.de>
 <20221017104141.7338-8-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:XHyKXEmfIp+8IpN/GFU3VJcE1uZUPkFWh2/ja95RgN021GmCn2tf69Og4s0kpGPaSwvcM
 Lw+xD75ClC2usJFimbmiojo70K+xAYylX66hpfjZG7RQREYFn7CRdJAYGLecEAF59pDUGo1FEk9j
 QztYhPithTyO4GAXwPbC1uwdn/any6M/KYmiWOliZ4UeIbVu1rJfimxnIORWEKgyhFPHZD9SDZU8
 4CrwnZzBdqUNkURtXcZsxSurdn/riHpLbe+f+OQMZk4dqinjhKP/w86kQw2aROYsWeUycO6/mQwM
 cY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:3X1DRKyYfB4=:0SYjpc8rCTHbnbw6nQ7E54
 CBut18XBBj4vKs2imxIn2lLysdZA+0cC2kfy+1s91yiECV7U8kr8/5K7hgW2VOzBZd+vEGJj5
 6tO1Ft4JWAAJT0LmCL9ECp1vpWecPhE4TuQp7lEcDNBdP5ji0RD+aoIvZj46R9bLtrH7j3saU
 J8HwBB3bQV7BgaUcrdxBlptjGjz+ovo8avYv61Sq4n2lbgUINb4bhRc/bu4EQX1EGim2sEh0h
 EGQZDqNR0sc16SIDY1nlXezIx6WOoThUxe4n+Uydp2PIoZ79+7mtr3c3WY49WI6rAn7z02AII
 xv0cPLMpzZuVkBKYrBW3ak5GzNkmSBwRvNk+iC6EcuSKFvgEKapyNi9S3sYYLVg/fEtGabDI+
 RjM1OaCAt4J4SXDGhCINBRoadl1tEfcOXgm0/45WGFxm3vIprAxHqK3s+NOBP2310MFi5HyTn
 ftrcVS6a/J6DRtXePxx/t4ohF/RaPC7jWKACVq9C8NkmzOqK7jSjIevAay58XizqMsR7/J/64
 N5ZbBsGxV5l+uAmAl1m3cMiGCYMRM2dcutiYkZyoPhQRlWlt70DtPnWTOo2Vhi6gsSTmfsWJH
 bCk+Q5H5jG6igGYbh+ptAzrnaevckmP/KxHN+FgvGEE5DyjxU5bjN7iUa3A9n/diTu4sEGPsQ
 /6nCsqs7z6M5IqzltYl/kLbug1wLanb9nu+14dOwBvEN1V1lKYUf/QlxvErsNHsKvc53zPwD/
 2FAJvuPcZRjR7SUWPvNnl5XtloUtBdVgXDIfD5BUZDS1sDvwK4hCA6o63VWZrcCQB6R+EmBO4
 jIykSTdHxBKGyRoE97T1dxiHwdb+GIdXPuUXZ77l9QyOvZHEptXeABr2eRCOjx+kxgEa0MKjo
 Vdm4TAP6H6XhVAJ05ST3r3LNbz7b+pZzFpnSy9EufZ3I+lNzO6mMgKX9dJFT0ty0N019TvMkN
 n+avyJZRGGPCfUyEC8zDftEY/K1YiTlHaSgbnmO7Gyvz6VuE/TrHqB0zhnaqX0ImRMiH1RJCv
 o8ydT8LZxXNHQBoplXOecQJMhxkFzpquVDOrMFPykTp4Zv4hM31J3NlEuWcOFvy/M9pTF8pmj
 Cvsdqs4eUNuAzyMyIGC7ovISsVDpsm2XIW4naxO2DxjJCsObGOGxB2BcS0egv3T5THk9TXaMC
 K/gdKKLVTJLM8A2g9rWZsGQPPH1LONrSnciZqbZ0v+JuRacBXqDOj+Lzy+dGZ5kGvheTq8c/o
 XUVudJ9h0pU5oXMUYVkgVxm9SHQz2Q9ZVAQqEbROgux8KBIWbgFiaip9lyeBXPWh77jm9DHa0
 HvkUAQ/R
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Gesendet: Montag, 17. Oktober 2022 um 12:41 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>

> changes compared to sams original version:
>
> - add clock-names to pcie node
>   driver does bulk handling without names, but binding requires 6 clocks
>   and not only 5 we have

i got info from mtk that i can define clocks in pcie-node like this:

			clocks =3D <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
				 <&infracfg CLK_INFRA_IPCIE_CK>,
				 <&clk40m>,
				 <&clk40m>,
				 <&infracfg CLK_INFRA_IPCIER_CK>,
				 <&infracfg CLK_INFRA_IPCIEB_CK>;
			clock-names =3D "pl_250m", "tl_26m", "tl_96m",
				      "tl_32k", "peri_26m", "top_133m";

So i only need the binding change i've posted in this series and have clea=
n dtbs_check.

if this is ok, i change it in next version.

regards Frank


