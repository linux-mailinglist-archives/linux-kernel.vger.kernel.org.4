Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C476F56F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjECLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:08:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01D032698;
        Wed,  3 May 2023 04:08:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAF672F4;
        Wed,  3 May 2023 04:08:52 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481E63F67D;
        Wed,  3 May 2023 04:08:07 -0700 (PDT)
Date:   Wed, 3 May 2023 12:07:59 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Shengyu Qu <wiagn233@outlook.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
In-Reply-To: <20230426142740.GN50521@google.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
        <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
        <20230426142740.GN50521@google.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 15:27:40 +0100
Lee Jones <lee@kernel.org> wrote:

Hi Lee,

I see this patch in Linus' tree, but something must have gone wrong here,
can you please check? See below ...

> On Fri, 21 Apr 2023, Shengyu Qu wrote:
> 
> > The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> > via an I2C bus.
> > 
> > Describe the regmap and the MFD bits, along with the registers exposed
> > via I2C. Eventually advertise the device using a new compatible string
> > and add support for power off the system.
> > 
> > The driver would disable PEK function if IRQ is not configured in device
> > tree, since some boards (For example, Starfive Visionfive 2) didn't
> > connect IRQ line of PMIC to SOC.
> > 
> > GPIO function isn't enabled in this commit, since its configuration
> > operation is different from any existing AXP PMICs and needs
> > logic modification on existing driver. GPIO support might come in later
> > patches.
> > 
> > ---  
> 
> You must not use these above the tags or Git will drop them.
> 
> > Changes since v2:
> >  - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch

So this patch was based on the AXP313a series, but I don't see that in
Linus' tree (or in any of your trees, if I have checked correctly).
There must have been a conflict, as this [PATCH v3 2/3] diff actually lists
the axp313a entry in the context lines.

> >  - Add axp_regulator_only_cells rather than directly using axp806_cells
> >    for cases that IRQ line isn't connected.
> > 
> > Changes since v1:
> >  - Nothing
> > 
> > [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
> > 
> > Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> > ---  
> 
> Put change-logs here instead.
> 
> >  drivers/mfd/axp20x-i2c.c   |   2 +
> >  drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
> >  3 files changed, 194 insertions(+)  
> 
> I manually added the missing tags for this and the DT patch and applied.

So this patch doesn't list any tags aside from Shengyu's
Signed-off-by. The patch in Linus' tree list a Reviewed-by: from
Krzysztof, which I don't see anywhere in the thread, he just reviewed the
binding patch, AFAICT. I see your tentative R-b: on v2, but with the
request to rebase and resend, which he did with v3. The applied patch
looks like v3, but not on the base commit this was send against.

So I am slightly confused, and am also wondering what happened to the
AXP313a patches? I see the binding patch merged, but not the MFD part,
even though you replied saying so.

Cheers,
Andre
