Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8217378D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjFUBuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:50:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3A31728;
        Tue, 20 Jun 2023 18:50:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 97CF9320096B;
        Tue, 20 Jun 2023 21:50:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jun 2023 21:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687312233; x=1687398633; bh=ZgGZAZR8pcors
        v0NqKTzq6EIHsrDfCA+LpCyLAbokVE=; b=qL8iQ7mhyc5OPbgvRtO+ouPf+8S1C
        jVDC1m02274zvr+TfF0noquCwSK3hK2B6Qrdy4FGoYaIJ8ZuquPQTLatemmGuybo
        xHVYnz2slTvyfn/UZG9WsCNLRuEUFWgLCci92OPtsq4Dzer5TXOznxFfCd5Nu6d9
        b1vxUV8l0BXIdKWM2tAaXB9cA2FLSwB27j82ifWQBZucO/akgrlquKFcmDSH6q3X
        h5ezwrD9O5mrXQ6dO/b0igGoYrDPtNHjwdM/VzN7UNdE4ed8KZgc+aqSYzOoAxLq
        HSMptL29brzZL61+Ck4wjglYBtyYOeWtx6sj2gu56eVlwnMDufvcDOZLA==
X-ME-Sender: <xms:aFeSZIMGtfIvvtz_39Sg7um8Dxe1Q2ZpckWdaueN4Q4YWRKxYI4g_A>
    <xme:aFeSZO-Tp90H9bEip33X9dnRV01zfgg-gG1-avO6HZYWOu0_BRSp6nxcQwPjo5AW5
    k9x7moubvaMS6ZwwYY>
X-ME-Received: <xmr:aFeSZPQO94jhAAZc87A63hdodu8I1ZIZmos0jBlSsAi5WqGOpn5_TxO-0A2sf8_ii_yL5JCnXzlGqv6Cxjsm3Y-m1e3oSrf-JCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpefggeeilefhlefhheejjefhjeefudeujefhffetfeeivdduieeltdeludef
    geethfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhoshhmmhdqvgigphhlrghnrg
    htihhonhhsrdhmugdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdroh
    hrgh
X-ME-Proxy: <xmx:aFeSZAsCdO7GwDcgZ7B7Sca74Dof9auMQ6FXk_JYYqrU36Kc0WP-mg>
    <xmx:aFeSZAeFommVLDAnEMNCBLlD7eEklHHDzitdtUuCGg4SMJj7juOwEA>
    <xmx:aFeSZE2KETMGNN8-Q50pteq2LoEzXcONcg_nb9p7F-tyH26tOTlQ4A>
    <xmx:aVeSZFHF3Ll8qkPHqhe70In4V_WvmeT0v1GKUV_3h9exXc7vanjEng>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jun 2023 21:50:29 -0400 (EDT)
Date:   Wed, 21 Jun 2023 11:51:19 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <20230620212502.GI286961@mit.edu>
Message-ID: <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Theodore Ts'o wrote:

> On Tue, Jun 20, 2023 at 01:54:23PM +1000, Finn Thain wrote:
> > 
> > I suspect that counting commits may be the wrong metric (I can think 
> > of better ones).
> 
> As far as whether counting commits is the wrong metric, it doesn't 
> matter if you look at lines of code changes, attendance at conferences 
> such as the Linux Plumbers Conference, or participation on weekly 
> subsystem calls or video conferences, it's fair to say that that the 
> vast majority of those current developers work for companies.
> 

The metric I'd use would be one that considers the benefit to the wider 
community. The proportion of developers who are on a payroll is relevant 
to that -- inasmuchas users are customers.

In general, FLOSS users are not customers because if they could buy what 
they wanted, they would not have to build, modify, integrate or support 
it.

> > But if that's what we have, the lack of commits from non-profit 
> > organizations is a situation that might actually be improved by 
> > changes like the ones I'm advocating.
> 
> Not only have you not provided any evidence for your thesis (which to be 
> fair is hard since what you are positing is a hypothetical), but you 
> haven't even provided a theory why you believe that to be true!
> 

Well, evidence is good. The literature has evidence to support the 
effectiveness of other maturity models when put into practice in an open 
source setting.

Is there evidence to support the notion that your Linux Contributor 
Maturity Model (in its present, unpatched form) will bring the anticipated 
benefits, should companies choose to embrace it (and perhaps replace 
whatever methodologies they presently use)?

