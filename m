Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939A640564
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiLBK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiLBK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:58:47 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21799381B;
        Fri,  2 Dec 2022 02:58:38 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CB99C5FD0B;
        Fri,  2 Dec 2022 13:58:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669978715;
        bh=bmtQOp0MHFjIRwhVsuo8y6uKrcRollt9lDuoEi9K2Ns=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=sDgpn/xX2RPFtFDVGuLMmeVg7uLVdiBcZaROU6x3DAGgZM0FchEFeCx3JRUpYdwY9
         y0yN84dSkfMyxuZZx5BqNzh6pjlUzcngmgoy7o3gSei2fdiZaCs5SqM1MiSuh8ENyr
         4Q9BGy/bvHKtkCPe7M+FE2HhijT3NzguM1r8bkpMBxuUn6oTb13fzxElpr6Z+ihNdV
         Si1fMikx9d8XNdgMs5pwxrKkmv/S6Y8nd2pIjbIHKLXOO4BCi17f5m7qlR9lQNN8gJ
         QU0PJlCJ7QtMAGiuJKKIh9fzjGqMACArv3WmsnL7QrIZdZBOGAbqvVkBYxf+aXuCrG
         nVZ6pfv+kampw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 13:58:35 +0300 (MSK)
Date:   Fri, 2 Dec 2022 13:58:34 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh@kernel.org>,
        <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <jian.hu@amlogic.com>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <linux-amlogic@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <rockosov@gmail.com>,
        <kernel@sberdevices.ru>, <neil.armstrong@linaro.org>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>
Subject: Re: [PATCH v8 03/11] dt-bindings: clock: meson: add A1 peripheral
 clock controller bindings
Message-ID: <20221202105834.4avip2trjbm3tpn7@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-4-ddrokosov@sberdevices.ru>
 <166995398331.2089708.18189499743713568568.robh@kernel.org>
 <20221202094940.elhjbz7tbgxesr52@CAB-WSD-L081021>
 <640ad325-91c4-109a-5ccd-05ac653a29bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <640ad325-91c4-109a-5ccd-05ac653a29bb@linaro.org>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Thank you for quick review. Let me explain you why I sent Jian broken
patches and applied my fixup patches above.

I've found several versions of A1 clkc drivers from Jian Hu Amlogic engineer,
the last one version was a couple years ago.
I've reworked the last (v7) version and didn't know the correct way to apply
all fixes.

From my point of view I thought about two options:
1) Merge all my changes with Jian Hu patches and leave Jian Hu SoB
2) Don't touch Jian Hu v7 patches and apply my changes above.

I have chosen the second option, because it looks like respect Jian Hu's
effort. I don't want to "stealing" his patches, just want to fix all
broken things.

So I'm sorry for misunderstanding here and please correct
me what's right workflow in such situation.

On Fri, Dec 02, 2022 at 11:39:47AM +0100, Krzysztof Kozlowski wrote:
> On 02/12/2022 10:49, Dmitry Rokosov wrote:
> > On Thu, Dec 01, 2022 at 10:10:04PM -0600, Rob Herring wrote:
> >>
> >> On Fri, 02 Dec 2022 01:56:55 +0300, Dmitry Rokosov wrote:
> >>> From: Jian Hu <jian.hu@amlogic.com>
> >>>
> >>> Add the documentation to support Amlogic A1 peripheral clock driver,
> >>> and add A1 peripheral clock controller bindings.
> >>>
> >>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> >>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >>> ---
> >>>  .../bindings/clock/amlogic,a1-clkc.yaml       | 65 ++++++++++++
> >>>  include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
> >>>  2 files changed, 163 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> >>>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> ./Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
> >> 	expected: http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#
> >> Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dts:18.48-30.11: Warning (unit_address_vs_reg): /example-0/periphs-clock-controller: node has a reg or ranges property, but no unit name
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dtb: periphs-clock-controller: reg: [[0, 2048], [0, 260]] is too long
> >> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> >>
> >> doc reference errors (make refcheckdocs):
> >>
> >> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-4-ddrokosov@sberdevices.ru
> >>
> >> The base for the series is generally the latest rc1. A different dependency
> >> should be noted in *this* patch.
> >>
> >> If you already ran 'make dt_binding_check' and didn't see the above
> >> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> >> date:
> >>
> >> pip3 install dtschema --upgrade
> >>
> >> Please check and re-submit after running the above command yourself. Note
> >> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> >> your schema. However, it must be unset to test all examples with your schema.
> >>
> > 
> > That's totally right warnings and errors. All of them are fixed in the
> > my "fixup" patch of Jian's original dt_binding schema:
> > 
> > https://lore.kernel.org/linux-amlogic/20221201225703.6507-11-ddrokosov@sberdevices.ru/
> 
> No, this patch must be fixed. It's not correct.
> 
> Best regards,
> Krzysztof
> 

-- 
Thank you,
Dmitry
