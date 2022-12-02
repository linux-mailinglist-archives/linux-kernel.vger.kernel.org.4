Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D16403C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiLBJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiLBJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:51:29 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F987CAF89;
        Fri,  2 Dec 2022 01:51:26 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D13BF5FD0B;
        Fri,  2 Dec 2022 12:51:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669974684;
        bh=72VVTkRY9DjXgUjSD9VXksh7Od+zuedUupDyk8ZPL64=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Ud3M/0dAGTjSPWCJ4qDcqnrloGRDW4WyDNac2USRNB1fBT0jW82Aagmxt+Imnip4B
         zpGE9qStbUJLOpbGVZZR7Ksa3sdzYFNee1SYP2uDfwQt/T4deWBHFyHULhK2dQ6ixH
         9DvfRo3qDQwt1dpvlZRknRuT5NCArqi98n2vb4Ja+w6CCDfPeejQOtYVfrVorbQmaw
         l8WkEuaZxJJxEBuZdaWVCy3mEA4TORauZczB4vpdYNyHkDXhz41yyoUzBTN6Fyejxn
         szgQlsAAE53MM/dnECSed+OhqBqBK8mNTAPCel9vx2pgk3WU15JgPUSTmRYDZn9xWU
         Z3MTXLbQa/tMg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 12:51:24 +0300 (MSK)
Date:   Fri, 2 Dec 2022 12:51:24 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <kernel@sberdevices.ru>,
        <robh+dt@kernel.org>, <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>, <jian.hu@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-amlogic@lists.infradead.org>, <jbrunet@baylibre.com>,
        <rockosov@gmail.com>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <neil.armstrong@linaro.org>
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
 <166995398251.2089685.16059995540663317860.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166995398251.2089685.16059995540663317860.robh@kernel.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
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

On Thu, Dec 01, 2022 at 10:10:04PM -0600, Rob Herring wrote:
> 
> On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
> > From: Jian Hu <jian.hu@amlogic.com>
> > 
> > Add the documentation to support Amlogic A1 PLL clock driver,
> > and add A1 PLL clock controller bindings.
> > 
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
> >  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> >  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.example.dtb: pll-clock-controller@7c80: reg: [[0, 31872], [0, 396]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-2-ddrokosov@sberdevices.ru
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Please find all fixes of above warnings and errors in the my patch
located at the link:

https://lore.kernel.org/linux-amlogic/20221201225703.6507-9-ddrokosov@sberdevices.ru/


-- 
Thank you,
Dmitry
