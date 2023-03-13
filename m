Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43636B7D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCMQUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCMQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:20:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A461F5ED;
        Mon, 13 Mar 2023 09:20:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DGK956004984;
        Mon, 13 Mar 2023 11:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678724409;
        bh=Uc2APdIAYB7poq9J28h4dQiY7hK7soScXAAPeXg8vIs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oLFZ5reC/TrJfowviVD24QbGoytUeZmk5sO7mxXs8MqztcHN+/nsekiBgfvQAryy/
         WJAUiMPD9Owyb70/oSy9eb9G4j6swxjsm0WX/6lYuG5E/dUlUBKZbfpQUZdm9GpDGO
         X6SVKr4EJK03ilwnfDECmFv71VscK2P0HHvfCVHI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DGK9SA071070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 11:20:09 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 11:20:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 11:20:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DGK8iI065378;
        Mon, 13 Mar 2023 11:20:08 -0500
Date:   Mon, 13 Mar 2023 11:20:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     a0502875 <d-dhyani@ti.com>
CC:     Bhavya Kapoor <b-kapoor@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel
 property
Message-ID: <20230313162008.faokisdbaeecm55h@swampland>
References: <20230203073724.29529-1-b-kapoor@ti.com>
 <3279b78d-fa6d-d1f4-3692-87e628bcd737@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3279b78d-fa6d-d1f4-3692-87e628bcd737@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:27-20230313, a0502875 wrote:
> On 03/02/23 13:07, Bhavya Kapoor wrote:
> > According to latest errata of J721e [1], (i2024) 'MMCSD: Peripherals
> > Do Not Support HS400' which applies to MMCSD0 subsystem. Speed modes
> > supported has been already updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> > but it missed dropping 'ti,strobe-sel' property which is only required
> > by HS400 speed mode.
> > 
> > Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.
> > 
> > [1]https://www.ti.com/lit/er/sprz455/sprz455.pdf
> > 
> > Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> > Signed-off-by: Bhavya Kapoor<b-kapoor@ti.com>
> 
> Reviewed-by: Diwakar Dhyani <d-dhyani@ti.com <mailto:d-dhyani@ti.com>>

Please fix your mailer. I will need to hand apply for now.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