The technical projects under the purview of FINOS require a contributor 
license agreement. This has historically been a difficult pill for some 
contributors to swallow, so it's hard to imagine widespread adoption of 
the entire FINOS methodolgy (absent some kind of leverage).

AFAICT, non-profit organizations are not considered by the FINOS 
formulation of an open source maturity model, whereas, the other open 
source maturity models I came across when skimming the literature do 
indeed consider those organizations.

The FINOS OSMM is designed to "ensure maximum profitability" while 
minimizing risk. 
https://github.com/finos-labs/osmm/blob/main/docs/user/OSMM-Explanations.md

> I *do* have a theory for what we've observed, which is that developers 
> like to have food with their meals, and the amount of time and effort to 
> do serious kernel work is significant.  And so companies are the ones 
> who can fund the engineers which are spending a good proportion of their 
> time working on Linux kerenl development.  These is why we see a huge 
> amount of work from people who work for Linaro, Intel, Red Hat, Google, 
> IBM, Nvidia, Facebook, Oracle, etc. both in terms of code contributed to 
> the kernel, code reviews of other people's code submission, design 
> discussions on LKML and in various "hallway track conversations" at the 
> verious Linux conferences/workshops, etc.
> 
> As far as non-profit organizations are concerned, most of them have very 
> tightly defined mission.  That mission might be mostly unrelated to the 
> kernel, except as a customer of the kernel --- for example, the Mozilla 
> and Eclipse Foundation --- or it might be Linux adjacent, such as "make 
> a good distributions ala Debian, Arch, Fedora, etc."  The people at 
> these non-profits might be volunteers (this is mostly the case for 
> Debian), or they might be paid engineers based on the corporate 
> sponsoprs of the non-profits (for example) or engineers who are paid by 
> a company, but who are "on loan" to the non-profit organization (for 
> example, in the Apache Software Foundation this is a common pattern).  
> Either way, though, those non-profits tend to have a very tightly 
> focused mission, and it tends not to be one which requires a large 
> amount of kernel development.
> 
> You appear to have a very different model of how non-profits might 
> approach the Linux kernel --- could you go into more detail about why 
> they might want to contribute to the Linux kernel, and how we might 
> encourage them to contribute more engineering effort?
> 

Sure. Here's a recent example, in which a not-for-profit volunteer might 
have been granted an opportunity to work upstream: 
https://lore.kernel.org/all/129c9d5e-213a-80c9-092e-dc1dcf38ae3e@linux-m68k.org/

The driver in question may may not be commercially viable, but that 
doesn't matter, if the intention is to foster new maintainers and increase 
the talent pool. And the problem ostensibly being addressed in the Linux 
Contributor Maturity Model is a shortage of maintainers.

I don't have a magic bullet to solve that problem (which is not just a 
Linux problem) but I'll make a few observations.

- Maintainers should be "automating themselves out of a job" to whatever 
  extent this is possible.  git is a good example of this, as is all of 
  the tooling and workflow automation that grew out of that (e.g. gitlab).

  Because the Linux project is structured as a heirarchy, I think Linus 
  and senior maintainers have a crucial role here. I don't think it's a 
  co-incidence that git was the brainchild of the top maintainer.

  Making the maintainer role more lucrative will provide a disincentive 
  for more automation (with or without level 5 performance reviews) unless 
  remuneration is tied to metrics that reflect maintainer effectiveness.

- The roles of maintainer and reviewer should be taught in universities at 
  a post-graduate level to increase the talent pool.

