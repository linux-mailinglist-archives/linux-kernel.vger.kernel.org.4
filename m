Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA266A4149
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB0L77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0L75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:59:57 -0500
X-Greylist: delayed 619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 03:59:55 PST
Received: from jayabaya.inti.net.id (jayabaya.inti.net.id [103.53.76.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC18C168;
        Mon, 27 Feb 2023 03:59:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by jayabaya.inti.net.id (Postfix) with ESMTP id E02102062C799;
        Mon, 27 Feb 2023 18:49:29 +0700 (WIB)
Received: from jayabaya.inti.net.id ([127.0.0.1])
        by localhost (jayabaya.inti.net.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Z5wPFsBpZAF; Mon, 27 Feb 2023 18:49:26 +0700 (WIB)
Received: from jayabaya.inti.net.id (localhost [127.0.0.1])
        by jayabaya.inti.net.id (Postfix) with ESMTPS id 1D0842062C782;
        Mon, 27 Feb 2023 18:49:26 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 jayabaya.inti.net.id 1D0842062C782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inti.net.id;
        s=25E9A704-571A-11E6-9418-628C66225056; t=1677498566;
        bh=CrM1CZv8v8352BqwtRx6w2ospgnxUoQ1Qfrn1jF8Fqw=;
        h=Date:From:Message-ID:MIME-Version;
        b=wRllvUaYSATCXbaB2jAaCXOMSsUWGJ4g3pxSolHjFBasziN2N6FEj2/xQ4RKcCHR1
         i4m1ahMvvfqSgEKG3D/0FqlmEwHj5iDcnYHoX8lc0CcpaDwdzsHwiAgaYCsqw3TS7u
         ZcJAOSzbeEqoSBqv4GayW4vaye/8aWCmiwfS5NuFJfW1S7kpPD3pgyzP370LlWx9iT
         Un/myEzfL47N+q4pAjdy9J95enTsd/Hd162iiDjADtinacgwTxvGiHt78HqL/p4N8Q
         2Sln/ZDD38aDh/6OPTgdVxgHCql81n8Z7BU9mDMgXqd+Az+auGkiNlmUeXcbcdrqMa
         9+Mu87keYQ2cw==
Received: from jayabaya.inti.net.id (jayabaya.inti.net.id [103.53.76.30])
        by jayabaya.inti.net.id (Postfix) with ESMTP id 59CD8206164DB;
        Mon, 27 Feb 2023 18:49:24 +0700 (WIB)
Date:   Mon, 27 Feb 2023 18:49:24 +0700 (WIB)
From:   =?utf-8?B?0KHQuNGB0YLQtdC80L3Ri9C5INCw0LTQvNC40L3QuNGB0YLRgNCw0YLQvtGA?= 
        <ali@inti.net.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <1345440694.85204.1677498564192.JavaMail.zimbra@inti.net.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [103.53.76.30]
X-Mailer: Zimbra 8.7.11_GA_3808 (zclient/8.7.11_GA_3808)
Thread-Index: r6ewl6eVrxzwczFYme654eD7Zmeg0w==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,MISSING_HEADERS,
        REPLYTO_WITHOUT_TO_CC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92=D0=9D=D0=98=D0=9C=D0=90=D0=9D=D0=98=D0=95;

=D0=92=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=
=D1=89=D0=B8=D0=BA =D0=BF=D1=80=D0=B5=D0=B2=D1=8B=D1=81=D0=B8=D0=BB =D0=BE=
=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
 5 =D0=93=D0=91, =D0=BA=D0=B0=D0=BA =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=
=BB=D0=B5=D0=BD=D0=BE =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=
=80=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BC, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D0=B2 =D0=BD=D0=B0=D1=81=D1=82=D0=BE=D1=8F=D1=89=D0=B5=D0=B5 =D0=
=B2=D1=80=D0=B5=D0=BC=D1=8F =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=
=82 =D0=BD=D0=B0 10,9 =D0=93=D0=91, =D0=B2=D1=8B =D0=BD=D0=B5 =D1=81=D0=BC=
=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=
=D1=8F=D1=82=D1=8C =D0=B8=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B0=
=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=83=D1=8E =D0=BF=D0=BE=D1=87=D1=82=D1=83=
 =D0=B4=D0=BE =D1=82=D0=B5=D1=85 =D0=BF=D0=BE=D1=80, =D0=BF=D0=BE=D0=BA=D0=
=B0 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=
=BF=D0=BE=D1=87=D1=82=D1=83 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D0=BE=D0=
=B3=D0=BE =D1=8F=D1=89=D0=B8=D0=BA=D0=B0 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=
=80=D0=BD=D0=BE. =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=
=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=
=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B8=D0=
=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BD=D0=B8=D0=B6=D0=
=B5:

=D0=B8=D0=BC=D1=8F:
=D0=98=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8F:
=D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=9F=D0=BE=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=AD=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=D0=BD=D0=B0=D1=8F =D0=BF=
=D0=BE=D1=87=D1=82=D0=B0:
=D0=A2=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD:

=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=
=D1=82=D0=B5 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=
=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=
=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=B2=
=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=
=D0=B8=D0=BA =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BE=D1=82=D0=BA=D0=BB=D1=8E=
=D1=87=D0=B5=D0=BD!

=D0=9F=D1=80=D0=B8=D0=BD=D0=BE=D1=81=D0=B8=D0=BC =D0=B8=D0=B7=D0=B2=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BD=D0=B5=D1=83=D0=B4=D0=BE=
=D0=B1=D1=81=D1=82=D0=B2=D0=B0.
=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D0=BA=
=D0=BE=D0=B4: en: WEB. =D0=90=D0=94=D0=9C=D0=98=D0=9D=D0=98=D0=A1=D0=A2=D0=
=A0=D0=90=D0=A2=D0=9E=D0=A0=D0=90. RU006,524765 @2023
=D0=9F=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D1=85=D0=BD=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=8F =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=
=D1=80=D0=B6=D0=BA=D0=B0 @2023

=D0=A1=D0=BF=D0=B0=D1=81=D0=B8=D0=B1=D0=BE
=D0=A1=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=D0=BC=
=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80.
