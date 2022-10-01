Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB95F1C4A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJANCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJANCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:02:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF9111150;
        Sat,  1 Oct 2022 06:02:40 -0700 (PDT)
Received: from letrec.thunk.org ([50.224.35.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 291D1llg021372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 09:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664629311; bh=aTfcemBsmicMYZJEDbdCu0TaaFm5a5Gz3rd/I9Vs+78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZtvOJuKC9L2HsHngvjK+hRM4bWaElHOBG8DOlgXmeZlOrN9U7zsikjNJ8sCRY/prZ
         d0kZ8p/DmD5FZYAdtMA5/9Ll28RQklxOhCH438XQkV/3DPc2lG3ykqaJCl8XIMVd3w
         RTE4NnZsreuRuvOf57wxCgy6TqZVRohTGAx1xrDJhlzc1xDjYdcxG1yY0FHEAYnFdD
         FRzGBCjibb57bAks0vCtg9cOFoW7Oh+Hou+ypJtNq4CFXb7nJqS5E1spf3rY8fboQt
         u30P7CNZMw1/tuQxckTo/aOpRWBZK/11Y6EWQbmzAkQ41En/MkRZv4eQw9vQqkbOj1
         9cE5gpMwJd5BQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 8F3DA8C2AB4; Sat,  1 Oct 2022 09:01:47 -0400 (EDT)
Date:   Sat, 1 Oct 2022 09:01:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <Yzg6O5BQUAYpj+bH@mit.edu>
References: <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
 <YzcdnnjJA4M09dNH@pendragon.ideasonboard.com>
 <YzeVVV+nPaxsqS0V@mit.edu>
 <Yzfy5wXuU0uxdIqr@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzfy5wXuU0uxdIqr@debian.me>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 02:57:27PM +0700, Bagas Sanjaya wrote:
> > Funny thing.  I've largely given up on getting any kind of useful bug
> > report from Launchpad, so I've largely ignored it.  In contast, the
> > bug reports I get for e2fsprogs from Debian are generally far more
> > actionable, with bug reports that have all of the data so I can
> > actually root cause the problem, and help the user.
> 
> So no matter how the bug tracker interface is, the etiquette is:
> Whenever something buggy happens, try to gather all information related
> to that event (reproduction steps and reproducer, logs, crash dumps,
> etc), then file the polished report. From your experience, it seems like
> Debian people knows it.

Another critical part of the bug tracker etiquette is when in doubt,
always file a separate bug report.  More than once, both with
Launchpad or Kernel Bugzilla, users will do a web search for "my file
system lost data" or "EXT4-fs error" and assume it's the same problem
as what they are seeing.

In some cases, for a bug report that is years old and already closed.
That's actually less damaging, because it's obviously noise, and it
can be ignored.  The more annoying one is when the bug is actively
being worked, and people dog-pile onto that bug, and the bugs might be
caused by hardware issues (more often than not, a "bug report" is
really due to someone with a failing hard drive, or a USB stick which
is sticking out of the laptop, and gets jostled).  Even it's a real
software bug, if there are two bugs whose bug reports are getting
jumbled together into a single bug tracker web page, it can get
horribly confusing for the poor maintainer being asked to work the
issue, and the two users who start aguing amongst themselves about
their pet theory.

(Another bug reporter etiquette: clearly differenciate between *facts*
that you are reporting, and your pet theories about what might be
going wrong.  If you're so smart that you think you know the problem,
express your theory in the form of a patch.  Otherwise, putting
theories into a bug report which is not backed up by facts is worse
than useless.)

Of course, all of this can happy with bug reports filed by e-mail, or
via the Debian BTS.  However, it seems that people who are smart
enough to figure out how to send e-mail to a vger.kernel.org mailing
list, or how to use Debian's command-line interface "reportbug"
script, generally have enough experience that they can file a decent
bug report.  Whereas people who can only fill in a web page.... tend
not to have that (minimal) filter applied.

					- Ted
