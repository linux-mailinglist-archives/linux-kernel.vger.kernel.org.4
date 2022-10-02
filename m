Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD35F2358
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJBNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:25:09 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3513F78;
        Sun,  2 Oct 2022 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TkwwomKWlqnBIYPS4/OnWkjJBdn/hEfUJ8NnLaO1wcE=; b=SJOuSpjJpptnqJCMproRy2Y/pQ
        XTBEoSvrtXwXQGmKBhF5icbvLvUOPRXYghdh/ZoBUVdErsQMCtbNZtNOi06upylUwUG5jvBDxnmEx
        MbOU9RpLNR6FBObjYe8TgYqox/x8pmIHvWHOvQ55Jb7SjiLvT3zHZihsr0O0xe0RCmWfVzB+xg2TY
        VOoQ4NYy4c9cyZeSpVYSvI3IxuypNjVTmgPMuyRCVtSkmA1j9l4yNrP8FT1fT1dXybXidvAafmqwK
        BWZKzmb5RwHNcku0QvHwLS78l5tFobFtzSWAkspqUP6MNZ9MAWu0xTiyq2g7ewCFLEXU798cPuDX4
        y6a0Eacg==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:56344 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeyxt-002dt6-1e;
        Sun, 02 Oct 2022 09:25:05 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <YzmBjgXq9geMnL1B@mit.edu>
Date:   Sun, 2 Oct 2022 09:25:01 -0400
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <936650EA-E521-41FF-81C3-AEEB72E484B1@sladewatkins.net>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
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

Hello,

> On Oct 2, 2022, at 8:18 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
>>=20
>> My expectations are actually quite low:
>>=20
>> * A central place to collect bugs (yeah, bugzilla)
>> * Proper up to date components (they don't change too often, so =
there's
>> not a lot of work to be done - you can refresh them probably every =
12-24
>> months and it's gonna be totally OK)
>> * An ability to CC the relevant people/mailing lists (this is the =
only
>> serious missing feature)
>>=20
>> That's it. It's a billion times better than random emails sent to =
random
>> mailing lists. Signing up once is easier that to keep track of whom =
and
>> where you've emailed or not. And of course it's a ton lot easier to =
find
>> the existing bug reports.
>=20
> First of all, some of the components do CC the relevant mailing lists
> automatically.  And this is the part of Bugzilla which is hand-hacked
> and has no, zero, nada support upstream.  I'll defer to Konstantin
> about how easy it is to keep that working.
>=20
> Secondly, not everyone is happy with getting an e-mail message sent to
> a mailing list that has a lot of bugzilla metadata associated with it,
> and depending on how they respond, the response might not make it back
> to bugzilla.

+1.=20

Personally, I prefer Bugzilla _over_ getting e-mail. But that=E2=80=99s =
just my opinion.

>> Bugzilla as it is works nearly perfectly. We have a number of =
developers
>> who don't want to touch it or get emails from it - it's their right.
>> However it would be madness to take it from users. That will make =
filing
>> and following up on bug reports an absolutely poor experience for
>> absolute most users.
>=20
> At the moment, developers aren't following up on the bug reports.
> There is some debate as to why.  Is it because users who can't figure
> out how to send e-mail, and who send web-form based e-mails send low
> quality bug reports that can't be easily responded to unless someone
> is paid $$$ and/or has the patience of a saint?  Is it because
> components aren't being gatewayed to mailing lists?

My hope is that we find a solution that *encourages* developers to =
follow-up on bug reports. So far, we=E2=80=99ve just gone back and forth =
on this and gotten nowhere.

>=20
> And if we force developers to get Bugzilla spam whether they want it
> not, and they said, "absolutely not", is it there right to have the
> mailing list gateway disabled --- and if so, what does that do to the
> user experience?  Thats basically the situation we have right now.

Yep, agreed.

-srw

