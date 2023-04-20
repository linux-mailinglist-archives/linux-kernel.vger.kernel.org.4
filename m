Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09316E904A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjDTKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjDTKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:32:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3AB4218
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:30:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b73203e0aso5805815b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681986618; x=1684578618;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZJwgBs4ZvH2V5COMqVnJxTF1DZNj66jHJe8317ccew=;
        b=To+N6GYKVWlKl+AKICApsLKrCBzMftW3PQ9TvC2sfgTLoJNowmD3cD3i11lXS1OPcS
         l9tm/gU8V9DrJargg6IbqdYYMgSTVMo5qJ3DS84loNektkoz0r44JV00f7zsuDRLsc3A
         xpeIJIQvpPjlMUQYqcO341n36Fyr4mVs3pKsOuJkzGB++qFndOUm32KwPS7PS8oU771f
         xDrTGTyFCDwKMaVVgsWkfqIaUkbA7rQvUwmsxGxGYsaREp8fIhXDjImLFYMzMXrI1bBN
         1/Ruvx294pXIks608jl3q1/bPpbxzieXtt6UYQ0Rb7f5hv75Nc3XG8TW8dVz9Xo9Af4X
         riaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986618; x=1684578618;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZJwgBs4ZvH2V5COMqVnJxTF1DZNj66jHJe8317ccew=;
        b=EogQannp2RCNvZKJk/04UV5sBuoX7AYSIsFTw3jJkT9caTU7++f/wxkd+UdY/81nqG
         BlxF2aKCyqBF0kbXdkbbpAiItIOb6IarbubrAN7VQ6HDRVwDets6VJk3TjI3ub7qWWLz
         Aor01citPUTSsMhuGYnBWNVa/U8mDUtt+myynMZpfKqJBNr0GBciF1DG11AS0MEHMm9n
         cm5lyHQvrwkKjuvOHS1wimXPhL9qNZsjhw5uxrbB2usS9Y7hqoH0op5oJJVbiyEgEoAL
         c3czXgypV/k9iB4lNWIiyShgEJhJqoIci5K33iaowGp0hAtvKMsWYK46KL4Z4zyo2M25
         V9EA==
X-Gm-Message-State: AAQBX9d67zIOpcUVOQlVteSWMbQ8ad5Mtuzi5JeBDiNLhYmu+ZTZFgJL
        BNnJYMZExJ8KTjg1IZfesAX2+7IIja7tkJiSrMM=
X-Google-Smtp-Source: AKy350bzY6DGKMoKINMVR1l8FhyqS1HOEPgaCAqwDf7VLhho8hpVkf2yWm9PHfRMOmtwNHsbCG37Xdyo36ah9RxxtPk=
X-Received: by 2002:a17:90b:a04:b0:244:d441:8f68 with SMTP id
 gg4-20020a17090b0a0400b00244d4418f68mr6333223pjb.16.1681986618241; Thu, 20
 Apr 2023 03:30:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: chernovetskyi@yandex.com
Sender: orjis7734@gmail.com
Received: by 2002:a17:522:2354:b0:4ce:2a7:694b with HTTP; Thu, 20 Apr 2023
 03:30:17 -0700 (PDT)
From:   Stepan CHERNOVETSKYI <imf4456657@gmail.com>
Date:   Thu, 20 Apr 2023 03:30:17 -0700
X-Google-Sender-Auth: moKsUei7rDH02xSn9rH1dhjbaYA
Message-ID: <CAH4GqQMzG=m4adktMJaZRYbC=UHva95OtL2BGCiCQEddm32UxA@mail.gmail.com>
Subject: INVESTITIONEN NACHFRAGEN
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber Freund,

Vielen Dank, dass Sie auf meine Nachricht geantwortet haben, die ich
Ihnen geschickt habe. Ich habe Ihren Kontakt aus der
Google-Personensuche erhalten und mich dann aufgrund der Situation in
meinem Land entschieden, Sie zu kontaktieren.

Ich bin Herr Stepan CHERNOVETSKYI aus Kiew (Ukraine); ich war
Gesch=C3=A4ftsmann, Investor und Gr=C3=BCnder der Chernovetskyi Investment =
Group
(CIG) vor der russischen Invasion meines Landes. Ich wohne derzeit
hier in Krzywaczka, Polen, und suche Asyl, da die Situation in der
Ukraine sehr dynamisch ist.

  Ich bin auf der Suche nach einer ehrlichen und zuverl=C3=A4ssigen Person,
die mir beim Kauf von Immobilien und anderen Investitionsprojekten in
Ihrem Land hilft. Aufgrund der Invasion Russlands in mein Land, der
Ukraine, halte ich es f=C3=BCr notwendig, mein Investitionsprojekt in Ihrem
Land zu diversifizieren, um mich davor zu sch=C3=BCtzen Zukunft meiner
Familie, nachdem mein Gesch=C3=A4ft von den russischen Milit=C3=A4rtruppen
zerst=C3=B6rt wurde und in meinem Land aufgrund der Krise keine sinnvolle
Gesch=C3=A4ftst=C3=A4tigkeit stattfindet.

  Bitte, ich m=C3=B6chte mit Ihnen die M=C3=B6glichkeit besprechen, wie wir=
 als
Gesch=C3=A4ftspartner zusammenarbeiten und durch Ihre Unterst=C3=BCtzung in
Ihrem Land investieren k=C3=B6nnen, wenn Sie mir helfen k=C3=B6nnen.

   Bitte antworten Sie dringend, wenn Sie an einer Partnerschaft mit
mir interessiert sind, um weitere Informationen zu erhalten.
Mit freundlichen Gr=C3=BC=C3=9Fen,
Herr Stepan CHERNOVETSKYI.
