Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1B68EF7D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjBHNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjBHNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:05:07 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9746702
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:05:06 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id m1so17937219vst.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nJE7Umqe7P4VH8Hrbu8vVW2dZ0tQTvT5Zv9JywovP4=;
        b=imyBTqdlyTdwjKTynerYemjl3sWlojZ8S3A5ARjb4DP6hW0egSaTmKkL9RN6RFh9kA
         SQRy1BaGzL+x/ZUSslSk6oDh+9ZH5bN7z0B0Et5goUwEY2ppMofjCZ4f9t9/5gteZJN5
         EiOx6B743GP494T6qR4VIVu1eLeUIPCtRWZuPSxE8HYFR3iqee6tiRgaTjXxU5jULvXB
         o9wLc4jZ/fmJlj+Js2vEoYG4axSbZb94xmfVt0T3OJGovFzdg+1tUJWHJS+N5RPLKR5x
         0rgSepxVjU+TyMMSycYyVR2JrsbfUOy1lx6JpCwzqRkqP0qeaYDOUvhFmcs1IPth/2z5
         wJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nJE7Umqe7P4VH8Hrbu8vVW2dZ0tQTvT5Zv9JywovP4=;
        b=yn0SnhurIrdbIwNPWvDmEEPhTKbpSP8E40V4IxdBoxVPAVsuXCkEipbpBYhKFrHIgb
         KZ8C2a/gjusg3DNSad0gLTMKsbZxeyM++zM5ev8FYPQ5do17v2l0RiAdzgLXL/Fl6l78
         jfS3MideuAzNnTIq0U3D77LPCExfhmAcP7sO1EiuvjglI/GTbRLZG1adjK6TMs8qfR7v
         TnGYPb5o4lieQnd7J51n94nqRg7Bk4rcN3Hqt2KWIWZGqE2msZ0qIAu0r2lpgKtbYd6b
         DbUPTS+/Z/tafH+xAvCdTFSYTVnud24yzmDIWVwjUgTfI8vQGQebisyzmfkGriaPjBSU
         I2/A==
X-Gm-Message-State: AO0yUKVrkI76+qPU80n0fa82ss85fBHTcHw5Ojykw0en+fanVs+yaIDu
        8RO6VzAHkrGkt0sjrJ8KB95BIlz7EvvK+U1ToO4=
X-Google-Smtp-Source: AK7set8ajWEPF6YzvlAURfsFS61p3RYhEMH50ExwL5B654GPKbA4IUCcgse3SezCgN8fRkDAGX+KqJdQDQVhOz6x5no=
X-Received: by 2002:a05:6102:27cb:b0:3fd:2d30:c53e with SMTP id
 t11-20020a05610227cb00b003fd2d30c53emr1654613vsu.35.1675861505322; Wed, 08
 Feb 2023 05:05:05 -0800 (PST)
MIME-Version: 1.0
Sender: ouedraogosylvain68@gmail.com
Received: by 2002:ab0:4424:0:b0:419:7dfe:1545 with HTTP; Wed, 8 Feb 2023
 05:05:04 -0800 (PST)
From:   Hannah Alex <hannah.aalex1@gmail.com>
Date:   Wed, 8 Feb 2023 13:05:04 +0000
X-Google-Sender-Auth: KxDZwdQilJANM1WD98DBkbpmU8U
Message-ID: <CALdawyGM2s-avFaw2N9geSaf_hCJoQjDVJAy5Hw69x8=cEutmA@mail.gmail.com>
Subject: HALLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liebste,
Mein Name ist Hannah Alex, ich w=C3=BCrde mich gerne =C3=BCber Ihre Dienste
erkundigen, um meine zu sein
ausl=C3=A4ndischen Partner / Investor und helfen Sie mir bei der
=C3=9Cbertragung und Verwaltung meiner
Mittel, indem sie in gewinnbringende Unternehmungen wie den Kauf eines
Unternehmens investieren
Aktien oder Immobilien in Ihrem Land. Ich habe eine angemessene Summe, die =
ich
von meinem verstorbenen Vater geerbt, in das Sie mir bei der
Investition helfen m=C3=B6chten
Ihr Land.Ich f=C3=BCge meine pers=C3=B6nlichen Fotos,Zahlungsnachweis des F=
onds,my
Internationaler Pass, die Sterbeurkunde meines verstorbenen Vaters und
vier Seiten
Testament von meinem verstorbenen Vater. Ich schicke Ihnen all dies,
damit Sie es haben k=C3=B6nnen
Vertrauen, dass Sie es mit einer realen Person zu tun haben
Hinweis: Im Folgenden sind die Hauptgr=C3=BCnde aufgef=C3=BChrt, aus denen =
ich
Sie kontaktiere.
(1) Ein neues leeres Bankkonto bereitzustellen, auf dem sich dieses
Geld befinden w=C3=BCrde
=C3=BCbertragen. wenn Sie nicht m=C3=B6chten, dass wir Ihr pers=C3=B6nliche=
s Konto verwenden.
(2) Als H=C3=BCter dieses Fonds zu dienen, da die Bank darauf bestand, dass=
 ihre
Vereinbarung mit meinem Vater war, dass ich einen ausl=C3=A4ndischen
Partner vorstelle
Freigabe des Fonds.
(3) Um Vorkehrungen zu treffen, damit ich in Ihr Land komme, um meine zu f=
=C3=B6rdern
Ausbildung und um eine Aufenthaltserlaubnis in Ihrem Land zu erhalten.
Bitte antworten Sie, sobald Sie diese Nachricht gelesen haben, um
weitere Details und Beweise zu erhalten.
Mit freundlichen Gr=C3=BC=C3=9Fe.
Hannah Alex.
