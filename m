Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B26E0F23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjDMNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDMNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:47:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA819A1;
        Thu, 13 Apr 2023 06:47:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q26so7004646lfe.9;
        Thu, 13 Apr 2023 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681393624; x=1683985624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwZ/eF4fiqz0MszyfKrsFFx3zAL0qYnY/EL/KUUq4wY=;
        b=oiWgvTqJHwkBH1RKUn7ibVk5ROGx65tRTG2qIELVVVFBJ3+/tnfSXkoLI3GWx5o88v
         aqD6Xj/K0ct4dwGKz0MahkOw9l5dmcQLgjachxWHVCTCZvq7c0oNNTHfKzS8C7VFTjgi
         ERsNQS9c6AKjAbF3R7LZcYnhKKFpyzZK1R8eeO9G21fg3eoZs7vdoLCWfOIUVjNPp9TH
         ZQwcSnZYCI5cInPfiWHTqdO4LkUiQXE32tfGDXfXMjAJ2PPGgz7NpDvhiHfiqmXaT3eI
         kVm+2I9spT3GsP7wGUiSXSr7Y4VKl23iyEUj4jShPTDK9H14//V/ws42YuINbhiqqf/k
         8jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393624; x=1683985624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwZ/eF4fiqz0MszyfKrsFFx3zAL0qYnY/EL/KUUq4wY=;
        b=R2NZOj6AB/CtLkfmgZSqnL9mlaeggJh9dREViIL3b221zPO8ss7zCow8cGnvTovIJE
         uxI9zEqXRvnSV4pFQY7z/FpBls+pvsOUzpKvjOPgahHUwZiVgTpmS23QAusBqfM39Jjx
         O8AsMnlaXPZOP1K2myXCVFROCXPWx692myL7mxA4MkesxwvHhK/Uy2lgLGAeER3pPStp
         d+eNuxyjMuQj28AZT+szB1+8DfKRonS25A8ffseJrn1z5PJUogztJs720LcMSjF4iccP
         R6Lv+hBd0zM0wOISFw0pTeDeFmbP48OiQ4TR6p6kfPnggjcpas7tI0GuKG8P2TqNOoVE
         TWhg==
X-Gm-Message-State: AAQBX9cf+PHjRbLq/3TtCPLIz0kCKXk0vzzTznI087+AfgltK1l+J1rG
        TkQm3MVk3PjpUjpWbRv6r6/5Y2aJXsk=
X-Google-Smtp-Source: AKy350b3Raib2Gc1q5nq7kEFIKSo0TF6cAvHjjAYrYlqABTW2alalbMunrWVIAy3REYiB78sw6pWqQ==
X-Received: by 2002:ac2:54b0:0:b0:4ec:6b89:b0ce with SMTP id w16-20020ac254b0000000b004ec6b89b0cemr819449lfk.40.1681393623461;
        Thu, 13 Apr 2023 06:47:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id w25-20020ac24439000000b004db3e330dcesm321269lfl.178.2023.04.13.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:47:02 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:47:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230413134700.uwv6nh3vh7yi5mzc@mobilestation>
References: <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
 <20230411150916.24vagjzbhshaujse@mobilestation>
 <ZDV6FKd/TupHEPMf@smile.fi.intel.com>
 <CAOSNQF3JQKVgvp5M17SzeyF5LB85_ZvkRpp3PZkCYcGcqm8V2g@mail.gmail.com>
 <ZDWJJaYauhOl0Iue@smile.fi.intel.com>
 <CAOSNQF2dxwbCa7_MrN-qd5mrK9jfpaakeExuMBwctXbsQGmiJQ@mail.gmail.com>
 <CAOSNQF3uie_Jk9xmEu9w6LvZvigkGEu+k5at8+a6chxMLehQHQ@mail.gmail.com>
 <ZDaxJbFylAU68W3V@smile.fi.intel.com>
 <CAOSNQF0iVtMnX2H6fGZHG3XD+OYWgrWMmVMiPH6Y3V1NY3WsXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF0iVtMnX2H6fGZHG3XD+OYWgrWMmVMiPH6Y3V1NY3WsXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joy

