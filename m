Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805D6E3168
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjDOMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDOMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:47:26 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0707449F;
        Sat, 15 Apr 2023 05:47:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33FCl94k058808;
        Sat, 15 Apr 2023 07:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681562829;
        bh=sb0FhD/LvwwWn6UVgXTwyf8MfqPC7ltsVNVDTgc/s2M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QDQgQiYwVuBe3q62Hmw9OoK4HiViFw5WAh26VXX6UwXcI74PUTPaYn4IHrBnhDHZh
         nmh5y32NvXcXhfCq3V6UC6ouqT8cQ5HJEU2KBG4eo7KWD2XL5Gnr2tX0p4s2xXtzsw
         XxD2FTSE4IYVbgF4pOpQpj+/cFfkp0IY9yoS0LkQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33FCl9bl037598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Apr 2023 07:47:09 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 15
 Apr 2023 07:47:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 15 Apr 2023 07:47:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33FCl90K046000;
        Sat, 15 Apr 2023 07:47:09 -0500
Date:   Sat, 15 Apr 2023 07:47:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Enable
 I2C
Message-ID: <20230415124709.fazcyqe5zfnbcrbc@jogging>
References: <20230414181434.2046049-1-u-kumar1@ti.com>
 <20230414181434.2046049-3-u-kumar1@ti.com>
 <20230414182401.2yfpwjug3naiwesi@quicksand>
 <b360dfd0-3dd3-996c-a9b6-1af770c4015b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b360dfd0-3dd3-996c-a9b6-1af770c4015b@ti.com>
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

On 09:36-20230415, Kumar, Udit wrote:
[...]

> > > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > index 63633e4f6c59..e66bbfe65ff2 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > @@ -254,6 +254,10 @@ exp3: gpio@20 {
> > >   	};
> > >   };
> > > +&wkup_i2c0 {
> > > +	status = "okay";
> > How about the pinmux? speed? what peripheral is on the wakeup i2c?
> > 
> > 	Do we have an eeprom or something here?
> 
> 
> This got eeprom and PMIC,
> 
> eeprom read is ok with pin mux and speed.
> 
> if you want to specify, let me know

yes, you must specify eeprom at least. I understand pmic is in
discussion atm [1], So, that can be resolved seperately.

Also if the eeprom is on the SoM, you should add this in the SoM dtsi,
not the baseboard dtsi.

[1] https://lore.kernel.org/all/714a56b1-438c-7aad-920b-f3f1d72afc5f@linaro.org/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
