Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756E736C93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjFTNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjFTNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:00:16 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA21738;
        Tue, 20 Jun 2023 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687266005;
        bh=uPYhTQCNXIp5UWDBWeIHL9Rq9QjLp2jnc5crHZrG+NE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=aaWhHr3TS2n6LlI8awjXE1EMw/lIEH/2cTqxh6LgJUQSwVuQKESZor7UEdsjhEWfD
         N271fO69C3siNt5phIUkbukWOwLdrqqJQ/vosX+k8ilIeTZ+6irgrmC8ZgstsTr+ZH
         h2KJ2FcyKZGhl96oJ92/HI2F3igtEfEBOmaUr5hE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 796721285D22;
        Tue, 20 Jun 2023 09:00:05 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hu8tV1jzkdA6; Tue, 20 Jun 2023 09:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1687266004;
        bh=uPYhTQCNXIp5UWDBWeIHL9Rq9QjLp2jnc5crHZrG+NE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kEJyMjUzKWi++WdyCSE7pG8RxCEB9AGp62nJ9PXdIlflzMIqejBI8Ft3CQfvPwIxI
         5KdXkBLZt8nlXApDwotTcbofK/WY0N54xaG0tz1LzZLEtlLKevNBqaELLWf3P65tpV
         +vB5iEHs96TwthbhA/Jsji/PWIQG9sR2vLnka66w=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 630301281F03;
        Tue, 20 Jun 2023 09:00:04 -0400 (EDT)
Message-ID: <408fd87a40c4957b2a8298e50db465fa2af43755.camel@HansenPartnership.com>
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Finn Thain <fthain@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 09:00:00 -0400
In-Reply-To: <99b5fc04-798d-a235-c001-fb444e78ada9@linux-m68k.org>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
         <2023061946-latitude-negligent-e4ae@gregkh>
         <99b5fc04-798d-a235-c001-fb444e78ada9@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-20 at 13:48 +1000, Finn Thain wrote:
> 
> On Mon, 19 Jun 2023, Greg Kroah-Hartman wrote:
> 
> > On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> 
> > > @@ -103,7 +103,6 @@ Level 5
> > >  
> > >  * Upstream kernel development is considered a formal job
> > > position, with
> > >    at least a third of the engineer’s time spent doing Upstream
> > > Work.
> > > -* Organizations will actively seek out community member feedback
> > > as a
> > > -  factor in official performance reviews.
> > 
> > Why are you removing this?  I write more performance reviews now
> > than I have have in my life, all for companies that I do NOT work
> > for. That's a good thing as it shows these orginizations value the
> > feedback of the  community as a reflection on how well those
> > employees are doing at their assigned job.  Why are you removing
> > that very valid thing?
> > 
> 
> I'm not preventing that. That's covered by level 4 and my patch only 
> alters level 3 and level 5.
> 
> Bonuses and salaries are tied to performance reviews so the hazard
> here are clear. Level 5 compels companies to seek feedback and
> naturally they will seek it from companies who share their goals. You
> ask too much of  employees if you expect them to put aside the
> corporate agendas and pursue the interests of the wider community.

Actually, I don't think we are.  Part of the mechanical effects of the
open source revolution was to empower employees over employers: it's
the employees who submit the code and are part of the community, not
the employer.  In many ways employees in Open Source become Ambassadors
and Agents for their employers.  There's a big drive in Foundation
driven Corporate Open Source to try to minimize this employee
empowerement effect, but it's there non the less.  A good open source
employee recognizes this, often moves employers keeping the same open
source community roles and tries to find a synergy between corporate
goals and community ones (the best actually alter the corporate goals
to effect this).

> Countless lawsuits over the last few decades made it abundantly clear
> that the goals of companies often diverge from those of the wider
> FLOSS community.

Yes, but with good employee guidance, convergence can be found.  In
many ways community manager positions at companies are about managing
the company goals rather than the community ...

> Consider all of the open source code thrown over the wall, the binary
> blobs, the binary modules, the built-in obsolescence, the devices
> shipped with vulnerabilities now reduced to e-waste because they
> cannot be fixed,  the vendor lock-in strategies, the walled gardens,
> the surveillance etc.

It's employers' money and time if they want to waste it in this
fashion.  Unfortunately theoretical education isn't always the answer
and some entities need a burned hand as a teacher.

> To my jaded mind, it is obvious that such reprehensible strategies
> can be advanced by co-operative employees given inducements from
> colluding companies. My patch won't prevent this sort of behaviour
> but it does remove a directive that would help facilitate it.

Most things in life can be abused.  When stating something like this
we're trying to encourage people to listen to their better angels even
if it risks abuse.


James
