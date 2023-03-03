Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F76A926F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCCI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCCI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:29:39 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D06E85
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:29:32 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230303082930760bd7a5cf0b7cee3b
        for <linux-kernel@vger.kernel.org>;
        Fri, 03 Mar 2023 09:29:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gr3Hac+WmoWh7ZF0FrDuL6o4QZ9VzlVBNRPd55fOqPY=;
 b=LVD78WxaP4vKOcP8K7GcrNLEJbQCCBawV3tS9mnRP074mpkZTZHHPHu0nR5EdL0PBJ2pxE
 1SO2waFURPJIflZDEhIRfjbo5kpSpRPzRSd+x3MTlIEeRpGAcy13DYSj44Vrl1WxhhL0TMCV
 k2welFjyFnOQO4VgifJXcfhEkF90A=;
Message-ID: <21e61d098cd78476770b8a0e782689c76ff30d80.camel@siemens.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt79
From:   Florian Bezdeka <florian.bezdeka@siemens.com>
To:     Daniel Wagner <wagi@monom.org>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri, 03 Mar 2023 09:29:28 +0100
In-Reply-To: <20230223143356.fa6tqrflmhrcqx33@carbon.lan>
References: <Y9KOvZH61omPpn/3@uudg.org>
         <2ad9f8a7528818b9509f62278b42e5bc6d210054.camel@siemens.com>
         <20230223143356.fa6tqrflmhrcqx33@carbon.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-23 at 15:33 +0100, Daniel Wagner wrote:
> Hi Florian,
>=20
> On Thu, Jan 26, 2023 at 06:41:27PM +0100, Florian Bezdeka wrote:
> > From the CIP projects perspective we would like to improve the
> > situation.
> >=20
> > From my perspective the following could be done:
> >=20
> >   - Instead of (or in addition to) building and testing released -rt
> >     branches enable testing of -rt release candidates
> >   - Make sure the build results get back to the maintainers
> >=20
> > I'm not sure if every -rt branch has a -rc branch. I'm not familiar
> > with the -rt release process yet.
>=20
> The process so far is, that every stable maintainer updates his tree (mer=
ges the
> stable tree) and does a local build and local tests. Usually when merging=
 latest
> upstream stable release there are no or little fallouts. When the maintai=
ner is
> happy he does the release by pushing the changes to the usptream branch. =
The
> release candiates come only into play when there is something the maintai=
ner is
> not sure how to handle or -rt patches are backported which need some more=
 eyes
> to look on. That means Sebastian's approval :)

Ok, so there are no automated test for each release.

>=20
> IIRC, I did give a presentation on the workflow some time ago...
>=20
> https://lpc.events/event/4/contributions/293/attachments/237/416/maintain=
ing-out-of-tree-patches-over-the-long-term.pdf
> https://www.youtube.com/watch?v=3D2ab4Knwlmo4

Thanks for the hint!

>=20
> When we started with this process kernelci didn't build these branches bu=
t that
> is long time ago.

At least (some) stable release branches are being build now but it
seems that nobody is caring about the result. That's one of the things
I would like to address.

>=20
> Personally, I don't mind doing an official -rc for every release and gett=
ing
> some additional builds and tests run by kernelci.

Ok, but that would be something that "all" -rt-stable maintainers
should agree on, no? At least to some degree to make the testing part
consistent.

>=20
> Though just piping the results back is the easy thing, the time consuming=
 task
> is to fix those problems. Do you plan to help out here?

Well, having the pipelines might be easy, but we don't have them yet,=20
right? Reacting on the pipeline results would be the next step that
possibly could happen in cooperation with the CIP project.

But yes, generally speaking we want to help. But we don't have infinite
resources (as usual), so we'd like to know where most impact could be
achieved.

Are there any plans to build and test the stable -rt branches with the
help of automation, for example by using the kernelci infrastructure?
If no: Would that be something that the RT project is interested in?

I'm asking for kernelci because the CIP project is already using that.
They defined a clear set of supported architectures, kernel configs,
test suites and concrete hardware (to some degree). This allows them to
make sure each release candidate of each branch is in good shape before
doing the actual release.

Regards,
Florian

>=20
> Thanks,
> Daniel

