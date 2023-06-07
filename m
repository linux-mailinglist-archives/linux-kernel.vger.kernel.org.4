Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B37270B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjFGVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFGVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:44:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F11B0;
        Wed,  7 Jun 2023 14:44:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso6560186e87.1;
        Wed, 07 Jun 2023 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174245; x=1688766245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xupC05x57AARfKBIM1aZnUShYcwzVxBXINlBcMbP1PY=;
        b=iccI07MU3UKtDN0cmJm9Kv0x8X0Sxr7Xp8LMLGiP8sUn8qqeogn3I6aXVl/HsM+1Ln
         9F0FgFAhZ+d9BT0ZkwYO9kehc9x+Xv7NRbwEjh1kjoRqAsLJ820WF4X2AdqTO4zV8Vhm
         EPE36KhkvF+Xa8B7k7guVf9Aust6qtAOB+uCQG8+sJAMojEXYeLTwFTtSGhjQyhybPz4
         Kkx+4lA6NCYYsIakKr4dZwTmeZrgkwtSZhozSzwpgIs2Ek3MKJYezi+32HnYo1L5+5aj
         ANcvCknDipoFRP0bwShNiIjO9J+x46BGio1zcan20hRUlCWObsAzb7t5PUa+W7vD+YV4
         32RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174245; x=1688766245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xupC05x57AARfKBIM1aZnUShYcwzVxBXINlBcMbP1PY=;
        b=aiSIhBG7DoGzlJ+4OQChIRiPyjW+D/kfaTfc9MlTer5TYKH6Ew+RzLwGrUtBKHat0x
         7BR3DY4hBxZ6sACBCiLklnw7SFoDT357IQS31UA96fQEqc1DWdArM2QdBgXjimyOocuQ
         AlCALbjD7YJKZhBndcR07iTqFTZr8E5bHpoO6wf2G1qwxx1o0OdV5XtXvIAPAP5LJxqN
         mWbam/8H+XCTzIP3N2LUBLYfx0uAWqPpaPbUW2R4LH55iOGFf6MpbMZ3AonEshRP53zb
         H1IfMeG81aXkpYMp9z1LbYQD5UEgQS2i8QtJs/zx8jTlgs1qFwwZGq41GSEfz8XzZhn2
         mPIA==
X-Gm-Message-State: AC+VfDy+iTXl3l4+zwywpS4Pd6yf2D4zCkdMxugnTlJla2L3buFwT9td
        G7t6rx4Wb1faltfPzKztRSvAHfswdmo=
X-Google-Smtp-Source: ACHHUZ5WqzIvCvIRX0JExjIZNhveN7iCZscVh4wkQjTF9LdIWnon4Gx7AO/CrL7uMS5IsJpyanW0AQ==
X-Received: by 2002:a19:ae0e:0:b0:4f3:895f:f3f5 with SMTP id f14-20020a19ae0e000000b004f3895ff3f5mr2324877lfc.61.1686174244794;
        Wed, 07 Jun 2023 14:44:04 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id d15-20020ac25ecf000000b004eff1f7f206sm1935030lfq.9.2023.06.07.14.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:44:04 -0700 (PDT)
Date:   Thu, 8 Jun 2023 00:44:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-ID: <20230607214402.o2kfsvtn66ga7eth@mobilestation>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
 <20230607112711.alcspwuwpt7nqja7@mobilestation>
 <ZICboAIZAcnYzyJr@ekohande-desk2>
 <20230607152828.4nxefvimokamhgvu@mobilestation>
 <ZIC2FYhcm4iGzlKI@ekohande-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIC2FYhcm4iGzlKI@ekohande-desk2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:53:41AM -0700, Abe Kohandel wrote:
> On 23/06/07 06:28PM, Serge Semin wrote:
> > On Wed, Jun 07, 2023 at 08:00:48AM -0700, Abe Kohandel wrote:
> > > On 23/06/07 02:27PM, Serge Semin wrote:
> > > > On Tue, Jun 06, 2023 at 04:18:44PM -0700, Abe Kohandel wrote:
> 
> > > > > - * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > > > > - * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > > > > - * provide a mechanism to override the native chip select signal.
> > > > 
> > > > I had nothing against this part of the comment but only about the
> > > > second chunk of the text.
> > > 
> > 
> > > Thinking about it a bit more there is nothing precluding this controller from
> > > being used for other purposes in the future. It is configured with two chip
> > > selects, only one of which is used today. I removed it to so it wouldn't become
> > > inaccurate if that happens.
> > 
> > Ok. Regarding the number of chip-selects. You could have overwritten
> > the dw_spi.num_cs field with value 2 then in the dw_spi_mountevans_imc_init()
> > method. Thus having a bit safer driver for your platform.
> 

