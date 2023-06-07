Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65D7264A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbjFGP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbjFGP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:29:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199362690;
        Wed,  7 Jun 2023 08:29:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f642a24555so1121617e87.3;
        Wed, 07 Jun 2023 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686151716; x=1688743716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkG07j6a5sEvBdwiRuVUkeLgTXUKOejeRtg3/oYhtwU=;
        b=bBZHb5Z1JGyQWBPkjCmzbPOU75gT+kZJczrkMBJzWzlF11Hy2baY4/lAh3BXcXCqJF
         T3LmiY7RocUxxsTn9IaGVg5kKwx5xuLl7uNKiW0VScqclTG58jyChUg4c1Ozese5HcEc
         pcQM0w45cvNpMCucJ2HBfT/ZCwjsKKmBI52lWaorhgV2fKxxnCdQ6hTnRtx4O2o6INxq
         1zaWaFiQUhqkXBjVR31WXBWIwZpH7hYaan1n0X76BS7ZJXGNZdodQpTKkBCKofSwNoe3
         vaA+p7AFm+3sbUJZUIUEfzCJEJoWVQztB7Aeo4tBxilzyBun8C+MPy8s/EvtY88wDMTu
         xD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151716; x=1688743716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkG07j6a5sEvBdwiRuVUkeLgTXUKOejeRtg3/oYhtwU=;
        b=dLzrpRInxut3SOyRsV2WGqNR9YpRP2MFiCwjw7SwGspYGJ70E90SUdgk/Uy+Pyf99i
         1tfOpiCUrAI01jDFtQbdaKCWQbkQxfvA1/t+mUf0YdEmLfPYq/XZMN/gAmRXvbylV5eD
         cFr77Z6LwhGM6snBXHEGb+xH+CmifufbRJ2OpkWIOWavr+gFGjUsnaaQgoLMOXJe1Obk
         ldcOH+H2mNgFC0W8JTRCXuR/NJcYdjlfTO9d44m3BeCmHevJvQ8VMujJ/z5hlEsMLs38
         FjD/24Z1FkerJEmxYDqBShzcgWIDNUNT0FGaAGh19LdMuhhnOTxB7J9wicvsTuHh6fiL
         DWPA==
X-Gm-Message-State: AC+VfDzuQ3Kmhd/ugbcpd5eQdHUtUsVqu/4Jfnk/gfiVqHBWDVzHl/jk
        LP0eWVRvQfOgo3Mr3uyDXjr9ID0S3zM=
X-Google-Smtp-Source: ACHHUZ7CDMvTcgd+5I93HKHl+k7wuI/C1UBjz6J/fRy1kRcXlzlgCCgs/aRN/5R7uCYTiARbZk2tvA==
X-Received: by 2002:ac2:4303:0:b0:4f3:5038:5857 with SMTP id l3-20020ac24303000000b004f350385857mr2185025lfh.55.1686151716335;
        Wed, 07 Jun 2023 08:28:36 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id m21-20020ac24295000000b004f1406b059asm1820848lfh.219.2023.06.07.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:28:35 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:28:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-ID: <20230607152828.4nxefvimokamhgvu@mobilestation>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
 <20230607112711.alcspwuwpt7nqja7@mobilestation>
 <ZICboAIZAcnYzyJr@ekohande-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICboAIZAcnYzyJr@ekohande-desk2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:00:48AM -0700, Abe Kohandel wrote:
> On 23/06/07 02:27PM, Serge Semin wrote:
> > On Tue, Jun 06, 2023 at 04:18:44PM -0700, Abe Kohandel wrote:
> > > Remove a misleading comment about the DMA operations of the Intel Mount
> > > Evans SoC's SPI Controller as requested by Serge.
> > > 
> > 
> > > Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> > > Link: https://lore.kernel.org/linux-spi/20230606191333.247ucbf7h3tlooxf@mobilestation/
> > > Fixes: 0760d5d0e9f0 ("spi: dw: Add compatible for Intel Mount Evans SoC")
> > 
> > Note Fixes tag normally goes first. In this case it seems redundant
> > though.
> > 
> 
> Thanks, will do this in the future.
> 
> > > - * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > > - * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > > - * provide a mechanism to override the native chip select signal.
> > 
> > I had nothing against this part of the comment but only about the
> > second chunk of the text.
> 

> Thinking about it a bit more there is nothing precluding this controller from
> being used for other purposes in the future. It is configured with two chip
> selects, only one of which is used today. I removed it to so it wouldn't become
> inaccurate if that happens.

Ok. Regarding the number of chip-selects. You could have overwritten
the dw_spi.num_cs field with value 2 then in the dw_spi_mountevans_imc_init()
method. Thus having a bit safer driver for your platform.

> 
> > > + * DMA-based mem ops are not configured for this device and are not tested.
> > 
> > * Note mem-ops is just a feature of the DW APB/AHB SSI controllers
> > * which provides a way to perform write-then-read and write-only
> > * transfers (see Transmit only and EEPROM read transfer modes in the
> > * hw manual). It works irrespective of whether your controller has a
> > * DMA-engine connected or doesn't have. Modern DW SSI controllers
> > * support Enhanced SPI modes with the extended SPI-bus width
> > * capability. But it's a whole another story and such modes aren't
> > * currently supported by the driver.
> > 
> > Just a question for the sake of the discussion history. Does your
> > platform have a DMA-engine synthesized to work with this DW SSI
> > controller? That is does your controller has the DMA Controller
> > Interface (handshake signals) connected to any DMA-engine on your
> > platform? I am asking because if there is no such DMA-engine then
> > the last part of your statement is just redundant since you can't test
> > something which isn't supported by design.
> 

> The platform does have a DMA-engine synthesized but I have been having some
> challenges with getting it to work which may require some further quirks added
> to the DMA driver. 

The main question is whether that DMA-engine has the handshake signals
connected to the DW SSI controller. If it doesn't then adding such
engine support would be a great deal of challenge indeed because a
software-based handshaking interface would need to be added to the
DMA-engine subsystem first. Then the DW SSI driver would need to be
fixed to work with that interface. Taking a FIFO-size into account and
an amount of IRQs to handle on each handshaking round, the resultant
performance might get to be not worth all the efforts so a simple
IRQ-based transfers implementation may work better.

> One example being the system uses 40-bit addressing but the
> DMA-engine is only synthesized with 32-bit address capability and is meant to
> only target a specific region of memory where it "knowns" the upper byte of the
> address.

That's a pretty much well known problem. The kernel has a solution for
it: DMA-mask set for the DMA-engine device (see dma_set_mask() and
dma_set_mask_and_coherent()) and SWIOTLB (formerly known as bounce
buffers).

Alternatively modern CPUs are normally equipped with a thing like
IOMMU, which can be used to remap the limited device address space to
any CPU/RAM address.

-Serge(y)

> 
> Anyhow, I hope to work through some of those challenges and enable this in the
> future.
> 
> Thanks,
> Abe
