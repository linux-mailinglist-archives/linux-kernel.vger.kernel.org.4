Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D96662B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjAIQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAIQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:25:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CD1C53;
        Mon,  9 Jan 2023 08:25:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bt23so13765376lfb.5;
        Mon, 09 Jan 2023 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPVe9k6xiQxoUlbt14zYIPRh4g1+8ixsVErgsbtB9oo=;
        b=kPvbUvB7GfEtAQBQs2fBAi2zssHgmpoRuC4zqehMAmQnHecMND2AgbC+KTZtTRGKYu
         Zo7c5tWB/VmrfKgWnXzynbK/axSnfllm5DxBJDG84+7re0oanLPPHsTg5QKDXtAw+u3o
         ic0MjKEPk7qQS61baTD3+ZRstAV988iby0DyNM2RxRDLtA9g+JCm4RUraiSUKF+qpv47
         UqCAyrx5rbZ3kYSet/xv7VZQ8wt2Y8AqtrzwjNbHLk+yrN5fwQju/bVPbOhTDRe+SPEs
         zzGpZxLz8DqLBRdaT2NV2ZZ8Ty0Emh/jcUV5viASOEkom5HAvjS2NiSthO6MDuQ2I0Hu
         pJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPVe9k6xiQxoUlbt14zYIPRh4g1+8ixsVErgsbtB9oo=;
        b=DeHXYgrIhqfM0dwLLALsKNqNAc8syjktINYJTXZELyWaunIGXTRLo6T7wFsuD1DJaT
         U6qrcg2o7iNmsg0HFmbQAhMXmnv3UdGM4YYp9dJYTu3yGJ8Z7DdTz813B2gQWfdbQX4I
         m8TIp/qmTgb8lX7rCkTtMn+oxdHKg3sWOrLL9RnVWXKPlfKh1hbEf6dWYf9YTHgXZSWM
         yn6jY41zgQkwlTUnkQWLnovKbh+9VCuf32uetc8UuiPf4CAxqGxFDilQ9Gmj/z7of2c/
         TicZnHjvc7F1QQugzRiL8jTVOdP1mLQOzO5s+B+wLsYol+gvcGDgdaK9eizTwebWYb+M
         5C7Q==
X-Gm-Message-State: AFqh2koWH63W7Auz4sWzf35U7Kc5PQO5Cmlg+wyVPsTs93lQhcWgRf62
        e8Hhcx5CRkEH6hORpUl+sY0=
X-Google-Smtp-Source: AMrXdXvdKy0bpU/Os2olN3rAMOHfWKUr7NqexHp3Y8yZL6kPzPbznIyLUVRUHaw+gQ4uoN3WWbTLvw==
X-Received: by 2002:a05:6512:31d6:b0:4b5:7817:419d with SMTP id j22-20020a05651231d600b004b57817419dmr21481910lfe.41.1673281508802;
        Mon, 09 Jan 2023 08:25:08 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004cc82b7080bsm701765lfc.200.2023.01.09.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:25:08 -0800 (PST)
Date:   Mon, 9 Jan 2023 19:25:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI
 controllers
Message-ID: <20230109162505.o3clvmwu3eremlyd@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221218174523.cke7ubh6nycd247c@mobilestation>
 <20230104222036.h4ke6maxkdvuqtqc@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104222036.h4ke6maxkdvuqtqc@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudip

On Thu, Jan 05, 2023 at 01:20:39AM +0300, Serge Semin wrote:
> Hi Sudip
> 
> On Sun, Dec 18, 2022 at 08:45:26PM +0300, Serge Semin wrote:
> > Hi Sudip
> > 
> > On Mon, Dec 12, 2022 at 06:07:17PM +0000, Sudip Mukherjee wrote:
> > > The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
> > > controllers support enhanced SPI which includes Dual mode, Quad mode and
> > > Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
> > > which can be used to prevent FIFO underflow and overflow conditions while
> > > transmitting or receiving the data respectively.
> > > 
> > > This is almost a complete rework based on the review from Serge.
> > 
> > Thank you very much for the series. I'll have a look at it on the next
> > week.
> 
> Just so you know. I haven't forgot about the series. There are some
> problematic parts which I need to give more thinking than I originally
> expected. I'll submit my comments very soon. Sorry for the delay.
> 
> Good news is that I've got the HW-manual for the DW SSI v1.01a
> IP-core. So I'll no longer need to ask of you about that device
> implementation specifics.

