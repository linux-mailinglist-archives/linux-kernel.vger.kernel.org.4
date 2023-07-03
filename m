Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551B745464
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGCEIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGCEIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:08:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C71180;
        Sun,  2 Jul 2023 21:08:15 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 363480Or021269;
        Mon, 3 Jul 2023 06:08:00 +0200
Date:   Mon, 3 Jul 2023 06:08:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE
 handling
Message-ID: <ZKJJoK4kyOCEYcOR@1wt.eu>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <2023063022-retouch-kerosene-7e4a@gregkh>
 <202306301114.E199B136@keescook>
 <2023070213-capacity-moneybags-3668@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070213-capacity-moneybags-3668@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 02:39:49PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 30, 2023 at 11:18:37AM -0700, Kees Cook wrote:
> > On Fri, Jun 30, 2023 at 09:14:21AM +0200, Greg Kroah-Hartman wrote:
> > > The kernel security team does NOT assign CVEs, so document that properly
> > > and provide the "if you want one, ask MITRE for it" response that we
> > > give on a weekly basis in the document, so we don't have to constantly
> > > say it to everyone who asks.
> > > 
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  Documentation/process/security-bugs.rst | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> > > index f12ac2316ce7..8b80e1eb7d79 100644
> > > --- a/Documentation/process/security-bugs.rst
> > > +++ b/Documentation/process/security-bugs.rst
> > > @@ -79,13 +79,10 @@ not contribute to actually fixing any potential security problems.
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
> > > +The security team does not assign CVEs, nor do we require them for
> > > +reports or fixes, as this can needlessly complicate the process and may
> > > +delay the bug handling.  If a reporter wishes to have a CVE identifier
> > > +assigned, they should contact MITRE directly.
> > 
> > Hmm. The language about "assigned ahead of public disclosure" was added
> > intentionally due to trouble we'd had with coordination when a CVE was
> > needed, etc. Additionally, it IS preferred to have a CVE in a patch when
> > it IS known ahead of time, so I think that should be kept. How about
> > this:
> > 
> > 
> > diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> > index 82e29837d589..2f4060d49b31 100644
> > --- a/Documentation/process/security-bugs.rst
> > +++ b/Documentation/process/security-bugs.rst
> > @@ -81,13 +81,12 @@ the email Subject line with "[vs]" as described in the linux-distros wiki:
> >  CVE assignment
> >  --------------
> >  
> > -The security team does not normally assign CVEs, nor do we require them
> > -for reports or fixes, as this can needlessly complicate the process and
> > -may delay the bug handling. If a reporter wishes to have a CVE identifier
> > -assigned ahead of public disclosure, they will need to contact the private
> > -linux-distros list, described above. When such a CVE identifier is known
> > -before a patch is provided, it is desirable to mention it in the commit
> > -message if the reporter agrees.
> > +The security team does not assign CVEs, nor do we require them for reports
> > +or fixes, as this can needlessly complicate the process and may delay
> > +the bug handling. If a reporter wishes to have a CVE identifier assigned
> > +ahead of public disclosure, they will need to contact MITRE directly.
> > +When such a CVE identifier is known before a patch is provided, it is
> > +desirable to mention it in the commit message if the reporter agrees.
> 
> I can not, in good faith, with the current mess that MITRE is going
> through, tell anyone that they should contact MITRE ahead of public
> disclosure, sorry.
> 
> All I can say is "if you really want one, go ask them for one", as
> everyone keeps asking us for one to pad their resume/CV.
> 
> Also note that many non-US-based companies are not allowed to contact a
> US-government-backed entity for potential security issues for obvious
> reasons.
> 
> So I don't want to even give a hint that we support or request this at
> all, or that it is something that changelog texts should contain for
> security issues (for the obvious reason of them being a "hint" one way
> or another.)
> 
> External groups may wish to play the CVE "game" as it facilitates their
> engineering procedures to get changes past managers, but that's not
> anything that we should be encouraging at all for all of the various
> geopolitical and corporate reasons involved in that mess.

I generally agree with your points above, and these can be easily
summarized by indicating that the patch will not wait for this, and
suggesting that MITRE is not the only possible source:

  The security team does not assign CVEs, nor do we require them for
  reports or fixes, as this can needlessly complicate the process and may
  delay the bug handling.  If a reporter wishes to have a CVE identifier
  assigned, they should find one by themselves, for example by contacting
  MITRE directly.  However under no circumstances will a patch inclusion
  be delayed to wait for a CVE identifier to arrive.

This puts the responsibility for finding one in time on the reporter
depending on what they expect, and if they want it in the commit
message, they'd rather have one before reporting the problem.

Willy
