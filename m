Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B16659C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAKLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAKLGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516164DE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:06:40 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f21so11219392ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlU9cpwZ1PhCgBax6Dj5BCT7f5O5MeFEUr5QdrO4Wuw=;
        b=KVN/KMy+6Nf87cMlNGqVVm+d1iauocAzUj51JKpCr5475sdbrIitYs74KVun7lLA7a
         RJosKNtiO9EwlWDWASZ8J041x6lnGDEtfafBlyoseZRA5nq0+1mHrJeHfqPdU53UAEpI
         ooL26nFPFPrg0tsYH8OZPg7USS59wkUWzLWrXfysZZaNj0rqVJHvI2yaIDoR3JvxUBkF
         rPdSQiiReSi60QR3s11L6xJnxod5YSzybLLbjFtXelC3m8vcNuTTfunM0f6Lc/PiLLqt
         4+BPREae+gj68z6xCO50zO1deNLWaCFDs9g5s87bmW/jU4Ze4ltz+iHAihR18VnDueRH
         e7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlU9cpwZ1PhCgBax6Dj5BCT7f5O5MeFEUr5QdrO4Wuw=;
        b=jAHs/RGFmzFsx6rKE5ASiBk4cIywGeOk7HLQtphRor/P0KKwEUP1UJuALBAPsZ/6gI
         Non4aZeuOk0je0wUqjEOsBasBb6BSgKFrmtTRyueStGG47B3bO92xViBiipQvt2wvZ0r
         Swludyy/HV4Ra7liizGokHYygzNep3bJ4Yhu4I90ud49hvsjfuuLgyEtHxtHiZualLXH
         6V4V7RJ1SxE9L90wyilLj2z0u2KP2ifM7rJbysqORYBGnT6+sZ5+6p1O4ZQNMtx35dty
         JSwQCEObA8LKC+tOEaee6qDM5JZvuHXqrnLmNzafpdIbEd7wL4Zs2r3yOlpj3EovPnw7
         BgFg==
X-Gm-Message-State: AFqh2krzFW7HEKnydAeKt+XKgGhtY+b/nH41RHKbcuckeHi6ZLfXxAMi
        +VzX/4pBZBGbUFzonjVxzLKdml8Ul+1iX4OlFKc=
X-Google-Smtp-Source: AMrXdXugte493pEDYJM5iLKBoU7RSSjRqB58hrwh2mW1in8d4fG9iAlER2FOhOd4RCjkm9hns9zKS1UKp9n8ufuhXgA=
X-Received: by 2002:a2e:99c2:0:b0:282:4d41:9363 with SMTP id
 l2-20020a2e99c2000000b002824d419363mr1093048ljj.518.1673435198337; Wed, 11
 Jan 2023 03:06:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:3178:b0:213:cdd2:a2f9 with HTTP; Wed, 11 Jan 2023
 03:06:37 -0800 (PST)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <drjameswilliams1926@gmail.com>
Date:   Wed, 11 Jan 2023 03:06:37 -0800
Message-ID: <CA++so7m_SC-3_hJu_Lp7i_uPhqxDkTvZwH1EQq91QO5Et_8FuQ@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drjameswilliams1926[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drjameswilliams1926[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

In der Zwischenzeit habe ich beschlossen, Sie aufgrund Ihrer
Bem=C3=BChungen in der Vergangenheit mit der Summe von 500.000,00 $ (nur
f=C3=BCnfhunderttausend US-Dollar) zu entsch=C3=A4digen, obwohl Sie mich au=
f der
ganzen Linie entt=C3=A4uscht haben. Aber trotzdem freue ich mich sehr =C3=
=BCber
den reibungslosen und erfolgreichen Abschluss der Transaktion und habe
mich daher entschieden, Sie mit der Summe von $500.000,00 zu
entsch=C3=A4digen, damit Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Geldautomatenkarte =C3=BCber 500.000,00 $ zu erhalten, die ich f=C3=BCr Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com

Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihr vollst=C3=A4ndiger Name:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen die Gesamtsumme von ($ 500.000,00) Geldautomatenkarte
zu schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison.
