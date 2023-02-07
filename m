Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B968CF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBGG2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBGG2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:28:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F1E07C;
        Mon,  6 Feb 2023 22:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266D8611C2;
        Tue,  7 Feb 2023 06:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D4C433EF;
        Tue,  7 Feb 2023 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675751285;
        bh=q6+JO5SgcW0OGdoQpvaWVdWIHi0K42+g3a4YBgTne9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6ZRXTaAThOfnlQ3usRHWgaU7mLM8FMz4WKGbnYLQ/DWelOqCUUL/8SFq2AxMcQdW
         4fltfxCPrlSIRiI4r1Ju6QdgWybnAITM4teSY42rYgVHwSXoTyb1IqDKYip4LF9/Wx
         yTyPu7IRdiyvKVXDbOEaGnWz6LpMMXIBEfnFdnCM=
Date:   Tue, 7 Feb 2023 07:28:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Message-ID: <Y+HvcqAiH+n8WUkg@kroah.com>
References: <20221206200740.3567551-1-michael@walle.cc>
 <20230103163902.218cb5c7@xps-13>
 <81a5c400-e671-fab3-732a-d615fa4242b3@linaro.org>
 <20230206234713.7cf2f722@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206234713.7cf2f722@xps-13>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:47:13PM +0100, Miquel Raynal wrote:
> Hi Srinivas,
> 
> + Greg
> 
> srinivas.kandagatla@linaro.org wrote on Mon, 6 Feb 2023 20:31:46 +0000:
> 
> > Hi Michael/Miquel,
> > 
> > I had to revert Layout patches due to comments from Greg about Making the layouts as built-in rather than modules, he is not ready to merge them as it is.
> 
> Ok this is the second time I see something similar happening:
> - maintainer or maintainers group doing the review/apply job and
>   sending to "upper" maintainer
> - upper maintainer refusing for a "questionable" reason at this stage.

Only the second time?  You've gotten lucky then :)

This happens all the time based on experience levels of reviewers and
just the very nature of how this whole process works.  It's nothing
unusual and is good overall for the health of the project.  In other
words, this is a a feature, not a bug.

> I am not saying the review is incorrect or anything. I'm just wondering
> whether, for the second time, I am facing a fair situation, either
> myself as a contributor or the intermediate maintainer who's being kind
> of bypassed.
> 
> What I mean is: the review process has happened. Nothing was hidden,
> this series has started leaving on the mailing lists more than two
> years ago. The contribution process which has been in place for many
> years asks the contributors to send new versions when the review
> process leads to comments, which we did. Once the series has been
> "accepted" it is expected that this series will be pulled during the
> next merge window. If there is something else to fix, there are 6 to 8
> long weeks where contributors' fixes are welcome. Why not letting us the
> opportunity to use them? Why, for the second time, I am facing an
> extremely urgent situation where I have to cancel all my commitments
> just because a random comment has been made on a series which has been
> standing still for months?

There's no need to cancel anything, there are no deadlines in kernel
development and I am not asking for any sort of rush whatsoever.

So relax, take a week or two off (or month), and come back with an
updated patch series when you are ready.  And feel free to cc: me on it
if you want my reviews (as I objected to these patches as-is) so that we
don't end up in the same situation (where one maintainer accepted
something, but the maintainer they sent it to rejected it.)

Again, there's no rush, and this is totally normal.

> What I would expect instead, is a discussion on the cover letter of the
> series where Michael explained why he did no choose to use modules in
> the first place. If it appears that for some reason it is best to
> enable NVMEM layouts as modules, we will send a timely series on top
> of the current one to enable that particular case.

Why not rework the existing series to handle this and not require
"fixups" at the end of the series?  We don't normally create bugs and
then fix them up in the same patch set, as you know, so this shouldn't
be treated any differently.

> > >> NVMEM layouts as modules?
> > >> While possible in principle, it doesn't make any sense because the NVMEM
> > >> core can't be compiled as a module. The layouts needs to be available at
> > >> probe time. (That is also the reason why they get registered with
> > >> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> > >> could be modules, too.
> 
> I know Michael is busy after the FOSDEM and so am I, so, Greg, would
> you accept to take the PR as it is, participate to the discussion and
> wait for an update?

Kernel development doesn't work on "PR" :)

And no, I can't take these, as I don't agree with them, and I totally
imagine others will object for the same reason I did (and then they
would object to me, as the patches would be in my tree, as I am then
responsible for them.)

So send an updated version whenever you have the chance.  Again, there's
no rush, deadline, or anything else here.  Code is accepted when it is
ready and correct, not anytime earlier.

thanks,

greg k-h
