Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C405F1199
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiI3S2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiI3S17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:27:59 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356A1A9A52
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ujHxdPgmhKxO1MszIAjNRLkYCBZur1r0ASOw6TpYe/Q=; b=mTqnJx7tJL1aVUqEwZgRKXn6kP
        iG2YTVwQPfkwGQET5DJddPf0tKGXo2Y0/VZ2N4ZzmQnV7Dh6VwAhAh85EsoAdv9Vw3Yb1+kzrRK8t
        nlBJUIKa/CsxD+bUd0XWMze8aV4kGLO+s/n3lqxPfg+iNOYUwPLdgyToCT4Z1YZOvsUsMnhwLVxo6
        eh9zlfkz17tfvFmUypAZxDhfnaMj/OUb2e/F6DvI5k0LFrPaWdc0SALBvs5po4G6yZsg1Bq5PyXfY
        0kdU9T/VvdDzt2Yyek+D8ZWWZwHPVCjxrAA1sv1DTAZBZonI+Ebwk1KzpJZkXeJYNFAzZ5fJurwIM
        aS97CsUQ==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:64171 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeKjs-009hDa-PE;
        Fri, 30 Sep 2022 14:27:56 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <0BD28445-7393-4153-B15C-59E5DA868E80@sladewatkins.net>
Date:   Fri, 30 Sep 2022 14:27:54 -0400
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F9EDCCA-AB85-44CE-AD9F-44394C8663B8@sladewatkins.net>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
 <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
 <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
 <0BD28445-7393-4153-B15C-59E5DA868E80@sladewatkins.net>
To:     Mirsad Todorovac <mirsad.todorovac@alu.hr>
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
> On Sep 30, 2022, at 8:03 AM, Slade Watkins <srw@sladewatkins.net> =
wrote:
>=20
> Huh, okay, I=E2=80=99ll see if I can try to reproduce it again.=20
>=20
> I wasn=E2=80=99t having issues with kernel 6.0-rc7 but I=E2=80=99ll =
try a fresh install and see what that changes.

I tried again twice (for =E2=80=9Cgood measure,=E2=80=9D so to speak.)
Once with my x86_64 test machine (fresh install of my distribution and =
6.0-rc7 kernel, Firefox snap 104.x/105.0.1), and with your setup =
(AlmaLinux, 6.0-rc7, same versions of Firefox snaps previously =
mentioned) as described in a previous email [1] and couldn=E2=80=99t =
reproduce.

Not sure what=E2=80=99s happening here, or what=E2=80=99s to blame (the =
kernel, snapd, etc.), to be completely honest with you. But obviously, =
there=E2=80=99s an issue on your system with the snaps. So in that case, =
I do think somebody else with more insight into what could possibly =
affect this =E2=80=94 or even Mozilla (specifically, the maintainers of =
their snap package) =E2=80=94 may be more helpful.

But please feel free to keep me in the loop! Even though I=E2=80=99m not =
able to reproduce, I=E2=80=99d still like to help wherever possible.

[1] =
https://lore.kernel.org/lkml/1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.uniz=
g.hr/
[2] =
https://lore.kernel.org/lkml/77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr/

Best,
-srw

