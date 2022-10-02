Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E105F2440
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJBRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJBRWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:22:23 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A426106;
        Sun,  2 Oct 2022 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WrPbaSzv/4VTpUQ9MnAyS53i5Kj6rLDp3NY7/tDVztw=; b=OvQlOx5ZZw4CP48AFNVI2deyfe
        Ol30g08ywaOg9bD3puD/qsPlDBK12Mg5FB11JR0RjpSX5yAwO6irp1AImZd4Wgc3OJeo+HpuZhEIO
        TN97f03Vn0rleSTFppqLyCJzZhe4Nz4BHJz0tF9mh7N2gWQJF/o+lnaai7R9u37fj4Ftx5DMBHSv7
        UTqFZIB+miCew9pUwR+HRUJiokFDWu4C47FlC3H+aBtQ5ixJzhE/44uTHSFy7kk2Pbn6jnYSOLqAz
        pbcbDRzQbW1S9ENq5l1kncNBGezXOarq7RdESeDiJZt1rU9IKxgxrhB6KFrg9WvH0CBWpgkx89D9t
        jlF/SVyQ==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:59397 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1of2fU-006dyC-VR;
        Sun, 02 Oct 2022 13:22:21 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <Yzm0mia7ndwFGk2c@ZenIV>
Date:   Sun, 2 Oct 2022 13:22:14 -0400
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev, ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C107EF2-9842-40D9-A23D-FCFD610A9104@sladewatkins.net>
References: <Yzm0mia7ndwFGk2c@ZenIV>
To:     Al Viro <viro@zeniv.linux.org.uk>
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

> On Oct 2, 2022, at 11:56 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> OK, then - please tell me how to prevent e.g. =
linux-fsdevel@vger.kernel.org
> getting spammed by that thing.  Where should I go and how do I =
unsubscribe
> it?

Exactly. It=E2=80=99d be nearly impossible, not to mention that you=E2=80=99=
d have to (somehow) do it for _a large number of lists_.=20

I=E2=80=99m sure there is a better solution, but this isn=E2=80=99t =
it=E2=80=A6

-srw

