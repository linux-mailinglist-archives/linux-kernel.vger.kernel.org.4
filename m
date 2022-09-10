Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2E5B47DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIJSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 14:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIJSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 14:09:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441364A83E;
        Sat, 10 Sep 2022 11:09:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a14so3678965ljj.8;
        Sat, 10 Sep 2022 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KS4TP2ze3jkqEm4agkQq4ZcaXK2TLvPAvVTwXaoewAE=;
        b=aaJ9jnC2m2QxfJ1x4hvagtBftMmxZMeEd7klq9aX0U2pGVAJfB6cNu0ywEgjmbCQa1
         nK/oe3TerCKLpE0H/l+SXyI5c9SNFCsaC1ejkM7w+FwdkeoJIF2z0/Qk/RIrEMtqiruw
         rX+887c6mE9Rj8lkPClsFcsr39JMz/SLgpwD+fqqz/MjTEn1cHOI/N645P+k7M97H9Fb
         Mmi4PJP5ShmhauUID1qpIsa7vvio0KsG6Z0yf83EblCl1IN3NIo90ln2XavI2a8tmzJ/
         1kErlJahBP69D8NmfJI+zy6VDqryxvqDFh5IkkoFU84p24gcHEijAbrPf+oNi05Urie9
         CvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KS4TP2ze3jkqEm4agkQq4ZcaXK2TLvPAvVTwXaoewAE=;
        b=dPmjGmPVhuoNFUB3NjRHXHVVNt1qpLiT1DURBwf6isg2A3JrXwFx/XlBFOENsN1q/F
         opZsfQf0FRgjlbHMjyL6YbUgGtuBNwNhEs6Bil2nJpix8sAjumQtvgycJbxkgr94JtHa
         TXjTMpWM/8qOO8SLAu4Ey0HIEIzR01/v9O5NijxgXPKGbMgyQqlhhOQHvpxrI4Y/UGZ8
         q4dGGZ1m+BYruJ065uFfdaLR1cj3jw4YAJicbce2+XGegcCMQU7NXMkaH9dhXRKGTfNq
         kzLlZJ8OWKoh/1TJSnA0az9/H5O2Y4ZN5y9YiqvJMX496usafvih8yZLoP8VOQX2HcCs
         5p4Q==
X-Gm-Message-State: ACgBeo3Enx7LGly2a7qPC8hjUYFhMqB+weDTxbmY/vMGLEZoCmWaaUdu
        jb81nr1VnO2peFhtvoNNkLE=
X-Google-Smtp-Source: AA6agR5r30odkaE5DK7PIWzQ2ruiFG4YP1rMHOV27OWfASoPKQuDfLBKQ0OjTKlnHWOk5VfhAtqUlQ==
X-Received: by 2002:a2e:700e:0:b0:26b:fadf:87b2 with SMTP id l14-20020a2e700e000000b0026bfadf87b2mr612116ljc.520.1662833360099;
        Sat, 10 Sep 2022 11:09:20 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512229100b00498fc3d4d15sm325984lfu.190.2022.09.10.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 11:09:19 -0700 (PDT)
Date:   Sat, 10 Sep 2022 21:09:17 +0300
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
Message-ID: <20220910180917.plhtjt3lp7b6wlb5@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910123542.tzxg2blegw55z5fj@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 03:35:45PM +0300, Serge Semin wrote:
> On Sat, Sep 10, 2022 at 07:30:45AM +0200, Christoph Hellwig wrote:
> > I think this will work, but unless we have to I'd generally prefer
> > to just split dta that is DMAed into into a separate allocation.
> > That is, do a separate kmalloc for the nvme_smart_log structure.
> 
> Well, both approaches will solve the denoted problem. I am just
> wondering why do you think that the kmalloc-ed buffer is more
> preferable? IMO it is a bit less suitable since increases the memory

> granularity - two kmalloc's instead of one. Moreover it makes the code
  ^
  `-- I meant fragmentation of course...

> a bit more complex for the same reason of having two mallocs and two
> frees. Meanwhile using the ____cacheline_aligned qualifier to prevent
> the noncoherent DMA problem is a standard approach.
> 
> What would be the best solution if we had a qualifier like this:
> #ifdef CONFIG_DMA_NONCOHERENT
> #define ____dma_buffer ____cacheline_aligned
> #else
> #define ____dma_buffer
> #endif
> and used it instead of the direct ____cacheline_aligned utilization.
> 
> -Sergey
> 
> > 
> > Guenter, is this ok with you?
