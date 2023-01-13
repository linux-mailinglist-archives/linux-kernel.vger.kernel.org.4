Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F281E66A238
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjAMSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAMSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:39:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125C209;
        Fri, 13 Jan 2023 10:39:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so34286105lfb.13;
        Fri, 13 Jan 2023 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+Ihb7yYd+dHkT3peC3oWMSMFZmTeVb3TWtbghgSLf8=;
        b=gWQQou4T5QGvl3TUuN+n2NqdV0UyZLx03XI3YRXPRylqua4IXFppBI8k2CQt8+ZFmh
         OOcb3x5rKqp88ZXO7UOJrfFq4QNKQA8JWxGryT1NaiBU6wzVP1Et8GQ4TEOXdleqWHeT
         AsFV5U/7Gn2anS5iB+pJQOc7wlAnDZovLNoHvw0vffHVQTzoYIfBHhNSyShrJ6CyGtXF
         paNqRK+sHrGDa2dppJfWu2eCGn0TFu9zSKFKNQ/smI782wpu5Kww9yVUXpxfIhsswJiU
         wmcKDdLG/TwbqQsRDLNvJqu9L0CR53sJ9JTHcwoCwAYzJmK7OEx1PgBjMBjZtFn3/oQb
         TXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+Ihb7yYd+dHkT3peC3oWMSMFZmTeVb3TWtbghgSLf8=;
        b=3uF7tj9DcKQE8ezMdubA6lI33VqiwWj4W9KNoqaMkoNIxSzLKIBIgbhJdYK19K240q
         Y7Q/QMH07QddKRX2b9Q+Zz/P0JzNSYL8nAH8ACx7jyCkQQ3kCFfpOjpHD0CxCDI2pjNl
         OQ1FkQKG2GHrYxguxdOM1pkXII/d12D8QS+3VbjZ8lT9Pt/Xe+V+5q+NBVGiIQoz0ohm
         fiVJtxde6eFA9A21ybuRVa4ALbEBsPzU+JLO9u7fQsNnSbfcJrSArZEHkBawJRvenCzp
         sjrZfTrS7zSBDcYoWRZCtiw1MOcBxzWFHCe9RUZPumtJ/t919qbFbbtwwVaWCliY5Csy
         wI9w==
X-Gm-Message-State: AFqh2kqXbpFH3nwCEr/pbQyxzdQQIKCg/Tjv3qYb8VKaAIe66KMgs4Hb
        paMlS+CC9uyIOJBEWZfKKGzsRLmsJxA=
X-Google-Smtp-Source: AMrXdXu712NUTAQ0T3YcSwrV0RpfV0bTzFPz9RV+HRn1MXb8nk5ZsrDEol6rOAdo02svcOg8qvGLBQ==
X-Received: by 2002:a05:6512:39c6:b0:4cc:725d:9d3d with SMTP id k6-20020a05651239c600b004cc725d9d3dmr9534530lfu.54.1673635140657;
        Fri, 13 Jan 2023 10:39:00 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b004cc9042c9cfsm1989295lfr.158.2023.01.13.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:39:00 -0800 (PST)
Date:   Fri, 13 Jan 2023 21:38:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix wrong FIFO level setting for long xfers
Message-ID: <20230113183857.ed5nh3k5ohm34oju@mobilestation>
References: <20230113165724.27199-1-Sergey.Semin@baikalelectronics.ru>
 <CAHp75Vc3+_SiVFzmJPM2dtPqUGErGY6Qc6_deS1yaDkjtT35rQ@mail.gmail.com>
 <20230113181854.ob7lgbwixnxdrcys@mobilestation>
 <Y8GjYUWKSbfXFNEK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GjYUWKSbfXFNEK@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:30:57PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 13, 2023 at 09:18:54PM +0300, Serge Semin wrote:
> > On Fri, Jan 13, 2023 at 07:33:16PM +0200, Andy Shevchenko wrote:
> > > On Fri, Jan 13, 2023 at 6:57 PM Serge Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > Due to using the u16 type in the min_t() macros the SPI transfer length
> > > > will be cast to word before participating in the conditional statement
> > > > implied by the macro. Thus if the transfer length is greater than 64KB the
> > > > Tx/Rx FIFO threshold level value will be determined by the leftover of the
> > > > truncated after the type-case length. In the worst case it will cause
> > > > having the "Tx FIFO Empty" or "Rx FIFO Full" interrupts triggered on each
> > > > word sent/received to/from the bus. In its turn it will cause the
> > > > dramatical performance drop.
> > > >
> > > > The problem can be easily fixed by using the min() macros instead of
> > > > min_t() which doesn't imply any type casting thus preventing the possible
> > > > data loss.
> > 
> > > But this would be problematic if the types of the parameters are different.
> > > Currently they are u32 vs. unsigned int.
> > 
> > Yes, it would but only in case if somebody changes their types. As you
> > said they are currently of u32 and unsigned int types which are the
> > same on all the currently supported platforms. So even if somebody
> > changes the type of any of them then the compiler will warn about it
> > anyway.
> > 
> > > I would rather assume that
> > > FIFO length is always less than or equal to 64K and just change the
> > > type in min_t to follow what dws->tx_len is.
> > 
> > There is no need in assuming in this case. FIFO depth doesn't exceed
> > 256 xfer words by the DW SSI IP-core design (judging by the constraints
> > applied to the SSI_RX_FIFO_DEPTH and SSI_TX_FIFO_DEPTH synthesize
> > parameters). So the dws->fifo_len can be easily converted to u16 type.
> > The problem is in the tx_len field casting to u16. It's a rare case,
> > but the SPI xfers length can be greater than 64K. The
> > spi_transfer.len field is of the unsigned int type and the SPI-core
> > doesn't have any constraints to that (except the one defined by the
> > controller drivers).
> > 
> > So to make sure I correctly understand what you meant. Do you suggest
> > to do something like this (it was my first version of the fix):
> > -	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
> > +	level = min_t(u32, dws->fifo_len / 2, dws->tx_len);
> > or even like this
> > -	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
> > +	level = min_t(typeof(dws->tx_len), dws->fifo_len / 2, dws->tx_len);
> > ?
> 

> No, I suggest
> 
> 	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);
> 
> So, we do not care about changing of the fifo_len type, and we won't issue
> a compiler warning if it becomes, let's say, u8. While your solution will
> still produce it.
> 
> > Personally I would prefer either my solution with just min() macros
> > usage (which in case of the types change will give the compile-time
> > warning about the types mismatch) or using the min_t(u32, ...) version
> > (using typeof() seems overkill). I don't see much different (do you?).
> 
> Yes, hence personally I prefer my proposal.

Ok. min_t(unsigned int, ...) it's then. I'll resubmit v2 shortly.

-Serge(y)

> 
> > Both versions have their pros and cons.
> 
> Right.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
