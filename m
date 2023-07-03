Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D1745F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGCPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGCPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB4E41;
        Mon,  3 Jul 2023 08:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA1160F58;
        Mon,  3 Jul 2023 15:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FFC433C7;
        Mon,  3 Jul 2023 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688396429;
        bh=lIdqQ67i0FMsC0cUxCJ5AfsUJuPaQdWJi5CbAOYuFN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqQaODny3PFiok3uuUGZ6RZMrVppXRyHc0EQzS5vSky8C1535Ew23fb+VpDMsh2R7
         5G/6V33iXSD8GKWOU6nSjt58XiHiRJEMJbTMC22aAfAnFPfltISAUNDBXp2f41ebzV
         oXxIdeuZvhu1IP9Wo5ArwWXnq2rsDUVMmG3METKA=
Date:   Mon, 3 Jul 2023 17:00:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE
 handling
Message-ID: <2023070335-groggily-catfish-9ad5@gregkh>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <2023063022-retouch-kerosene-7e4a@gregkh>
 <202306301114.E199B136@keescook>
 <2023070213-capacity-moneybags-3668@gregkh>
 <ZKJJoK4kyOCEYcOR@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKJJoK4kyOCEYcOR@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:08:00AM +0200, Willy Tarreau wrote:
> On Sun, Jul 02, 2023 at 02:39:49PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 30, 2023 at 11:18:37AM -0700, Kees Cook wrote:
> > > On Fri, Jun 30, 2023 at 09:14:21AM +0200, Greg Kroah-Hartman wrote:
> > > > The kernel security team does NOT assign CVEs, so document that properly
> > > > and provide the "if you want one, ask MITRE for it" response that we
> > > > give on a weekly basis in the document, so we don't have to constantly
> > > > say it to everyone who asks.
> > > > 
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  Documentation/process/security-bugs.rst | 11 ++++-------
> > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> > > > index f12ac2316ce7..8b80e1eb7d79 100644
> > > > --- a/Documentation/process/security-bugs.rst
> > > > +++ b/Documentation/process/security-bugs.rst
> > > > @@ -79,13 +79,10 @@ not contribute to actually fixing any potential security problems.
> > > >  CVE assignment
> > > >  --------------
> > > >  
> > > > -The security team does not normally assign CVEs, nor do we require them
> > > > -for reports or fixes, as this can needlessly complicate the process and
> > > > -may delay the bug handling. If a reporter wishes to have a CVE identifier
> > > > -assigned ahead of public disclosure, they will need to contact the private
> > > > -linux-distros list, described above. When such a CVE identifier is known
> > > > -before a patch is provided, it is desirable to mention it in the commit
> > > > -message if the reporter agrees.
> > > > +The security team does not assign CVEs, nor do we require them for
> > > > +reports or fixes, as this can needlessly complicate the process and may
> > > > +delay the bug handling.  If a reporter wishes to have a CVE identifier
> > > > +assigned, they should contact MITRE directly.
> > > 
> > > Hmm. The language about "assigned ahead of public disclosure" was added
> > > intentionally due to trouble we'd had with coordination when a CVE was
> > > needed, etc. Additionally, it IS preferred to have a CVE in a patch when
> > > it IS known ahead of time, so I think that should be kept. How about
> > > this:
> > > 
> > > 
> > > diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> > > index 82e29837d589..2f4060d49b31 100644
> > > --- a/Documentation/process/security-bugs.rst
> > > +++ b/Documentation/process/security-bugs.rst
> > > @@ -81,13 +81,12 @@ the email Subject line with "[vs]" as described in the linux-distros wiki:
> > >  CVE assignment
> > >  --------------
> > >  
> > > -The security team does not normally assign CVEs, nor do we require them
> > > -for reports or fixes, as this can needlessly complicate the process and
> > > -may delay the bug handling. If a reporter wishes to have a CVE identifier
> > > -assigned ahead of public disclosure, they will need to contact the private
> > > -linux-distros list, described above. When such a CVE identifier is known
> > > -before a patch is provided, it is desirable to mention it in the commit
> > > -message if the reporter agrees.
> > > +The security team does not assign CVEs, nor do we require them for reports
> > > +or fixes, as this can needlessly complicate the process and may delay
> > > +the bug handling. If a reporter wishes to have a CVE identifier assigned
> > > +ahead of public disclosure, they will need to contact MITRE directly.
> > > +When such a CVE identifier is known before a patch is provided, it is
> > > +desirable to mention it in the commit message if the reporter agrees.
> > 
> > I can not, in good faith, with the current mess that MITRE is going
> > through, tell anyone that they should contact MITRE ahead of public
> > disclosure, sorry.
> > 
> > All I can say is "if you really want one, go ask them for one", as
> > everyone keeps asking us for one to pad their resume/CV.
> > 
> > Also note that many non-US-based companies are not allowed to contact a
> > US-government-backed entity for potential security issues for obvious
> > reasons.
> > 
> > So I don't want to even give a hint that we support or request this at
> > all, or that it is something that changelog texts should contain for
> > security issues (for the obvious reason of them being a "hint" one way
> > or another.)
> > 
> > External groups may wish to play the CVE "game" as it facilitates their
> > engineering procedures to get changes past managers, but that's not
> > anything that we should be encouraging at all for all of the various
> > geopolitical and corporate reasons involved in that mess.
> 
> I generally agree with your points above, and these can be easily
> summarized by indicating that the patch will not wait for this, and
> suggesting that MITRE is not the only possible source:
> 
>   The security team does not assign CVEs, nor do we require them for
>   reports or fixes, as this can needlessly complicate the process and may
>   delay the bug handling.  If a reporter wishes to have a CVE identifier
>   assigned, they should find one by themselves, for example by contacting
>   MITRE directly.  However under no circumstances will a patch inclusion
>   be delayed to wait for a CVE identifier to arrive.
> 
> This puts the responsibility for finding one in time on the reporter
> depending on what they expect, and if they want it in the commit
> message, they'd rather have one before reporting the problem.

Oh, nice wording, let me steal that!  :)

thanks,

greg k-h
