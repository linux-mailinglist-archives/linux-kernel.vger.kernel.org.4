Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73BE6DDE34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjDKOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDKOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:38:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80738448E;
        Tue, 11 Apr 2023 07:38:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h12so5752456lfj.8;
        Tue, 11 Apr 2023 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681223881; x=1683815881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HfxwgTBgQXWC6fG+aiC6jOWHTPMJBQRX3DVcb99zZo=;
        b=i7pz3ot8hLcJhgDkQjOjtEL+XNljQTYUxvVad/zSVIzphX3Mi7AuYMpDd3Ud1Jwuph
         1ppkuxwFfT0rqm4iIT1MpHRI35IgZw6tGEGrQkf+wPHOyqQs4rsNEb6hzIpP1yXJf+ki
         buLMyVfbyJjs2f1lW4f2JP8pEHcNISDpCk/X8ECycwTcRST8asczc39pYomv3b7Uast/
         64NMZc40Lin7VCqNRQGFGeZO9B2cR5XXB2r53Zwl3zQgP9N2Nyza4hr+uCyjDgZAqNZU
         ovO3LsNvn5Q23kuC3JlpEQeBZg0qK7etFzGzKdplRLoIws4icx9EYOKbWxUxCWk1So82
         Ru2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223881; x=1683815881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HfxwgTBgQXWC6fG+aiC6jOWHTPMJBQRX3DVcb99zZo=;
        b=DM0AGuNgKFD5hxHxBzhAQO5HUDxJrGIUUqF0iYKLE40dtwZUCn9X/V/jg+3ck3wEMA
         Bx4MmHu7xOz+LKYx7InoLqjHMXeua7qHrOlpYRLKIubr0sqav+dKGfgYAS0olxWgmJlI
         9jAfkS1PxUK8AQREtJi12X3eW87PDtEze6dQbhggFcjkWNPzjz3pYZtvMvs0mZH9Bq1R
         DFR5qEsDTB89WM6XefsCnq1B1j8kv5tWYl8ErC2Ozu6HvxU113pryyaZxwnq02xQYCEk
         mxYwuhx59o8RliDV9jOiagvfc9kqMKSV/JDW98lgMbaoQrEvt6wFCNrr9kUdl/jBATcB
         wLGw==
X-Gm-Message-State: AAQBX9dR/jiJdIs2oWAtNr+kuectBwE0S1s/ljCcZsFfORx43cQkGNL8
        Ckd0tcz/HwsAs71isjoJ36c=
X-Google-Smtp-Source: AKy350a5Uh/F6sTGc4L+Fe7bAKFsCd9WDVCeqHJFjZHNcaIt+kgMf2vTS5okEmNmOw/i4rzBUmxI0A==
X-Received: by 2002:ac2:4883:0:b0:4ec:5607:9055 with SMTP id x3-20020ac24883000000b004ec56079055mr3976585lfc.31.1681223881090;
        Tue, 11 Apr 2023 07:38:01 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id l29-20020ac24a9d000000b004eae73a0530sm2593770lfp.39.2023.04.11.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:38:00 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:37:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <20230411143758.2rpaxux6esiln26q@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:18:34PM +0300, Andy Shevchenko wrote:
> On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:
> > Check capabilities of DMA controller during init to make sure it is
> > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > and store addr_width capabilities to check per transfer to make sure the
> > bits/word requirement can be met for that transfer.
> 
> ...
> 
> > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> 
> Can we avoid forward declarations please?
> 
> ...
> 
> > +	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > +	      rx.directions & BIT(DMA_DEV_TO_MEM)))
> > +		return -ENXIO;
> 

> What about simplex transfers where we only care about sending or receiving data
> and using dummy data for the other channel? Doesn't this make a regression for
> that types of transfers? (Or, if we don't support such, this should be explained
> in the commit message at least.)

I don't think the code above is that much relevant for the half-duplex
transfers. The DW APB SSI-DMA driver requires both Tx and Rx channels
being specified thus supporting the Full-duplex transfers at least in
case of the TxRx and Rx-only SPI-transfers (the later case relies on
having the dummy buffers supplied by the SPI-core). Thus the channels
must support the corresponding DMA-directions.

Indeed the Tx-only DMA-based SPI-transfers implementation in the
driver implies not using the Rx DMA-channel, but even in that case the
Rx-channel still needs to be specified otherwise the DW APB SSI-DMA
setup methods will halt with error returned. So unless there are cases
with dummy Rx DMA-channels (which I very much doubt there is) I don't
see the suggested update causing a regression. Am I missing something?

> 
> ...
> 
> > +	/*
> > +	 * Assuming both channels belong to the same DMA controller hence the
> > +	 * address width capabilities most likely would be the same.
> > +	 */
> > +	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> 

> I don't think so this is correct.
> 
> Theoretically it's possible to have simplex transfers on which the one of
> the channel is simply ignored / not used. See above.

Please see my explanation above. To cut it short even in case of the
half-duplex SPI-xfers both channels need to be specified with the
respective capabilities. It's implied by the DW APB SSI-DMA setup
methods design (see dw_spi_dma_init_mfld() and
dw_spi_dma_init_generic()).

So until the DW APB SSI-DMA driver is re-developed to supporting true
Tx-only and Rx-only transfers with no requirement one of the channels
being specified I don't see any problem with the code above. Do you
still think otherwise?

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
