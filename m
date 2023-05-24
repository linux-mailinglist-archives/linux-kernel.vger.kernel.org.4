Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529B47112EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEYRyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjEYRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:54:43 -0400
Received: from mail.posokab.go.id (mail.posokab.go.id [36.91.28.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCE97
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:54:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.posokab.go.id (Postfix) with ESMTP id 3270E16A6AB1;
        Thu, 25 May 2023 15:14:41 +0000 (UTC)
Received: from mail.posokab.go.id ([127.0.0.1])
        by localhost (mail.posokab.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wpT5ds3WoCdy; Thu, 25 May 2023 15:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by mail.posokab.go.id (Postfix) with ESMTP id A60A217419C2;
        Thu, 25 May 2023 14:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.posokab.go.id A60A217419C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.posokab.go.id;
        s=FD81C132-DAB5-11EB-B2BB-FC8C3A52EF8C; t=1685025558;
        bh=rDx/k9KkPI/Uq3UDPUpjfenG3LJkQYh+gD252HVmnTE=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=SummAWw2Sfg/RKYo4hGvqn1Dv10qj6+Gl6PKypF9YrWPtUWM6rJM+Ni0rIv/xsmJD
         carA7fz5v47zgsmBJ0vJDjTXU1eciZQjNoRF1JaVHNuCtaX34zSEgncD7GVM6sw/iA
         4UIBCI1fSdIuJ94lyCQlLGyAvVhYkEVvYUfDf2ls0RoYK5ZCpy+E57dYt+F2mtMiAJ
         PtgfP/6pVXJgxjgxr623PxPW/2zkGPBh+ZKHxmVJoLEWVLAjLJ7UV9a1Enb1ZdQuzz
         N9Em4lGkZ/p77Omi+y3AmK/QlN6899fxlpgQPR30/DJL9FYndK8sfATTPvrOm2BazP
         eGILZXZtw3SyQ==
X-Virus-Scanned: amavisd-new at mail.posokab.go.id
Received: from mail.posokab.go.id ([127.0.0.1])
        by localhost (mail.posokab.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ROvXqx_c2kzd; Thu, 25 May 2023 14:39:18 +0000 (UTC)
Received: from [192.168.1.13] (unknown [176.42.129.235])
        by mail.posokab.go.id (Postfix) with ESMTPSA id 6D5F915E1BC3;
        Wed, 24 May 2023 12:53:41 +0000 (UTC)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: DIENSTLEISTUNGSDARLEHEN
To:     Recipients <roy@mail.posokab.go.id>
From:   "LEIHSERVICE" <roy@mail.posokab.go.id>
Date:   Wed, 24 May 2023 15:53:35 +0300
Reply-To: bryandav381@gmail.com
Message-Id: <20230524125341.6D5F915E1BC3@mail.posokab.go.id>
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,
        RCVD_IN_SBL,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,
        URIBL_BLOCKED,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: posokab.go.id]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [36.91.28.163 listed in zen.spamhaus.org]
        *  0.1 URIBL_SBL_A Contains URL's A record listed in the Spamhaus SBL
        *      blocklist
        *      [URIs: mail.posokab.go.id]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 RCVD_IN_MSPIKE_L5 RBL: Very bad reputation (-5)
        *      [36.91.28.163 listed in bl.mailspike.net]
        *  0.0 T_SPF_HELO_PERMERROR SPF: test of HELO record failed
        *      (permerror)
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [bryandav381[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PROSPECT RAPID SERVICE LOAN COMPANY bietet:
A. 2 % und 3 % weltweiter privater Barkredit und Projektfinanzierung.
B. Weltweiter Handel mit Kryptow=E4hrungen.
C. Finanzielle Bankinstrumente wie Bankgarantie (BG) und mittelfristige Sch=
uldverschreibungen (MTN) auf leicht gew=FCrzter ? Lease- und Fresh Cut (FC)=
-Basis.
D. Offene weltweite Mandats-/Beraterpositionen werden mit einer Provision v=
on 3 % f=FCr jedes initiierte und erfolgreich abgeschlossene Gesch=E4ft ver=
mittelt.

Interessierte Bewerber f=FCr Finanzdienstleistungen sollten sich f=FCr unse=
re Anh=E4nge/Kreditantragsformulare an uns wenden. Das Angebot gilt sowohl =
f=FCr zertifizierte als auch f=FCr nicht zertifizierte Bewerber

Wir sind hier, um Ihre finanziellen Bed=FCrfnisse zu erf=FCllen

Mit freundlichen Gr=FC=DFen,
Bryan David,
Leitender Finanzberater.
PROSPECT RAPID SERVICE LOAN COMPANY.
