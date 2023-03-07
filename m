Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6976ADA63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCGJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCGJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:30:48 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA0166C6;
        Tue,  7 Mar 2023 01:30:41 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CC1F85FD29;
        Tue,  7 Mar 2023 12:30:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678181438;
        bh=6lO2QPTQx3VBJm1+Mk1D4msGumd9zL1FfxW8GKaySUM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=WHHQ25INA4QvVTURiwMJGV5hMnZftiN63Ifz7A2mfW+NTpI54v8hESwXAXLZqdwlW
         MGhxM1iAbBbkzAvjOfAlHx7P4lFY0J707JY0Ucz4s4Y7+r4Lw9LPaYCtWVREMfmGo3
         HtADJAVAr/t7moCXoAIwX+2nbKjoRbji3xklYAniIVLjG/XqXfFFvvobXzsWf9K0XL
         HrxTsXy5G9T947pYDABhBthcz9XrmqNVTXUzhl+498h2+FkL0T6dchr33hQEwPO8Yo
         85OTB9VbLUeq4Qdpfc3ypGS+SS3ndyf6TWZBU1+ZnXkHb+SCk3WHCwTOvF4ieZha2a
         iDxUMp/n35vQQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  7 Mar 2023 12:30:38 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Topic: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Index: AQHZNxDMFNGdYZWqIECM18Y2pLjN2K7u9V0AgAAZIwA=
Date:   Tue, 7 Mar 2023 09:30:37 +0000
Message-ID: <20230307093011.vviyrtygneqy2us3@cab-wsm-0029881.sigma.sbrf.ru>
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
 <9623bc3f-760a-e838-c80f-40d2f9b79f35@linaro.org>
In-Reply-To: <9623bc3f-760a-e838-c80f-40d2f9b79f35@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.24]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1566E12FAC27704AB3308B0CAB3B36E7@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/07 06:50:00 #20921514
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The [PATCH 1/2] highly confused b4, anyway it's applied on v6.4/arm64-dt.
>=20
> Thanks,
> Neil


Oh, sorry for the noise.=20
Thank you, Neil!

--=20
Thank you,
Alexey=
