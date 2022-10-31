Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47E6133DE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJaKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJaKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:45:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCDDDBE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:45:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso7754736wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HimZc8yramtrHBkHsNskSIVkCsBkqEjbz+TPQpvnPJY=;
        b=qsbc9mzjfMnFh1ImVFaFLb5Aviz5c5pV9s86KLOPuvkHckXMfhxasxeP5vAxqcjxG8
         c5W63ZWFxp16y1VQJJ0N6vS9LSotP4jgQCarQCmiiG5V8WceaBm57NKZMfyML0SgbYtR
         w3jpVonYaueZGEe/j67ZUES24gVkBDao57Jz9OcQzzwzDGhR2wRfqXATp9LZ2luVJCT9
         +SmzAQ9Ymc5w1sinvAwAKPNQpbadvkicavQTvOCdO/Xu0NXQHYafkdHpjPjwyOJwPewe
         gajLK8WV1GzO2KUIw7wAd43kqXZERrOwp0T5RBza13wIcnmJsru1JAnbdKpJtQapzLVW
         wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HimZc8yramtrHBkHsNskSIVkCsBkqEjbz+TPQpvnPJY=;
        b=INOCFKM6F7j3GoOStV7GV73GXuusu/2rDKOo6Xknb53Ct8DyuxHz4q7S48pbnBnyvz
         lqGQIhXCmSoTslHwlAURcWM7yuKjNBXf3KvtQvnDHEHbnQ7Qw+sh7N6QJEWhv1yXOOk6
         gBV61x/I4cP5iiAPPSGb5WvVnMqroEnVfTHPUTZ2E14ud1v80oTLwGtRNMkm3HxeKQWM
         Tnh5UPgrlYWPLu4xHQzWgmXgQtU4wBtuYcKMqYO6F0FeTQeVHunlBrT6ALu5Xn2Ejk0K
         qUHs9SP7VBPjuFdkW+n1I/RrnvTRK3kS3CzV6kyyzq/l+HVj1Irh0AyEuPtKOoFyvnEv
         +1/Q==
X-Gm-Message-State: ACrzQf2oC8p8KghCX59B+2NLeY8NXCiYK1OKx+Q7P0Bv6y6NOXF0wT3n
        RKUNNjBCiTO5iwDNgSzv+IkJxzUXg+zheQJKD4c=
X-Google-Smtp-Source: AMsMyM4W/Jj/p/PSFomfK/bl/hCS9S9ZRK8GFAu/a8IvDO06pk1Wzohf4yLZVfyfera0z/JbFNYy+t5tg5REfwedocU=
X-Received: by 2002:a1c:a102:0:b0:3cf:4792:d3a2 with SMTP id
 k2-20020a1ca102000000b003cf4792d3a2mr7381216wme.55.1667213115212; Mon, 31 Oct
 2022 03:45:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: alyonadegrik@yandex.com
Sender: christinabreish@gmail.com
Received: by 2002:a5d:538d:0:0:0:0:0 with HTTP; Mon, 31 Oct 2022 03:45:14
 -0700 (PDT)
From:   Alyona Degrik <leelayouthayotin@gmail.com>
Date:   Mon, 31 Oct 2022 03:45:14 -0700
X-Google-Sender-Auth: 17aT_lK5Xc2RqqY3v7F-OB_j7Q8
Message-ID: <CAMQjNMvRabkJz8OiWNnDmbiBas-SquTk_OHGhKSyPzCaaER4rw@mail.gmail.com>
Subject: Hilf mir, bitte
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber Freund,

Bitte sch=C3=A4men Sie sich nicht, Sie =C3=BCber dieses Medium zu kontaktie=
ren;
Mein Ziel ist es, eine tragf=C3=A4hige Gesch=C3=A4ftsbeziehung mit Ihnen in
Ihrem Land aufzubauen.

Ich bin Frau Alyona Degrik aus Kiew (Ukraine); Ich war Eigent=C3=BCmerin
und Gesch=C3=A4ftsf=C3=BChrerin von LEOGAMING, bevor Russland in mein Land
einmarschierte. Ich habe Ihr Profil durchgesehen und es klingt
interessant, also habe ich beschlossen, Ihnen zu schreiben und Ihre
Hilfe und Unterst=C3=BCtzung f=C3=BCr Investitionszwecke zu suchen, aufgrun=
d der
Invasion Russlands in mein Land Ukraine.

Ich halte es f=C3=BCr notwendig, mein Gesch=C3=A4ftsprojekt in Ihrem Land z=
u
diversifizieren, um die Zukunft meines einzigen Sohnes zu sichern,
nachdem mein Gesch=C3=A4ft von den russischen Milit=C3=A4rtruppen zerst=C3=
=B6rt wurde
und in meinem Land keine sinnvollen wirtschaftlichen Aktivit=C3=A4ten mehr
stattfinden.

Ich w=C3=BCrde wirklich gerne mehr =C3=BCber dich erfahren! Und ich hoffe, =
dass
du mich auch kennenlernen willst. Wenn ja, dann freue ich mich auf
Ihre Antwort.

"Mit all meiner Aufrichtigkeit
Frau Alyona Degrik
alyonadegrik@legislator.com
