Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6106B32E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCJAna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:43:29 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066B5D251;
        Thu,  9 Mar 2023 16:43:26 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32A0hCmC055370;
        Thu, 9 Mar 2023 18:43:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678408992;
        bh=CuyET4dXI3Nb3R8yiBlQC4XOd23d1xfB0IxLQQdd8K4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HYKu5ExPKfvwtKDgvwCikSrVZeZMrhXLUVnK+cITyR5EiBy6sJbULEDv4NgjG0Tiy
         5DAs5Grc7i0qYJo/BIAdVB9qkn4PT8OdGsw15SiQTHlGQvkdBjrkIXCDRZMEnfU/mR
         nvgQoeuPjTzGXk6ZWhtBE9aqzLkrX9k66Rie2nec=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32A0hCFl013382
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 18:43:12 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 18:43:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 18:43:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32A0hBc6095856;
        Thu, 9 Mar 2023 18:43:11 -0600
Date:   Thu, 9 Mar 2023 18:43:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: k3: Introduce debounce select mux
 macros
Message-ID: <20230310004311.5e5ekv7edpbahjap@groggily>
References: <20230308084309.396192-1-nm@ti.com>
 <CACRpkdbBWeFupRin=JuMCGDWkzbsR18N+4ZEbQOPJq=p3w0yLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdbBWeFupRin=JuMCGDWkzbsR18N+4ZEbQOPJq=p3w0yLw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:03-20230309, Linus Walleij wrote:
> On Wed, Mar 8, 2023 at 9:43 AM Nishanth Menon <nm@ti.com> wrote:
> 
> > Introduce the debounce select mux macros to allow folks to setup
> > debounce configuration for pins. Each configuration selected maps
> > to a specific timing register as documented in appropriate Technical
> > Reference Manual (example:[1]).
> >
> > [1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Patch applied.
> 
> Consider doing what Krzysztof recommends: move thes <dt-bindings/*.h>
> down to the arch where you're using it and have them as .dtsi files instead
> or something.

Yep, that sounds like a better idea. If you are ok to drop this
patch, then lets do the cleanup first and move the pinctrl to something like
arch/arm64/boot/dts/ti/k3-pinctrl.h

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
