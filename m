Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DED6417F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiLCQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLCQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:58:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532031AF36;
        Sat,  3 Dec 2022 08:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C55ED60CA0;
        Sat,  3 Dec 2022 16:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107BEC433D7;
        Sat,  3 Dec 2022 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670086727;
        bh=iWh2UI3d2eVdkhHsEtxuowy62D6hweHEheaMfQIiPGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nRVt5ZkovxmoP3SscT6h8w6Mb0YCHL9mKuNjV64jVGDEv++PNuONvT6tx0Ls7PgGI
         paC2O338Wp1q3Sdueumthu4Fcm6C+2hW/UHls6j8s9wJKdasZwJs6XQxkhlVAA4Sx0
         jsIgZ3ZMZKFkQmaJ+JZhQ7guBAqcTb0KG+NY0/tLykNi29elb6e65G3C/Esn0MHuf3
         QAD2c7FMA4vDYdLpK7aiuUXGmdolrm7dZRaC+Om1RzBPCNhQRKb0ORRCRBMZRgpGKs
         SSAB57mko0vd8YA5RapplU+7uq1aHDs+X7Mq2bpdBEGmp+B6Ihpqi7H4tGQOiVKSLw
         VqI419aMTdq5g==
Date:   Sat, 3 Dec 2022 17:11:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Message-ID: <20221203171131.6d096078@jic23-huawei>
In-Reply-To: <b56cdcf1-459b-63a2-a060-49564e11ce9f@wolfvision.net>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
        <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
        <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
        <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
        <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
        <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
        <4d1b0054-efd4-e10e-17a6-d236052afa49@wolfvision.net>
        <Y4TAF1hn0l1CziUh@smile.fi.intel.com>
        <b56cdcf1-459b-63a2-a060-49564e11ce9f@wolfvision.net>
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

On Mon, 28 Nov 2022 15:26:51 +0100
Michael Riesch <michael.riesch@wolfvision.net> wrote:

> Hi Andy,
> 
> On 11/28/22 15:05, Andy Shevchenko wrote:
> > On Mon, Nov 28, 2022 at 02:48:48PM +0100, Michael Riesch wrote:  
> >> On 11/28/22 14:27, Andy Shevchenko wrote:  
> >>> On Mon, Nov 28, 2022 at 01:18:04PM +0100, Gerald Loacker wrote:  
> >>>> Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:  
> > 
> > ...
> >   
> >>> It's a rule to use _t for typedef:s in the kernel. That's why
> >>> I suggested to leave struct definition and only typedef the same structures
> >>> (existing) to new names (if needed).  
> >>
> >> Andy, excuse our ignorance but we are not sure how this typedef approach
> >> is supposed to look like...
> >>  
> >>>> or  
> >>>  
> >>>> 	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;  
> >>
> >> ... because
> >>
> >> #include <stdio.h>
> >>
> >> struct iio_val_int_plus_micro {
> >> 	int integer;
> >> 	int micro;
> >> };
> >>
> >> typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;
> >>
> >> int main()
> >> {
> >>   struct iio_val_int_plus_micro a = { .integer = 100, .micro = 10, };
> >>   struct iio_val_int_plus_micro_db b = { .integer = 20, .micro = 10, };
> >>   return 0;
> >> }
> >>
> >> won't compile.  
> > 
> > I see. Thanks for pointing this out.
> > 
> > Then the question is why do we need the two same structures with different
> > names?  
> 
> Most probably we don't need "struct iio_val_int_plus_micro_db" at all
> since IIO_VAL_INT_PLUS_MICRO_DB and IIO_VAL_INT_PLUS_MICRO get the same
> treatment in industrialio-core.c. At least it should not be introduced
> in the scope of this series. In the end this is up to whoever writes the
> first driver using the common data structures and IIO_VAL_INT_PLUS_MICRO_DB.

They get same treatment today because we don't attempt to deal with
IIO_VAL_INT_PLUS_MICRO_DB in conjunction with any of the analog circuit type
front ends yet. Mind you, even though the handling in iio-rescale.c will be
different if anyone ever adds support for the DB form (I shudder at the maths
of combining this with other scale factors), I don't see the possibility meaning
we need a different structure.  

Jonathan


> 
> Best regards,
> Michael
> 

