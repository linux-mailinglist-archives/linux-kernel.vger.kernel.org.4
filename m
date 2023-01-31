Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE086830FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjAaPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjAaPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:11:57 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76285552AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:09:57 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s41-20020a05683043a900b0068bd63d34d0so1392627otv.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztle2daLV2Ol1mZZSbgVEf6Z84P5M5IegFTTzfrvXK8=;
        b=ZweK5xRpWTJim9Bv1/MIvGL+yQjz5NL6iXC8aKUlbN4LXyN0jBmU9PquqCE/fIkldL
         Q+PP02jD6yGpULfaQgRuucrczl/6cGwduQS6JJnBjw0Hh/pdfbG6c10dk8FfJC4C0sR0
         rnOWD77Jq7/QTJETtEOR++xDgJEhhmA3LVfK02XUKnbWTsrmYX/aZVKyuTTmxTkWeXY3
         kAq+HRMxrSdIokpPwbI1jCzFQ+btl1jIi6g9J/X9e5QanBFaNGmB3k4dbdPIDpw0R/xx
         8NSEsTjUn4rLl+gcL/2+1ocot4yvYBvDduUlk2Fyhhbl/Ys4zXuINS8KsKFmSXg1wrGt
         TBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztle2daLV2Ol1mZZSbgVEf6Z84P5M5IegFTTzfrvXK8=;
        b=Z2uARySS9Y4QTqWm38lxpQWqBW89QChxUQxuQF//Rrsd84Ds6cuptBm8MYDmBibJVu
         rPVEzZwSr2jCin+/pvVqJlNoIQDzhjov2AjkZxGPWCgxcbF18AHNv3AHuPyBt7cDwzuI
         DDzyFYZGBAW8rSrP40g5B7fRqX/v2q5hnwfmHmHT3jWnOzInlWaSghDwdaQoHJmGLaoj
         WkJdO+ieCFObOyXcM9LQkRIxyTgGdBKQ3PPvU7PS2p/fjjxtPslOVNcefS72taeI1ZJC
         vbOzZm5VwmR7GhlYeuY26j30l+6cJA+Gw/5H05j48nrB/Ga+iMwKvVJLuzFDMIY0TZq5
         35WQ==
X-Gm-Message-State: AO0yUKVVboQbkItGbiB4N0tpMQZdZj7m1pcWkD3o6hmaAt1gOEM3jVoV
        mtBSACKv5ovmCCvEG5/s6OBTUkmWegsyojM4bJg=
X-Google-Smtp-Source: AK7set8C4sqAI2t5yaXBqHuhLJnlx97knCSnvQkikP08rXxNs1hD/jMOYazXOSBDpUQOHlNKPBbhQJGiloZzh16KK10=
X-Received: by 2002:a05:6830:309f:b0:68b:d33a:8691 with SMTP id
 g31-20020a056830309f00b0068bd33a8691mr359741ots.104.1675177721687; Tue, 31
 Jan 2023 07:08:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:5293:b0:df:cce3:e4bc with HTTP; Tue, 31 Jan 2023
 07:08:41 -0800 (PST)
From:   Barrister Abraham <barristera380@gmail.com>
Date:   Tue, 31 Jan 2023 07:08:41 -0800
Message-ID: <CAOdGwCWb-1cBeB2_5nY6SSv6X7gkOBToSmaq4bVtHTQRNkYXgw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:332 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barristera380[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barristera380[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oppmerksomhet takk,

Jeg er Mr. Abraham Morrison, hvordan har du det, jeg h=C3=A5per du er frisk
og frisk? Dette er for =C3=A5 informere deg om at jeg har fullf=C3=B8rt
transaksjonen vellykket ved hjelp av en ny partner fra India, og at
fondet n=C3=A5 er overf=C3=B8rt til India til bankkontoen til den nye partn=
eren.

I mellomtiden har jeg bestemt meg for =C3=A5 kompensere deg med summen av
$500 000.00 (kun fem hundre tusen amerikanske dollar) p=C3=A5 grunn av din
tidligere innsats, selv om du skuffet meg langs linjen. Men likevel er
jeg veldig glad for en vellykket avslutning av transaksjonen uten
problemer, og det er grunnen til at jeg har bestemt meg for =C3=A5
kompensere deg med summen av $500 000,00 slik at du vil dele gleden
med meg.

Jeg anbefaler deg =C3=A5 kontakte sekret=C3=A6ren min for et minibankkort p=
=C3=A5
$500 000,00, som jeg beholdt for deg. Kontakt henne n=C3=A5 uten
forsinkelser.

Navn: Linda Koffi
E-post: koffilinda785@gmail.com

Vennligst bekreft til henne f=C3=B8lgende informasjon nedenfor:

Ditt fulle navn:........
Adressen din:..........
Ditt land:..........
Din alder:.........
Yrket ditt:..........
Ditt mobiltelefonnummer: ..........
Ditt pass eller f=C3=B8rerkort:.........

Merk at hvis du ikke har sendt henne informasjonen ovenfor
fullstendig, vil hun ikke gi ut minibankkortet til deg fordi hun m=C3=A5
v=C3=A6re sikker p=C3=A5 at det er deg. Be henne sende deg den totale summe=
n av
($500 000,00) minibankkort, som jeg beholdt for deg.

Med vennlig hilsen,

Mr. Abraham Morrison
