Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096A6F5634
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjECKbC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjECKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:31:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F4510C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:30:57 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pu9kq-00078d-S7; Wed, 03 May 2023 12:30:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     philipp.tomsich@vrull.eu, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     bjorn@kernel.org, jrtc27@jrtc27.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
Date:   Wed, 03 May 2023 12:30:36 +0200
Message-ID: <4830085.8hb0ThOEGa@diego>
In-Reply-To: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
References: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 2. Mai 2023, 19:15:29 CEST schrieb Palmer Dabbelt:
> On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu wrote:
> > On Tue, 2 May 2023 at 09:58, Björn Töpel <bjorn@kernel.org> wrote:
> >>
> >> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
> >>
> >> > It is a pity that the current interface was designed without involving
> >> > RVI (and that I had to ask my team to put together a patch set for
> >> > further discussion, given that none of the other major vendors in RVI
> >> > stepped forward).  I guarantee that plenty of reviewers would have
> >> > highlighted that a central registry (even if it is just a kernel
> >> > header) should be avoided.
> >>
> >> Are you claiming that the hwprobe work was not done in the open, but
> >> secretly merged? That is not only incorrect, but rude to upstream RISC-V
> >> Linux developers. I suggest you review how you interact with upstream
> >> kernel work.
> >
> > Please don't put words into my mouth...
> >
> > I was merely pointing out that there was no engagement by the RVI
> > member companies (in regard to this mechanism) within RVI, which would
> > have prevented Jessica's issue.
> > This would have also helped to address the concerns on vendor-defined
> > extensions.
> >
> > Also who do you refer to when you say "how _you_ interact"?  If it is
> > RVI that you refer to: it doesn't interact with upstream work
> > directly, as it doesn't own any engineering resources.
> > RVI provides a forum for member companies to come to an
> > understanding/design and then have the member companies perform the
> > work and take it upstream.
> 
> I'm not even sure what you're looking for here: if RVI doesn't want to 
> work upstream, then complaining that RVI isn't part of upstream 
> discussions is pretty pointless.
> 
> >> Why didn't RVI get involved in the review of the series? The expectation
> >> cannot be that all open source projects go to RVI, but rather the other
> >> way around.
> >
> > That is exactly the point I was making and which you seem to miss: RVI
> > does not own any engineering resources and depends solely on its
> > member companies to project into open source projects.
> >
> >> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
> >> probing"). Your team was very much involved in the review.
> >
> > I am aware, as I had reviewed and commented on these are well.
> > And my only request (was and) is that we need to figure out a way to
> > efficiently deal with vendor-defined extensions.
> 
> Maybe you should go talk to you team, then?  Handling vendor extensions 
> via hwprobe has been discussed, sounds like you're confused again.

I too have this vague memory of us talking about vendor extensions,
but my memory is really bad for stuff like this, so I spent the morning
combing through all the hwprobe iterations looking for it, but so far
have only found

https://lore.kernel.org/lkml/CALs-HstoeoTWjTEZrLWouCgwq0t3tDB6uL=tB68RJDs1ub4Frw@mail.gmail.com/

I'm most likely just blind, but does someone have another pointer?


Thanks
Heiko