Finally I managed to consolidate my thoughts regarding your patchset.
Here is the summary. Some specific comments will be sent in-reply to
the corresponding patches.

First of all there is a crucial difference between eSPI capability
available on DW APB SSI and DW AHB SSI controllers:
DW APB SSI 4.x:
+ Tx until FIFO is empty
+ No clock stretching at all
DW AHB SSI 1.x:
+ Tx until CTRLR1.NDF if clock stretching is available
+ If no clock stretching then Tx until FIFO is empty.
See the DW APB SSI IP-cores don't have the clock stretching feature.
That should be kept in mind while implementing the portable eSPI
support in the DW SSI driver. Your version of the eSPI support is only
applicable for the devices with the eSPI clock-stretching capability
which significantly narrows down its applicability. Anyway you should
convert your code to working only if the clock-stretching feature is
detected.

Moreover your implementation will only work on the platforms with the
native chip-selects. If the GPIO-based CS setup is detected the standard
SPI-messages/transfers-based kernel API will be utilized (see the
spi_mem_exec_op() method implementation) which currently imply the
single-laned SPI bus only. For the same reason the DMA capability won't
work in your eSPI implementation.

If you want that to be fixed then you'll need to update the standard
transfer (+DMA) procedure so one would take the
spi_transfer.{tx_nbits,rx_nbits} fields into account activating the
eSPI modes accordingly. The dw_spi_transfer_handler() method and its
DMA counterpart shall be altered too since the eSPI implies the
Tx-only or Rx-only modes.

Here are several notes applicable to all your patches:
1. Please use the dw_spi_enh* prefix for all eSPI-related methods. That
shall unify the eSPI-code a bit in the same way as it was done in the
DMA-modules (see it has the method defined with the dw_spi_dma_* prefix).

2. Please define the enhanced versions of the MEM-op methods below their
non-enhanced counterparts. Thus we'll have a clearer driver code.

3. It isn't normally welcome to add some code in one patch and fix it in
some following up patch.

4. I am pretty much sure you shouldn't touch the spi_controller data
internals if it isn't platform-specific settings on the controller
probe procedure. Mark won't bless such change. The
spi_controller.xfer_complete field is the internal completion handler
and should be used by the SPI core only.

Regarding the patchset in general. It's ok to provide the eSPI mode
support for the native chip-selects only. But since there are going to be
not a few requests to you to fix I'd suggest to refactor the series in the
next manner:

[PATCH 1] spi: dw: Add Enhanced capabilities flags
Just define the new capability flags
+ DW_SPI_CAP_ENH
+ DW_SPI_CAP_ENH_CLK_STR
Note the capabilities auto-detection will be added later in this patchset.
Yeah, I remember asking you to add the DW_SPI_CAP_EMODE macro, but adding
the _ENH suffix instead seems more readable and would refer to the
eSPI-related methods.

[PATCH 2] spi: dw: Update enhanced frame forward config
In this patch please fix the dw_spi_update_config() method so one would
perform both standard and enhanced config setups:
+ Add new field dw_spi_cfg.enh_frf.
+ Declare new structure struct dw_spi_enh_cfg with the wait_c, addr_l,
inst_l and trans_t fields.
+ Convert the dw_spi_update_config() method to accepting the optional
struct dw_spi_enh_cfg *ecfg pointer.
+ Update the CTRLR1.NDF field for Tx-only transfers if
DW_SPI_CAP_ENH_CLK_STR capability is available.

[PATCH 3] spi: dw: Reduce mem-ops init method indentations
+ This is a prerequisite patch before adding the eSPI-related
MEM-op methods to make the following up patches simpler and more
coherent. It implies updating the dw_spi_init_mem_ops()
function so one would return straight away if the platform-specific CS-methods
or MEM-ops methods are specified. Thus further function updates would be
performed in the more coherent patches with simpler changelog. (See my
comments to your patch "[PATCH v2 04/15] spi: dw: add check for support of enhanced spi".)

[PATCH 4] spi: dw: Add enhanced mem-op verification method
+ Almost the same as your patch "[PATCH v2 04/15] spi: dw: add check for support of enhanced spi"
except the code will have one less indentation due to the patch #3.
Some other issues shall be fixed too. See my comments to your patch for
details. (init if DW_SPI_CAP_ENH_CLK_STR, op->dummy.nbytes / op->dummy.buswidth >= 4)

[PATCH 5] spi: dw: Add enhanced mem-op size adjustment method
+ The same as your patch "[PATCH v2 11/15] spi: dw: adjust size of mem_op"

