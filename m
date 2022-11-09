Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FECF6228F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKIKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiKIKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:48:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6452648C;
        Wed,  9 Nov 2022 02:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667990882; x=1699526882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OpLpfKgFncaOypu/Y4C5vCxOS6jzJd+feOYi1RLb4lY=;
  b=ue/pWzw6a8CXhJZ0FZP/EV+LW2hnsHfSUWqqOhbMAV0B6PSNYCwmV2cV
   +iwzKUg7RdeEmY+ud7IU74XSJAxftAfbK8IeTafo2Cm7ZBiO1UEdti3EM
   F5KdMeUhJ5kd2WXkss7WAb86syJcvo9RgpU4DcE6Wv+OPnO696BqkjCIj
   xIWK8EgMAEmVwG5oCIPECX4h9uE1FgL3QQASUnq3cOxz+A0e+zMjsu160
   MprmkqyL0X4L81DH+yFoRVbCkfgpop9HrCN5oEShn0iqzwVv/a4QbwqTv
   eiCRizIsFS9rzTuj2jDFO6R2T20Jg1uyJ0gp5mqwPwSuj0eypjVBUBttm
   A==;
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="186093230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Nov 2022 03:48:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 9 Nov 2022 03:47:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 9 Nov 2022 03:47:57 -0700
Date:   Wed, 9 Nov 2022 10:47:40 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v11 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Message-ID: <Y2uFTM/O0b39greO@wendy>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
 <20221007113512.91501-5-conor.dooley@microchip.com>
 <20221109093525.kx4tyvha7y3sikxw@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109093525.kx4tyvha7y3sikxw@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:35:25AM +0100, Uwe Kleine-König wrote:
> On Fri, Oct 07, 2022 at 12:35:13PM +0100, Conor Dooley wrote:
> > Add the newly introduced pwm driver to the existing PolarFire SoC entry.
> > 
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I assume you will rework the series and resend this one with the driver
> patche. Applying patch #4 alone doesn't make sense, so I'm marking this
> one as "changes requested", too, in the PWM patchwork instance.
> 
> IMHO patches #1 and #2 make sense to be applied already without the
> driver given the binding is already there. I assume they will go in via
> the riscv tree, so I will mark these two as "handled elsewhere".

Right. Makes sense to me - I'll take the dt-binding & the dt via the
riscv (or soc, we're changing things up there [a]) tree.

Thanks,
Conor.

[a] - https://lore.kernel.org/linux-riscv/mhng-e4210f56-fcc3-4db8-abdb-d43b3ebe695d@palmer-ri-x1c9a/
