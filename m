Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F707313E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbjFOJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjFOJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:32:14 -0400
X-Greylist: delayed 8404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 02:32:12 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0001BD2;
        Thu, 15 Jun 2023 02:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686821530; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NTkz/F98FAB9EP8/uPNmjKI7sbZYPv+bNqmwBuFyCOKQdu8KVL9nvOh2oB64Fvhuuv
    BHHXHTDDe5DK5+VEEWCzJD+Bf7RlkOo7uBH8NHz7wPMthLuf6YMWiTFQr976EKeGcQih
    McbAsEyZys+BrwRWx0PoQ8C11ohLsX3toH/KOdDK56hGSA5zSPWaXPkSG98WCetDMexH
    QcRgxuzE+u14bXH8zXUFAeiZnh48CAHrdX3nBdqpytY4ArPe+AQyox/T1FxuyeDhfJZ/
    DxK3NbgechROk5wsVcoMcCPjzydOmtU3nxQr6ycVPqp/jwEMrek2OhrufHHh5J7UJaUc
    BEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686821530;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=rdXiwRKLa25iA50V22EnrAVG7V/n2VWhkNaXZ8DmZr8=;
    b=X10A4GWF22LiuWJn5OViyGdA1YZHvgJM/0uR+5N2az6CQ02tpzm0j6h4qR5aDPXV9L
    uCiWDIinObc6juxl1CEvAxu2WATbiSjT1VkycDsVHcbfJ3XVVQaaWCbMV47pIes2tQJh
    JpzXeMgEBDuh8zTooJV7YP4pTBGIp1bDDrEdB/YcpRNK5JKXAnVMpSRyOnzhj1CLUjp3
    Lr/du1yTPx9072caCcTEAiA4T74LG/mjSHwEpC/x1t2bfOztrj5zSwHKDJ3KePesMzet
    +HTLwkDsZrqn+HR6Z0hidOyJoG+ydEj+6ZMriGFKI/Fh74b7LNMmxs/Idx4MMGTuo/yg
    icGg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686821529;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=rdXiwRKLa25iA50V22EnrAVG7V/n2VWhkNaXZ8DmZr8=;
    b=CScb8zj6NZPT3kyX+ABmqs4dpZJYiARr+JjrHvNtOxZWIdUwKvmyDNKF6ZzFNUjjmx
    bJg+oyiSK0q6edSkSEMbxKJFe5Wd8lmXcWCROSAnUjQkndU2a90eighmSIlFgtUdaouR
    J9EZgd1pH4w3xAypS08WZqqFgjFEOekfMToIbX69I5tiG2EQoC/KbhJhciRKVBtPKmyG
    90+Vp69MUiFKSjvZND/oRtQaYArZYCzHhRIJ9JRWu/3nw+E0tmBF/4qr+AnEcayxNPyH
    kxEIITS4vF8p5u0rhP0smwPqbU0nbkycDVPVAoWjh0M973rlAqRpSCf6mqjmEMGHt/yR
    JVuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686821529;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=rdXiwRKLa25iA50V22EnrAVG7V/n2VWhkNaXZ8DmZr8=;
    b=tbEgi1nYzSiwdc5Huh2N54qlKwSiJkG/wb+vW7cYs38UByHrZh7guoxi5FCHzRQrKt
    aT+QK8Y7EC4VPXkhkyBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F9W92zq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 11:32:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230615090804.GA8625@alpha.franken.de>
Date:   Thu, 15 Jun 2023 11:32:09 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>, list@opendingux.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD2F5891-794C-4154-BBBD-F23C04E6FE05@goldelico.com>
References: <E1q9iWM-0004zB-00@elvis.franken.de>
 <20230615090804.GA8625@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 15.06.2023 um 11:08 schrieb Thomas Bogendoerfer =
<tsbogend@alpha.franken.de>:
>=20
> On Thu, Jun 15, 2023 at 10:39:53AM +0200, Paul Cercueil wrote:
>> Thomas: are you able to drop this series from mips-next, or should =
I/we send fixup patches instead?
>=20
> as I'm not rebasing mips-next I need fixup patches. This won't solve
> bisectability, but not doing rebases is the what Linus prefers.

Indeed. I have found some very old statements on this topic:
https://yarchive.net/comp/linux/git_rebase.html

> > How do I insert build fixes into existing changesets so that the =
tree
> > is more bisectable?
>=20
> Just delay pushing out. There really is _zero_ downside to this. None =
at
> all. There are only upsides.

...

> Also, I'd *much* rather have a few problems in the tree than have =
people
> screw up history in order to hide them. Sure, we want to keep things
> bisectable, but quite frankly, if you do a reasonable job and compile =
the
> kernel before you push out, it will be "mostly bisectable".
>=20
> And yes, mistakes happen. Mistakes will *always* happen. It's ok. =
Relax.

...

> So in short:
>=20
>  - clean trees and bisectability are all wonderful things. No doubt =
about
>    that at all.
>=20
>  - but if getting there means that you lose a lot of _other_ wonderful
>    things (like being able to trust history, and the people being =
under
>    your watchful eyes having to deal with you re-writing their trees),
>    we'd be much better off taking the occasional commit that fixes =
things
>    up _after_ the fact rather than before!
>=20
>  - and you actually can help fix your issues by doing some simple =
things
>    *before* pushing out, rather than push out immediately. IOW, do =
your
>    whitespace sanity fixes, your compile checks etc early, and don't =
push
>    out until after you've done them.

...

> So:
>  - making things public is *different* from developing them. Don't =
push
>    out just because you committed something!
>=20
>  - you shouldn't publicize a tree until it's in reasonable shape. =
EVER.
>    Even -mm or -next is *not* better off with a pile of sh*t just =
because
>    you're working in that area.
>=20
>    I cannot stress this enough. I think Andrew has been way too polite =
to
>    some people.
>=20
>  - and once it is, you generally shouldn't mess with old commits even =
when
>    you fix things. Full cleanliness or always being able to bisect
>    specific configurations is not an excuse for messing up all the =
other
>    things, and if this problem happens a lot, I would like to point =
you to
>    the two previous points.
>=20

...

> And btw, a *big* part of the above is also:
>=20
>  - mistakes happen.
>=20
> There will be bugs. There will be cases where things aren't bisectable
> (although they should generally be bisectable for *your* =
configuration,
> because if they aren't, that shows that you didn't even compile the
> commits you made).
>=20
> And there will be kernels that don't boot. Even expecting people to =
always
> boot-test every single commit would be unrealistic - let's face it, =
most
> things look really obvious, and the fact that even obvious fixes can =
have
> bugs doesn't mean that there should be hard rules about "every single
> commit has to be boot-tested on X machines".
>=20
> So it's an important part of the process to try to do a good job, and =
not
> publicizing crap - but it's *equally* important to realize that crap
> happens, and that it's easily *more* distracting to try to clean it up
> after-the-fact than it is to just admit that it happened.

Ok, then we have to keep this series as is and fix it on top (just for
my V2a board since it seems to work for Paul for a different version).

So let's focus on the fixes.

Best regards,
Nikolaus


>=20
> Thomas.
>=20
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not =
necessarily a
> good idea.                                                [ RFC1925, =
2.3 ]