[PATCH 6] spi: dw: Mask out IRQs if no xfer data available
+ Instead of checking the master->cur_msg pointer to be non-NULL I guess
it would be ok to disable the IRQs if !dws->rx_len && !dws->tx_len in the
dw_spi_irq() method. Although I have doubts that after the commit
a1d5aa6f7f97 ("spi: dw: Disable all IRQs when controller is unused") there
is need in that conditional statement especially seeing the dw_reader()
and dw_writer() methods won't do anything if no data available to
transfer.

[PATCH 7] spi: dw: Move wait-function to the driver core
+ Instead of re-implementing the xfer completion wait function one more
time (as you've done in "[PATCH v2 09/15] spi: dw: use irq handler for
enhanced spi") just move the dw_spi_dma_wait() method from spi-dw-dma.c to
spi-dw-core.c, accordingly fix the prototype and implementation, rename
the dw_spi.dma_completion field to something like xfer_completion and use
the new method in the DW SSI core and DMA modules.

[PATCH 8] spi: dw: spi: dw: Add enhanced mem-op execution method
+ Just add the methods particularly implementing the mem-op execution
process like:
dw_spi_enh_irq_setup(): instead of updating the dw_spi_irq_setup() method
just create a new one which would initialize the IRQ-handler and unmask
IRQs accordingly (depending on the rx_len/rx_len values?).
dw_spi_enh_transfer_handler(): similar to your implementation of the
IRQ-handler except it will use the internal wait-for-completion infrastructure.
dw_spi_enh_write_then_read(): shall write the cmd+addr and activate the
CS line. After that the transfer shall begin.
dw_spi_enh_exec_mem_op(): similar to the dw_spi_exec_mem_op() method. It
shall update the controller config taking the enhanced part into account,
activate the IRQs using the dw_spi_enh_irq_setup() method, call the
dw_spi_enh_write_then_read() function and then wait until the IRQ-based
transfer is completed.

[PATCH 9] spi: dw: Add enhanced mem-op capability auto-detection
+ Just check whether the CTRLR0.SPI_FRF field is writable and values it
accepts. Based on that set the DW_SPI_CAP_ENH capability flag and update
spi_controller.mode_bits field. Similarly check whether the
SPI_CTRLR0.CLK_STRETCH_EN bit is writable and set the
DW_SPI_CAP_ENH_CLK_STR capability flag.
+ Note first you need to try detecting the eSPI capability and only
then the eSPI clock stretching capability.
+ Note the best place for that is the dw_spi_hw_init() method where all
the HW-init and auto-detection is done.

[PATCH 10] spi: dt-bindings: dw-apb-ssi: Add DW AHB SSI compatible string
+ The same as your "[PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version"

[PATCH 11] spi: dw: Add DW AHB SSI compatible string
+ The same as your "[PATCH v2 15/15] spi: dw: initialize dwc-ssi controller"

Some implementation-specific comments I'll submit in-reply to the
corresponding patches.

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > -Serge(y)
> > 
> > > 
> > > 
> > > -- 
> > > Regards
> > > Sudip
> > > 
> > > Sudip Mukherjee (15):
> > >   spi: dw: Introduce spi_frf and STD_SPI
> > >   spi: dw: update NDF while using enhanced spi mode
> > >   spi: dw: update SPI_CTRLR0 register
> > >   spi: dw: add check for support of enhanced spi
> > >   spi: dw: Introduce enhanced mem_op
> > >   spi: dw: Introduce dual/quad/octal spi
> > >   spi: dw: send cmd and addr to start the spi transfer
> > >   spi: dw: update irq setup to use multiple handler
> > >   spi: dw: use irq handler for enhanced spi
> > >   spi: dw: Calculate Receive FIFO Threshold Level
> > >   spi: dw: adjust size of mem_op
> > >   spi: dw: Add retry for enhanced spi mode
> > >   spi: dw: detect enhanced spi mode
> > >   spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version
> > >   spi: dw: initialize dwc-ssi controller
> > > 
> > >  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
> > >  drivers/spi/spi-dw-core.c                     | 347 +++++++++++++++++-
> > >  drivers/spi/spi-dw-mmio.c                     |   1 +
> > >  drivers/spi/spi-dw.h                          |  27 ++
> > >  4 files changed, 364 insertions(+), 12 deletions(-)
> > > 
> > > -- 
> > > 2.30.2
> > > 
