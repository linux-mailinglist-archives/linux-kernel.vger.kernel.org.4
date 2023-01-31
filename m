Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02DB682F69
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAaOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:37:26 -0500
Received: from mx-gw-prx01.wika.co.id (pegasus.wika.zone [103.25.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A7B12D64;
        Tue, 31 Jan 2023 06:37:23 -0800 (PST)
Received: from mx-gw-prx01.wika.co.id (localhost.localdomain [127.0.0.1])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id 0B57243EC2;
        Tue, 31 Jan 2023 21:37:22 +0700 (WIB)
Received: from smtp-gw.wika.co.id (smtp-gw.wika.co.id [10.4.0.44])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id 3365E43EB6;
        Tue, 31 Jan 2023 21:37:21 +0700 (WIB)
Received: from smtp-gw-01.wika.co.id (localhost [127.0.0.1])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id 9FF5421369;
        Tue, 31 Jan 2023 21:37:05 +0700 (WIB)
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from smtp-gw.wika.co.id ([127.0.0.1])
        by smtp-gw-01.wika.co.id (smtp-gw-01.wika.co.id [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lKAZokgLXwYw; Tue, 31 Jan 2023 21:37:05 +0700 (WIB)
Received: from mailbox.wika.co.id (unknown [10.4.0.84])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id DF5AB2133F;
        Tue, 31 Jan 2023 21:36:39 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 651747FDB6786;
        Tue, 31 Jan 2023 21:36:42 +0700 (WIB)
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3i6Ti0Kkb6tZ; Tue, 31 Jan 2023 21:36:41 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id E43027FC89313;
        Tue, 31 Jan 2023 21:36:40 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailbox.wika.co.id E43027FC89313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wika.co.id;
        s=3A269092-2A4A-11ED-99C4-3E27D2C9E2D5; t=1675175801;
        bh=LjBXUFVAwYLFBDK7H9dfJR2LVch/buu352HP+VChywc=;
        h=Date:From:Message-ID:MIME-Version;
        b=aSw+TO0Xc3q+90viYi6+pAN6yKhSbPyzgEu5mh5//CSTJ3rPTnEKnVcr28oaglfxW
         Ju4vXb9NxxC+go03D97Fsta1OaqepE/1xWW284tDw+Qmi6sNj4IJl4l51nBkho7tI7
         KE+d6DQjQU2HCtCDbIZIHR+gBZhTuRAQ79GjZ195hfgLEJCpYyCNyJwRpsL5ZgQcSy
         tCasKogCIjiLyv7QjBk8GRgyBErYu4ockPJNPe8f4xayEuE9xRx+P0f3GQJPujgf1c
         PLLdEnupHIYh+2NmikJlJao6OvOGO/C/kl22VSwBCZNINJdHtHA/g7AyX9QXl9i1rk
         q8wJUQSGjGCCg==
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jWHNa6yBeEFm; Tue, 31 Jan 2023 21:36:40 +0700 (WIB)
Received: from mailbox.wika.co.id (mailbox.wika.co.id [10.5.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 80E177FC89308;
        Tue, 31 Jan 2023 21:35:57 +0700 (WIB)
Date:   Tue, 31 Jan 2023 21:35:57 +0700 (WIB)
From:   =?utf-8?B?0KHQuNGB0YLQtdC80L3Ri9C5INCw0LTQvNC40L3QuNGB0YLRgNCw0YLQvtGA?= 
        <wellbeing@wika.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <424193689.90066.1675175757158.JavaMail.zimbra@wika.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [10.5.0.1]
X-Mailer: Zimbra 8.8.12_GA_3866 (zclient/8.8.12_GA_3866)
Thread-Index: 4wkYTzWVRFlG+CokEpoP7kajITMYDQ==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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

