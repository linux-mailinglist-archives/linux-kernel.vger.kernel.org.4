Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA95B4633
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIJMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 08:35:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CD45040;
        Sat, 10 Sep 2022 05:35:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a14so3018178ljj.8;
        Sat, 10 Sep 2022 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ylankE0Ntcy0fsfQcuqcC6SNPzukIG6CjHTnu9Jh3Qw=;
        b=m0j2q/wOOyX3sBYygCXuf0GnAJujmOFo7EMdTErAa7sxWkqNTWnaVnXVBgbItew1PR
         H1ZpKn6ij5A7tzWhxS1U+LBe2qbuh141TFxjZQl7aSI4dsknFOr5w8B78TVDLILswE20
         J2UM+cmXt9JvaoIfSVuU03E4eHlWjzQWEoosHlGodaDN38+9O1w05ghVJzSZgANOI4MZ
         Bk09wNS7slZRxakCNeRyA1SUiG0q0C/DN8ZPOzbeWFs9rhUE/hluKrath+zb1leShmtf
         uNRN+Mx+KOIo4YMVbAl0alNUQHkfzQ/J1qo2wTY9+f/NnI1mD5iW9jqwgn4WJjyG6AeN
         Z7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ylankE0Ntcy0fsfQcuqcC6SNPzukIG6CjHTnu9Jh3Qw=;
        b=T3UZV1ohQsWwsE+ti+0hZ9O5UqYq4UyH+BnluWzmOuBeNDHtxpFmSM9zi/RlMVm9yn
         6d3ozLrFolxohCiql59b2WDGuttoPhp64VcNVhEG6g7JWJNSxv81pCCmISdikjdB7IXu
         Y1YsOin8dkqbUvZfDlIssMn415WYF1O1qsGxH/mIYUNNpniUppYfFDjKod87T1j28zF/
         ZZ2PNiLuUSwetq+KrEM/Y7X8jjmw2FUZCZ9zOrUfe2gqkinTx6GSZIIgzvzPMFf2wq/P
         W9CAkBMvfAParGDhwGHiKKp/vLcui48i6c0T2h3G+Q58pTZtmbkFxlXPLp4Cf7R/9uMb
         DGyQ==
X-Gm-Message-State: ACgBeo3sib1eBwMnaCCnnDglHqdnC+DH9kmuun8F1if4kZEjRZY1b47/
        ZrzOLfsDcvqcWSDMSwQJxmU=
X-Google-Smtp-Source: AA6agR7AEhYcjxJXjLPhbXBdf+MXAQzDChKDVE1xSxa0FIjE57ci1fPhV4Eba3gXLB1Lx6IGlLnRaA==
X-Received: by 2002:a05:651c:2d0:b0:25e:6c94:59d5 with SMTP id f16-20020a05651c02d000b0025e6c9459d5mr5644442ljo.488.1662813345560;
        Sat, 10 Sep 2022 05:35:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id a19-20020a056512201300b0048a757d1303sm243827lfb.217.2022.09.10.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:35:44 -0700 (PDT)
Date:   Sat, 10 Sep 2022 15:35:42 +0300
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
Message-ID: <20220910123542.tzxg2blegw55z5fj@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910053045.GA23052@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 07:30:45AM +0200, Christoph Hellwig wrote:
> I think this will work, but unless we have to I'd generally prefer
> to just split dta that is DMAed into into a separate allocation.
> That is, do a separate kmalloc for the nvme_smart_log structure.

Well, both approaches will solve the denoted problem. I am just
wondering why do you think that the kmalloc-ed buffer is more
preferable? IMO it is a bit less suitable since increases the memory
granularity - two kmalloc's instead of one. Moreover it makes the code
a bit more complex for the same reason of having two mallocs and two
frees. Meanwhile using the ____cacheline_aligned qualifier to prevent
the noncoherent DMA problem is a standard approach.

What would be the best solution if we had a qualifier like this:
#ifdef CONFIG_DMA_NONCOHERENT
#define ____dma_buffer ____cacheline_aligned
#else
#define ____dma_buffer
#endif
and used it instead of the direct ____cacheline_aligned utilization.

-Sergey

> 
> Guenter, is this ok with you?