- On the whole, I don't think remuneration or training can solve the 
  problem. I do think automation and tooling can do it.

  To develop that technology, subsystem maintainers must collaborate on 
  process, automation and tooling. That means they must remedy the 
  balkanization that presently exists across subsystems.

  I realize that experimentation and risk-taking are part of the reason 
  why Linux is the success that it is. However, at some point, senior 
  maintainers have to decide, for example, "the model used by subsystem A 
  is _measurably_ better than the process used by subsystem B, so the 
  former technique will become mandatory and then collaboratively improved 
  upon."

  So, we come back to metrics again. (As you would know, "you can't 
  improve what you can't measure.)

> > > I'm not sure how this document would "hinder collaboration" with 
> > > non-profit organizations and individuals.  Could you say more about 
> > > your concern regarding how this undesireable outcome would happen in 
> > > practice?
> > 
> > I believe that I've now addressed this in my message to Greg.
> 
> Well, no, you haven't.  More below....
> 
> On Tue, Jun 20, 2023 at 01:48:59PM +1000, Finn Thain wrote: (in reply to 
> Greg)
> > 
> > Bonuses and salaries are tied to performance reviews so the hazard 
> > here are clear. Level 5 compels companies to seek feedback and 
> > naturally they will seek it from companies who share their goals. You 
> > ask too much of employees if you expect them to put aside the 
> > corporate agendas and pursue the interests of the wider community.
> 
> I was a hobbyist from 1991 to 1999 (I was the first North American linux 
> kernel developer, and at the time my day job was tech lead for the MIT 
> KerBeros Team and I also served on the IETF Security Area Directorate 
> and was one of the IPSEC working group chairs), and then from 1999 until 
> present, I've worked for companies (first VA Linux Systems, then the IBM 
> Linux Technology Cetner, and now at Google).  So I think I know 
> something about how employees balance the needs of the Linux Kernel 
> community and the needs of their employer.
> 

I don't mean to lecture you, Ted. I have great admiration for your 
considerable contributions and insight. Also, I benefit from extfs every 
day and for that I'm grateful.

> > Countless lawsuits over the last few decades made it abundantly clear 
> > that the goals of companies often diverge from those of the wider 
> > FLOSS community.
> > 
> > Consider all of the open source code thrown over the wall, the binary 
> > blobs, the binary modules, the built-in obsolescence, the devices 
> > shipped with vulnerabilities now reduced to e-waste because they 
> > cannot be fixed, the vendor lock-in strategies, the walled gardens, 
> > the surveillance etc.
> 
> There haven't been *that* many lawsuits, and while there have been some 
> bad actors, there have also been many, MANY examples of companies that 
> have contributed in highly positive ways.  For example, well over a 
> decade ago, IBM started requiring that their peripheral card suppliers 
> (e.g., network cards, SCSI host bus adapters, etc.) that it would be a 
> requirement that thosse companies providing those peripherals MUST have 
> upstream Linux device drivers as a condition of the procurement 
> contract.
> 
> And the more enlightened companies *do* understood that out-of-tree 
> patches are technical debt, and to get drivers, patches, etc., upstream 
> in the long run would save them huge amounts of effort.  So there are 
> plenty of ways in which the meeting the goals of the FLOSS comunity is 
> ultimately, good towards achieving the goals of for-profit companies.
> 

Indeed.

> > To my jaded mind, it is obvious that such reprehensible strategies can 
> > be advanced by co-operative employees given inducements from colluding 
> > companies. My patch won't prevent this sort of behaviour but it does 
> > remove a directive that would help facilitate it.
> > 
> > Greg, if you want to see more performance reviews, the maturity model 
> > could compel companies to provide unsolicited feedback, instead of 
> > seek it from an arbitrary source. Would you be amenable to a revised 
> > patch along those lines?
> 
> It was never about *companies* providing unsolicited feedback, but 
> rather the upstream Linux kerenl development community:
> 
> Level 4
> =======
> 
> * Organizations will consider community member feedback in official 
>   performance reviews.
> 
> Level 5
> =======
> 
> * Organizations will actively seek out community member feedback as a 
>   factor in official performance reviews.
> 
> I could see making this be more explicit by spelling out "upstream 
> development community" and "regarding their upstream contributions". But 
> I'm not sure where you thought it was about "getting *from* companies".
> 

I know that was not the intention, but I think that the incentives work 
against the intention, and it need not be so.

> The reality is that many, if not most of the key Linux kernel developer 
> leaders are employed by companies.  And so we are quite well practiced 
> at being able to put on our "open source leader hat" --- and explicitly 
> telling people that this is what we are doing --- as well as being able 
> to explain when we are relying the requirements from a particular 
> company, usually when we are explianing what motiviated a particular 
> code contribution.
> 
> So if I were asked to give a recommendation for an employee working at 
> Company I, and I'm working at Company G, I'm perfectly capable of 
> saying, this is what this person has done as an upstream developer, and 
> based on her upstream contributions, you should definitely promote her.  
> And this has actually happened, BTW.  If we could encourage more 
> companies to sek out or accept more feedback from community members, 
> that would certainly be a good thing.
> 
> Cheers,
> 
> 						- Ted
> 
> 
