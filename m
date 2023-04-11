Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9926DDF08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDKPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDKPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:09:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CEA46AF;
        Tue, 11 Apr 2023 08:09:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d7so21926069lfj.3;
        Tue, 11 Apr 2023 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225760; x=1683817760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4l9gGbBhem91l3LZk10wDjtDcy4j4z6z5yoCU+ggJhM=;
        b=LtEeRGDLhkts6D15O4owrM358WkFth20ZX3y7nmuWmmMbtVF/6JhM6zlHRnCkxoCfq
         6ASPPu/i6BTjVOMH7Lwm13ybxrQrrLXEitlBw3md4zWLnMmPk2dBk+nSinvd+f3uOrZR
         AtF5rHRzqVdEqyJwSIzhb4iQ76ZYrk2wNGxKcnwfOACyjtS4qAowPXwKDodSFWiC51L3
         9Qa1OjGWP/7jXejyUeb1OLCih6ks29Sf5X4cDipvjvrffjKCIeC5lsaYo3HNjrU+yss2
         Zojjsj59Ui1CUq5EGwzXfg0ql+mkcXZ7wLL0bp4badtv0bYxhj5EGCnSm54SNZDw9bL1
         NJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225760; x=1683817760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l9gGbBhem91l3LZk10wDjtDcy4j4z6z5yoCU+ggJhM=;
        b=gm4MWS7WDUE6n8zMekqeP4XlyuR+RWfrws2FGRDbgTxGONAvQ1ssggRsp4YYUMH2L8
         Q2HbA/T5ZZbUPkFN9ChhLYCFhjHlGuSTjuttGuyiua37Y9NQ+9Tzl7lSEP6Db2iLG9YL
         ChPYnHDHOMI6a82k8uPBhbk0AT0IsLXChsBmsB3dyOB/F4GEIwwCMovYjsrvHR8Zs/Fi
         qjmwsY1ZpBEy0LVKTCSOtPu5Hy+glPdzIvOvlfsDsgko1I2QE0KZhoSbm7YIPHQ0Ts12
         Op0pQEMNtiyg6sKa23GJC5NASLgXHEdJmqs8ltQfmgwr9oQhaBnJi1BRlSiIXPx47fIV
         BHOQ==
X-Gm-Message-State: AAQBX9d/aAr9yx1Bwq/ISD4X9VZSBIDX2e3c4XX4I5jcwjRQ3hbl34Ze
        Hzf2uZNrbj9aJBZxjH3utvI=
X-Google-Smtp-Source: AKy350Z+mA4olk2EsE2nZlZIDBu2hIZ6NIsF+wElv86rLgas95v9BTFiV+K4mt3WuBfzmvhjV/W+gw==
X-Received: by 2002:a05:6512:1582:b0:4dc:75c3:9a90 with SMTP id bp2-20020a056512158200b004dc75c39a90mr4201933lfb.11.1681225760014;
        Tue, 11 Apr 2023 08:09:20 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id g13-20020ac2538d000000b004eb41d26d49sm2588350lfh.28.2023.04.11.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:09:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:09:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230411150916.24vagjzbhshaujse@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
 <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote:
> > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
> 
> ...
> 
> > > > -	if (n_bytes == 1)
> > > > +	switch (n_bytes) {
> > > > +	case 1:
> > > >  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > -	else if (n_bytes == 2)
> > > > +	case 2:
> > > >  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > -
> > > > -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > 
> > > > +	case 3:
> > > 
> > > I'm not sure about this.
> > 
> > This actually makes sense seeing the function argument can have values
> > 1, 2, _3_ and 4:
> > dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> > transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
> > ...
> > dw_spi_dma_convert_width(dws->n_bytes)
> > 
> > The spi_transfer.bits_per_word field value depends on the
> > SPI peripheral device communication protocol requirements which may
> > imply the 3-bytes word xfers (even though it's indeed unluckily).
> > 
> > This semantic will also match to what we currently have in the
> > IRQ-based SPI-transfer implementation (see dw_writer() and
> > dw_reader()).
> 

> Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for that. Why we don't
> use it?

We could but there are two more-or-less firm reasons not to do
that:
1. There aren't that much DMA-engines with the
DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SSI just
ignores the upper bits if CTRLR0.DFS is less than the value actual
written to the DR registers. Note DW DMAC engine isn't one of such
controllers. So if we get to meet a peripheral SPI-device with 3-bytes
word protocol transfers and the DMA-engine doesn't support it the
DMA-based transfers may fail (depending on the DMA-engine driver
implementation).
2. The DW APB SSIs (3.x and 4.x) can be synthesized with the APB Data
Bus Width of 8, 16 and 32. So no matter whether DMA-engine supports
the 3-bytes bus width the system bus most likely will either convert
the transfers to the proper sized bus-transactions or fail.

So taking all of the above into account not using the
DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using it with
a risk to fail some of the platform setups especially seeing the DW
APB SSI ignores the upper bits anyway.

-Serge(y)

> 
> > > > +	case 4:
> > > > +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > +	default:
> > > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
