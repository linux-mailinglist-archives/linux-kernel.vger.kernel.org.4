Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093496DDE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDKOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDKOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:47:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C610E7;
        Tue, 11 Apr 2023 07:47:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d7so21829122lfj.3;
        Tue, 11 Apr 2023 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681224466; x=1683816466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/jMQfJ+OaxQQq99OLTvMBe96qlkVenqoQY+g71eAao=;
        b=Xd3mJ7j5XVCrv+/dHWZPyu81rz6bkKhkR7LdGd3gd0MCmnCF1SJLgIkZcQnmEi0zQe
         2l3gnbZ94yr+hiXDZb/qVBgscL23+KfTWgmM2JYH2qvwTaCvkfpSh+P+MJfNrxQNtvNF
         z6QO7FQ5Jdioflm//g457NrGbJfmNpjmFyYV+Mn355VInkxJTYVfitsUz9kSJ90B0MTt
         IXKxJ+CUJINoZW2mv65WeSWHkGTZNzM5Ee4z5DS3KkxApdTC5wvuSWj6lQVQBCokyoUh
         xjHZ6B/hZQ5SR5QIsxfZ+9sQvNMMoJEQNrEZJ8SHgD5p6g7b2PRRUkNPA26F70Lrsa20
         NTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224466; x=1683816466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/jMQfJ+OaxQQq99OLTvMBe96qlkVenqoQY+g71eAao=;
        b=aMESdGDSnbIyj7z3DMONd8eqvQ8mUeQ0lk/Sv65UmnvyANZmaMDyqCrWiziMJx3Ci4
         SobmwjSLIx63MQQsrZObnueJ6Zb13OHqF1htER6cHiWS5p3hPL12AyhiVgQmj5op0zzL
         67/nThtW6TgSLtre1bffJpnok3Ch3IcG73o5QdWBD8yYCkyZRZMIaLJ4QGBx/5TF9Tgz
         TDzeBvVlufuBye18dL5Pqk7f1ojStfSpnYSDnLg017nqf9ttpyRkbNbslILYHt+AJ+4f
         0jH3xX+OUbMqTKFnWBkJ6xCvBvuKF0GE0g7FwSnWsIx/HTw+fgM7QXkDMpicMVSoNrkm
         ilLA==
X-Gm-Message-State: AAQBX9dRqDt/PrGpMurXMP4f7oieJo0zFLH8/+Ps+Cpymw6D4/Bb0Kor
        iqefn/VhDPCvZolvTGPJKG8=
X-Google-Smtp-Source: AKy350Z3IXSRVTV+XGwDb7aD1v3YNUNn8s1FJpV6fLJaoo+9qlh0IUWf5ejwC1nCvMlaZcynASO/MQ==
X-Received: by 2002:a19:ad09:0:b0:4db:26b1:ec52 with SMTP id t9-20020a19ad09000000b004db26b1ec52mr3950452lfc.59.1681224465757;
        Tue, 11 Apr 2023 07:47:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id r10-20020ac25a4a000000b004dda76fad5asm2583693lfn.218.2023.04.11.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:47:45 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:47:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <20230411144743.if72zn5et33khkcp@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
 <20230411143758.2rpaxux6esiln26q@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143758.2rpaxux6esiln26q@mobilestation>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:38:01PM +0300, Serge Semin wrote:
> On Tue, Apr 11, 2023 at 03:18:34PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:
> > > Check capabilities of DMA controller during init to make sure it is
> > > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > > and store addr_width capabilities to check per transfer to make sure the
> > > bits/word requirement can be met for that transfer.
> > 
> > ...
> > 
> > > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> > 
> > Can we avoid forward declarations please?
> > 
> > ...
> > 
> > > +	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > > +	      rx.directions & BIT(DMA_DEV_TO_MEM)))
> > > +		return -ENXIO;
> > 
> 
> > What about simplex transfers where we only care about sending or receiving data
> > and using dummy data for the other channel? Doesn't this make a regression for
> > that types of transfers? (Or, if we don't support such, this should be explained
> > in the commit message at least.)
> 
> I don't think the code above is that much relevant for the half-duplex
> transfers. The DW APB SSI-DMA driver requires both Tx and Rx channels
> being specified thus supporting the Full-duplex transfers at least in
> case of the TxRx and Rx-only SPI-transfers (the later case relies on
> having the dummy buffers supplied by the SPI-core). Thus the channels
> must support the corresponding DMA-directions.
> 
> Indeed the Tx-only DMA-based SPI-transfers implementation in the
> driver implies not using the Rx DMA-channel, but even in that case the
> Rx-channel still needs to be specified otherwise the DW APB SSI-DMA
> setup methods will halt with error returned. So unless there are cases
> with dummy Rx DMA-channels (which I very much doubt there is) I don't
> see the suggested update causing a regression. Am I missing something?
> 
> > 
> > ...
> > 
> > > +	/*
> > > +	 * Assuming both channels belong to the same DMA controller hence the
> > > +	 * address width capabilities most likely would be the same.
> > > +	 */
> > > +	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> > 
> 
> > I don't think so this is correct.
> > 
> > Theoretically it's possible to have simplex transfers on which the one of
> > the channel is simply ignored / not used. See above.
> 
> Please see my explanation above. To cut it short even in case of the
> half-duplex SPI-xfers both channels need to be specified with the
> respective capabilities. It's implied by the DW APB SSI-DMA setup
> methods design (see dw_spi_dma_init_mfld() and
> dw_spi_dma_init_generic()).
> 
> So until the DW APB SSI-DMA driver is re-developed to supporting true

> Tx-only and Rx-only transfers with no requirement one of the channels

s/with no requirement one of the channels/with no requirement of both the channels

-Serge(y)

> being specified I don't see any problem with the code above. Do you
> still think otherwise?
> 
> -Serge(y)
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
