Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27568AE41
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 05:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBEE1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 23:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEE1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 23:27:34 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532741A976
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675571236; bh=Bl3q9N96wskCK4mlPCCWGLIDevGsFJBvIxE8otxLPyc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=mqAUWP3Vq83B/s+cz7pqA0E1CEFHBq3lLhpmah1hqZB4Lnaro/WMK2r6UwbEWJqw+
         Y0xiZsgFc9lBlZDxRTKo3hhxs65xcm42NXYRn6SPDq+Dlwx8qZBgL84aVwwy3/mOhY
         xu9hdAXJm8CHI4ghyTyOH7YFuC7iHeRBvCFUT9pM=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  5 Feb 2023 05:27:16 +0100 (CET)
X-EA-Auth: AWysFKhs5B5sJV9Z/cSZOLf4Q+9zyxF8r/uMuEGLDZZX9lUcDhMCbpqMEYqSNmTEXtQJcoraCn4AQiE6ac9TyPB6sE6JVbPJ
Date:   Sun, 5 Feb 2023 09:57:10 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Regarding checkpatch camelcase issues
Message-ID: <Y98wHhGMY1eSaWG1@ubun2204.myguest.virtualbox.org>
References: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
 <Y94L+WNGGfvrg6Mg@debian.me>
 <Y97uUeB6OfO469SY@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y97uUeB6OfO469SY@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 12:46:25AM +0100, Guru Mehar Rachaputi wrote:
> On Sat, Feb 04, 2023 at 02:40:41PM +0700, Bagas Sanjaya wrote:
> > On Sat, Feb 04, 2023 at 05:25:38AM +0100, Guru Mehar Rachaputi wrote:
> > > Thanks for your support.
> > > 
> > > I wanted to confirm if each checkpatch encounter for camelcase issue should
> > > be fixed in a new patch?
> > > 
> > > For example: If the issue is with same variable, then multiple
> > > modifications can be made in one patch.
> > > 
> > >   -> above example is OK
> > > 
> > > 
> > > For example: If the issue is with multiple variables, then multiple
> > > modifications can be made in one patch.
> > > 
> > >   -> above example is NOT OK / NG
> > > 
> > > 
> > > Please confirm me if my understanding is correct?
> > > 
> > 
> > I guess you have generated a patch series, then check it through
> > checkpatch.
> > 
> > Indeed, if checkpatch complains at a particular patch, you need to do
> > interactive rebase. Make sure that rebase todo list contains "edit"
> > lines on commit you want to fix up. After that, fix these complaints.
> > 
> > When you're done, regenerate the patch series and make sure that there
> > are no checkpatch complains on it.
> > 
> > Thanks.
> > 
> > -- 
> > An old man doll... just what I always wanted! - Clara
> 
> Thanks for the reply
> I guess I was not clear. When I run checkpatch on a driver there
> were so many camelcase issues in each file. So I wanted to know if I
> proceed to fix them, should I submit each change as a patch or each file
> as a patch?
> Since each file has many camelcase issue and the driver has morethan one
> such file.

Hi Guru,
You can look at similar change proposals from other developers here[1]. That should help
you understand how it was done previously. This resource is very useful to
determine if the change you are proposing was already submit by another
developer and the feedback on it. In general, it is a great resource to learn.

You should also look at the guidelines on how to design your patch, number of
changes, when to use a patch set etc at this location[2]. This page has more
additional links to resources that are useful to understand how to submit
patches. Check these links [3] & [4].


[1] https://lore.kernel.org/?q=&a=search+all+inboxes
[2] https://kernelnewbies.org/Outreachyfirstpatch
[3] https://kernelnewbies.org/PatchPhilosophy
[4] https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst

Hope this helps.

Regards,
deepak

> 
> -- 
> Thanks & Regards,
> Guru
> 


