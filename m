Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965976A9380
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCCJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCCJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:14:43 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7317154;
        Fri,  3 Mar 2023 01:14:27 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 043C55FD24;
        Fri,  3 Mar 2023 12:14:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677834866;
        bh=kUxnEfhf3DSq+AgIFhAXjSbGolPo+vWxyTE1tXzicTs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=U2VsBqbdmuVXpFEsA05fb/bTexuln481h/mtvOffQH2yTwXz3QJY7qX5PV6+1Czrk
         l+k76WjTHxc/aK4/m8x45QT0CiD1xChznaxX8xBlNOtRdmeoknKpxMj4k93xuJen6+
         eMA5sU5LIHyxaTu62/SErXhprUKXI/S5OHmTXBvYI+C46YhuysLFTSKhyA6Zu1F03o
         KC6cS7e8avRwYkcUfPo+CdlQzYl8AR11MKO48/7VL00he81fzjUVES0Ypk8MVAMpr4
         /sYhMebpSjITGl5z0Ti9088UBqtWmCaMhm6Pzum+XG+NoZAjF/JWSDwzZhph8/RO9o
         R7XRxD/dbSu0Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  3 Mar 2023 12:14:25 +0300 (MSK)
Date:   Fri, 3 Mar 2023 12:14:25 +0300
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
Subject: Re: [PATCH v9 5/5] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <20230303091425.hwn5ihu4et4oviee@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-6-ddrokosov@sberdevices.ru>
 <d5c93a9f-4a66-f884-a4d1-68cf47bcd7d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5c93a9f-4a66-f884-a4d1-68cf47bcd7d4@linaro.org>
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

On Fri, Mar 03, 2023 at 09:29:59AM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2023 19:37, Dmitry Rokosov wrote:
> > Add the documentation for Amlogic A1 Peripherals clock driver,
> > and A1 Peripherals clock controller bindings.
> > 
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++++
> >  include/dt-bindings/clock/a1-clkc.h           | 102 ++++++++++++++++++
> >  2 files changed, 175 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> >  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> > new file mode 100644
> > index 000000000000..3dc86e912dea

[...]

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/a1-pll-clkc.h>
> 
> Eh, this explains bisectability problem.
> 
> Please do not sent patchets which are not bisectable. You can hard-code
> the IDs in the example, they don't really matter.
> 

Yep, my fault. As I mentioned in the other patchset, I've executed dt bindings
checkers on the total patch series, not on each patchset. Sorry for
that.

[...]

-- 
Thank you,
Dmitry