> I am currently setting dw_spi.num_cs via the num-cs property in the device
> tree. Is one preferred over the other? I guess setting the dw_spi.num_cs in
> code is safer than using the device tree. 

Strictly speaking the "num-cs" property is supposed to be used for
generic DW APB SSI devices (compatible with the snps,dw* string) only
since the IP-core can be synthesized with up to 16 slave select lines
and originally it was considered as impossible to auto-detect the
number of lines (although it's actually possible just by test-writing
to the SER register - another idea for the driver improvement ;) ).
Meanwhile vendor-specific implementations of the DW APB/AHB SSI
controller are synthesized with the particular parameters values
including the number of slave-select signals. Thus the kernel driver
can easily infer all device parameters (like reg-io-width, num-cs,
etc) just based on the compatible string (that's what I did in the
spi-dw-bt1.o driver). The problem is that historically nobody cared
about too relaxed "num-cs" utilization and now we can't update the
driver and the bindings to strictly follow that constraint. The only
solution is to implement the SER-writability-based auto-detection
procedure but it isn't free of risks to break some older devices
(though this problem can be avoided by making it optional).

To sum it up and answering to your question, it's preferable to
directly initialize dw_spi.num_cs in driver if the value is known.

Note though that the DW APB SSI driver currently has a limitation of
GPIO-based chip-selects usage: a total number of chip-selects must not
exceed a number of the native chip select lines (except AMD Pensando
Elba device). It's because in order to have the controller performing
the SPI transfers at least one SER flag must be set. Since we can't
predict which native CS is free from being utilized on a platform
(SPI devices can be instantiated from user-space), the GPIO-based
lines are activated together with the corresponding SER flag.

> 
> > > > > + * DMA-based mem ops are not configured for this device and are not tested.
> > > > 
> > > > * Note mem-ops is just a feature of the DW APB/AHB SSI controllers
> > > > * which provides a way to perform write-then-read and write-only
> > > > * transfers (see Transmit only and EEPROM read transfer modes in the
> > > > * hw manual). It works irrespective of whether your controller has a
> > > > * DMA-engine connected or doesn't have. Modern DW SSI controllers
> > > > * support Enhanced SPI modes with the extended SPI-bus width
> > > > * capability. But it's a whole another story and such modes aren't
> > > > * currently supported by the driver.
> > > > 
> > > > Just a question for the sake of the discussion history. Does your
> > > > platform have a DMA-engine synthesized to work with this DW SSI
> > > > controller? That is does your controller has the DMA Controller
> > > > Interface (handshake signals) connected to any DMA-engine on your
> > > > platform? I am asking because if there is no such DMA-engine then
> > > > the last part of your statement is just redundant since you can't test
> > > > something which isn't supported by design.
> > > 
> > 
> > > The platform does have a DMA-engine synthesized but I have been having some
> > > challenges with getting it to work which may require some further quirks added
> > > to the DMA driver. 
> > 
> > The main question is whether that DMA-engine has the handshake signals
> > connected to the DW SSI controller. If it doesn't then adding such
> > engine support would be a great deal of challenge indeed because a
> > software-based handshaking interface would need to be added to the
> > DMA-engine subsystem first. Then the DW SSI driver would need to be
> > fixed to work with that interface. Taking a FIFO-size into account and
> > an amount of IRQs to handle on each handshaking round, the resultant
> > performance might get to be not worth all the efforts so a simple
> > IRQ-based transfers implementation may work better.
> 
> Oh sorry, I wasn't explicit enough. The HW handshaking signals are connected to
> the DW SSI controller so we should be able to take advantage of that
> acceleration and not have to go through the challenging steps you have
> outlined.
> 
> > > One example being the system uses 40-bit addressing but the
> > > DMA-engine is only synthesized with 32-bit address capability and is meant to
> > > only target a specific region of memory where it "knowns" the upper byte of the
> > > address.
> > 
> > That's a pretty much well known problem. The kernel has a solution for
> > it: DMA-mask set for the DMA-engine device (see dma_set_mask() and
> > dma_set_mask_and_coherent()) and SWIOTLB (formerly known as bounce
> > buffers).
> > 
> > Alternatively modern CPUs are normally equipped with a thing like
> > IOMMU, which can be used to remap the limited device address space to
> > any CPU/RAM address.
> 
> Thanks for all the advice Serge, much appreciated! Hopefully I can come back
> with a patch to enable the DMA engine for this platform in the near future.

Always welcome. Feel free to ask should any question arise on that
journey.

-Serge(y)

> 
> Thanks,
> Abe
