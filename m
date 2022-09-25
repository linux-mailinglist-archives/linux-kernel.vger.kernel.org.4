Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF25E96A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiIYWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIYWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:23:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4828E0D;
        Sun, 25 Sep 2022 15:23:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so8202653lfr.2;
        Sun, 25 Sep 2022 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FtEqwG/K5xL9hXf+ZrP/wIckLjWw253tSx59CJRjURo=;
        b=N3zreAPfbahoEwQV/C8efRAOUCuOnhdFwUg8hikd4a1/01yPQNnPcCpOsb7gLEPng6
         rn16dNKQol45mqFmIneUl4ARey1O/Ac7Oxx1N+hgHC+69ZLn/nOrvF6pqQim3i4ygx5t
         qCh9zb5P5C2gs8MgWrmeBFZCx/huBngE7tMhCW7JVwdjGTvfemIsTbMTde+hkI6ydsGD
         Y8tSALjoT+bEbAav394L9zBxwsaB8eI7Fuu8PJWwI6VuPXtbvjVNtA7CBL23meDH3zw/
         SQFR+be4EQnNerC9or4kS9qwx+M2jTJbpwg20BcvjwmVRKTMhknskmZkn2Cvi24zLIej
         lgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FtEqwG/K5xL9hXf+ZrP/wIckLjWw253tSx59CJRjURo=;
        b=oVR1km8wrsYEcjmnk2IKOdZc8OmR7tZDFj4FSlCmNTWrz8GBWIpVQfkbkIojJ9HC1E
         B3+bdxTNdqPC75lXNTEVpPbXHJs1uRzn5j9tmULEJUy4lZN651qI2ZdmBdbpR9xfWMXT
         uvNomMXOWclE4EJ4bpX6OorNWnYbl03OGwg9xcs3zQ5IfshjL4SFfqd0KO/+KzW0PXe7
         2fretXiYeQ2W+XpVqNQ1+nEML97enUeZZShOlR53cwTeVpo3odJMPIb/rm0Ey1CBvR8O
         naZefEZ61mbe4A1IEcjvfiBVSTlZqYdoAjK6nuCdK5m/JgpeB9GiEk2GWYyK7JF0yFRH
         vR0A==
X-Gm-Message-State: ACrzQf0Wwuw6S7PCgLCbHgKz+crXEYt55hB6MlCLpwKb+lifzpGjgANR
        nb0bAPQgQoIdHK17oBJOk/RCpLlVuT30Tw==
X-Google-Smtp-Source: AMsMyM5qFMDgU027/Sm9muPHKDgrE5SpekpER+jHiBO95ZmOUdyFKex46JvtxCjMFbSXa2HOzzYqrQ==
X-Received: by 2002:a05:6512:3ba:b0:497:a116:3f86 with SMTP id v26-20020a05651203ba00b00497a1163f86mr7296009lfp.142.1664144608290;
        Sun, 25 Sep 2022 15:23:28 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2327682lfj.266.2022.09.25.15.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 15:23:27 -0700 (PDT)
Date:   Mon, 26 Sep 2022 01:23:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220925222325.irltbraf4e2j4vtq@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
 <20220912082909.GA10666@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082909.GA10666@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

Sorry for the delay with response.

On Mon, Sep 12, 2022 at 10:29:10AM +0200, Christoph Hellwig wrote:
> On Sat, Sep 10, 2022 at 03:35:42PM +0300, Serge Semin wrote:
> > Well, both approaches will solve the denoted problem. I am just
> > wondering why do you think that the kmalloc-ed buffer is more
> > preferable?
> 

> Because it clearly documents the intent.  Here is one buffer that is
> just a data buffer, and here is one with kernel internal structure.
> The concept of embedding on-disk / on-the-wire structures into internal
> stuctures always seemed rather weird and unexpected to me, as we now
> need to ensure that the alignment works right on both sides.  With
> the right annotations (as done in this series) this will work, but
> it feels a little fragile to me.

IMO both the approaches seem unclear if a reader doesn't know what
they have been introduced for. Anyway do you insist on using the
kmalloc-ed buffer here instead? If so I'll resubmit the series with
this patch updated accordingly.

-Sergey

> 
> > What would be the best solution if we had a qualifier like this:
> > #ifdef CONFIG_DMA_NONCOHERENT
> > #define ____dma_buffer ____cacheline_aligned
> > #else
> > #define ____dma_buffer
> > #endif
> > and used it instead of the direct ____cacheline_aligned utilization.
> 
> So independent of my preference for separate allocations, this suggested
> additional would still be very useful for the places where we need
> to use the alignment for performance or other reasons.  I'd use
> something like __dma_alligned or similar, though.
