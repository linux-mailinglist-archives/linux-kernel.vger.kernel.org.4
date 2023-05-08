Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03A6FAC6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjEHLYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjEHLYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7B39B99
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:24:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so6902231276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683545052; x=1686137052;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=ODmOdw7/59wxxHee1GE+p3nW6Pg8aPvANxQeZNY4Lu//v/mfDx78W0IDGW58qK475w
         zKSODI8wCVfsNsO0tEsuUwReENrApOTGFc0SftfIln6F1hIaexk9jl1goyge3Hvk6fa1
         Lm4xZml8cfSdnW0/oRc3OZvEbV4uZjlgHXrTS4xfBSRvNwfnUkUqPWtz6FHgTCsN8KKJ
         ilKURM3gdYHVvzDrESMGwZBA2lRwjR0uMPWEZuYU5JRg12ja86r2qXfyDUF4DjVKb5Qq
         WKKVj7ZK8j5YoInEZZ/uk+6+Fg12xzJgetIsKiOCeGJZPzGcG5ccOxdPBep2QupqbxQG
         INNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545052; x=1686137052;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=Pvi2waQ9WnFLdkmML1MAO2yjd+SVQ1UxKrt89Bkw7/zVlx1qBlccUI/4lV9L+n9e8m
         fO6wtrQ6SxxNDgvSqzwtkwhlgJHMz4MVjIxSwkxc7rk/WCbMFGVGA+N0QZkU1wNLf65R
         X9vKWkEyKVE2qow1ssScfShqZSKjqP9LlCHorVKEJg9wcxD/KKCA4KiBdW3CL+9nsu50
         nEu7wkN8P390Nm/A5cILq5jI6U11oJrqdn3eX6JIos1OlGQsWuc6fBOBlGOSW+Jj/Vdz
         T0R12xOmhY8J9MR9r2N7v4DX+jpk0JxSIdlM+u5nyRvU2I+/Nzcea0abRWDC40TOyXLQ
         9QBw==
X-Gm-Message-State: AC+VfDwuqsfDuJYqjva/9yUiok4QNlgR2ljevSWvUhF7KhKz1rqnOok/
        5jwaK2dBW8hpOhDsEZ7weHb9icsOSHQ+0JzyVkk=
X-Google-Smtp-Source: ACHHUZ7Rbr3A7Cw6BlXT+oRGGA/L5s0C74gTETBDrbqT41jhxqW/ni8ZMAWT3pu2mD5qaxTId+d5JiYfYJhTPHEpz5U=
X-Received: by 2002:a25:ae8a:0:b0:b9e:b9b4:bb12 with SMTP id
 b10-20020a25ae8a000000b00b9eb9b4bb12mr9370107ybj.48.1683545052013; Mon, 08
 May 2023 04:24:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3a4c:b0:340:9fae:39 with HTTP; Mon, 8 May 2023
 04:24:11 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <georgemike70311@gmail.com>
Date:   Mon, 8 May 2023 13:24:11 +0200
Message-ID: <CAJrV87ZMDNMdk5OMd4XD8TQERqzaCX2Zt5DiLgtRbsnsBecL_Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buna ziua

Numele meu este George Brown. Sunt avocat de profesie. vreau sa va ofer
rudele apropiate clientului meu. Ve=C8=9Bi mo=C8=99teni suma de (8,5 milioa=
ne USD)
dolari pe care clientul meu i-a l=C4=83sat =C3=AEn banc=C4=83 =C3=AEnainte =
de moartea lui.

Clientul meu este un cet=C4=83=C8=9Bean al =C8=9B=C4=83rii tale care a muri=
t =C3=AEntr-un
accident de ma=C8=99in=C4=83 =C3=AEmpreun=C4=83 cu so=C8=9Bia sa
si singurul fiu. Voi avea dreptul cu 50% din fondul total, =C3=AEn timp ce
50% va avea
fie pentru tine.
V=C4=83 rug=C4=83m s=C4=83 contacta=C8=9Bi e-mailul meu privat aici pentru =
mai multe
detalii: georgebrown0004@gmail.com

Multe mul=C8=9Bumiri in avans,
Domnule George Brown,
