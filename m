Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2525D619C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiKDQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKDQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:04:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E442710;
        Fri,  4 Nov 2022 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667577856;
        bh=HaDXsj5DAmUozxmuMTfo9ex+N6s+nv1T65q4Xi8hgFE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZM2nwxB2r33PzRiQCbOUAeIkRnw2n9KjRUooAhRZVI9FX5xWWX4UWs1MZdn2iJS+F
         DWw5BS4v8Jnvr9XtlBMz3T9NOVl2wGVwoY6N3nwXNjBEhsV+Dv6NN6zqc4N8WCs8Cm
         Wa7veXULp3mR9NTq7H0N6DHXJibfQDALqqGUKtdkqQ5M4JAtSPGCQHwoMP4adChuoL
         0lKpbFDuN3NR8wlpvQwKrfO6ot4c0ThUdXII1H6Vk4auLgDsdN88eA3fFYftYDciUg
         hDG0gzOSaS80ZkoAsjTsiizwU2afLqcd+Ru8+pr6JHMuGs7YqTALqohyx6/tazW/Po
         bnsNJoZx5VbNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.77.26] ([80.245.77.26]) by web-mail.gmx.net
 (3c-app-gmx-bs24.server.lan [172.19.170.76]) (via HTTP); Fri, 4 Nov 2022
 17:04:16 +0100
MIME-Version: 1.0
Message-ID: <trinity-889b4468-8a50-4eae-80a1-6bd9ffbeaaf2-1667577856206@3c-app-gmx-bs24>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v2] dt-bindings: pinctrl: update uart/mmc bindings
 for MT7986 SoC
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 4 Nov 2022 17:04:16 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <e7192d9b-df86-a860-d5cb-8b4b9184e5bc@linaro.org>
References: <20221025070255.14407-1-linux@fw-web.de>
 <e7192d9b-df86-a860-d5cb-8b4b9184e5bc@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2X1CafeoZLi1maobab4XpgEBgVUV/xQr84vHR6gjBAuOAY+JVVgANmAm4TcRb/l8nDxS2
 TnKDSNrjO66TVkQ5Xv4tr22SQACFwC8dyQ5Ll1ovrg6NFnaVVla9fQWFTGVG3ydGBt4eY/4/7vU8
 BOJEfNFxM3uM2fdID/4ZsxJovvlK1CDWDoVbs+QRvVF175YDPu+J5S564bNkOGoh11auRi/vnZss
 jHYbLCQ7bKanEf80Q/YE26Kq+rO1TwJuNmmvMxFtfFWsv5EV0YohuUNEs5XDlMS5neXaVDZAYIYw
 +g=
UI-OutboundReport: notjunk:1;M01:P0:uc0fEXlhH1I=;v14gmGUwfv0+qhv+chsSKxKrs5P
 pwVmYK1Z+eFI4681MyQNBz/llzYKerv1128HaHFkR43erPzjWWPnk/BxJfoUhH3LmmWPkGsWG
 Sk8JuO1KSz5VdbakOSaL3Ql+Q7VPd4OGrLYhSBz8dfwaawb4C3pSOYpTnkgmMjCmqQgFXmrfq
 b9kGjG+G5j8n2iuiXVsv/L6nFTFnolCkwcPKeFysjsSbGZ7M0lGV+kaRIrPmezJVEnMSFiL9D
 pYy2VsMd7Dk17hgP81q7yhcsCA5vXFceeYISenxgZfBiXQSJV6mNKSFiGp0Ttql8Jyr1O/3ZV
 VyfLpd7PRJMmzap8TtKeBdgp6R9xVMsX/IaaKtXXfij97OGpAGCOJqs5hCE4Oz3DMP+F7QY0f
 WIN527EHyL47okLwszSdFNatf6uh9rc9oCMqHSMHq2l4P5g0//mfjV8G6O80rYd/RXfinSKGQ
 7PPQRA0vJckPPSWEr9IRQpH2he3G8/22AzEqEBjDvZ6xAkTTz+iiUCN5zYA4mTT+lBmT1IJtf
 h09a8G8k4edta9sAq9qiMoGgS59X1Se7+ounLhHeWFFVZSVrgWNGdy4sBjD4vvgAb+/78C1gd
 oKf9no7c1eIuJa6bFL0s8Rwwya4yeVFr6M0ihtwsNdwU00a2L+3SLcHVvkwzhJ48p1WF5kNKE
 4KXjT9FbecheJRm35FwNbIfhbmCrFR//HA7gt/o5x3FgnaeLupaIbf6BboNfWbDFrRcQ1aTLt
 5zPRw4LOtLFUnk4KjIWnSF/+GgkaQn834lSdZe5OsIaQRJWuCnkC7VL73hMGHATNrap6UOuzr
 IDQZmto+wcE9Idj3Tx1bfR8NAo9OQlPqjlgFTRtTW3H7c=
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

> Gesendet: Dienstag, 25. Oktober 2022 um 20:35 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> Betreff: Re: [PATCH v2] dt-bindings: pinctrl: update uart/mmc bindings f=
or MT7986 SoC
>
> On 25/10/2022 03:02, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add new splitted uart pins and emmc_51
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

after talking with MTK for the emmc pinctrl settings (custom pull-up) they=
 suggested me to change
binding to fix other emmc-values and allow multiple (2) uart-items

so on top of this patch

             then:
               properties:
                 groups:
-                  enum: [emmc, emmc_rst, emmc_51]
+                  enum: [emmc_45, emmc_51]
           - if:
               properties:
                 function:
@@ -231,10 +231,12 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [uart1_0, uart1_rx_tx, uart1_cts_rts, uart1_1,
-                         uart1_2_rx_tx, uart1_2_cts_rts, uart1_3_rx_tx,
-                         uart1_3_cts_rts, uart2_0_rx_tx, uart2_0_cts_rts,
-                         uart2_1, uart0, uart1, uart2]
+                  items:
+                    enum: [uart1_0, uart1_rx_tx, uart1_cts_rts, uart1_1,
+                           uart1_2_rx_tx, uart1_2_cts_rts, uart1_3_rx_tx,
+                           uart1_3_cts_rts, uart2_0_rx_tx, uart2_0_cts_rt=
s,
+                           uart2_1, uart0, uart1, uart2]
+                  maxItems: 2

i would squash these changes and send as v3 or should i send an extra-patc=
h?

regards Frank
