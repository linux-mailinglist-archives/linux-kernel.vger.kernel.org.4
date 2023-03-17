Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47996BF270
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQU2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCQU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:28:01 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC4AB8B4;
        Fri, 17 Mar 2023 13:27:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 539265FD4F;
        Fri, 17 Mar 2023 23:27:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679084872;
        bh=9klZq5XNmdsCI8Jf4BIs+c2sADGKOJ1gBsYtYIHMRbs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=XZLGSNSDmTYCZb7s7O8f3ZHMIYyHbCaPHo56b39hLpJh8r2PPMyPdt6JZf/f58gS6
         348VQBGsQwgKna4KcBjfocVat4Lqe47Se+jPzZVU/R2rBfpLoY1XV5J9SdDnY/MhuD
         nEQmoM7C4NtEflIqujh+NYYR6c0/dYiZ2pSZIDpWO/wkYg9ssjJ8UCokIFIKbMHW4O
         wrMnu9VEuqIb6kJwYg6uDZFbq4+xVLkxvqCB/1BdyNc2QmNUJgg2jzPqIkAyQSsUIV
         4ehY8/Xe9OvmJIHSZFZWjeQXbTyfcDZK5fT93/oA8Zjv4VhwxaKfF9gR7OjPIoDThE
         zH5yyfYc2Jekg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 17 Mar 2023 23:27:49 +0300 (MSK)
Date:   Fri, 17 Mar 2023 23:27:48 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Message-ID: <20230317202748.7ctqhswettiemwi7@CAB-WSD-L081021>
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <20230317185317.GA2608140-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230317185317.GA2608140-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/17 17:26:00 #20964929
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:53:17PM -0500, Rob Herring wrote:
> On Tue, Mar 14, 2023 at 02:48:25PM +0300, Dmitry Rokosov wrote:
> > On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
> > > On 13/03/2023 21:12, Dmitry Rokosov wrote:
> > 
> > [...]
> > 
> > > > +#define CLKID_SPIFC		84
> > > > +#define CLKID_USB_BUS		85
> > > > +#define CLKID_SD_EMMC		86
> > > > +#define CLKID_PSRAM		87
> > > > +#define CLKID_DMC		88
> > > 
> > > And what is here? Between 88 and 121?
> > > 
> > 
> > Explained below.
> > 
> > > > +#define CLKID_GEN_SEL		121
> > > > +
> > > > +#endif /* __A1_CLKC_H */
> > > > diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > > > new file mode 100644
> > > > index 000000000000..8e97d3fb9d30
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> > > > @@ -0,0 +1,20 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > 
> > > I found in changelog:
> > > "fix license issue, it's GPL-2.0+ only in the current version"
> > > and I do not understand.
> > > 
> > > The license is wrong, so what did you fix?
> > > 
> > 
> > Sorry don't get you. Why is it wrong?
> > I've changed all new source files to GPL-2.0+ except yaml, because yaml
> > dt bindings schemas require the following license:
> 
> Why 2.0+? The kernel's default license is 2.0-only. Are you (and 
> your lawyer) okay with GPL v4?
> 
> But this is still part of the DT binding and has the same license 
> preference:
>  
> >     # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 
> However, the header licenses are complicated due to .dts licenses which 
> are all over the place. The requirement is dual licensed and matching 
> what includes it.

Agree with you. As we discussed with Krzysztof, checkpatch must verify
such wrong license tags. I've introduced the patchset for that, please
take a look:

https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/

-- 
Thank you,
Dmitry
