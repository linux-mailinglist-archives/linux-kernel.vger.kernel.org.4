Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165375B6BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiIMKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiIMKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:47:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C65EDD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:47:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e16so20112805wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=yhVK8WrZm26ZcSVr19Po16EXfW5YQpPJlTEdqhl2uLA=;
        b=nw7hKzJ0NaZev1kBtHNWeiT8s4kbr2XkOIUip4DfgNVIlGHpdT3iX6upqTLG2me1dm
         NdcsUIPawLC2nYkjUp70dIFOLbu9VvYXbE6TDdtVqF81xq2L6Zy2W5d5Ljpeo+d3OwF1
         zo3Hu3phWCQcpsK9+s6Ah5/lVwxsxRj/9vi7XB473gs61GgSuFrFpwX9Tq0vwj6e7Jbu
         ErBqLYr7xGjekRrWMrGmAzAL7Um+Up8ysbneMK0hXq8guKQloJIUtFjWiT84MsSGwp8G
         aSuwRjgRWlMuH6CXefh/vU+EaQBoLc3ux1UQzZKqj62yXnxLiDrMJn/W8H44xbLYy3ag
         +JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yhVK8WrZm26ZcSVr19Po16EXfW5YQpPJlTEdqhl2uLA=;
        b=L0tUQwsGhVpVy+GV63ZLvQl4NGH/b9WGFdrllskkg9pW9gcf6bUGQQbgXfXwuWj40Z
         C2/CZkGW+DUbrFld+WenscrqLzn6OMkU0MBG8D/ogDAa09x6+C6PuA9PaKv5B+hWqtAr
         ZWh2R4lNBNib37YFqVSrVhsXv9UjSddulAtkUmg6HqDNISxGIi8oFUTyxbfzyrC4pC1m
         4V5/Rhm6mGm2RvtAzoFMdME6B6o7vQo4623HEfgqWSbTkk65pZ63ZGbmIJAofmc3GstA
         5v98KZJvX6W1OxX2OzUxjciwWLuxSSWE3yur8VjP1vD9oV3+QCA5p7xcWrXPlCxFdRsx
         eJpw==
X-Gm-Message-State: ACgBeo3Ay0TbDRcyfekxnE/SkeHKOqSOabdfn8Lpv0KqyB7VyM+6ZUj2
        GBXtef2IQx8zAvJtvSEdwkFQBt2gGratC0+M+szh4VxX1ow=
X-Google-Smtp-Source: AA6agR42acyh4lTT8z9gAhVYy1wLxloC+BFQRpNRmeO62dAqFBIjtu15+Lh5mQRQvipZRwv/lvSWKhgL0Fw/jkURREw=
X-Received: by 2002:ac2:44ad:0:b0:497:ad5a:c39d with SMTP id
 c13-20020ac244ad000000b00497ad5ac39dmr8753479lfm.666.1663065668690; Tue, 13
 Sep 2022 03:41:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9901:0:0:0:0:0 with HTTP; Tue, 13 Sep 2022 03:41:07
 -0700 (PDT)
Reply-To: marija.sterbenc@aol.com
From:   Marija Sterbenc <marijasterbenc19@gmail.com>
Date:   Tue, 13 Sep 2022 11:41:07 +0100
Message-ID: <CAGtsSUxhc7qEinM1OYbU98nfOt+kEZXOrrtHA=cOTw6p4nm9PQ@mail.gmail.com>
Subject: Asszony Marija Sterbenc
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
