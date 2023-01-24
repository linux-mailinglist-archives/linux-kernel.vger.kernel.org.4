Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D3679EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjAXQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAXQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2026B1;
        Tue, 24 Jan 2023 08:38:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196BF60ADA;
        Tue, 24 Jan 2023 16:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0673BC433D2;
        Tue, 24 Jan 2023 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674578312;
        bh=1fehoiVZxL/sJuvdNIBqzb2g04Po36ejMe8GPiKr1eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSvzufRHRuuZYdhVlkhDRPo1LuFkwMGuQlXMZ/B/qVNE6erVXPSjPUzaMiQ5zeLbX
         onRm5eCNeL7JFvzXbOmD9NT31+YgbbIz66dozfwocuQosvDlOftkCIL/rC/m/dNBMK
         1OCYhptVc39+/SQpM0rFroK5at3HiliFPLS3jZCM=
Date:   Tue, 24 Jan 2023 17:38:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anton Blanchard <anton@linux.ibm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        James Morris <jamorris@linux.microsoft.com>, corbet@lwn.net,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, ndesaulniers@google.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y9AJhe+OjJNwLq7N@kroah.com>
References: <20230123183926.249601-1-mcgrof@kernel.org>
 <Y87X6tFlevIebcc6@kroah.com>
 <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
 <Y89E+S7TA6UwtNe2@casper.infradead.org>
 <Y89qrid7YOsIFbD6@kroah.com>
 <Y9AF1UV/ow7eP92L@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9AF1UV/ow7eP92L@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:22:45AM -0800, Luis Chamberlain wrote:
> On Tue, Jan 24, 2023 at 06:20:46AM +0100, Greg KH wrote:
> > On Tue, Jan 24, 2023 at 02:39:53AM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 23, 2023 at 01:48:03PM -0800, Luis Chamberlain wrote:
> > > > > > @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
> > > > > >    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
> > > > > >    Intel		Tony Luck <tony.luck@intel.com>
> > > > > >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> > > > > > +  Samsung       Javier González <javier.gonz@samsung.com>
> > > > 
> > > > I'll send a fix on v2.
> > > > 
> > > > BTW while at it, it got me wondering, since most of the emails on
> > > > this hw embargo page are not required to have kernel.org accounts
> > > 
> > > This isn't the list of hw embargo people.  This is the list of
> > > "ambassadors" who can help people work through the security disclosure
> > > process.  My impression is that it's to tell me that I should contact
> > > Konrad, since he also works at Oracle, to help me through the process.
> > > It's not for people outside Oracle to contact.
> > > 
> > > If I have the wrong impression of that list, perhaps the description
> > > could be clarified.
> > 
> > That is correct, but it is primarily a list that I use when needing to
> > contact companies about potential issues in their hardware. 
> 
> That is the impression I gathered.
> 
> > For that I
> > don't need a GPG key, that's only required if they need to get added to
> > a secure mailing list, and at that point I can have a key sent to me, it
> > does not have to be in our kernel.org keyring at all (and list
> > participants usually are not there.)
> 
> That might be useful to explain in the documentation.

It is not really needed as the kernel.org gpg keyring has nothing to do
with this list or the people on it.  No need to say "that other thing
over there has nothing to do with this thing here", otherwise we would
be enumerating everything in this file :)

thanks,

greg k-h
