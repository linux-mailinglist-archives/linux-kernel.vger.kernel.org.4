Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0285703188
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242236AbjEOP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbjEOP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A519AA;
        Mon, 15 May 2023 08:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73CC62093;
        Mon, 15 May 2023 15:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75951C433EF;
        Mon, 15 May 2023 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164515;
        bh=OGtmFJDczh3lYYzoiMZ4oyNnfvHEjzaMRFzhpDA09j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAoTbfQu22qiYm8SDgNHeAgqv9i+33VJd3ttD9ikwxavqhcGnUAkZzvGMUX8atDxm
         qMGn4EusTXzzPV8LbBv+BJT8nqyF3ZoGhJgjAeQOLRftx52X9nojXypic+681cmuAV
         o8J9tTyF2p/k0IAvc9fxacMrMux9CRFc3Yg6k1Z+EX1tTyM50NVjQUuLeNoetWtlXV
         /qmRRYz7a2RD5mb8j7hJcvI3oghFJPh0+OMNEOBL4PdvnSbe85H/Ed9NIwMnEsb8JY
         XSU0Y05T299LtDJ6FDAEOcNI9mCAdtiNHRVD4FINCsa9GOnHaRta99g9X/3I68IOAp
         9tqU40fJBtG+g==
Date:   Mon, 15 May 2023 16:28:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shengyu Qu <wiagn233@outlook.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230515152829.GW10825@google.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
 <20230515161940.3bcbe932@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515161940.3bcbe932@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Andre Przywara wrote:

> On Mon, 15 May 2023 11:52:29 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Thu, 04 May 2023, Krzysztof Kozlowski wrote:
> > 
> > > On 03/05/2023 13:07, Andre Przywara wrote:  
> > > > On Wed, 26 Apr 2023 15:27:40 +0100
> > > > Lee Jones <lee@kernel.org> wrote:
> > > > 
> > > > Hi Lee,
> > > > 
> > > > I see this patch in Linus' tree, but something must have gone wrong here,
> > > > can you please check? See below ...
> > > >   
> > > >> On Fri, 21 Apr 2023, Shengyu Qu wrote:
> > > >>  
> > > >>> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> > > >>> via an I2C bus.
> > > >>>
> > > >>> Describe the regmap and the MFD bits, along with the registers exposed
> > > >>> via I2C. Eventually advertise the device using a new compatible string
> > > >>> and add support for power off the system.
> > > >>>
> > > >>> The driver would disable PEK function if IRQ is not configured in device
> > > >>> tree, since some boards (For example, Starfive Visionfive 2) didn't
> > > >>> connect IRQ line of PMIC to SOC.
> > > >>>
> > > >>> GPIO function isn't enabled in this commit, since its configuration
> > > >>> operation is different from any existing AXP PMICs and needs
> > > >>> logic modification on existing driver. GPIO support might come in later
> > > >>> patches.
> > > >>>
> > > >>> ---    
> > > >>
> > > >> You must not use these above the tags or Git will drop them.
> > > >>  
> > > >>> Changes since v2:
> > > >>>  - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch  
> > > > 
> > > > So this patch was based on the AXP313a series, but I don't see that in
> > > > Linus' tree (or in any of your trees, if I have checked correctly).
> > > > There must have been a conflict, as this [PATCH v3 2/3] diff actually lists
> > > > the axp313a entry in the context lines.
> > > >   
> > > >>>  - Add axp_regulator_only_cells rather than directly using axp806_cells
> > > >>>    for cases that IRQ line isn't connected.
> > > >>>
> > > >>> Changes since v1:
> > > >>>  - Nothing
> > > >>>
> > > >>> [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
> > > >>>
> > > >>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> > > >>> ---    
> > > >>
> > > >> Put change-logs here instead.
> > > >>  
> > > >>>  drivers/mfd/axp20x-i2c.c   |   2 +
> > > >>>  drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
> > > >>>  include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
> > > >>>  3 files changed, 194 insertions(+)    
> > > >>
> > > >> I manually added the missing tags for this and the DT patch and applied.  
> > > > 
> > > > So this patch doesn't list any tags aside from Shengyu's
> > > > Signed-off-by. The patch in Linus' tree list a Reviewed-by: from
> > > > Krzysztof, which I don't see anywhere in the thread, he just reviewed the
> > > > binding patch, AFAICT.   
> > > 
> > > Yep, I never reviewed this.
> > >   
> > > > I see your tentative R-b: on v2, but with the
> > > > request to rebase and resend, which he did with v3. The applied patch
> > > > looks like v3, but not on the base commit this was send against.
> > > > 
> > > > So I am slightly confused, and am also wondering what happened to the
> > > > AXP313a patches? I see the binding patch merged, but not the MFD part,
> > > > even though you replied saying so.  
> > > 
> > > Because the patch #1 was broken, see:
> > > https://lore.kernel.org/all/TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
> > > 
> > > The SoB and Reviewed-by were after --- and apparently b4 understood it
> > > as cover letter and applied everywhere.
> > > 
> > > Lee,
> > > Do you have the latest b4? If yes, this should be reported as b4 bug,
> > > assuming you used it.  
> > 
> > I am using b4, although the version I'm using is quite old (0.9.0).
> > 
> > Also, this was quite some time ago - I have slept since applying this
> > and do not distinctly remember doing so.  Thus, the application of your
> > R-b may well have been a mistake on my part.  I'll keep an eye for such
> > things in the future and if I see (and remember) an issue, I'll report
> > it.
> 
> So what are we going to do about the two series now? I guess it's not
> worthwhile to revert Shengyu's patch, just for the wrong R-b: tag?

No, I won't be reverting any patches.

> So does this mean both series should be rebased on top of that and re-sent?

Yes please.

-- 
Lee Jones [李琼斯]
