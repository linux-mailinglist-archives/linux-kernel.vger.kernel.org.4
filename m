Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80E76A965A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCCLdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:33:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D431CDE2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:32:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d6so1272330pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843150;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZPNy2m65J4or9S1ciAWfr/hetKH7sp73g11/Q9rN90=;
        b=ahjMGp/Y9hpmOf4tFtZrgG6+sBW/PcCUKdyNqhAgdv4fq9owY4mrhghNL4bX+6Ue3S
         b5UthoT2P+1kRdYwVO6Zlxm7Jf3snk8DDltShifhwF1La/6dq60Ah+gV48/GuE9NL8Fs
         x1jmFBWsIM6alUMXz6xDusl09P9XLl40BSQRS9JeG71C3OpfX56hNA1o5Lstq2zuDdkr
         ez+M2JvWVQjnR+OWNiSc+gy5KD5WVf/abgqYjf5lsS/wS0jQW/4Ec2pXeguqbiwUY+gm
         q9vS99lWAJjiLddeJ6WJWeppYq9+tIW3hC3BCpzRF45wmN8yxfLaepGYYNc5XNwfmMza
         7Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843150;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZPNy2m65J4or9S1ciAWfr/hetKH7sp73g11/Q9rN90=;
        b=1dX0auBfi6eOnKQPzz1xtet9/ObZXM7yI2t8KRzu4vWOzIvCdw4Z8SGZhuIkMi+aQ7
         ZmvwORqHSu4trsFHQhT5CRJEbl2mO1uAN+oXcXdNVBaxm1/K9qjE+JKD6oUQf99pD76+
         qK8MNucdFSN6gnV9RHAN5zuc/HKJGvVlRFRqXIX84cnAuu2Qn6pVKojXj208qhYYzvM4
         +2xd1y+Sg6tMpe2TZ5u3AOYo1qZ7Nd1BXLE4fj0026xtkxsFGUhgpYztB0n8hQmQLau3
         7/t08f2neDW/M/NJVX6Wux1R8kGRvh2jMLpnObivJ7lhKQn1j/CBDb0orgJPdAvB2CFW
         IyBg==
X-Gm-Message-State: AO0yUKXWuFh7RKA7Yt4N7n5OTtJ6g2qAavOXleKjySS44dtmv7SCDlUU
        +gbByEV158k29PBZdWJ9X0UwzH6Fa7ASCjDdBGg=
X-Google-Smtp-Source: AK7set+u8alBgErQToAKkyOpQZlo82CBDK5KkNf1VrhhnT70SUb132+u8U/ZJHHnnX42hJA+8H5+WgIMAsy6LRGfTqc=
X-Received: by 2002:a63:924d:0:b0:503:a26e:b4cf with SMTP id
 s13-20020a63924d000000b00503a26eb4cfmr372582pgn.8.1677843149620; Fri, 03 Mar
 2023 03:32:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:abc9:0:b0:5e1:af18:533a with HTTP; Fri, 3 Mar 2023
 03:32:29 -0800 (PST)
From:   Patrick Lema <rev.lema1@gmail.com>
Date:   Fri, 3 Mar 2023 11:32:29 +0000
Message-ID: <CADhqz9UarQSpp0CyzpSn2DFdHd4==tWEniAp_LENo6SzoQ7BXg@mail.gmail.com>
Subject: Hallo mein Lieber im Herrn
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo mein Lieber im Herrn

Es tut mir sehr leid, dass ich im B=C3=BCro sehr besch=C3=A4ftigt war.

Guten Tag, sind Sie wirklich die wahre Person, ich wurde von Tony
William angewiesen, diese Visa-Karte zu senden? Bitte beschuldigen Sie
mich nicht, dass ich gefragt habe

Diese Fragen, obwohl ich Ihren Namen auf der Visakarte gesehen habe,
weil ich Sie noch nie pers=C3=B6nlich gesehen habe. Ich wurde von Herrn
Tony William nur angewiesen, bevor er reiste, diese Visa-Karte im Wert
von 1.800.000,00 USD an den Besitzer zu senden, sobald der Besitzer
mich daf=C3=BCr kontaktierte, aber ich war =C3=BCberrascht von Ihrem Kommen=
tar.
Die Visa Card ist hier in meinem B=C3=BCro auf Ihren Namen geschrieben.
Meine Liebe, ich habe Angst davor, die Visa Card mit diesem Betrag an
die falsche Person zu senden, deshalb stelle ich diese Fragen, um
sicherzustellen, dass ich nicht in den falschen H=C3=A4nden war.

Machen Sie mir bitte keine Vorw=C3=BCrfe, denn als Mensch wie ich mit
Gewissen wird es Ihnen genauso gehen, wenn Ihnen ein v=C3=B6llig Fremder in
solch vertraulichen Angelegenheiten im Internet schreibt, also teilen
Sie bitte meine Bef=C3=BCrchtungen und machen Sie mir keine Vorw=C3=BCrfe.
Aufgrund Ihres Namens, den ich auf dieser Visakarte gesehen habe, habe
ich ein implizites Vertrauen in Sie, deshalb habe ich Ihnen sogar
geantwortet und ich verlange, dass Sie mich auf die gleiche Weise
halten. Wenn Sie wirklich der Besitzer dieser Visa Card sind, geben
Sie mir die folgenden Anforderungen, damit ich Ihnen Ihre Visa Card
=C3=BCber die FedEx Delivery Company oder den DHL-Zustelldienst zusenden
kann. Sie k=C3=B6nnen jeden Lieferservice w=C3=A4hlen, der f=C3=BCr Sie in =
Ihrem Land
in Ordnung ist.


                                           Dinge ben=C3=B6tigt

1. Ihre vollst=C3=A4ndigen Namen................
2.Ihre direkte Postanschrift, kein Postfach.......
3. Ihr direkter Telefonanschluss.......................
Dein Land...............

Bleib gesegnet
Dein im Herrn
Pfr. Patrick Lema
