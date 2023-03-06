Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5D6AB852
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCFIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCFIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:31:38 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1B20695
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1678091484; bh=Z19aTZpc2+qXkbvxrT61U2B6qSK+x6gCTrJeS9vjx4s=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=UWJOFNw3hDEUTy5Sm5Ix8pibMT/qB88tq1g3w7yNHQe/uxR78njM4MoX+cLafbFk7
         VZ95rTDWpsPrLlkXVZY+h4dZUstVnuewwoa2wj8WtFK3SfMx4cUX3TiZtqDP4uEFzm
         8Po0oaos4UqNkY3fMNTZA1aeM7GTJe9UrW2iRkzU=
Received: by b221-5.in.mailobj.net [192.168.90.25] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Mon,  6 Mar 2023 09:31:24 +0100 (CET)
X-EA-Auth: UiJYxm9oWcsUCfEOM2Sqn5R+/Jsc6BXXj7fAwVUjLeyP1HR1f4NwXnuKrPKQYZa6q4k8XpgRwxP9qCvBIPc2fJZ0rhwiyaoP
Date:   Mon, 6 Mar 2023 14:01:10 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <ZAWkzuCF9GaqnnaJ@ubun2204.myguest.virtualbox.org>
References: <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
 <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
 <ZAVxo6WHGu3kO1nl@combine-ThinkPad-S1-Yoga>
 <ZAV7xvr3BCqByjy6@ubun2204.myguest.virtualbox.org>
 <ZAWAyyNt0rgrpA1l@combine-ThinkPad-S1-Yoga>
 <ZAWPk12Fz0gxaqzB@ubun2204.myguest.virtualbox.org>
 <ZAWa5NpBHrPhaNWA@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWa5NpBHrPhaNWA@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:48:52AM +0100, Guru Mehar Rachaputi wrote:
> On Mon, Mar 06, 2023 at 12:30:35PM +0530, Deepak R Varma wrote:
> > On Mon, Mar 06, 2023 at 06:57:31AM +0100, Guru Mehar Rachaputi wrote:
> > > On Mon, Mar 06, 2023 at 11:06:06AM +0530, Deepak R Varma wrote:
> > > > On Mon, Mar 06, 2023 at 05:52:51AM +0100, Guru Mehar Rachaputi wrote:
> > > > > On Tue, Feb 07, 2023 at 01:49:15PM +0530, Deepak R Varma wrote:
> > > > > 
> > > > > Hej Deepak,
> > > > > 
> > > > > I have a problem in sending patchset through mutt.
> > > > > I have been trying sending to my own mail address but it won't work.
> > > > 
> > > > This could be because of mutt configuration. There are some additional checks if
> > > > you are trying to use mutt with gmail. Search over google or lore old posts to
> > > > know more about it. The important aspect is to configure and test mutt well
> > > > before you use it for sending out patches.
> > > > 
> > > > > 
> > > > > When sending patchset I think we should use "In-Reply-To" flag and
> > > > > include "Message-ID" to which we want this to be in series to. I tried
> > > > > both "git send-email" feature and mutt "forwarding feature".
> > > > 
> > > > I have not used "git send-email", so can't help you there. But mutt has worked
> > > > very well for me. Ensure you are reading and following the instructions from
> > > > this page well: https://kernelnewbies.org/Outreachyfirstpatch
> > > >
> > > 
> > > So for example from these patches: 0.patch, 1.patch
> > > how to use "mutt -H" to send patches in one thread?
> > > 
> > > if first one is: mutt -H 0.patch
> > > then should second one be: mutt -H 1.patch In-Reply-To: Message-ID?
> > 
> > Try this out by sending to yourself and you will know :)
> > 
> > There is a section "Using git format-patch to send patchsets" in the link I sent
> > in my last email. Please read that.
> > 
> > Deepak.
> >
> 
> I tried it and it won't work.
> My question itself was how to use mutt to send patchset? which is not
> clear on the site.
> 
> I have no problem in sending one single patch through mutt.
> 
> To be more clear:
> https://lore.kernel.org/lkml/cover.1666299151.git.drv@mailo.com/
> at above link, you submitted patchset.
> 
> How to send this series using mutt?
> If I use "mutt -H x.patch" for every patch file they are seperate emails
> in my inbox.

The following command creates cover letter and patches as a threads

git format-patch -o /tmp/ --cover-letter -n --thread=shallow commitIDx^..commitIDy

Send cover-letter and patches with mutt -H XXXXX command

Note: Cover letter us optional. If you do not have one, the patches will still
be threaded.

HTH
Deepak.




> 
> > > 
> > > 
> > > > > 
> > > > > Another issue is, how to attach patch file from inside mutt(for example: 
> > > > > "mutt -H x.patch" from command line is used to extract header and body of a 
> > > > > mail in mutt)?
> > > > 
> > > > Why do you want to do that?
> > > > Build a patch file using "git format-patch" and then use "mutt -H" to send the
> > > > patch. Both the commands work directly from the command line. If there is a need 
> > > > for any additional attachments in support of your patch [configs, logs, trace as
> > > > evidence, test outcomes etc], you can attach those from within the "mutt -H"
> > > > execution context.
> > > > 
> > > > I suggest testing mutt well before you start sending any patches out by sending
> > > > the patches to yourself. Do not use any kernel mailing list for testing.
> > > > 
> > > > 
> > > > Regards,
> > > > Deepak.
> > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Thanks & Regards,
> > > > > Guru
> > > > > 
> > > > 
> > > > 
> > > 
> > > -- 
> > > Thanks & Regards,
> > > Guru
> > > 
> > 
> > 
> 
> -- 
> Thanks & Regards,
> Guru
> 


