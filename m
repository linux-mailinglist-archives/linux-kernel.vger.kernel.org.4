Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B135B6BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiIMKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIMKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:44:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21F5E643
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:44:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b23so11345153pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=yhVK8WrZm26ZcSVr19Po16EXfW5YQpPJlTEdqhl2uLA=;
        b=GfUZ1cYNoPoctR7/l6/MYGJAbAglU5djikC3MLE645dY3WQ7H6BVg/4ZcemKyForQp
         tB3IRU1ELMe8Zq1g6ukC7GKKTwHDoF5CUrJxNEqI7SP9x0rUJY8bj5Wgrd1JcpWyYYhW
         SK6i35d0DWqpChv9GGv5Et39EwWRGJzVc2P4gKAgK5F2hkSM2RmOoi+Bkz+fKnB4GFQb
         oz6LrgsyMLDWpTNWTJeCT3oYx0SgLmwL3lRs58FWZEYzTfSaak2YIwpfH++s0awCBl6P
         UKmIHZZNBirbq1oCdyyz5VL5i95t/lKjjv5ODHvxbMgdhhehxE7LvP4ZmM/paArqfZlp
         CNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yhVK8WrZm26ZcSVr19Po16EXfW5YQpPJlTEdqhl2uLA=;
        b=dGh8tmUe3AMibWtgsZuzliX4LWpuyu/GJFb64Xmi0Q/XI/nog1sLQMNpXMfuHFHiGl
         JQLEhZytCSxK+XhqPwSah1rRAXlIbim8iyTC+pHM8gyS+cpiZbPbr5FfSq7R86gyJX4R
         WT5Mm0DAulLMcBTj+Ioh6immGpN2LX5jrxP8+zX/Gn0+NxuchuCAmr23zylPzgX3gpZY
         +ip7GVe5IaPCx3QVlTI5YJLEEPrNcn+erX9N8Lc5/1Az0iUnnN5W9ISGIgG4+WihN48w
         tYoRhqcyWPP9lrlXQSGBZVoqRMJNVXgEKCJes4TKTBXX3ipZ1DX1s5Qv+N8H43yJKn1U
         UE8w==
X-Gm-Message-State: ACgBeo0BnzV815f23xd5lq3WZILIJZdEvneVfSaR+IAw1RT1BTJCClJp
        RiGdkedavQzJCHiZEcpQCd8JBSV2BsiX5aydttNnr4iPG60=
X-Google-Smtp-Source: AA6agR6i935bojFKdB6xeKJ8KZeRCQEPyZ1tKEhe7FTAZf3JqGkgvXqO/Y+kXKrAnkAKrKr7tQHE7uIUjHvkMLY6FMU=
X-Received: by 2002:a5e:c316:0:b0:6a1:4c40:4574 with SMTP id
 a22-20020a5ec316000000b006a14c404574mr3372672iok.58.1663065537472; Tue, 13
 Sep 2022 03:38:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:24d0:b0:35a:632a:f8c5 with HTTP; Tue, 13 Sep 2022
 03:38:56 -0700 (PDT)
Reply-To: marija.sterbenc@aol.com
From:   Marija Sterbenc <marijasterbenc55@gmail.com>
Date:   Tue, 13 Sep 2022 11:38:56 +0100
Message-ID: <CAGcOYb8Kty7QLbe6UAvZb=zOy4Jc1v=c5z7FKO2Znh+d9JAarA@mail.gmail.com>
Subject: Asszony Marija Sterbenc
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:430 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1405]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [marijasterbenc55[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marijasterbenc55[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asszony Marija Sterbenc

Legkedvesebb az =C3=9Arban,

Minden tiszteletem =C3=A9s embers=C3=A9g mellett k=C3=A9nytelen voltam be=
=C3=ADrni a
humanit=C3=A1rius ter=C3=BCleten.

=C3=96zvegy Marija Sterbenc =C3=B6reged=C5=91, hosszan tart=C3=B3 beteg (r=
=C3=A1k). Jelenleg
mag=C3=A1nk=C3=B3rh=C3=A1zba ker=C3=BClt. Van n=C3=A9h=C3=A1ny alapom, ahon=
nan =C3=B6r=C3=B6k=C3=B6ltem
a f=C3=A9rjem, Anthony Sterbenc, aki k=C3=A9s=C5=91bb aut=C3=B3balesetben h=
alt meg.

Amikor a f=C3=A9rjem =C3=A9letben volt, 4.500.000.00 eur=C3=B3t let=C3=A9tb=
e helyezett
(4.500.000.00 eur=C3=B3) egy bankban. Jelenleg ez a p=C3=A9nz m=C3=A9g mind=
ig a
bank.

Az orvosom azt mondta, hogy a k=C3=B6vetkez=C5=91 3 h=C3=B3napig nem fog ta=
rtani
r=C3=A1kprobl=C3=A9ma.Sz=C3=BCks=C3=A9gem van valakire, aki nagyon =C5=91sz=
inte =C3=A9s istenf=C3=A9l=C5=91 =C3=A9s
szervezet, amely felhaszn=C3=A1lhatja ezeket az alapokat Isten munk=C3=A1j=
=C3=A1ra
a f=C3=A9rj azt tan=C3=ADtotta, hogy ezt az alapot j=C3=B3t=C3=A9kony c=C3=
=A9lokra kell ford=C3=ADtani,
mint p=C3=A9ld=C3=A1ul iskol=C3=A1k, =C3=A1rvah=C3=A1zak, k=C3=B3rh=C3=A1za=
k =C3=A9p=C3=ADt=C3=A9se stb.

Az=C3=A9rt d=C3=B6nt=C3=B6ttem =C3=ADgy, mert nincs gyermekem, aki =C3=B6r=
=C3=B6k=C3=B6lni fog
ezt a p=C3=A9nzt =C3=A9s azt akarom, hogy Isten irgalmas legyen hozz=C3=A1m=
, =C3=A9s
elfogadja a lelkemet.
Istennel minden lehets=C3=A9ges. K=C3=A9rem, ha tudja haszn=C3=A1lni
ezeket az alapokat Isten munk=C3=A1j=C3=A1ra, kedves

Szeretn=C3=A9m, ha elk=C3=BClden=C3=A9 nekem az al=C3=A1bbi inform=C3=A1ci=
=C3=B3kat.

A teljes neved -----------------------
Orsz=C3=A1god -------------------------
C=C3=ADmed --------------------------
A korod ------------------------------
Az =C3=96n =C3=A1ll=C3=A1sa ------------------------
A telefon ------------------------
Amint megkapom a v=C3=A1lasz=C3=A1t, megadom a kapcsolattart=C3=B3j=C3=A1t
Bank =C3=A9s =C3=A9n is ki=C3=A1ll=C3=ADtunk =C3=96nnek egy felhatalmaz=C3=
=B3levelet, amely megteszi
megmutatja, hogy =C3=96n az alap jelenlegi kedvezm=C3=A9nyezettje.

Rem=C3=A9lve, hogy megkapja v=C3=A1lasz=C3=A1t. Legyetek =C3=A1ldottak az =
=C3=9Arban.

K=C3=B6sz=C3=B6n=C3=B6m

Tisztelettel

Asszony Marija Sterbenc
