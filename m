Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF035F1125
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiI3RtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiI3RtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:49:11 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F461E16E2;
        Fri, 30 Sep 2022 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2DQAQ/DVjh9XJe012TirfWSDIuPuQzX5Pl4j7t64C7A=; b=LnBYJzWknlr1GcKhsJVE5Vu79Y
        U7ZfmVcDW/zC1vgb341/sIf1Mq0PPYkDZ+n5YLij7WdErKFbDr+qVw99C6yN8QWVGTP5gmCiCDGaE
        8xrj8JFgm80iyogpG3q4KyWdzhrpWRehX6AHc7g1VogKItDW7X7te9G3Y3sk+wJqrOlnsH4MYBwrY
        DRyCpo9EG7hdZmDNt6nHtg9dZQR9yVHP3P6HatMaixOZbrzmrIiPzEweURcfbflOmvZOfmMK+id5K
        kxe1ifmIzPKgYZc6YnKxZj8k2KYK+IU0wxEC+nYs8kgaZ6lUc3BAfQBKjXg46akxgb3hTA74ACZNG
        cwWr/sjw==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:62270 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeK8J-00963m-7O;
        Fri, 30 Sep 2022 13:49:07 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <SJ1PR11MB60836F8B9E045C5542D01ADAFC569@SJ1PR11MB6083.namprd11.prod.outlook.com>
Date:   Fri, 30 Sep 2022 13:49:01 -0400
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A947768-A4CC-4BE8-AFF3-056CAE266674@sladewatkins.net>
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
 <SJ1PR11MB60836F8B9E045C5542D01ADAFC569@SJ1PR11MB6083.namprd11.prod.outlook.com>
To:     "Luck, Tony" <tony.luck@intel.com>
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

Hey:

> On Sep 30, 2022, at 1:28 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
>> E-mails sent from a web interface could have as much structure as =
you'd like.
>> So one avenue would be to set up a nice interface for bug reporting, =
that just
>> delivered the form data in e-mail format to the proposed =
bug-receiving mail list.
>=20
> Web interfaces have the advantage that they can be full of boxes which =
indicate
> useful details to supply. Like what kernel version? Did this work on =
an older version,
> is so, which one? Which CPU vendor/model are you using? Is there an =
error message?
> Are there warnings in the console log before the error? Can you upload =
a full console log?
> Does this happen repeatably? What are the steps to reproduce?

Not to mention, they have the advantage of being faster, in a lot of =
cases. (Sometimes, just a few keystrokes and an issue is filed. Saves =
everyone time.)

> Sometimes it takes a few round trips by e-mail to establish the =
baseline facts.

+1 to this, it=E2=80=99s much easier to have that information =
immediately at hand. It helps no one when you have to wait for it all to =
trickle via email taking days if not weeks. Waste of everyone=E2=80=99s =
time, in my mind.

As I=E2=80=99ve said=E2=80=94my opinion is that email is good for =
discussions, but  is not great for bug reports (at least, the initial =
ones that have all the base information.)=20

-srw

