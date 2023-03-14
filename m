Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A036B920A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCNLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCNLsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:48:41 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD1346A3;
        Tue, 14 Mar 2023 04:48:28 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5576E5FD1A;
        Tue, 14 Mar 2023 14:48:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678794507;
        bh=marFiN47fr+Q7MFOCmdErjItiqHs7/cgayQIHPn8o7A=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=biN9QXQ+GzSQr7wcFa+QfG5JRntdnWm9/Wu0T6S/6iTOTMHlN0Wy2zlNhadFUno0l
         0o0zTqvmMr0fn6Tgzh/gWnrqGT1onen90KfpytT34E7+3ffksNeeQlcSmCNgEwAFIz
         G+92O3ABna3Oiu6dQvkfFhXLcvMYWsI2dJaBpkhAZgw2N6NMMvDB5OY/97dAzsHkvg
         Qn0n/7J50CbBM801iRfbkkUUXL4voWuGWQWrm3mYpRn0Y8HhSja0vgl3BN6xHKz85l
         /y62Sn+MrFT+rULGOzT6gD5FH6yZ9txoP8JOqC1S/UvyJLwjvDTfuwZP4TBsVuqPRO
         XpvKzMr2snI5A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 14:48:26 +0300 (MSK)
Date:   Tue, 14 Mar 2023 14:48:25 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Message-ID: <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/14 06:01:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 21:12, Dmitry Rokosov wrote:

[...]

> > +#define CLKID_SPIFC		84
> > +#define CLKID_USB_BUS		85
> > +#define CLKID_SD_EMMC		86
> > +#define CLKID_PSRAM		87
> > +#define CLKID_DMC		88
> 
> And what is here? Between 88 and 121?
> 

Explained below.

> > +#define CLKID_GEN_SEL		121
> > +
> > +#endif /* __A1_CLKC_H */
> > diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > new file mode 100644
> > index 000000000000..8e97d3fb9d30
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> 
> I found in changelog:
> "fix license issue, it's GPL-2.0+ only in the current version"
> and I do not understand.
> 
> The license is wrong, so what did you fix?
> 

Sorry don't get you. Why is it wrong?
I've changed all new source files to GPL-2.0+ except yaml, because yaml
dt bindings schemas require the following license:

    # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

I've pointed it in the changelog.

> > +/*
> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> > + * Author: Jian Hu <jian.hu@amlogic.com>
> > + *
> > + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> > + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > + */
> > +
> > +#ifndef __A1_PLL_CLKC_H
> > +#define __A1_PLL_CLKC_H
> > +
> > +#define CLKID_FIXED_PLL		1
> > +#define CLKID_FCLK_DIV2		6
> > +#define CLKID_FCLK_DIV3		7
> > +#define CLKID_FCLK_DIV5		8
> > +#define CLKID_FCLK_DIV7		9
> > +#define CLKID_HIFI_PLL		10
> 
> 
> Probably I asked about this... why indices are not continuous? You know
> that consumers are allowed to use number 2 and it will be your ABI, even
> though you did not write it in the binding? That's a tricky and
> confusing pattern for no real gains.

Actually, indices are continuou but splitted into two parts: public and
private. The public part is located in the dt bindings and can be included
from device tree sources. The private part is in the drivers/clk/meson
folder, and only clk drivers can use it.
I know, there is some trick when the user just inserts a digit value and
doesn't use constants. But I'm starting from the assumption that such
dts changes will not be approved by maintainers. In other words, the user
*must* apply defined ABI constants from dt bindings; it's a strong
restriction.

-- 
Thank you,
Dmitry
