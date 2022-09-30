Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEE5F10FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiI3RhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiI3RhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:37:05 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88162B1AD;
        Fri, 30 Sep 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=szezkDrZv/DIxoNhXmXzm3IHUZyWzUBX9UZD4NvKIjU=; b=PhVGZ1A5LidZWBPURz5QMuk8dH
        /sGHgHnqd4P/H8S06hrK2f/1js8wLash+/09h5YDpdVvbR/51/FjJYW54Lh+xYiHWkiB/9YpXTDH4
        36MEFHtlDoTmmoBCj3umIjPcKI7y+OrWou3fAqwobXdzoNc6VS4wQ7gI33GW3mVhPf5tIe/TvQc/p
        DrSqXvC5cupJ6nQpIHQLn/JCzhqfZ/qd5bMX0FouirafFbs7y7s6elSf5Fr0XOHOEeqlm96HhZ65p
        6SZRghEaeTk34ERWtAvg2r87rgpdbI9YixTcKpAMNPn2TlFx7xe4E4T0WCFVD6yHWi2lZ7eUILans
        oNzy4i8g==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:61749 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeJwb-008x9c-FO;
        Fri, 30 Sep 2022 13:37:01 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
Date:   Fri, 30 Sep 2022 13:36:57 -0400
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B455C4C1-BECF-4325-B709-8B2C965279DC@sladewatkins.net>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
To:     "Artem S. Tashkinov" <aros@gmx.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - premium237.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sladewatkins.net
X-Get-Message-Sender-Via: premium237.web-hosting.com: authenticated_id: srw@sladewatkins.net
X-Authenticated-Sender: premium237.web-hosting.com: srw@sladewatkins.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artem, all,

> On Sep 30, 2022, at 12:34 PM, Artem S. Tashkinov <aros@gmx.com> wrote:
> Debian uses an email based bug tracker and you know what? Most people
> avoid it like a plague. It's a hell on earth to use. Ubunutu's =
Launchpad
> which looks and feels like Bugzilla is a hundred times more popular.

Yeah, Ubuntu=E2=80=99s Launchpad instance is definitely easier to =
navigate than Bugzilla and has more info at a glance (when looking at =
individual bug reports.) Do I necessarily think they look and feel the =
same? Nah. But, hey, it=E2=80=99s all subjective so it=E2=80=99s cool!

Ultimately I=E2=80=99m conflicted here (even my own opinions have =
already changed twice since I jumped in on the discussion.) Some say =
email is terrible, others say it=E2=80=99s the way they want to do it. =
Because that=E2=80=99s all subjective: that was bound to happen, of =
course. My take is that if the goal is to please *everyone*, we=E2=80=99re=
 not going to get anywhere.=20

Email =E2=80=94 imo =E2=80=94 is good for discussions, but not for =
reporting bugs. Web has upsides of being easier to navigate (sometimes =
faster) with just a few clicks/keyboard shortcuts and some words to =
describe an issue, steps to reproduce, kernel versions it affects, etc.

But no matter what system (email, web, etc.) you use =E2=80=94 there =
will always be things that gets lost, whether that=E2=80=99s because =
someone didn=E2=80=99t see something and/or it got buried by something =
else more urgent. Sadly, that's just going to happen, and the best thing =
to do is improve it so that it=E2=80=99s _less likely_ to do so.

-srw
