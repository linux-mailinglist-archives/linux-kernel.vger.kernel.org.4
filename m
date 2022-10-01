Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C55F18AA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 04:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiJAChn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 22:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiJAChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 22:37:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB851ABFE0;
        Fri, 30 Sep 2022 19:37:38 -0700 (PDT)
Received: from letrec.thunk.org ([50.224.35.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2912bLTR006816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 22:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664591844; bh=z0peX8Psl4TmqPUIRkl+yYsD2eDEDDU+Gc3/CwEQoCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nkAMdpLgdd/kjwKRNPZZ4rDWnZOT3Xg/QneaPaV2prt3yud4by6XfluDS8sDs2Wil
         2dTfSibVzPJHf52XcowMcne7o/mkfhqKHFpc/QUHsLRzIb5OnsMznCKLbBYnwbBlwp
         bJNtFVzteXcYo/jQaF9Ja3YVCE+zxkJgqt0Z8T/PzvoLUIQRqcrEux0BoP+ZMN3jre
         C+VIrbJLXeST/nR7oD2ZDLY65BPN5MoCJTC4ATVJbDPICq6UcEoztxhsceYEqlostp
         HiLxs+XEZe8qCkCbJp5b9uEoSeEfhOckg0OhgSZ5abvoDh4gF8D7OdfEajRoaYnn20
         FD2eIdUM7CPvw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7BAE38C2AB5; Fri, 30 Sep 2022 22:37:21 -0400 (EDT)
Date:   Fri, 30 Sep 2022 22:37:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@leemhuis.info
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate
 supporters should be mailed
Message-ID: <Yzen4X1Na0MKXHs9@mit.edu>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 05:18:52PM +0100, Bryan O'Donoghue wrote:
> > So the root cause of your confusion was you couldn't figure out
> > the fact that "supporter" in the output of get_maintainver.pl means
> > "maintainer of a supported subsystem", wasn't it?
> > 
> > I guess all you need would be just a short notice along the lines of:
> > 
> >      "supporter" in the output from get_maintainer.pl means "maintainer
> >      of a supported subsystem".
> > 
> > No?
> 
> We discussed that a bit earlier.
> 
> https://lore.kernel.org/lkml/20220928003006.230103-1-bryan.odonoghue@linaro.org/T/#u
> https://lkml.org/lkml/2022/9/28/1394
> https://lkml.org/lkml/2022/9/28/1511
> https://lkml.org/lkml/2022/9/29/188
> 
> I think its fair to say the consensus so far is to leave the
> get_maintainer.pl output as is.


FWIW, I actually think the output of get_maintainer.pl is pretty
broken in this regard.  (Then again, I've never thought all that
highly of get_maintainer.pl, *especially* because of the bogus git
fallback, but that's another story.)

Consider:

% ./scripts/get_maintainer.pl --file  drivers/acpi/power.c
"Rafael J. Wysocki" <rafael@kernel.org> (supporter:ACPI)
Len Brown <lenb@kernel.org> (reviewer:ACPI)
linux-acpi@vger.kernel.org (open list:ACPI)
linux-kernel@vger.kernel.org (open list)

I'm sorry, but that's just *wrong*.  Rafael is the *maintainer* of the
ACPI subsystem, and the term "supporter" is rarely if ever used
anywhere in our docs.  As I said earlier, trying to treat S: field to
say anything about the entitles listed under the M: field of the
Maintainers file is a category error.

Consider: ACPI subsystem is is "supported".  From a user's
perspective, what are they supposed to take from that?  That the ACPI
subsystem is somehow better supported than say, the MM subsystem
(which is only "maintained"), or all of Linux networking, which is
also "maintained".  And so Rafel is a "supporter", but David Miller
and Andrew Morton are "maintainers", respectively. ?!?

I think the original rationale behind the S: field is to help people
understand, in particular for device drivers, how solid a particular
device driver might be.  Was it officially supported by the hardware
manufacturer?  Was it supported by a some random student who hacked
something together?  Was the still being actively maintained?  But
even then, just because a driver is "officially" supported by the
hardware manufacturer doesn't necessarily mean that it is any more
reliable, or high quality, than something which is being supported by
someone who supposedly isn't getting paid to support it.  (And there
are plenty of subsystems listed as "maintained" where the people
listed under M: are most certainly getting paid to work on it.)

       	     	    	 	   	   - Ted
