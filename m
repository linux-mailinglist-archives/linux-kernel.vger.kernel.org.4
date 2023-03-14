Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BD6B9877
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCNPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCNPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:01:13 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86386A7;
        Tue, 14 Mar 2023 08:01:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4F4625FD07;
        Tue, 14 Mar 2023 18:01:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678806068;
        bh=VYtZNHbbMXIq+g24HuL1awnMYFh5ypx+E6yBnfNcl6A=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=qsIgGNq9FJ+V3tMbZis0wrWJCHqgOAd4VH5hKqsP84sHMMyQ126g9D4n8CC8NTKJO
         Afl9vosImnTrlWVMKzxfDPpOjxrWMdK1sk4SaFNE8dntktMxQRzU2t74V9gSwFXpKp
         10uMAGSu1bm8lH97M+c6NOdSUeqcgM5inA2oGwOb/kRDUOG8D8aISg26bYcYDbSheg
         kHA8dDLPO0lEC5OkuKUA9Jh2hh+nT9Bry6FSSDspRZHQvpWX4wDWH90tubUGwn4taT
         4C/MVlZF48vOsFrnsWz6DcreHu/PcPaTfbDT2szz9BMaB+BV7e/4wxZjxBdtvOzmxu
         4tNQ8XpHc70eg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 18:01:07 +0300 (MSK)
Date:   Tue, 14 Mar 2023 18:01:07 +0300
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
Message-ID: <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
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

On Tue, Mar 14, 2023 at 03:05:48PM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2023 12:48, Dmitry Rokosov wrote:
> > On Tue, Mar 14, 2023 at 12:28:40PM +0100, Krzysztof Kozlowski wrote:
> >> On 13/03/2023 21:12, Dmitry Rokosov wrote:
> > 
> > [...]
> > 
> >>> +#define CLKID_SPIFC		84
> >>> +#define CLKID_USB_BUS		85
> >>> +#define CLKID_SD_EMMC		86
> >>> +#define CLKID_PSRAM		87
> >>> +#define CLKID_DMC		88
> >>
> >> And what is here? Between 88 and 121?
> >>
> > 
> > Explained below.
> > 
> >>> +#define CLKID_GEN_SEL		121
> >>> +
> >>> +#endif /* __A1_CLKC_H */
> >>> diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> >>> new file mode 100644
> >>> index 000000000000..8e97d3fb9d30
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> >>> @@ -0,0 +1,20 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0+ */
> >>
> >> I found in changelog:
> >> "fix license issue, it's GPL-2.0+ only in the current version"
> >> and I do not understand.
> >>
> >> The license is wrong, so what did you fix?
> >>
> > 
> > Sorry don't get you. Why is it wrong?
> 
> Run checkpatch - it will tell you why wrong. The license is not correct.
> This is part of binding and should be the same as binding.
> 

I always run checkpatch before sending the next patch series. Checkpatch
doesn't highlight this problem:

--------------
$ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
188:+/* SPDX-License-Identifier: GPL-2.0+ */
294:+/* SPDX-License-Identifier: GPL-2.0+ */

$ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
total: 0 errors, 0 warnings, 0 checks, 259 lines checked

a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch has no obvious style problems and is ready for submission.
--------------

I've got your point, will fix in the next version.

> > I've changed all new source files to GPL-2.0+ except yaml, because yaml
> > dt bindings schemas require the following license:
> > 
> >     # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > 
> > I've pointed it in the changelog.
> 
> The only thing I found was:
> "fix license issue, it's GPL-2.0+ only in the current version"
> 
> so what exactly you pointed out in changelog? What was to fix? What was
> fixed? Correct license into incorrect? But why?
> 

By 'license issue' I meant your comment for the previous version at:
https://lore.kernel.org/all/6a950a51-fe90-9163-b73d-0a396d7187ee@linaro.org/

I thought you mentioned the problem is in two license usage in the one
line (GPL + MIT), I've fixed it to GPL2 only, and mentioned it in the
changelog.

I didn't know about the special requirement for a dt-bindings license, I've
just checked other clock dt-bindings and found that license is different
in the many places:

$ grep -r "SPDX" include/dt-bindings/clock | grep -v -e "GPL-2.0.*BSD-2-Clause" | wc -l
291

And Tegra Car 124 as an example for different license between yaml
schema and binding header:
$ grep "SPDX" include/dt-bindings/clock/tegra124-car.h
/* SPDX-License-Identifier: GPL-2.0 */
$ grep "SPDX" Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

Anyway, it's not a problem to fix the license to the same value between
header and yaml schema, I'll fix it in the next version.
But based on the above experiments, other clock bindings should be fixed
as well, checkpatch behavior should be extended for dt bindings headers
licence checking.

> > 
> >>> +/*
> >>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> >>> + * Author: Jian Hu <jian.hu@amlogic.com>
> >>> + *
> >>> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> >>> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >>> + */
> >>> +
> >>> +#ifndef __A1_PLL_CLKC_H
> >>> +#define __A1_PLL_CLKC_H
> >>> +
> >>> +#define CLKID_FIXED_PLL		1
> >>> +#define CLKID_FCLK_DIV2		6
> >>> +#define CLKID_FCLK_DIV3		7
> >>> +#define CLKID_FCLK_DIV5		8
> >>> +#define CLKID_FCLK_DIV7		9
> >>> +#define CLKID_HIFI_PLL		10
> >>
> >>
> >> Probably I asked about this... why indices are not continuous? You know
> >> that consumers are allowed to use number 2 and it will be your ABI, even
> >> though you did not write it in the binding? That's a tricky and
> >> confusing pattern for no real gains.
> > 
> > Actually, indices are continuou but splitted into two parts: public and
> > private. The public part is located in the dt bindings and can be included
> > from device tree sources. The private part is in the drivers/clk/meson
> > folder, and only clk drivers can use it.
> > I know, there is some trick when the user just inserts a digit value and
> > doesn't use constants.
> 
> This is not a trick. This is how DTS works. You have only indices/numbers.
> 
> > But I'm starting from the assumption that such
> > dts changes will not be approved by maintainers. In other words, the user
> > *must* apply defined ABI constants from dt bindings; it's a strong
> > restriction.
> 
> But it is not correct assumption. Defines are very important, but they
> are just helpers. Otherwise without defines you could not use any clock?
> We pretty often use IDs - for DTS to allow merging via different trees,
> for DT binding examples to not rely on headers.
> 
> Your driver implements the ABI and the driver exposes for example clock
> ID=2, even if it is not in the header.
> 
> These IDs are unfortunately undocumented ABI and you if you change them,
> users are allowed to complain.
> 
> Solution: don't do this. Have all exposed clock IDs and clocks in sync
> (and continuous).

I see. But I don't understand how I can restrict access to private
clock objects. I don't want to open ability to change system clocks
parents, for example. Or it's under device tree developer responsibility?
I would appreciate any assistance in determining the best path.

-- 
Thank you,
Dmitry
