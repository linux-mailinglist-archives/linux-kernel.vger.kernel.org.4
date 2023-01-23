Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A8677A42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAWLir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAWLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:38:45 -0500
X-Greylist: delayed 926 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 03:38:42 PST
Received: from mx-gw-prx01.wika.co.id (pegasus.wika.zone [103.25.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4482B1E5F7;
        Mon, 23 Jan 2023 03:38:42 -0800 (PST)
Received: from mx-gw-prx01.wika.co.id (localhost.localdomain [127.0.0.1])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id 9542543F72;
        Mon, 23 Jan 2023 18:23:15 +0700 (WIB)
Received: from smtp-gw.wika.co.id (smtp-gw.wika.co.id [10.4.0.44])
        by mx-gw-prx01.wika.co.id (Proxmox) with ESMTP id D4CED42D4B;
        Mon, 23 Jan 2023 18:23:14 +0700 (WIB)
Received: from smtp-gw-01.wika.co.id (localhost [127.0.0.1])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id DB5261D1C5;
        Mon, 23 Jan 2023 18:23:01 +0700 (WIB)
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from smtp-gw.wika.co.id ([127.0.0.1])
        by smtp-gw-01.wika.co.id (smtp-gw-01.wika.co.id [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ndJ5t11NtQNR; Mon, 23 Jan 2023 18:23:01 +0700 (WIB)
Received: from mailbox.wika.co.id (unknown [10.4.0.84])
        by smtp-gw1.wika.co.id (Postfix) with ESMTP id 4956D1D294;
        Mon, 23 Jan 2023 18:22:35 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id D124B7FEDE967;
        Mon, 23 Jan 2023 17:41:39 +0700 (WIB)
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id d9hdkZcGanI1; Mon, 23 Jan 2023 17:41:39 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 5E9B57FEDE962;
        Mon, 23 Jan 2023 17:41:38 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailbox.wika.co.id 5E9B57FEDE962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wika.co.id;
        s=3A269092-2A4A-11ED-99C4-3E27D2C9E2D5; t=1674470499;
        bh=Jx3dcL/IIt9T0ZSV86Zqvxv64a59Mzb0LP9gkXXwYFY=;
        h=Date:From:Message-ID:MIME-Version;
        b=oB3ph2URBjV0SWV8wTOOYA7QxRC1XY9DPePkJrs/s1hVAX825JDcQzII0IWw8qT0e
         yp8Wv0sEUq842LvR6his4mDpvkl/C9uBDebHYivybT5JBYWFszLPRviP4wGkehr5oE
         P1HUYWLe3oaAvErjkuEuZEGmzayw4L7RhPqUzwx3mftGUpfn6QAIK71YxTBvqg8FY8
         I0a4qPcygQCkwn6lIVkqAf9gwIb4ekfPcghfvWu/OWCqvzobKg31uvKxwsw5iA1aOe
         P4Z7cJzJmu02wlM7xs/wb4T/VFnLDJJ5XC10NNWYU8k6vjyvoBodNNfkvoe/Rry4zq
         ay9dSmsgAVtFA==
X-Virus-Scanned: amavisd-new at wika.co.id
Received: from mailbox.wika.co.id ([127.0.0.1])
        by localhost (mailbox.wika.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S9Lljg84lApW; Mon, 23 Jan 2023 17:41:37 +0700 (WIB)
Received: from mailbox.wika.co.id (mailbox.wika.co.id [10.5.0.1])
        by mailbox.wika.co.id (Postfix) with ESMTP id 7BCA57FE3B31A;
        Mon, 23 Jan 2023 17:41:05 +0700 (WIB)
Date:   Mon, 23 Jan 2023 17:41:05 +0700 (WIB)
From:   =?utf-8?B?0KHQuNGB0YLQtdC80L3Ri9C5INCw0LTQvNC40L3QuNGB0YLRgNCw0YLQvtGA?= 
        <wellbeing@wika.co.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <1834817443.1773547.1674470465704.JavaMail.zimbra@wika.co.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [10.5.0.1]
X-Mailer: Zimbra 8.8.12_GA_3866 (zclient/8.8.12_GA_3866)
Thread-Index: aW51MjFEPLpubSKbG9l0vEMDCm2jfg==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

