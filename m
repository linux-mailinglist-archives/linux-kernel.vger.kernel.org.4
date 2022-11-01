Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364B614788
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKAKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiKAKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:13:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8C10DA;
        Tue,  1 Nov 2022 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667297618;
        bh=EXo84VvyGFTmnUtTrG/jdPf51mIhHpHMuo9uKvlgcNU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lzdpyZ1ZS169jMbRDTgL75XNWlMM2oWp6gL7Q1PQsKPnFMYm0rYRtToZ5Zak5tAdY
         KZlEUSD4/6Ye8nvFoYFR8YjjQe7I/hQm7c8tzNMOgQuD4jgGXkzZMM0TCh1qKZDYVz
         1U+FYiUoOQE5CP9RX/EflIbfb8kaUuVZF/vOUcqAB+kX09mgIF/vbZGYqnuz7UcE43
         QYr5WYnPQw6U2Ko44aL4YOW6jKZa+iDg3C2a1iFRuXOfVs7alYhzxOCxtHvEF0jSM6
         K6Wahsp8ZRUoXPROUnDJ531uOU+OXqxd267x2/vdEs/gXM3u60qTxagSZ6+RZ4Xm7h
         y6J15bBNbJilQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.243] ([80.245.78.243]) by web-mail.gmx.net
 (3c-app-gmx-bs25.server.lan [172.19.170.77]) (via HTTP); Tue, 1 Nov 2022
 11:13:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-5f39285a-b188-4b6d-a5e5-d1b3439f9506-1667297618702@3c-app-gmx-bs25>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Aw: [RFC v2 0/7] Add BananaPi R3
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 1 Nov 2022 11:13:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221026093650.110290-1-linux@fw-web.de>
References: <20221026093650.110290-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:vTLmDZVdxu/OhxXQdTtnUrTU8yVjVdP1AJqlwGeH25SKTftZwcYz5EUJkxLnSKt07UwBO
 AZZbIwz0azU04gsTcylSqO6vpy0EJMzg5tGR6LU9P0Fu85IZkrE5+GvcTrFINcfITW6IQHBLSBFa
 Ft628KAFdy+1Uggnv23DdweVKm61nlYoU2BK7H+xx03l/g9HHxmdfjZz2g6JqY6yhL37vjh5GhrX
 tADFjdkiyYWiCkiglzb25HY2ojRF2UaNFGC60wf2sADUuXgTkxAaiCcrJEoX+IogGJD7XYOWH9/G
 OY=
UI-OutboundReport: notjunk:1;M01:P0:NZk14boAfX4=;LLalRtJ//zvUVwCWzAr8k322sTN
 QrXMtEJIgtdByG7Wy3iKadWHhDzcH+8JJky+xYmGl0x8d7JUgaE1xOa5OHwcdWkzrpgCU105m
 x+XuKXuKkw8v3nE//WDldWCE95s+VodeOkosiVeZsazU+t0+UjMHnVUK9zjlJRUmbE3BGi8uD
 qTKbcussMJZhIgyY74RI4oQhhgh3ic6bcznLXJyzDNDNYzbVWG1qQD6nmvwUHNBkG5O7u1W4s
 gpbq6LsV3vRVxzaxXMK6FX/CJzhaG05bDBay5eBlzdtJathrutqoXncnBApWT9YF3qPjegtgN
 keK/JrUyx2435Ql+HWtGXtTy4HN+b8cUyN0KJnUWSSLVrDCJ4Q22hFyMtFqE5L3xyHimVRpiL
 NRlqJvWjswaiYO3dVQ7Wr3vQWCDz61wI5N5KaCRjp3D5YQPp/kulgfwdOarMuIJwSJ0zZyqB5
 D2zgo86SDhkazQggr8yhqWFX88pHbaNo5Dy1KLouTqIqvg8wWY/A+GLhi6qyoFx3cjW7CJ5Ir
 ngMQ4POi1PhV1bbW5vos8SZhHy61WdivCE7Mj59uV/0ru8hcchBfZ7kagu6rlvcSX1iQuIsdi
 WHE8A0LTkJfGQJnofSzp3o6QcmITBU8NLb0p10n8VJSRv2atfdq4bZPw6RQTaZiMvKAddG3Fr
 +5PxhSLaLwqRomNt0M0nLEPCqBk/91Zgv0PwKo9YDhmHYd1cZnr2f2UKP+yoEl2L8VfHu+jP4
 Spe9FgBMgRA7Ys0Ie1FeAIur0P9rIuizXj71uNWWP4Pn9azh4GwfX3lEY7FRqoGbNRm/hwy7t
 1DHP6sjZ0gMx9urEAFh8zluDt+JzsuX8pectH+UDZotTs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

any comments on Parts 2,3,4 and 6?

>   arm64: dts: mt7986: add i2c node
>   arm64: dts: mt7986: add spi related device nodes
>   arm64: dts: mt7986: add usb related device nodes
>   arm64: dts: mt7986: add crypto related device nodes

maybe they are ready to merge? mtk is working on mmc-pinctrl and i work on the other comments for r3 dts.

regards Frank
