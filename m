Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819C4624C17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKJUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKJUn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:43:27 -0500
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5DD46;
        Thu, 10 Nov 2022 12:43:25 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id 734E23EBA5;
        Thu, 10 Nov 2022 15:43:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1668113004; bh=RQD/JlAkDQ6AgOYscQR7ABn1mU+bmv60xb1cB8ThUHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfCRhXJz/nQnGqJCjdgccJImktHwnpeFZptG9gD6TAvtcIHUzzz/PLIdtEG7tjGm6
         03lWayrdMmsdGtf2eBPqsOTudlx+fAme1X6chHeEre+jzmHRq41R0yEN/3+unZwAya
         hA+5u2urOBY2wrqwFl172IjbBNot87ymFm/BHKLIa7XxgbWH/ftduhbyHaptnN3//1
         O0wNkBJC2F8rJLkEvqgXqSdkg3dpgjEPZv383ZmzJWrUWvkIFimZ6ljnh3xqcS8MHS
         dzjvUk49gsvRYiNbmWaYZKObnfRGu9jdgrc3WYZ9YmFG8rZVIdmpX02McEKAIOB6rR
         MQBaEnnvAKpRQ==
Date:   Thu, 10 Nov 2022 15:43:22 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1]: iio: light: rpr0521: add missing Kconfig
 dependencies
Message-ID: <20221110204322.waygj3v466haadmr@device>
References: <20221110144448.wexu6neb67krqhla@device>
 <Y20b8Ty71+qk8aDZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20b8Ty71+qk8aDZ@smile.fi.intel.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2022, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 09:44:48AM -0500, Paul Gazzillo wrote:
> 
> >     CC      drivers/iio/light/rpr0521.o
> >   drivers/iio/light/rpr0521.c: In function 'rpr0521_drdy_irq_thread':
> 
> These two lines can be removed.

Will do.

> > (This bug was found with the help of a tool, krepair, that generates
> > configuration files for commits: https://github.com/paulgazz/kmax)
> 
> I'm not sure we need this in the commit message. Do we have a tag for
> the static analyzers?

I'll also remove this.

> > The following patch ensures that the code controlled by IIO_BUFFER and
> > IIO_TRIGGERED_BUFFER is available:
> 
> > Reported-by: Paul Gazzillo <paul@pgazz.com>
> 
> Without SoB this may not be anyhow proceeded. Please, read Submitting Patches
> documentation and try again.
> 
> (Btw, Reported-by above contradicts the commit message that refers to the tool,
>  and not human)

Apologies, I was confused about whether I or the maintainer fills that
out.  Will submit a new version with SoB.

Thanks!
Paul

> 
> -- 
> With Best Regards,
> Andy Shevchenko
