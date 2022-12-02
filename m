Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136276403BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLBJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiLBJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:49:48 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08794CB229;
        Fri,  2 Dec 2022 01:49:44 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D027B5FD0A;
        Fri,  2 Dec 2022 12:49:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669974581;
        bh=FbqsU5GM/s6H3tix6hLnnOQO0K56pMLJtqHLVhUNgXs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=UPYOpBXln+D9Lxmxx9q2ygclqrJdoUAa8swbKYm+8ASGftkpKx8beygRXG6PDCV9n
         HgQuF0cb+CgZx7AOSCrDHHp7oZmRUVK9kEasMLDnPWYCyeaIianqRHgb2Qgc1TL7yK
         0/dZrba9wr0NfWFU5U+4wSXwiaYrtrPqO0s4M3FGue8qiTqjuHsOBTeKE4ZteYBix6
         z0xkxkFAE89NSuG2hysxpUUXcIGBahNZHJZbaRfLPR7IVVxsknE0nS83aYFCFtvExS
         JPsRvTSVerFnrsPEzUzjmXHFqugK929a1DRr2cAK7dFDahM9yzU5w/BtTKIDcJs/TG
         ONH9njUxEksEg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 12:49:41 +0300 (MSK)
Date:   Fri, 2 Dec 2022 12:49:40 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     <martin.blumenstingl@googlemail.com>,
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
Message-ID: <20221202094940.elhjbz7tbgxesr52@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-4-ddrokosov@sberdevices.ru>
 <166995398331.2089708.18189499743713568568.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166995398331.2089708.18189499743713568568.robh@kernel.org>
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

On Thu, Dec 01, 2022 at 10:10:04PM -0600, Rob Herring wrote:
> 
> On Fri, 02 Dec 2022 01:56:55 +0300, Dmitry Rokosov wrote:
> > From: Jian Hu <jian.hu@amlogic.com>
> > 
> > Add the documentation to support Amlogic A1 peripheral clock driver,
> > and add A1 peripheral clock controller bindings.
> > 
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  .../bindings/clock/amlogic,a1-clkc.yaml       | 65 ++++++++++++
> >  include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
> >  2 files changed, 163 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> >  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#
> Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dts:18.48-30.11: Warning (unit_address_vs_reg): /example-0/periphs-clock-controller: node has a reg or ranges property, but no unit name
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.example.dtb: periphs-clock-controller: reg: [[0, 2048], [0, 260]] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221201225703.6507-4-ddrokosov@sberdevices.ru
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

That's totally right warnings and errors. All of them are fixed in the
my "fixup" patch of Jian's original dt_binding schema:

https://lore.kernel.org/linux-amlogic/20221201225703.6507-11-ddrokosov@sberdevices.ru/

-- 
Thank you,
Dmitry
