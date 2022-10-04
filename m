Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C45F46C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJDPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJDPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:32:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B033358;
        Tue,  4 Oct 2022 08:32:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn8so2289793ljb.6;
        Tue, 04 Oct 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LJpQSt6f76xKyg5mFA+8DKvdT5AduyXHQ9BWqHR6Jys=;
        b=NBLGR9LigeFmBloKTsH3jAyJdA2BxTIkpCCdzRtXt35tT8t77dwX8+1lCCsIzW6m1K
         10X2ruTGY9VTmD5WOseHk2qtASOcK9oNV2yeTVycxcIH1B27teASNTL8jkogyKcnG9ja
         lDYB/eUzTQtiog3LEROv008MKQyvrrmmHAUZqX9UiXsw5EsLKAQxgKS89IMkOyTy/SXW
         BoeX0Gt881L/c8+qW6ay+296XSBAnQVjvtl0f7QjPoQmqj+j2HqKBQ2galI9YkGZJgxw
         YPqPPDw1JEOrV60b/AHJzSy8+O+m/znCSzB9O4TyFBvZn2gzRfxRm/e3cyPKAHrrBq/A
         sPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LJpQSt6f76xKyg5mFA+8DKvdT5AduyXHQ9BWqHR6Jys=;
        b=KCSbvSnbdD6jRIvNVH3xgBpCyFW12zScaSkhAnD/zxjBhLuUeFYmoXGDgCZl/SE6Ru
         BZEqDNqA8bUKsxFk80fXOVs1ai0l7QaewoVLawEc6pZsqSIEUxKB/kt5ILXgUA+0NBty
         VXedSZR6maa8KCx6X8JubqhjGvETQzh5uBqZ9GtrcCp5KE8ocgkcS8BM8TDVBxYmTgdq
         7lsCYwQRnAyjlbi9Q2v5fYd4Q3rtwcTSiw3paUIh1HIMwAuZ7uWJdNHGyiFwguD4NSiX
         JO1e1NvDKD5ba1oe/S5IyU9fDLsOubhVa5Zy6tDsEwMvcU9Ukf3D7LJCK/HgIYQjUytY
         HOlQ==
X-Gm-Message-State: ACrzQf1bqZFjV9WTgQ6fJqUL3S51aZs3W4l0vTJgwtNIhbPctJNR8qFd
        dgI+2VT5KKdqCUAtqZ+SuY4=
X-Google-Smtp-Source: AMsMyM70KCRNNDKjPyPxNz/cIaHtp4wK32laKXHtSsO/3EwAzNBVS3tfMgR6hVFHSIO9qLn8bDdbpA==
X-Received: by 2002:a05:651c:4ca:b0:26c:50e6:a9d3 with SMTP id e10-20020a05651c04ca00b0026c50e6a9d3mr8918382lji.318.1664897555773;
        Tue, 04 Oct 2022 08:32:35 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bx30-20020a05651c199e00b0026acfbbcb7esm763543ljb.12.2022.10.04.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:32:34 -0700 (PDT)
Date:   Tue, 4 Oct 2022 18:32:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: sed-opal: Cache-line-align the cmd/resp
 buffers
Message-ID: <20221004153233.bxevkwwi6kqdpyep@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
 <cce74aec-61b1-d5eb-1b62-746e45ebfe69@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce74aec-61b1-d5eb-1b62-746e45ebfe69@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:24:08PM -0600, Jonathan Derrick wrote:
> Hi
> 
> On 9/29/2022 4:46 PM, Serge Semin wrote:
> > In accordance with [1] the DMA-able memory buffers must be
> > cacheline-aligned otherwise the cache writing-back and invalidation
> > performed during the mapping may cause the adjacent data being lost. It's
> > specifically required for the DMA-noncoherent platforms. Seeing the
> > opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> > drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> > respectively we must make sure the passed buffers are cacheline-aligned to
> > prevent the denoted problem.
> > 
> > [1] Documentation/core-api/dma-api.rst
> > 
> > Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >   block/sed-opal.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index 9700197000f2..222acbd1f03a 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -73,6 +73,7 @@ struct parsed_resp {
> >   	struct opal_resp_tok toks[MAX_TOKS];
> >   };
> > +/* Presumably DMA-able buffers must be cache-aligned */
> >   struct opal_dev {
> >   	bool supported;
> >   	bool mbr_enabled;
> > @@ -88,8 +89,8 @@ struct opal_dev {
> >   	u64 lowest_lba;
> >   	size_t pos;
> > -	u8 cmd[IO_BUFFER_LENGTH];
> > -	u8 resp[IO_BUFFER_LENGTH];
> > +	u8 cmd[IO_BUFFER_LENGTH] ____cacheline_aligned;
> > +	u8 resp[IO_BUFFER_LENGTH] ____cacheline_aligned;

> I'm with Christoph on this one.
> When I see ____cacheline_aligned, I assume its for performance reasons, not
> to work around a DMA limitation. Can we instead kmalloc (which provides
> alignment) these buffers to make it more clear? May want to add that same
> comment pointing out some architectures require these dma targets to be
> cache aligned.

Ok. I'll resend v3 with these buffers being kmalloc'ed.

Please note the SED OPAL entry of the MAINTAINTER list contains your
intel-email address, which bounces back the messages (so does the
Revanth' one). I'll add your new address to my patchset' "To"-list,
but if you want to get new OPAL-related patches sent directly to your
linux.dev email address the entry should be updated.

-Sergey

> 
> 
> >   	struct parsed_resp parsed;
> >   	size_t prev_d_len;
