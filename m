Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E8D6A9370
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCCJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCCJLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:11:47 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BD1BAD6;
        Fri,  3 Mar 2023 01:11:44 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5E7D75FD19;
        Fri,  3 Mar 2023 12:11:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677834701;
        bh=3ji1fr9+q7ezZEBlpXkWKmZcPIE/FPeg1wnZMzAhRes=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=JUX++Hk0a9OvSMig9pzrU7L+21DIQRJuGk+c0BBy918SyyBRBg9/SSMD7JXmvyGGb
         WAPu7qkxJjGeOplHqiiCOuf7HjTe1/+tG/8QsHWhT2RHqdYlAc/9C6WYg5tk68NB/r
         86wJyyBX9kj7EikhG1kk6Pe/EdN4jcbLV7zCCCHSu5Z7U8+ziuDUhcn7bLce120lbD
         XUrrN33GK32N9tYqzTKB0fTorWjWNwNaHjDq8TQvFbhas+UdjqMvT5/y7TpeuDeSjz
         ie32LWHynk7euhR6bOsKeGeBjCWea9pu/EW34qqY0Rs2c4L5MWjiXG66zytwtlbx9h
         uC7E1X5HJk0Zw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  3 Mar 2023 12:11:40 +0300 (MSK)
Date:   Fri, 3 Mar 2023 12:11:40 +0300
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
Subject: Re: [PATCH v9 3/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20230303091140.isp2rfmhatkqan3o@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-4-ddrokosov@sberdevices.ru>
 <6a950a51-fe90-9163-b73d-0a396d7187ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a950a51-fe90-9163-b73d-0a396d7187ee@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/03 05:33:00 #20911335
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Thank you for quick review!

On Fri, Mar 03, 2023 at 09:28:22AM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2023 19:37, Dmitry Rokosov wrote:
> > Add the documentation for Amlogic A1 PLL clock driver, and A1 PLL
> > clock controller bindings.
> > Also include new A1 clock controller dt bindings to MAINTAINERS.
> > 
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  include/dt-bindings/clock/a1-pll-clkc.h       | 20 +++++++
> >  3 files changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> >  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> > 

[...]

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/a1-clkc.h>
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 

I always run dt binding tests before sending the patch series.
It's 'must have' prerequisite along with checkpatch.

The first one (dt_binding_check):
    $ make ARCH=arm64 INSTALL_MOD_PATH=${INSTALL_MOD_PATH} \
           CROSS_COMPILE="${CROSS_COMPILE}" DEPMOD=${DEPMOD}
           INSTALL_MOD_STRIP=1 -C ${KERNEL_PATH} \
           dt_binding_check DT_SCHEMA_FILES=${DT_SCHEMA_PATH}

The second one (dtbs_check):
    $ make ARCH=arm64 INSTALL_MOD_PATH=${INSTALL_MOD_PATH} \
           CROSS_COMPILE="${CROSS_COMPILE}" DEPMOD=${DEPMOD} \
           INSTALL_MOD_STRIP=1 -C ${KERNEL_PATH} \
           dtbs_check DT_SCHEMA_FILES=${DT_SCHEMA_PATH}

But, as you mentioned in the another patchset, I didn't take into account
bisectability. In other words, I didn't execute above sanity check on the
each patchset.
Thank you for good catch, I'll fix it in the today v10 patch series.

> > +    apb {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        clock-controller@7c80 {
> > +            compatible = "amlogic,a1-pll-clkc";
> > +            reg = <0 0x7c80 0 0x18c>;
> > +            #clock-cells = <1>;
> > +            clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
> > +                     <&clkc_periphs CLKID_HIFIPLL_IN>;
> > +            clock-names = "fixpll_in", "hifipll_in";
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39ff1a717625..8438bc9bd636 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1895,6 +1895,7 @@ L:	linux-amlogic@lists.infradead.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/amlogic*
> >  F:	drivers/clk/meson/
> > +F:	include/dt-bindings/clock/a1*
> >  F:	include/dt-bindings/clock/gxbb*
> >  F:	include/dt-bindings/clock/meson*
> >  
> > diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> 
> Filename matching bindings, so amlogic,a1-pll-clkc.h

You are totally right. But looks like other amlogic clock bindings don't
follow this rule.
So I'll change my patch series and send another patch series with fixup other
amlogic clock bindings.
> 
> > new file mode 100644
> > index 000000000000..3a559518c6e6
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Any particular reason for using license other than in binding? Was it
> intentional (e.g. because it is derivative work)?
> 

No reason, actually. I've just used license which was introduced in the
previous patch series versions by Jian Hu. I suppose, standard license
usage should be okay.

[...]

-- 
Thank you,
Dmitry
