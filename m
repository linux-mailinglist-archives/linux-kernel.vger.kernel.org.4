Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54DA679327
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjAXIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:32:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3E10D4;
        Tue, 24 Jan 2023 00:32:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B8961220;
        Tue, 24 Jan 2023 08:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C0C433D2;
        Tue, 24 Jan 2023 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674549161;
        bh=rIDsMgNqHZEK4RnqoXuGpWAZUP6dPkDNloRyfeqXo1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6sh26le2asB0FDFaq5hZrzqRzMQUqvPtNypdwxMhaFSVoXKRfHlWpYkXbSGjOiGs
         wnaUtLOo1WoPLe41JpfKH5kneTndB+1YBaCx7j0PTMlqbBXHATayeyoJs4vS8MJcSJ
         K7FLmjbiznezc8Be927FDsugjd+cJwYYlWYGd9ttogMbhIlyw3MPM3WIqxFv3N9aYf
         +j95imY4P5HVG3KTIeX0OmvEFy5nJwmzRO1q5QAPxVt6ZVEXnVNxSayVun0CWXWr+d
         llB24Qx9Lq95GQmcwapf5CGVD4e/nRkAZmvcqFQ1Wgr3XBAvVjo/thj7/yle5oRHaD
         JFMdg0nLoBlow==
Date:   Tue, 24 Jan 2023 09:32:35 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Message-ID: <20230124083235.6fhvnjgl4bzuzwuq@wittgenstein>
References: <20230124085951.59eb8da3@canb.auug.org.au>
 <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
 <20230124102535.1e21a533@canb.auug.org.au>
 <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
 <20230124110745.5c9b78b0@oak.ozlabs.ibm.com>
 <8871d62a-b87f-75d6-fb5d-d9811a3e5dae@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8871d62a-b87f-75d6-fb5d-d9811a3e5dae@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:11:47AM +0900, Damien Le Moal wrote:
> On 1/24/23 09:07, Stephen Rothwell wrote:
> > Hi Damien,
> > 
> > On Tue, 24 Jan 2023 08:30:29 +0900 Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> OK. I think I will merge the 3 patches that create the conflict and rebase
> >> the patches. I need that for retesting at least. But given the size of the
> >> conflict resolution, I may push that as an update to my for-6.3/for-next
> >> branch. Let me see...
> >>
> >>> Alternatively, just leave the fix up to Linus (but mention it to him
> >>> when you send your pull requests).  
> >>
> >> Understood. Let me retest first :)
> > 
> > When I said "merge", I meant literally "git merge <some stable branch
> > from the vfs-mapping tree that contains the conflicting commit>" not
> > cherry pick the commits i.e. you would need to coordinate with
> > Christian about having a common branch (or making sure that the part of
> > his tree you pull in is immutable).
> 
> Yep, cherry picking did not work :)
> I did a merge test and came up with the same resolution as you did. It
> looks good. It looks big but is in fact fairly simple. I will keep it as
> is and signal it to Linus when I send my PR.

I don't rebase branches after they're in -next as soon as someone
wants to depend on them.

> 
> But retesting everything to be sure there are no issues.
> 
> Christian,
> 
> Next time, when you touch an fs, please cc the maintainer for acks. I had
> that zonefs series ready for a while and we could have coordinated for the
> conflict...

I understand merge conflicts aren't pleasant as I'm dealing with them on
a regular basis myself and I'm sorry that this is causing churn for you.

Similar to other large branches such as the initial folio conversion
that affected a lot of filesystems and other branches of mine it simply
becomes impractical to generate a massive recipients list.

All filesystems were touched in non-semantical ways and simply replace a
vfs type.

One of linux-next's tasks is to find generated merge conflicts so that
we can coordinate. As usual, I will send a list of merge conflicts
caused by one of our branches to Linus and point him to the relevant
threads that Steven reported with proposed resolutions as he prefers to
fix them up himself.

Sorry for the inconvenience.
