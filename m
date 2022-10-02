Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59C5F23AE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJBOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJBOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:48:20 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37926498;
        Sun,  2 Oct 2022 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gWzPMps3Q5viimmfl6sV284M/N5y+shUDxxXBBqoCkU=; b=iNqzp2P8jAayhN9Z6KXnUi9xqe
        UX8lSnjtAq0qQNHYmBEOfW8LaTFKV0bVTiflZw0zpnPZDJHPu07pnBA1y6P31KsOM/6YS1CTZgwbp
        vHJCRuUjue0PpmxeJqXndddWrHq9YXb2HrE5tAXnF9jtqidcsXP9DM0borleo3pEC3TnhOcWqhc1y
        kSIdHxtxytpimIMmza1RXFGvQkIgloHJZAF32nftla+icanoc4hXoShecuohOrErWSDv96wWGxncD
        aLxxoUdRZ7f757RImJgIuXbc1F8fEsMpv7aDubKWCQnbtHz65vXyk4wRWwti32tAvKXjDmQUEESdy
        H++T0khg==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:58045 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1of0GP-0043by-UI;
        Sun, 02 Oct 2022 10:48:18 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
Date:   Sun, 2 Oct 2022 10:48:12 -0400
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11098E44-8BB4-4318-9BE1-A659573E6BA4@sladewatkins.net>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
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

> On Oct 2, 2022, at 8:49 AM, Artem S. Tashkinov <aros@gmx.com> wrote:
> As I've said many times already: bugzilla must be an opt-out, not =
opt-in
> experience/option.
>=20
> Let's subscribe the past six months of developers using git commits =
and
> if someone doesn't like getting emails they go to the website and
> unsubscribe _once_ which takes a minute. This is a non-issue I've no
> clue why we're dwelling on it.

I disagree with this in its *entirety* and I really don=E2=80=99t think =
it has any chance of moving forward.=20

If this were to happen (and it won=E2=80=99t!) then developers will just =
send the emails to spam or some other filter because they didn=E2=80=99t =
_consent_ to being subscribed to it. And in my opinion, they=E2=80=99d =
be justified in doing that.

-srw

