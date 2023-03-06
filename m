Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF16AC1F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCFNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCFNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:55:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C4302A8;
        Mon,  6 Mar 2023 05:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7748960FAD;
        Mon,  6 Mar 2023 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F82C433D2;
        Mon,  6 Mar 2023 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678110947;
        bh=Wf4YQcAC+Jm2I9CCfuzkob0ucL7kvHPm83R8Iaznm8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuyLkf5yicVsPrxdH6BBpJtx21GCkr2kM9jvYsm49qC+t0Wv/VdcE5bwiE1Mj5BIk
         lHJL4JU8eg+k4Fu4EvFLDXMZvSeLRYP0PtDmd8dX91jLWABkaMbeszEGodJZkXoFqU
         pd4MeNC3WaumonqsEqRgM2KvALN2/rQozOZZsRAE=
Date:   Mon, 6 Mar 2023 14:55:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
Message-ID: <ZAXw4EHQldOi35gJ@kroah.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <88b8ed4babd8c2d00ff4a4d8876378ba@milecki.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88b8ed4babd8c2d00ff4a4d8876378ba@milecki.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:54:10PM +0100, Rafał Miłecki wrote:
> On 2023-03-01 16:22, Miquel Raynal wrote:
> > The base series on which these changes apply is still contained in [1],
> > I would prefer to keep it as it was and apply this series on top of it.
> > 
> > (...)
> > 
> > [1] https://github.com/miquelraynal/linux/tree/nvmem-next/layouts
> 
> My experience with kernel development over all subsystems I touched is
> that patches should be improved until being clean & acceptable. I never
> sent a series with more recent patches fixing issues in earlier patches
> of the same seriee.
> 
> So my preference would be to get a new, clean & complete set of patches.

I agree, don't break something and then fix it up in a later patch, that
makes bisection impossible.

thanks,

greg k-h
