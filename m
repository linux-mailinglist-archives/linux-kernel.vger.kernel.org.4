Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710F25F0A76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiI3Lb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiI3Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:30:54 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042225C9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/EukxfdnhKdF1nqxT6s4PlbHcg989kYCavTHmv0Ny1o=; b=m6AIUAcqsUWl5urwN+sGUq2upZ
        U60pv/INm6BCrzezizfcEmsJmfw+mP8tdhDQ8zYrcTP8NhRKxaWSzzJHhe/w9/e/uUVA6cQ4vQ1kQ
        MOn7cmD9u2n6tL09r6Hxsxmz9XibvNv/Z6k7iTHPV8QFWp16Qc7xFGA52RcuAhNpRF+w3X5X7voBk
        n+QSIFJ0EzB6KJzVSK7xmFPmd2jgqax2zUuo0zP4uCiLo9yWusLSQM6KWJMjnPbFrvfLJjM986I82
        PyczHchnZ92q3QQ2FOh2FPIqThSfK1Ao+0Ap5IZ8zaK64r2Sah8/h584S8STXcwmtnLgmJcfemN12
        6j+3BhEA==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:49250 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeE5D-002ddS-MJ;
        Fri, 30 Sep 2022 07:21:31 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
Date:   Fri, 30 Sep 2022 07:21:27 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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

> On Sep 30, 2022, at 6:48 AM, Mirsad Todorovac =
<mirsad.todorovac@alu.unizg.hr> wrote:
>=20
> Hi all,
>=20
> I can confirm this bug also on AlmaLinux (CentOS fork) with snapd =
version 105.0.1 of
> Firefox.
>=20
> After some time, tabs started crashing, but restarting Firefox binary =
was after that
> unsuccessful, giving the message:
>=20
> [marvin@pc-mtodorov ~]$ /snap/bin/firefox &
> [1] 137734
> [marvin@pc-mtodorov ~]$ /bin/bash: /lib/x86_64-linux-gnu/libdl.so.2: =
unsupported version 0 of Verdef record
> /bin/bash: error while loading shared libraries: =
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verneed =
record
>=20
> [1]+  Exit 127                /snap/bin/firefox
> [marvin@pc-mtodorov ~]$

Did you report this to the folks at Mozilla?

Best,

-srw