On Thu, Apr 13, 2023 at 09:37:35AM +0530, Joy Chakraborty wrote:
> On Wed, Apr 12, 2023 at 6:55 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Apr 12, 2023 at 02:51:44PM +0530, Joy Chakraborty wrote:
> > > On Wed, Apr 12, 2023 at 1:11 AM Joy Chakraborty <joychakr@google.com> wrote:
> > > > On Tue, Apr 11, 2023 at 9:52 PM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Tue, Apr 11, 2023 at 08:48:52PM +0530, Joy Chakraborty wrote:
> > > > > > On Tue, Apr 11, 2023 at 8:47 PM Andy Shevchenko
> > > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > > On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote:
> > > > > > > > On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> > > > > > > > > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > > > > > > > > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
> >
> > ...
> >
> > > > > > > > > > > > -     if (n_bytes == 1)
> > > > > > > > > > > > +     switch (n_bytes) {
> > > > > > > > > > > > +     case 1:
> > > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > > > > > > > > -     else if (n_bytes == 2)
> > > > > > > > > > > > +     case 2:
> > > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > > > > > > > > -
> > > > > > > > > > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > > > >
> > > > > > > > > > > > +     case 3:
> > > > > > > > > > >
> > > > > > > > > > > I'm not sure about this.
> > > > > > > > > >
> > > > > > > > > > This actually makes sense seeing the function argument can have values
> > > > > > > > > > 1, 2, _3_ and 4:
> > > > > > > > > > dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> > > > > > > > > > transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
> > > > > > > > > > ...
> > > > > > > > > > dw_spi_dma_convert_width(dws->n_bytes)
> > > > > > > > > >
> > > > > > > > > > The spi_transfer.bits_per_word field value depends on the
> > > > > > > > > > SPI peripheral device communication protocol requirements which may
> > > > > > > > > > imply the 3-bytes word xfers (even though it's indeed unluckily).
> > > > > > > > > >
> > > > > > > > > > This semantic will also match to what we currently have in the
> > > > > > > > > > IRQ-based SPI-transfer implementation (see dw_writer() and
> > > > > > > > > > dw_reader()).
> > > > > > > >
> > > > > > > > > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that. Why we don't
> > > > > > > > > use it?
> > > > > > > >
> > > > > > > > We could but there are two more-or-less firm reasons not to do
> > > > > > > > that:
> > > > > > > > 1. There aren't that much DMA-engines with the
> > > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SSI just
> > > > > > > > ignores the upper bits if CTRLR0.DFS is less than the value actual
> > > > > > > > written to the DR registers. Note DW DMAC engine isn't one of such
> > > > > > > > controllers. So if we get to meet a peripheral SPI-device with 3-bytes
> > > > > > > > word protocol transfers and the DMA-engine doesn't support it the
> > > > > > > > DMA-based transfers may fail (depending on the DMA-engine driver
> > > > > > > > implementation).
> > > > > > > > 2. The DW APB SSIs (3.x and 4.x) can be synthesized with the APB Data
> > > > > > > > Bus Width of 8, 16 and 32. So no matter whether DMA-engine supports
> > > > > > > > the 3-bytes bus width the system bus most likely will either convert
> > > > > > > > the transfers to the proper sized bus-transactions or fail.
> > > > > > > >
> > > > > > > > So taking all of the above into account not using the
> > > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using it with
> > > > > > > > a risk to fail some of the platform setups especially seeing the DW
> > > > > > > > APB SSI ignores the upper bits anyway.
> > > > > > >
> > > > > > > But this is not about SPI host hardware, it's about the consumers.
> > > > > > > They should know about supported sizes. Either we add the corresponding support
> > > > > > > to the driver or remove 3 case as I suggested. I don't think it's correct to
> > > > > > > use 3 as 4.
> > > > > >
> > > > > > Another thing to add is that as per spi.h even if bits per word is a
> > > > > > not a power of 2 the buffer should be formatted in memory as a power
> > > > > > of 2
> > > > > > ...
> > > > > >  * @bits_per_word: Data transfers involve one or more words; word sizes
> > > > > >  * like eight or 12 bits are common.  In-memory wordsizes are
> > > > > >  * powers of two bytes (e.g. 20 bit samples use 32 bits).
> > > > > >  * This may be changed by the device's driver, or left at the
> > > > > >  * default (0) indicating protocol words are eight bit bytes.
> > > > > >  * The spi_transfer.bits_per_word can override this for each transfer.
> > > > > > ...
> > > > > > Hence for n_bytes = 3 or 24 bits/per word we expect the client SW to
> > > > > > format it to 4 byte buffers hence the transaction generated should
> > > > > > also be of size 4 from the DMA.
> > > > >
> > > > > You didn't get my point. The consumer wants to know if the 3 bytes is supported
> > > > > or not, that's should be part of the DMA related thing, right?
> > > > >
> > > > > It's incorrectly to say 4 for 3 if the backend DMA controller behaves differently
> > > > > on this. How do you know that (any) DMA controller integrated with this hardware
> > > > > has no side effects for this change.
> > > > >
> > > > > So, I don't think the case 3 is correct in this patch.
> > > >
> > > > I see, I am of the opposite opinion in this case.
> > > >
> > > > Other then Serge(y)'s points,
> > > > I was trying to say that irrespective of what the underlying DMA
> > > > controller supports we should use DMA_SLAVE_BUSWIDTH_4_BYTES when
> > > > n_bytes = 3 from SPI perspective as we get n_bytes from bits per word
> > > > passed by the client / spi framework " dws->n_bytes =
> > > > DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) ".
> > > > Based on the spi header what I perceive is that for bits/word between
> > > > 17 and 32 the data has to be stored in 32bit words in memory as per
> > > > the example in the header " (e.g. 20 bit samples use 32 bits) ".
> > > >
> > > > Hence, taking an example to transfer 6 bytes (say 0xAA 0xBB 0xCC 0xDD
> > > > 0xEE 0xFF) with bits per word as 24 (n_bytes = 3) i.e. a total of 2
> > > > words I expect the buffer to look as follows which is coming from the
> > > > client:
> > > > _ _____address|__________0________4________8________C
> > > >     SD:00000000|>00CCBBAA 00FFEEDD 00000000 00000000
> > > > Hence to transfer this successfully the DMA controller would need to
> > > > copy 4 bytes per word .
> > > >
> > > > Please correct me if my understanding of this is incorrect.
> >
> > Thank you for finding the answer for me by yourself!
> >
> > > On the other hand I do see that in the fifo driver dw_writer() /
> > > dw_reader() increments the pointer with 3 incase n_bytes = 3 even
> > > though it copies 4 bytes.
> > > ...
> > >    if (dws->n_bytes == 1)
> > >       txw = *(u8 *)(dws->tx);
> > >    else if (dws->n_bytes == 2)
> > >       txw = *(u16 *)(dws->tx);
> > >    else
> > >       txw = *(u32 *)(dws->tx);
> > >
> > > dws->tx += dws->n_bytes;
> > > ...
> > > This will not behave as using DMA_SLAVE_BUSWIDTH_4_BYTES in the DMA so
> > > maybe I am not correct in interpretting the spi.h header file.
> > > Can CPU's in general access u32 from unaligned odd addresses ?
> >
> > Generally speaking the above code must check number of bytes for being 4.
> >
> > > From Serge(y)'s comment regarding this, the APB interface writing data
> > > to the FIFO register definitely cannot handle
> > > DMA_SLAVE_BUSWIDTH_3_BYTES since it handles a power of 2 only.
> > > Hence we can possibly remove "case 3:" completely and also mask out
> > > DMA_SLAVE_BUSWIDTH_3_BYTES from dma_addr_width capabilities so that
> > > can_dma api does not allow n_bytes = 3 to use DMA.
> > >
> > > Would that be correct ?
> >
> > We have to fix the above and the DIV_ROUND_UP(transfer->bits_per_word,
> > BITS_PER_BYTE) one to be something like
> >
> > roundup_pow_of_two(round_up(..., BITS_PER_BYTE))
> >
> 
> Hello Serge(y),
> 
> Are we okay in removing n_bytes=3 support from the dma driver switch case ?
> This will also lead to can_dma returning false for n_bytes=3 which
> will essentially make it fall back to fifo mode.

Yes, I am ok with dropping the "3"-case from
dw_spi_dma_convert_width() in your patch. Could you also provide an
additional patch in your series which would replace
DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) with
roundup_pow_of_two() as @Andy suggests? It is supposed to be a bug-fix
AFAICS to the commit a51acc2400d4 ("spi: dw: Add support for 32-bits
max xfer size").

-Serge(y)

> 
> > > > > > > > > > > > +     case 4:
> > > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > > > > > > > > +     default:
> > > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > > > > > +     }
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
