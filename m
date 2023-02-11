Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFB693170
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBKONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:13:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F92A6E9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:13:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so22155023ejx.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2W6fH16FA2/6eQDF1zQFhED1OmsIaecTWCUQ1lGtQUg=;
        b=CbheKqWzeuaLZxejYIAiwGB2/+AM+eV9j5CTnvmFr2VoIKHPoq9wZNERl7mNbBq2/r
         8nCVdRrP5ikUbWoejzT5naXVnLFfajT29qUhNuiGMunNMfhJsV5ZI5Kpqhn0x7zbKXXR
         z3UbEfMmTgtsqjfRUA3G7hBHIjBhE6odrlCdBOQYnMHaTdBuwYWqGCcGogPkSrGLxrlR
         4zMiNA92CZUob29I1KzahsvoGhup76WFnvElMsu15p2ZZuL3MgP4MgxNjxXcUlZtFgOu
         sd8ZI4nxcOPgy8GIAQQMz0A6MvWnEboKE5iuDz9iRPWXhPWocmRUbiq2eIu2EqH5B/8W
         ISHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W6fH16FA2/6eQDF1zQFhED1OmsIaecTWCUQ1lGtQUg=;
        b=5Zy/1GNDPlq2I2cnCBX97sEORjhojN4R+qOMrLXpAkwAhK+Js6IYgvnhI46HssQcUw
         atTfxtz0ApNPj1M/HK6HPBcrg0jA1P9Kn9W3PhhRJtosKzFiBHy1Yd4ZXv2cX1i7kYwk
         koAawn4pwWu1W/+23qpYSGQ6DTPmipWng4ufVhj5PaDTqm4Ab/KLwCp+pNAgrRh0t+8X
         dmOwDjIyMV7qG+94b4Mntd7zwh4AMVdYt8b8iMhdwD1cra9UOj+dPdfa6u3zyHulmSmh
         iNElpSMhkAmoSTPQwSWuwb1kfsO8bhLg0GHyDTQqTXH3MbP8/VCKORk43VKGGwisH8l7
         BLnQ==
X-Gm-Message-State: AO0yUKWznbzIyzlm4CvhXxpj758YdVdehW8PDhZfZC5gnUogx+e/HetP
        a954TnbbWdXxlMSnESs2ziWb2G3gVlh2ZdHOBCo=
X-Google-Smtp-Source: AK7set/3zxNYD8yQlfE5utEFh52DqPR91N+p49aTMLoEe6oCmUCFRlKFErkm1coCeTCCN33V3C/0KZtMTpASAydnoM0=
X-Received: by 2002:a17:906:4c99:b0:884:ead1:4e58 with SMTP id
 q25-20020a1709064c9900b00884ead14e58mr2372117eju.4.1676124815899; Sat, 11 Feb
 2023 06:13:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: stepanchernovetskyi@yandex.ru
Sender: humuadams7@gmail.com
Received: by 2002:a17:907:3f92:b0:88f:8aba:8130 with HTTP; Sat, 11 Feb 2023
 06:13:35 -0800 (PST)
From:   Stepan CHERNOVETSKYI <cchernovetskyi@gmail.com>
Date:   Sat, 11 Feb 2023 06:13:35 -0800
X-Google-Sender-Auth: E05z09UAU2UlN-EffcHPGkEkTLM
Message-ID: <CAON-AC5LxgWHuSVGGX2d+aOXzH0auVhgEpVxcEyhh9VjJi59Sw@mail.gmail.com>
Subject: Bitte, ich brauche deine Hilfe
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sehr geehrte Damen und Herren,

Bitte sch=C3=A4men Sie sich nicht, Sie =C3=BCber dieses Medium zu kontaktie=
ren;
Ich habe Ihren Kontakt von der Google-Personensuche erhalten und mich
dann entschlossen, Sie zu kontaktieren. Mein Ziel ist es, mit Ihnen
dort in Ihrem Land eine tragf=C3=A4hige Gesch=C3=A4ftsbeziehung aufzubauen.

Ich bin Herr Stepan CHERNOVETSKYI aus Kiew (Ukraine); Ich war
Gesch=C3=A4ftsmann, Investor und Gr=C3=BCnder der Chernovetskyi Investment =
Group
(CIG) in Kiew, bevor Russland in mein Land einmarschierte. Mein
Gesch=C3=A4ft wurde von den russischen Milit=C3=A4rtruppen zerst=C3=B6rt un=
d es gibt
keine sinnvollen wirtschaftlichen Aktivit=C3=A4ten in meinem Land.

Ich suche Ihre Hilfe und Unterst=C3=BCtzung beim Kauf von Immobilien und
anderen Investitionsprojekten.Ich halte es f=C3=BCr notwendig, mein
Investitionsprojekt in Ihrem Land aufgrund der Invasion Russlands in
mein Land, die Ukraine, zu diversifizieren und die Zukunft meiner
Familie zu sichern.

Bitte, ich m=C3=B6chte mit Ihnen die M=C3=B6glichkeit besprechen, wie wir a=
ls
Gesch=C3=A4ftspartner zusammenarbeiten und durch Ihre Unterst=C3=BCtzung in=
 Ihr
Land investieren k=C3=B6nnen, wenn Sie mir helfen k=C3=B6nnen.

Bitte, wenn Sie an einer Partnerschaft mit mir interessiert sind,
antworten Sie bitte dringend f=C3=BCr weitere Informationen.

Mit freundlichen Gr=C3=BC=C3=9Fen,
Herr Stepan TSCHERNOWEZKI.
Adresse Nr.: 26 Urochishche Natalka,
Kiew (Kiew) 04209 Ukraine
E-Mail-Adresse: chernovetskyi@chemist.com
