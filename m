Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC973B607
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFWLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFWLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:23:53 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262641739;
        Fri, 23 Jun 2023 04:23:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 033445FDBC;
        Fri, 23 Jun 2023 14:23:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687519430;
        bh=40WKuG5jN7u47rR1N8bQt7QB0nFmgHe9lhfPp15dYpQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=grZYGVHuEo09bhs0QV2CoZlhgAcNo1pykB++zdadokLwQ7AwngjQ9RFJF2JzN5vpJ
         EhVb10NH41aE0B2sKDKn6gRacu3jqTLmtWAQqrO9n2pP6AmUtzHP8es2tWy7zU8VGQ
         DE7jvKw19sQ99fz9D6u/enc9YqI3tIHYU9BzlET32ojVhE5XWKsZ0ncPLJW8vD+4sK
         5VZ9hDFQOc16K+J4qjN9hsCdWrUZOhRU68U8QXsvSWNQbLBzG8TJGWB6UyoHwhwlsB
         ixIuscjLDVSZ5HDTpnpBHEKndULQfOncjImDvjDGY2tKmjf+3h60lmHmj29FV+8BQq
         vOlG80yaV1Qww==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 14:23:49 +0300 (MSK)
Date:   Fri, 23 Jun 2023 14:23:49 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>, <kernel@sberdevices.ru>,
        <sdfw_system_team@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/6] arm64: dts: meson: a1: introduce several
 peripheral IPs
Message-ID: <20230623112349.reyls6um3dccrkl3@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230623082201.7tfnpjvwi22omleq@CAB-WSD-L081021>
 <dd5d7bc8-5ded-ebfe-48a2-55e330cd7544@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd5d7bc8-5ded-ebfe-48a2-55e330cd7544@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/23 08:45:00 #21561595
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof,

On Fri, Jun 23, 2023 at 10:49:19AM +0200, Krzysztof Kozlowski wrote:
> On 23/06/2023 10:22, Dmitry Rokosov wrote:
> > Hello Neil, Krzysztof, Jerome, Martin, Rob and Conor,
> > 
> > Would you please review this patch? The latest modifications enable CLK,
> > EFUSE, USB, SDIO (WiFi), and UART (BT) functionality on A1 boards.
> > 
> 
> It's not a binding...
> 
> Best regards,
> Krzysztof
> 

Ah, I was thinking that you could also review the changes made to the
device tree board files. I apologize for any inconvenience caused by
additional notifications.

-- 
Thank you,
Dmitry
