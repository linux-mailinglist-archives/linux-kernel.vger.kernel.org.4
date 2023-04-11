Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD556DDD58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDKOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDKOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:11:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0265580;
        Tue, 11 Apr 2023 07:11:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n22so6909611ljq.8;
        Tue, 11 Apr 2023 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222278; x=1683814278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pi0Pp9L47XQNH40/0qR1Exsm2iIPOQns4z7hkaAk5YM=;
        b=ZuxMps5cfIp9v+DnfkSzfr8LSLuH2ppBqjfHHlBZ8F72+Zf+qRP2SoB4tL/xV3p3Id
         zb/qs18gPt6xnEU9zGAA38Eb3GczunHj7PgEni4RGqYKSjeUGXHsbPIzbkzqvavYPkYk
         Dmt5whwnjH9h9oRmBbB3Pid3h0DqYD6HW1TnHZVyNOHfcn2TrhYYn12l05JZxdWHhBzi
         00nT+09OVLCUbMDIbgmPb7CIBt/DL2YnxktdJyB3yaEox646vv4mUY87WA++M5TxWCi5
         zaSOW5xaMRIO1kuZhm1azmoiEKRkmQSFCJy685/xMEB4rOXL4ufyPb3fsOPGKQIxA8B1
         PFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222278; x=1683814278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi0Pp9L47XQNH40/0qR1Exsm2iIPOQns4z7hkaAk5YM=;
        b=frIx+DGdT2R+sBLFwW6QeIBLibiYPZ5XjcwfyeaY63t5LaziEnT0EMwA6iOKHC4wF9
         VQw4pV2wR6h9BdMu2IJ9KmSEVjNkWi2l1RVs5fQmyhBeHCQfcReB3cHcEPJ4VX3Y+NGA
         mJWmGpv92yDF1ZDbzcNeIjfTF033QgYa5OnGG6zXwUV4H2iLdeil3mk+pcPbe04r/Qnj
         lXP8pUmS03P4+OlNSf7GUtuw6jcynJ+SSLxdq673VmniObqEMYy1/Nkdrt7mUT3buDkF
         M4bpPb9QeI2C1X6aVKTvLPBSFI43mAYtV+cpxcAOkNKsCjiH+dyRucygosYaShdG01KA
         zukQ==
X-Gm-Message-State: AAQBX9eCoGv16LcuLSnXH1uSQMIzrFzqjuSkvKV1ehsq60WXO+iV+Cs6
        cyeKMB0w4FEssRlWvW6X1/6cCZtiEDw=
X-Google-Smtp-Source: AKy350Y8DJSSMnI9OStcRejY35fvQfOXa+Cd/H/Xvtndw7+UvzognrlUcgAkO+NLf19dCVzqtnrvqA==
X-Received: by 2002:a2e:9d4f:0:b0:2a7:7e5a:f212 with SMTP id y15-20020a2e9d4f000000b002a77e5af212mr701328ljj.5.1681222278093;
        Tue, 11 Apr 2023 07:11:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b00298dc945e9bsm2802720ljb.125.2023.04.11.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:11:17 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:11:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230411141115.vrfd6sud66u6xeog@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
> 
> First of all the Subject is wrong. You are not touching DMA controller.
> Needs to be rephrased.
> 
> > Add Support for AxSize = 4 bytes configuration from dw dma driver if
> 
> SPI DMA driver
> 
> (or something like this, note capital letters for acronyms).
> 
> > n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > 
> > Number of bytes written to fifo per write is depended on the bits/word
> > configuration being used which the DW core driver translates to n_bytes.
> 
> ...
> 
> >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> >  {
> > -	if (n_bytes == 1)
> > +	switch (n_bytes) {
> > +	case 1:
> >  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > -	else if (n_bytes == 2)
> > +	case 2:
> >  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > -
> > -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> 
> > +	case 3:
> 
> I'm not sure about this.

This actually makes sense seeing the function argument can have values
1, 2, _3_ and 4:
dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
...
dw_spi_dma_convert_width(dws->n_bytes)

The spi_transfer.bits_per_word field value depends on the
SPI peripheral device communication protocol requirements which may
imply the 3-bytes word xfers (even though it's indeed unluckily).

This semantic will also match to what we currently have in the
IRQ-based SPI-transfer implementation (see dw_writer() and
dw_reader()).

-Serge(y)

> 
> > +	case 4:
> > +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +	default:
> > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > +	}
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
