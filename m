Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8F5E96AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIYWbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIYWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:30:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CE28E16;
        Sun, 25 Sep 2022 15:30:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g20so5601617ljg.7;
        Sun, 25 Sep 2022 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a0hPbzQaBpMZbWVLyY6Ndr2md1EPl8heRcl2lfx1uao=;
        b=prIsjwSViz1wXo7G4+dw2QMAUYRqb+JaN8xLaFU0Mpm720vsQlKbiP86kSyjK6/J2f
         UGL1JMA+tZbm+36axWkxsWe76LZ50jIgn88og12tFEhHuVazHWUXqmuxCGQQTATOLLmZ
         spdrcaq4Lzuq2ssEmvib39fmILwUzpX8VRsbe7Lq+Qajv529JR0stTj6IQi6cEHLkmKh
         OafABWRhWwcww6JDyoK0lU7XrAFw9x3u/15eQrfGPJIta/7hVKMeZBDesROTh0WhRfJi
         Nfd032HRBElAfY2jFOTPhNqIK1eLWkfEokcM8b151gDnjM4vSzgW3h4PbTqXJUyDvznl
         W5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a0hPbzQaBpMZbWVLyY6Ndr2md1EPl8heRcl2lfx1uao=;
        b=gAlFmgyZTnyggUK+6w5HNuc2f3JCjR9nQm+JveIwHSL/ygAkn8xKRad6N0ThML26ll
         ZHI4Tz+bxHR/7Qt5z1URJybe6U+f9mVHIeoNt88/WIpMJKIr45BcIfc4vHeYfOUxcKnf
         L2rZb1W2W93lwiI5oL37oYSTItVo697/7O64nEsfRw7zovKFyYBHwmyZEddIGDzw5ioj
         gG/rzbXubFyHGzEdqqiBak22IwOOdE5v7DtcphAoxdLDGF9Z4sZviUuczWxGCX8O/1MY
         MpGnV9Z6pvlotfXPX/R76pCiK5dUqBz59z/9B3onmlT7cm/Y2KePbn9RIlXkVGWRSQa+
         1wzg==
X-Gm-Message-State: ACrzQf37CXm6GdfKPC9+iJ9JNN4/h0TYFku6nK3oC8lOP/SgQrBnM8xm
        QJSnycm1tXvYcgilVGTV1xY=
X-Google-Smtp-Source: AMsMyM6HNh9b7WyDnzcSuSoW1HsGYT8oADEab3CivQY//vuQJo3RvP7/TJc7qf3WbBEZsPmwfLKAhQ==
X-Received: by 2002:a2e:7d13:0:b0:26c:4062:acfe with SMTP id y19-20020a2e7d13000000b0026c4062acfemr6763157ljc.201.1664145053791;
        Sun, 25 Sep 2022 15:30:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b0049f9c732858sm2322995lfg.254.2022.09.25.15.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 15:30:53 -0700 (PDT)
Date:   Mon, 26 Sep 2022 01:30:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Rafael Antognolli <Rafael.Antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp
 buffers
Message-ID: <20220925223051.5vem3ab4267jlxeg@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
 <20220910053203.GB23052@lst.de>
 <20220911162854.ivoeyzilpboplldw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911162854.ivoeyzilpboplldw@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Jens, @Revanth, @Jonathan do you have anything to say regarding the
patch and what @Christoph suggested?

On Sun, Sep 11, 2022 at 07:28:57PM +0300, Serge Semin wrote:
> Hello Christoph
> 
> On Sat, Sep 10, 2022 at 07:32:03AM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 09, 2022 at 10:19:16PM +0300, Serge Semin wrote:
> > > In accordance with [1] the DMA-able memory buffers must be
> > > cacheline-aligned otherwise the cache writing-back and invalidation
> > > performed during the mapping may cause the adjacent data being lost. It's
> > > specifically required for the DMA-noncoherent platforms. Seeing the
> > > opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> > > drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> > > respectively we must make sure the passed buffers are cacheline-aligned to
> > > prevent the denoted problem.
> >
>  
> > Same comment as for the previous one, this should work, but I think
> > separate allocations for the DMAable buffers would document the intent
> > much better.  Given that the opal initialization isn't a fast path
> > I don't think that the overhead should matter either.
> 
> Thanks for the comment. I see your point. Let's hear the subsystem
> maintainers out for their opinion regarding the most suitable solution
> in this case. If they get to agree with you I'll resend the series
> with altered fixes.
> 
> -Sergey
