Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD17461A63C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 01:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKEABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 20:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKEABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 20:01:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986742F44;
        Fri,  4 Nov 2022 17:01:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A5015bb068560;
        Fri, 4 Nov 2022 19:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667606465;
        bh=70/J8OoLwMz2ZYUbC2R1pWuNjEn/hRSMKPEEuh66w90=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Gv3WplavkR0OhY3cyw5apGFxR8Pf4CI2qe6wRU3/3HFrBUeOEZpOLj8xzHzVACoLa
         HfODwGrn/JtbF4xchec3d9/wau+CU2O5VbVnZTeCrc1mBQWK3TZP1Zm0vcp3FIEAy7
         7bl9h7DVTgXC33YKFhXXlUaKA0MUNVwhVwtcB20I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A5014iV084742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 19:01:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 4 Nov
 2022 19:01:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 4 Nov 2022 19:01:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A5014d5015472;
        Fri, 4 Nov 2022 19:01:04 -0500
Date:   Fri, 4 Nov 2022 19:01:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     jerome Neanne <jneanne@baylibre.com>
CC:     Lee Jones <lee@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <kristo@kernel.org>,
        <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <tony@atomide.com>,
        <vigneshr@ti.com>, <bjorn.andersson@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>, <arnd@arndb.de>,
        <jeff@labundy.com>, <afd@ti.com>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <msp@baylibre.com>, <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Message-ID: <20221105000104.rtj3r6ufqwqmepon@keenly>
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com>
 <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:58-20221104, jerome Neanne wrote:
> 
[...]

> 
> > 
> > Can you try an compile with W=1 please.
> This raise one warning on mfd:
> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ defined but
> not used [-Wunused-function]
>    28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> soft_shutdown has been validated and is used in TI baseline even if not
> hooked in upstream version further to this review:
> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
> 
> It was a TI requirement to implement it...
> Let me know if you want me to remove this function or if we can keep it like
> this.

There are platforms without psci, correct? I think the comment was to
drop the force override with system-power-controller property,

if (!pm_power_off) {
	tps65219_i2c_client = client;
	pm_power_off = &tps65219_pm_power_off;
}

Could still be valid for such platforms, no? I do see that the
capability that the PMIC has - which is software shutdown is a valid
feature that we support in many different PMIC drivers. Is'nt the job of
the driver to introduce the functionality in a manner that is
appropriate to the OS framework?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
