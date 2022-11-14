Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF0628945
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiKNT1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiKNT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:27:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32624BCC;
        Mon, 14 Nov 2022 11:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D88A6137A;
        Mon, 14 Nov 2022 19:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBAEC433C1;
        Mon, 14 Nov 2022 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454031;
        bh=5UNR9fJzQk/JHrUBk+Oph8kZR/kxfVNPsMaCAXJcNgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c1ifZddpYPeZPYyYL3zAf+qWX9cBPYllYUvVSu280ZnqB9C7iZrTZ0lcLqubh/nIa
         MqT6DwWLcrn6TIF8LNY8KCHF92QnlXsFp+XpB+p5MblEhKyOoqgzIwCmuFZMXuXZhA
         hhK6YSnks0wWMhsMXboLWdFDOxz0x4N1USg4a1g16TD52lg8rgBPT8oO0X3ZMDWh4P
         D9ZA6VT/tqaTTDAjnmSz/aaLEK538+W9BPl1vSaaS1DvW3SwbKFR5mys5cQbqhcauS
         WrLi88hIN7X8eFRRLxeyAJ5fzMnPBvhEN5LstdzvmALhF05M01lUGY+e93qiwRJHbB
         d2ScT+VGOdHsQ==
Date:   Mon, 14 Nov 2022 19:39:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH 1/5] iio: addac: ad74413r: add spi_device_id table
Message-ID: <20221114193928.37b25f17@jic23-huawei>
In-Reply-To: <4e98c469-cd22-a946-784c-5e0391142570@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-2-linux@rasmusvillemoes.dk>
        <20221112165049.51a5f391@jic23-huawei>
        <4e98c469-cd22-a946-784c-5e0391142570@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 09:02:44 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 12/11/2022 17.50, Jonathan Cameron wrote:
> > On Fri, 11 Nov 2022 15:39:17 +0100
> > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >   
> >> Silence the run-time warning
> >>
> >>   SPI driver ad74413r has no spi_device_id for adi,ad74412r
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  drivers/iio/addac/ad74413r.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> >> index 899bcd83f40b..37485be88a63 100644
> >> --- a/drivers/iio/addac/ad74413r.c
> >> +++ b/drivers/iio/addac/ad74413r.c
> >> @@ -1457,12 +1457,20 @@ static const struct of_device_id ad74413r_dt_id[] = {
> >>  };
> >>  MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
> >>  
> >> +static const struct spi_device_id ad74413r_spi_id[] = {
> >> +	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
> >> +	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
> >> +	{},  
> > Trivial, but prefer not to have a comma after a "NULL" terminator like this.
> > It would never make sense to add anything after it in the array.  
> 
> I agree and wouldn't have added it if it weren't for the existing case
> in the other table.
> 
> > Now you are matching existing driver style, but I'd still rather not see more
> > instances of this added.  
> 
> Sure.
> 
> > Also, driver_data is not currently used. It should be because adding this
> > spi_id table means the driver can be probed via various routes where
> > device_get_match_data() == NULL.   
> 
> That makes sense, I think I thought that that would somehow happen
> automatically. Looking through the history of similar fixes, I see that
> for example 3f8dd0a7dc does indeed add code as you suggest, but
> 855fe49984 does not (and also doesn't add the corresponding .driver_data
> initializers in the spi table). They may very well both be correct, but
> looping in Oleksij for good measure.

It depends a bit on whether there is any plausible chance of anyone making
use of say greybus with the device (I think that still relies on the spi id
though not checked recently).  If not and no board files exist, chances are
that all is needed is the id table (to make autoprobing of modules work).
Still I'd not leave the opening for the unexpected to happen given users
have an annoying habit of finding the corner cases :)

Jonathan

> 
> > Hence, alongside this change you need to have a fallback to cover that case.
> > Something along the lines of...
> > 
> > 	st->chip_info = device_get_match_data(..);
> > 	if (!st->chip_info) {
> > 		struct spi_device_id *id = spi_get_device_id();
> > 		if (!id)
> > 			return -EINVAL;
> > 
> > 		st->chip_info = (void *)id->driver_data;
> > 		//or better yet cast to the correct type I'm just too lazy to look it up ;)
> > 		if (!st->chip_info)
> > 			return -EINVAL;
> > 
> > 	}  
> 
> Thanks,
> Rasmus
> 

