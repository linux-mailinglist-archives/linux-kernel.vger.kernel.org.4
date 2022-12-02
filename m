Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804A6405D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiLBL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiLBL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:36 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2B91C3C;
        Fri,  2 Dec 2022 03:28:34 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 38ADA5FD0B;
        Fri,  2 Dec 2022 14:28:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669980512;
        bh=QzvFMzqrA0Xg0ajrI6zhrJuw38OKMTtVraispL2tE5E=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=lBwot9vFV15uD5M33HJ79TCkCRtyuaA/E3weqyezHlA3yqraYskiuEPjO6v448V7i
         5deR42884JIBqJBxZ4aCDvA1AAVuc6sMLx/PQ/oepAvvpcO9VOjyh4dZTdHwYkoHka
         laB1/HmW19+QVZ7Q846YakiBgWThM/+Xdg3V+PVIHH9dk1pitWvKjXLzbBbKyuIfQ/
         T4SNyRifAot1M7bPFURV69UEtNkq/eBVTmdg9RpaDDrZ3waihQQj27bXq/34w4w12a
         usOQWRH+BjonlmObazTAIhxiojKtwtArt7qiIMyKzcsxLPaUpc7lMs77H7smW9KMSA
         B/nlHTjDxpEQw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 14:28:32 +0300 (MSK)
Date:   Fri, 2 Dec 2022 14:28:26 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <sboyd@kernel.org>, <khilman@baylibre.com>,
        <kernel@sberdevices.ru>, <robh+dt@kernel.org>,
        <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>, <jian.hu@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-amlogic@lists.infradead.org>, <rockosov@gmail.com>,
        <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        <neil.armstrong@linaro.org>
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20221202112826.zkpjyb3f4e2755sh@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
 <166995398251.2089685.16059995540663317860.robh@kernel.org>
 <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
 <cea3cdd4-3d36-1439-b211-047091c05a0f@linaro.org>
 <1jfsdy83h3.fsf@starbuckisacylon.baylibre.com>
 <b425da35-c189-aabb-65b9-f956945d7b08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b425da35-c189-aabb-65b9-f956945d7b08@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 07:44:00 #20636821
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>> On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
> >>>>> From: Jian Hu <jian.hu@amlogic.com>
> >>>>>
> >>>>> Add the documentation to support Amlogic A1 PLL clock driver,
> >>>>> and add A1 PLL clock controller bindings.
> >>>>>
> >>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> >>>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >>>>> ---
> >>>>>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
> >>>>>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
> >>>>>  2 files changed, 68 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> >>>>>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> >>>>>
> >>>>
> >>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>>>
> >>>> yamllint warnings/errors:
> >>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> >>>>
> >>>> dtschema/dtc warnings/errors:
> >>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename

...

> >>>
> >>> Please find all fixes of above warnings and errors in the my patch
> >>> located at the link:
> >>>
> >>> https://lore.kernel.org/linux-amlogic/20221201225703.6507-9-ddrokosov@sberdevices.ru/
> >>
> >> Why? This patch here is broken and it should be fixed. Don't apply
> >> broken patches...
> > 
> > Dmitry is ressurecting a series that is several years old and not his to
> > begin with.
> > 
> > He was unsure about take the code of somebody else.
> > To be fair, he even asked for advice on IRC about to proceed.
> > 
> > Dmitry, as you may have guessed, for next revision, please fix Jian Hu
> > original patches in place, not with fixup patches.
> > 
> > If your fixes are minor (not complete rewrite), please keep the original
> > author and add your SoB
> 
> We never take intentionally wrong patches, e.g. code which does not even
> compile, and immediately fix it in next patch.
> 
> Can you imagine adding such drivers? Which are broken in the commit they
> are added?
> 
> So the patchset is old or abandoned, take ownership, add co-developed
> etc. Just don't add known broken code.

Okay, I've got your point. It's reasonable.
I will fix Jian Hu's patches (squash with mine) and mark all of them
with co-developed and SoB Jian Hu tags. Thank you for explanation.

-- 
Thank you,
Dmitry
