Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAB574632E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGCTHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGCTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7BAF;
        Mon,  3 Jul 2023 12:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A04560F1D;
        Mon,  3 Jul 2023 19:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8880EC433C8;
        Mon,  3 Jul 2023 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688411241;
        bh=Kd7EHdh7ZgDRJ7WngoJ1HViLWXS7NRXYd7wLjSFpoDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsnGCgJQMYIKo8o81WtnAGPizAR+Ssu3mbkrGltLSAPGEpIkz+btrmQqziqsRCkYb
         RtUisuqx2+n4H0kjyKxRdsXpYk48DT9vHRoT+YVmWL+aanf7R52W8ORcW2yvVzzbMg
         52hNo6VBqIwtF250kVDjy7L+4H1DU7Tz37gcXLCg=
Date:   Mon, 3 Jul 2023 21:05:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE
 handling
Message-ID: <2023070329-mangy-dipping-2ebd@gregkh>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <2023063022-retouch-kerosene-7e4a@gregkh>
 <202306301114.E199B136@keescook>
 <2023070213-capacity-moneybags-3668@gregkh>
 <ZKJJoK4kyOCEYcOR@1wt.eu>
 <2023070335-groggily-catfish-9ad5@gregkh>
 <202307031131.51907BC65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307031131.51907BC65@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:35:37AM -0700, Kees Cook wrote:
> On Mon, Jul 03, 2023 at 05:00:15PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 03, 2023 at 06:08:00AM +0200, Willy Tarreau wrote:
> > >   The security team does not assign CVEs, nor do we require them for
> > >   reports or fixes, as this can needlessly complicate the process and may
> > >   delay the bug handling.  If a reporter wishes to have a CVE identifier
> > >   assigned, they should find one by themselves, for example by contacting
> > >   MITRE directly.  However under no circumstances will a patch inclusion
> > >   be delayed to wait for a CVE identifier to arrive.
> > > 
> > > This puts the responsibility for finding one in time on the reporter
> > > depending on what they expect, and if they want it in the commit
> > > message, they'd rather have one before reporting the problem.
> > 
> > Oh, nice wording, let me steal that!  :)
> 
> Yeah, this is good. The last sentence is a little hard to parse, so how
> about this, with a little more rationale expansion:
> 
> However under no circumstances will patch publication be delayed for
> CVE identifier assignment. Getting fixes landed takes precedence; the
> CVE database entry will already reference the commit, so there is no loss
> of information if the CVE is assigned later.

"simple is better" should be the key here, reading a wall of text is
hard for people, so let me just keep the one new sentance that Willy
proposed and if people still struggle with the whole CVEs and
security@k.o mess in the future, we can revise it again.

Also, there is not really a "CVE database", I think that's what NVD from
NIST does and CNNVD from China does, and "Something to be named in the
future soon" will do for the EU.  There is a "CVE List" at cve.org, but
that thing is always out of date, and for all of this I don't want to
have to try to explain it in our document as that's nothing we want to
mess with :)

thanks,

greg k-h
