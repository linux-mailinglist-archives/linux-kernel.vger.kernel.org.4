Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF9E68BB74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBFL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBFL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:26:50 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F437287;
        Mon,  6 Feb 2023 03:26:47 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id F26075FD07;
        Mon,  6 Feb 2023 14:26:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1675682805;
        bh=+b7Gig9aMFAnjD/150MtY6Vnuwn+Zr+gPuERxpgsvec=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=WtPutzbjZBadAkqWaM4zocXJwyxiwemphMLyv5wqMgvxEM3+viJiQuj82QEWvxv+c
         J1qb2YlQaKmMSf6E8v0L9h5BgmBjZudKYcz6ut9a8B7VUeqG7vnTtsGRw+JexEGD1j
         YQPeHS8l7rvCbFDwR/BwWNChpce8WaFBlnnSPS9Ge0ACyyiTV8YrqeQexmpoYu0FAn
         mtH4gVGxOx9zSzwwkY0u6JYC7+F0Jud2AuORa8gUaufWqCpR3nUbdofea/cfFksY4I
         9QyBHrdfacyjnXIN+pS1VW208ppF4X/jR7YL/JSUWfAuaEPPV4ObcDn0oBW42gz9Ca
         w0JWPm4DObzxg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:26:39 +0300 (MSK)
Date:   Mon, 6 Feb 2023 14:26:38 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Alexey Romanov <avromanov@sberdevices.ru>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Message-ID: <20230206112638.kbkcghcnbdszd4ru@CAB-WSD-L081021>
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
 <CAFBinCC7=QR3Dd_N8VN-L7CpFWETTTehNo6j54f9Y53w8emwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFBinCC7=QR3Dd_N8VN-L7CpFWETTTehNo6j54f9Y53w8emwUQ@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/06 06:22:00 #20842749
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Sun, Feb 05, 2023 at 12:05:46AM +0100, Martin Blumenstingl wrote:
> Hi Alexey,
> 
> On Thu, Feb 2, 2023 at 3:15 PM Alexey Romanov <avromanov@sberdevices.ru> wrote:
> >
> > Add gpio interrupt controller node.
> >
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> I have no way to verify the register offset or interrupt numbers.
> Overall it looks good though, so:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

We've verified interrupt numbers and register offsets on the our device
board based on A1 (A113L) + A113L datasheet.

-- 
Thank you,
Dmitry
