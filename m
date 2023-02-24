Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2053E6A1D63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:23:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0011E9C7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:23:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ee7so40292340edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jpdwd3xuyVkT/VZTbWwrg7JoT4Mr4P0993yBblOq6r0=;
        b=AMChXn+jJA0VmC73Ftrt/sIRrMV/w0wOotZDXWGLsSP1YomQXFPzVL8mnlqb7b7lzV
         51V0c+IriY/1pEjKvkLk2h/fi60sThPAUE6tOBLjQBE47f+9U0WmFdwIS0gUNob4v7CG
         3J6qGrC7O8D/V4c/J2FcyIAL9SsksxGQ5kOf6xgQ3ereeZski2wxFyLomEdPKsNvzMg/
         /2BhAvZJcR839+aObwnzAbdwIQOaYPgivbDbpl8AN+VhQqVqFjQiLNwx8nVJxMfKY55z
         2rMItKrR4aZ77yA7dYiIDPN8yyrxtdbHwmrgKpHWL6C56W7aMUZhhaOR/oMJQLdxLLns
         +lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpdwd3xuyVkT/VZTbWwrg7JoT4Mr4P0993yBblOq6r0=;
        b=1k0gPf56ULD0RA1XMHYHm/o6Zm0rro5s8UjgmfaJVqyIbMQ0b1sI/6mZjR32Wjw6aJ
         +kfV5tCRYun56GkzT7NtM6ILAVip5rjPONgkzz6I8m5KFQJKNXCw7H8tTJFvWlijwKaJ
         BIUGr2Pi4366HGhmYnTMlU+OUGs0OPtXMhW+SeX+VPKswmaOp3ZnP3Gu0y4P543gL+rO
         1/EpJeB6laJGLwg1oBnHKs0WGvwqc22rnQYHA378KmMILwRu/z79kn1Iidn/Tn0wJRGG
         i3UkUM8Gw3wHnJoZ8PvEbSlFOgtlHuQ0Wne5iLrbIu7OH0bk1DZsjT+1WmSa2tiSQZw+
         2jyg==
X-Gm-Message-State: AO0yUKWPFC+wtloHmlDH2cpJI3oYN69A7gGrcAvBlHZl7RocDRIX4fVM
        bLSUYXBQTmUPYCiHE0+D9urPRyGDJPlW4UQXMpQ=
X-Google-Smtp-Source: AK7set8sp/3gTfRdtCcy+zKizs0jW/WBVzqVJ9JeAbeMqmEqgJM9aLXywYmlVQtc3keKz+zZvl0hYxxCGHo723nVkAs=
X-Received: by 2002:a17:906:9251:b0:8ce:cb8f:3747 with SMTP id
 c17-20020a170906925100b008cecb8f3747mr8284666ejx.5.1677248613685; Fri, 24 Feb
 2023 06:23:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:7806:0:b0:1f0:12e9:4bf1 with HTTP; Fri, 24 Feb 2023
 06:23:32 -0800 (PST)
Reply-To: cfc.ubagroup013@gmail.com
From:   Kristalina Georgieva <tonyelumelu918@gmail.com>
Date:   Fri, 24 Feb 2023 14:23:32 +0000
Message-ID: <CAHPS+3eiMB9-4vWaJy0WsYw1hT5LaFZYcuNTZVcEk_uXXLgHmQ@mail.gmail.com>
Subject: HEAD UUDISED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tonyelumelu918[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cfc.ubagroup013[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tonyelumelu918[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lugupeetud abisaaja!
Saatsin sulle selle kirja kuu aega tagasi, aga ma pole sinust midagi kuulnu=
d, ei
Olen kindel, et saite selle k=C3=A4tte ja sellep=C3=A4rast saatsin selle te=
ile uuesti.
Esiteks olen pr Kristalina Georgieva, tegevdirektor ja
Rahvusvahelise Valuutafondi president.

Tegelikult oleme l=C3=A4bi vaadanud k=C3=B5ik =C3=BCmbritsevad takistused j=
a probleemid
teie mittet=C3=A4ielik tehing ja teie suutmatus tasuda
=C3=BClekandetasud, mida v=C3=B5etakse teie vastu j=C3=A4rgmiste v=C3=B5ima=
luste eest
varasemate =C3=BClekannete kohta k=C3=BClastage kinnituse saamiseks meie sa=
iti 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Oleme direktorite n=C3=B5ukogu, Maailmapank ja Valuutafond
Washingtoni Rahvusvaheline (IMF) koos osakonnaga
Ameerika =C3=9Chendriikide riigikassa ja m=C3=B5ned teised uurimisasutused
asjakohane siin Ameerika =C3=9Chendriikides. on tellinud
meie Overseas Payment Remittance Unit, United Bank of
Africa Lome Togo, et v=C3=A4ljastada teile VISA kaart, kus $
1,5 miljonit teie fondist, et oma fondist rohkem v=C3=A4lja v=C3=B5tta.

Uurimise k=C3=A4igus avastasime koos
kardab, et teie makse on hilinenud korrumpeerunud ametnike poolt
pangast, kes =C3=BCritavad teie raha teie kontodele suunata
privaatne.

Ja t=C3=A4na anname teile teada, et teie raha on kaardile kantud
UBA panga VISA ja see on ka kohaletoimetamiseks valmis. N=C3=BC=C3=BCd
v=C3=B5tke =C3=BChendust UBA panga direktoriga, tema nimi on hr Tony
Elumelu, e-post: (cfc.ubagroup013@gmail.com)
et =C3=B6elda, kuidas ATM VISA kaarti k=C3=A4tte saada.

Lugupidamisega

Proua Kristalina Georgieva
