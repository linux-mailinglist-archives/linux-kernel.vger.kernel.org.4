Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEC66A1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjAMSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjAMSYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:24:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E279087A;
        Fri, 13 Jan 2023 10:18:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g18so1383478lfh.0;
        Fri, 13 Jan 2023 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxAGNP6m+hWbayl/B3smxi4u/Bu9mzDKwqCFrJpkK4w=;
        b=qVEiVTB0YdELAdigdDX+JBQaTKszlSQxsumGPhoo07wfIAy4+zUOm1HFrukjxbs1aB
         tPSyQQme0j9EOo2VbUnPCo6s6+k2hFxZjv0Y+HlabjED3ttYLRT9Itgo6L5yklIFig1Q
         K3+msXhWJf61jigWq7MaOYDrkZ7gctW5+kQ9+ExisBd9w4dtVQ27B36cClyBzEVDNWGF
         mJFV8fCtwXIPq38cDDhgn/CHffKQ3clvt+CRM49xDnoH+4F97ndcmpTsAFkgL4TSYPJ4
         84Zp7COg+VRagQJPOQNf/wXN7YULgLEk7YC4v1ZwjTFOE/a+zn/VOg4sbP3JR3wTa58f
         bKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxAGNP6m+hWbayl/B3smxi4u/Bu9mzDKwqCFrJpkK4w=;
        b=WJgQL2Kv6TzD4Q7C2NURHbXrmcCYyJwzu1Yuqh5CDk8MWS/k93gq1W/YdYrKaYEf5H
         i2nIrJnlvEJqbRx2L5SiEoxvheDwr6Z7GDulOutCfL9KbBQI/zg+61ryXDA5400pGeAY
         JKvuercZFu+nQzpIdtbK6a8BkyVrOnsC/7LJhfK86+uwA3hvQDPpGE9Ap7OrML88i9Gp
         KKCyfKmZ0KQ1fpMN/gKuBmvOLMaaSE3lAzZ1akRQEUjI/h8xam34qhy8BuAOvBtU21V4
         2QVLr/IXD7udlN7WGAMw48AmhmmmEuzhNLYKVQCORdcKzrtzXQlAypDvomu33B6xlsnQ
         z68w==
X-Gm-Message-State: AFqh2krqNUrdWnJtoSvEW5miG4gr1kb9ayfrJDP1As1k/4AOfCoNqjY4
        gRDMdGC/dRhV+BQyaUn66lKbvCIB1WKJVg==
X-Google-Smtp-Source: AMrXdXsW4nNpXjpD6kXNNgwSWftW0S0fYxjcSHtZIot6kxPedDISGxb/I8YhNoCkIvu2edRSM4vWcA==
X-Received: by 2002:a05:6512:32cc:b0:4cb:4378:9c6 with SMTP id f12-20020a05651232cc00b004cb437809c6mr10653556lfg.23.1673633937291;
        Fri, 13 Jan 2023 10:18:57 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id h15-20020a05651211cf00b00498fc3d4d15sm3941876lfr.190.2023.01.13.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:18:56 -0800 (PST)
Date:   Fri, 13 Jan 2023 21:18:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix wrong FIFO level setting for long xfers
Message-ID: <20230113181854.ob7lgbwixnxdrcys@mobilestation>
References: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
 <CAHp75Vc3+_SiVFzmJPM2dtPqUGErGY6Qc6_deS1yaDkjtT35rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc3+_SiVFzmJPM2dtPqUGErGY6Qc6_deS1yaDkjtT35rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:33:16PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 13, 2023 at 6:57 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Due to using the u16 type in the min_t() macros the SPI transfer length
> > will be cast to word before participating in the conditional statement
> > implied by the macro. Thus if the transfer length is greater than 64KB the
> > Tx/Rx FIFO threshold level value will be determined by the leftover of the
> > truncated after the type-case length. In the worst case it will cause
> > having the "Tx FIFO Empty" or "Rx FIFO Full" interrupts triggered on each
> > word sent/received to/from the bus. In its turn it will cause the
> > dramatical performance drop.
> >
> > The problem can be easily fixed by using the min() macros instead of
> > min_t() which doesn't imply any type casting thus preventing the possible
> > data loss.
> 

> But this would be problematic if the types of the parameters are different.
> Currently they are u32 vs. unsigned int.

Yes, it would but only in case if somebody changes their types. As you
said they are currently of u32 and unsigned int types which are the
same on all the currently supported platforms. So even if somebody
changes the type of any of them then the compiler will warn about it
anyway.

> I would rather assume that
> FIFO length is always less than or equal to 64K and just change the
> type in min_t to follow what dws->tx_len is.

There is no need in assuming in this case. FIFO depth doesn't exceed
256 xfer words by the DW SSI IP-core design (judging by the constraints
applied to the SSI_RX_FIFO_DEPTH and SSI_TX_FIFO_DEPTH synthesize
parameters). So the dws->fifo_len can be easily converted to u16 type.
The problem is in the tx_len field casting to u16. It's a rare case,
but the SPI xfers length can be greater than 64K. The
spi_transfer.len field is of the unsigned int type and the SPI-core
doesn't have any constraints to that (except the one defined by the
controller drivers).

So to make sure I correctly understand what you meant. Do you suggest
to do something like this (it was my first version of the fix):
-	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
+	level = min_t(u32, dws->fifo_len / 2, dws->tx_len);
or even like this
-	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
+	level = min_t(typeof(dws->tx_len), dws->fifo_len / 2, dws->tx_len);
?

Personally I would prefer either my solution with just min() macros
usage (which in case of the types change will give the compile-time
warning about the types mismatch) or using the min_t(u32, ...) version
(using typeof() seems overkill). I don't see much different (do you?).
Both versions have their pros and cons.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
