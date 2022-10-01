Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10005F18B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiJACrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 22:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJACr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 22:47:28 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E127B00;
        Fri, 30 Sep 2022 19:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GSSVx8a10C2Ptq/IxND8jGp4c8AAPLbLg6LWZR941oA=; b=bxwH8hzw/G1XWHnYnGgB7jXkWn
        dUhd1s9msXvk3+du0hChdGyjo5gnBNBdSAE5O5/rwXOSTfFmC6DweGMOz/vL5nPwAZ94jwUhurLY1
        E7U6cIavTe5UEP/FdaBIxwc76b2u/Gya7D96cqLj9RgOkIL9LFqheCmwwyaFz5VVvwN0mxYRwNt9x
        0zTYSFhl3StIoNYO7oOfpXnYQ8hr//F4i5og810+xnDCHlc3j8QC6J8PstokqBO6wr6flHNno1WIC
        sbrIr6DXArAMmeqTQnGO3/2FdIpgA2NAvHzspyC0y21CIuiFpmHB7XMP/lUJPL+COhvckgltZPTrw
        uFghToLQ==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:51150 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeSXE-000I41-Sf;
        Fri, 30 Sep 2022 22:47:25 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <YzeVVV+nPaxsqS0V@mit.edu>
Date:   Fri, 30 Sep 2022 22:47:20 -0400
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ED67BA1-087F-4E74-885E-4F9617187735@sladewatkins.net>
References: <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
 <YzcdnnjJA4M09dNH@pendragon.ideasonboard.com> <YzeVVV+nPaxsqS0V@mit.edu>
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

Hey there:

> On Sep 30, 2022, at 9:18 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Fri, Sep 30, 2022 at 07:47:26PM +0300, Laurent Pinchart wrote:
>>> Debian uses an email based bug tracker and you know what? Most =
people
>>> avoid it like a plague. It's a hell on earth to use. Ubunutu's =
Launchpad
>>> which looks and feels like Bugzilla is a hundred times more popular.
>>=20
>> It would be pretty sad if the only options we could come up with for =
bug
>> tracking would be either popular with reporters and ignored by
>> maintainers, or the other way around. Ideally we wouldn't have to =
decide
>> which of those two classes of users to prioritize, but I fear that,
>> given resource starvation, we'll have to make a decision there that =
will
>> be unpopular with one of the two sides.
>=20
> Funny thing.  I've largely given up on getting any kind of useful bug
> report from Launchpad, so I've largely ignored it.  In contast, the
> bug reports I get for e2fsprogs from Debian are generally far more
> actionable, with bug reports that have all of the data so I can
> actually root cause the problem, and help the user.

Yeah, this all comes down to personal preference and experience. For =
instance, that hasn=E2=80=99t been my experience and I happen to like =
Launchpad=E2=80=99s layout for reports, but I can see why you=E2=80=99d =
feel that way. (Different roles, different experiences, so-to-speak.)

> So Launchpad may be pretty, but perhaps because of selection bias, the
> bug reports I've seen there are generally a waste of my time, and if
> I'm going to choose which users I'm going to help for ***free***, it's
> going to be the one which is far less frustrating to me as the
> volunteer.

Yep, valid point there.=20

> "100 times more popular" is not necessarily a feature if what we get
> is 1000 times the noise.

I mean, I get it. And, obviously, something like Launchpad isn=E2=80=99t =
going to scale the way that it needs to in order for it to work for =
this. =20

Not everyone is going to like whatever solution is put in place, if =
there=E2=80=99s even any solution put in place: there will always be =
complaints from folks.

*Sigh.*

-srw

