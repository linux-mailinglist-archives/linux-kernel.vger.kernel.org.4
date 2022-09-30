Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A05F0967
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiI3LBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiI3LBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:01:06 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1618C01D;
        Fri, 30 Sep 2022 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MbUG2nwFZSur9xYNWjWHknIj8DJdh+OxYHZixEvitT0=; b=tabn7kxOq/aYH2/gkIRVSuoi2w
        DQgpDbEUlRzByXGVGTwJG9TL5yii/uvz1ntEaxx8/0mLjUse7sWfXuypSP+OledxKA4vZ5dchbYMx
        Vb8LRAeMJfW7/fyZPIpkNNR7RpWA+BWpmOsO8Es9brpx8pqGkiky02ogFUfSinHOZkqHK1iIkDx5E
        94wr/3cFfTrRbsxNhc8JoDvTMJW+og+UJCjbF0iWUlHErtdd6OhUrYt3qRnNQfnInzVeuiVr7S5WM
        B685jyt6jvG4e19Y7wCXbBDJuYN2GF6418/LLdzF0j/rok0w1MrCJwL8WnNjEvRlG32X7QjmxinPi
        wbarR1pg==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:61757 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeDPB-0024Xh-5E;
        Fri, 30 Sep 2022 06:38:05 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <52d93e6c-c6f0-81dd-07ca-cdae13dffba4@gmx.com>
Date:   Fri, 30 Sep 2022 06:37:47 -0400
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <93802832-F5DA-45C3-B7DF-451D9086E4B5@sladewatkins.net>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <5d15ec50-e0b7-dc90-9060-3583633070e8@leemhuis.info>
 <52d93e6c-c6f0-81dd-07ca-cdae13dffba4@gmx.com>
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

Hi,

> On Sep 30, 2022, at 5:03 AM, Artem S. Tashkinov <aros@gmx.com> wrote:
> On 9/30/22 08:47, Thorsten Leemhuis wrote:
>> On 29.09.22 15:04, Konstantin Ryabitsev wrote:
	[trimmed]
>> Sometimes there are days where I think "let's go down the 'do =
everything
>> by mail' rabbit hole some more and couple a pastebin and a somewhat
>> improved regzbot with an app (usable both locally and on the web) =
that
>> helps users preparing a report they can then send with their usual
>> mailer". And then there are days "ohh, no, that might be a totally
>> stupid thing to do". :-/
>=20
> Emails are absolutely horrible in terms of keeping track of the state =
of
> the issue. Who has replied? Who has provided the necessary data? Where
> can this data be found? What if a person has forgotten to "Reply All"
> and instead clicked "Reply"? Hell, no. Then people get swamped with
> their own emails, the previous email from this discussion went =
straight
> to SPAM for my email provider. It's too easy to lose track of =
everything.

Email deliverability and spam filters are certainly something to =
consider. (Thanks email providers.)

>=20
> The kernel bugzilla has helped resolve critical issues and add
> impressive features with dozens of people collaborating. This is =
nearly
> impossible to carry out using email except for dedicated developers
> working on something.

Exactly.

>>=20
>> we really need to figure out the entire
>> process and pinpoint who is going to be the one in charge of bug =
reports. If
>> you think that LF should establish a fund for a position like that, =
then you
>> should probably approach LF fellows (Greg KH, Shuah Khan), who can =
then talk
>> to LF management. The IT team will be happy to support you with the =
tooling,
>> but tooling should come second to that -- otherwise we'll just be =
replacing an
>> old and rusty dumpster on fire with a new and shiny dumpster on fire.
>=20
> Bugzilla with all its issues is still super convenient.


+1, I don=E2=80=99t think the solution longterm is to _not_ have a =
system like Bugzilla for this reason. Emails can certainly be sent from =
the system but it should continue existing.

-srw

