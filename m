Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23974F37B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGKPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGKPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:31:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DB98;
        Tue, 11 Jul 2023 08:31:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36BFVi2Z045003;
        Tue, 11 Jul 2023 10:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689089504;
        bh=D3D3/xIRjkeyEdydyNGC69xJm+Qy4qemkwlt3tgV/OI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kDNYjFlaCjTd1th4zNrVe7yHWM0bCL1XKtmJSVK+FdMDS4wujgpNi4CLdJrPY7+Kd
         KJ1bj0HBkQguTBxO23pz+0PBO/XLR7tic7+dDLd4Dh2RR1Dc4Fe78U/eIuLL/BbqcN
         oWDE50qb94/Om2aYd/T67KJGWu/bdRA4eMUwTD+I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36BFVik8045541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 10:31:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 10:31:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 10:31:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36BFViMW069720;
        Tue, 11 Jul 2023 10:31:44 -0500
Date:   Tue, 11 Jul 2023 10:31:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Message-ID: <20230711153144.jvofubaez5uoog5p@unmanaged>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
 <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
 <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:01-20230711, Jayesh Choudhary wrote:
> 
> 
> On 10/07/23 17:13, Krzysztof Kozlowski wrote:
> > On 10/07/2023 12:17, Jayesh Choudhary wrote:
> > > From: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > The system controller node manages the CTRL_MMR0 region.
> > > Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > [j-choudhary@ti.com: Add reg property to fix dtc warning]
> > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > index 2ea0adae6832..68cc2fa053e7 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> > > @@ -5,6 +5,9 @@
> > >    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > >    */
> > > +#include <dt-bindings/mux/mux.h>
> > > +#include <dt-bindings/mux/ti-serdes.h>
> > 
> > Why? What do you use from that binding?
> > 
> 
> Missed idle-state in the mux-controller node here for default values.
> I will wait for more feedback and then re-spin the series.

btw, I am wondering if ti-serdes.h should even exist in dt-bindings -
are any of the macros used in the driver? or should this follow the
pinctrl style macros that could happily reside in arch/arm64/boot/dts/ti
?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
