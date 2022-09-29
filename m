Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFE5EFB23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiI2QoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiI2QoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:44:18 -0400
X-Greylist: delayed 3894 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 09:44:17 PDT
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E94153EF7;
        Thu, 29 Sep 2022 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bhJ9ijaSrg8Q+iqIaQe6wLGB9ZwmWZRAjaxAvMQnDDY=; b=TmfJx7SJEmrvukW5mmoQnYn35S
        lfgwfPVrEFMbjnPKdUOEJY0kY2aD6VEChuL2+9nQiA23OFHvMPbfwniErdA8xfv109X4wK4K4paEw
        ndbIVCPQiGGlKFE3o3xKUMkE+v8CJ/7nnbKzRQCNC7yNv9KqNET+Yha6bRSYk9di8sImT/Lysex0U
        zrFExlNefn6xeoB2yjUK0iX5p+75PDOmGHI8roUJCPyPZWKr2PSVKMwD6kQ02L+DGvh5VzjhlDgIp
        lTyDJXFgqP1P1ct9u+ITXKDujYtsYjV7LZA+t8iIUj9LMNUC9+xhtlLQHjjFUldbiNPRIPsVGDSUj
        b5A63veg==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:49863 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1odvdC-00HRHw-Jt;
        Thu, 29 Sep 2022 11:39:22 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20220929153135.vu43n5kgdj4a3at6@meerkat.local>
Date:   Thu, 29 Sep 2022 11:39:20 -0400
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4935ACC-65C8-4705-B9FF-A1CA0A648B9D@sladewatkins.net>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <20220929153135.vu43n5kgdj4a3at6@meerkat.local>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

> On Sep 29, 2022, at 11:31 AM, Konstantin Ryabitsev =
<konstantin@linuxfoundation.org> wrote:
>=20
> On Thu, Sep 29, 2022 at 02:22:10PM +0000, Artem S. Tashkinov wrote:
>> * Delete all the components.
>> * Leave a catch-all one.
>> * Let bug reports rot because no one will ever see them. Almost just
>> like now. Don't remind me of mailing lists.
>=20
> This is my proposal, except also:
>=20
> 1. post all new bugs and comments to a public-inbox feed that people =
can query
>   via lore.kernel.org and tooling like lei.

Honestly, giving it a lot more thought, this is a brilliant idea.

>=20
>> Mailing lists will not work for such a huge project. Period. In the
>> early 90s they worked, but we are 25 years later with millions more
>> users. With a ton more of a ton more complicated hardware.
>=20
> We've recognized this a while ago, which is why our efforts have been =
targeted
> at query-based message feeds. Hence, tools like lore.kernel.org and =
lei. It's
> a work in progress, for sure, but it doesn't require any "everyone =
must switch
> workflows today" kind of coordination, and avoids introducing single =
points of
> failure by making it easy to replicate everything to mirrored systems.

My parents taught me growing up that you can only ever _improve_: you =
can never be perfect.=20

Needless to say, it=E2=80=99s worth a shot.


Best,

-srw

