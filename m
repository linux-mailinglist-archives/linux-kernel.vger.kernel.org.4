Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B46B1A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCIETF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:19:02 -0500
X-Greylist: delayed 4367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 20:18:59 PST
Received: from smtp1.fnusa.cz (smtp1.fnusa.cz [IPv6:2001:718:806:2::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B76EFA4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:18:58 -0800 (PST)
Received: from smtp1.fnusa.cz (mailfilter.fnusa.cz [172.30.0.204])
        by smtp1.fnusa.cz (Postfix) with ESMTP id DB607121A5D;
        Thu,  9 Mar 2023 01:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1678322781; bh=P2Y6aV5Hr6frSoASAbu09uyjGoBEe9aRt+HSKCoBn/I=;
        h=Date:From:Reply-To:Subject:From;
        b=6lqq6GklJFTyKMRd4hUAA0ZqITRFS6AIaWsBHUp//UWxArDnrsyWm4ROjhWFN2iIi
         i5bB5PFK1mU80h+fRq2ZWEgJdzx3QvuV8gMds7R0TwIpMX/ezL0m9iqUTdnlBRykWS
         7zavpQHxMD2Dk2TPh7D3OeugNj3EXxe0BTVar89M=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from zimbros.fnusa.cz (zimbros.fnusa.cz [172.30.0.176])
        by smtp1.fnusa.cz (Postfix) with ESMTP id 0FBC2122B71;
        Thu,  9 Mar 2023 01:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1678322776; bh=P2Y6aV5Hr6frSoASAbu09uyjGoBEe9aRt+HSKCoBn/I=;
        h=Date:From:Reply-To:Subject:From;
        b=54KWTMoxvrPSR0uG5YzYTXx3x/TO5QTIxeJvhLMXoUbXYP3YHo9yO4XSLUrDN0sbT
         KfohtU9eTHcM1IfTGOegtWQ2pFtiyQmC7LPIZoMC7V7xFk58UNrI2Z/fKRJ/NZuExX
         ZGC8UzIeVinhuX4wycyMPrSehcavjrBDxMRo1yZA=
Date:   Thu, 9 Mar 2023 01:45:49 +0100 (CET)
From:   Marion <eliska.stravova@fnusa.cz>
Reply-To: Marion <mabakker562@gmail.com>
Message-ID: <531234093.26485966.1678322749882.JavaMail.zimbra@fnusa.cz>
Subject: =?utf-8?Q?Witaj_s=C5=82o=C5=84ce,?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2001:9b1:8826:0:98:128:186:90]
X-Mailer: Zimbra 8.6.0_GA_1182 (zclient/8.6.0_GA_1182)
Thread-Topic: Witaj =?utf-8?B?c8WCb8WEY2Us?=
Thread-Index: IPGcCqSYCmPFx35l8HQozc950OqNxQ==
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mabakker562[at]gmail.com]
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Witaj kochanie,

Przepraszam, =C5=BCe przeszkadzam i naruszam twoj=C4=85 prywatno=C5=9B=C4=
=87. Jestem singlem,
samotna i potrzebuj=C4=85ca opieku=C5=84czego, kochaj=C4=85cego i romantycz=
nego towarzysza.

Jestem tajemniczym wielbicielem i chcia=C5=82bym skorzysta=C4=87 z okazji
dowiedzie=C4=87 si=C4=99 wi=C4=99cej o sobie nawzajem. Wiem, =C5=BCe kontak=
t z tob=C4=85 jest dziwny
w ten spos=C3=B3b i mam nadziej=C4=99, =C5=BCe mi wybaczysz. Jestem nie=C5=
=9Bmia=C5=82=C4=85 osob=C4=85 i
wiem, =C5=BCe to jedyny spos=C3=B3b, w jaki mog=C4=99 zwr=C3=B3ci=C4=87 two=
j=C4=85 uwag=C4=99. chc=C4=99 tylko
wiedzie=C4=87, co my=C5=9Blisz, a moim zamiarem nie jest obra=C5=BCanie Ci=
=C4=99.
Mam nadziej=C4=99, =C5=BCe mo=C5=BCemy zosta=C4=87 przyjaci=C3=B3=C5=82mi, =
je=C5=9Bli tego w=C5=82a=C5=9Bnie chcesz, chocia=C5=BC chcia=C5=82bym
by=C4=87 kim=C5=9B wi=C4=99cej ni=C5=BC tylko przyjacielem. Wiem, =C5=BCe m=
asz kilka pyta=C5=84
zapytaj i mam nadziej=C4=99, =C5=BCe kilkoma z nich zaspokoj=C4=99 twoj=C4=
=85 ciekawo=C5=9B=C4=87
odpowiedzi.

Wierz=C4=99 w powiedzenie, =C5=BCe dla =C5=9Bwiata jeste=C5=9B tylko jedn=
=C4=85 osob=C4=85,
ale dla kogo=C5=9B wyj=C4=85tkowego jeste=C5=9B ca=C5=82ym =C5=9Bwiatem=E2=
=80=9D. Wszystko czego chc=C4=99 to mi=C5=82o=C5=9B=C4=87,
romantyczn=C4=85 trosk=C4=99 i uwag=C4=99 od wyj=C4=85tkowego towarzysza, k=
t=C3=B3rym jestem
maj=C4=85c nadziej=C4=99, =C5=BCe b=C4=99dziesz ty.

Mam nadziej=C4=99, =C5=BCe ta wiadomo=C5=9B=C4=87 b=C4=99dzie pocz=C4=85tki=
em d=C5=82u=C5=BCszej wsp=C3=B3=C5=82pracy
komunikacji mi=C4=99dzy nami, po prostu wy=C5=9Blij odpowied=C5=BA na t=C4=
=99 wiadomo=C5=9B=C4=87, to
uczyni mnie szcz=C4=99=C5=9Bliw=C4=85.


U=C5=9Bciski i buziaki,

Marion.
