Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6886FAF91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjEHMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjEHMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:01:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38046427
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:58:44 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3318961b385so44399445ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683547122; x=1686139122;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=SD+Vigicn2RLbrrfV7Tjx5fsKjbUQHUjWZPs447MmcnKiMh0oL6aB0oNkJy11SLLJD
         obK7578mAGFH80fZ9wqHqptAiD/+h0Lg99Guza7Tmlxn/SJUr4OaBhVQCVDxqUhr9ZDv
         AW/pMNLpPjZVm/lX8LHbN3PCuAK9C5wLD7jykhmupBZ/jbJ9JxaV+5GJt/bxBKC95ZoD
         iy8JO9PVNolF8gKNOmKCxYPqNKlvh+EhGnhzMO5PFMvJkh6xiTz4H3RziEe/4aMvQOwW
         nLY//Mlvrs4xlBtwGXiP1rYTqzuV0S+Kk8RLnp2ww86ex8Ob54q8NexMWkQxo4f4nbpN
         snGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547122; x=1686139122;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqeUWDoSs0kIbCfr3nS8TzW819KiR3PYMo9rpWCO4k=;
        b=cOXiuy0SXhCds4fxZGG/O1D2gejVMQG1/MDbGBJtxzqt4aSyM7iYHCxlJ5qCB4IRK9
         ZN9NH98Q5KJOlBSFA1GzTaQb2OmtgoQTRK3WJl0XMWBnnV7Uds6Z7p+yvvSrov81tLBC
         Z6xzGq9FVrivIGt7KLdmtr9nJU+IHBXkwg5yK1fAlNgyk0OI0uHy8qNBlgsM/N6DPr29
         K968CckSk4c1SrZbSCcvevO/gHtrElJSWhe0suyyWcNvGPPPD20+Mfo1/qWMsam7lBDT
         eX57MN7/0rENhm5x3U+HO++YjOFBY0fOthaLEdolGp5tHsgfigSCfsllKeUq/58RMmdw
         hhFQ==
X-Gm-Message-State: AC+VfDxDbI8oeyfWwWBKhdW7//lgOijLFCfPhRM9+3rxUFmi2Ln8CzHs
        ouZkUd0z/MpHSRcHUg9gPb7sTCPVuxuSzTw/d4c=
X-Google-Smtp-Source: ACHHUZ5bJyQFIgmGSzuK5pDcoIx0c1u/Uljz5CA9D+QBSuZFri0KXXph9zl7/ztmKGxlmJEmz7YIIRyPUQgAT79E9HQ=
X-Received: by 2002:a92:cc05:0:b0:32f:752d:4a4e with SMTP id
 s5-20020a92cc05000000b0032f752d4a4emr6489135ilp.1.1683547122213; Mon, 08 May
 2023 04:58:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:d4c9:0:b0:32a:daf1:c0ab with HTTP; Mon, 8 May 2023
 04:58:41 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <joeakaba00@gmail.com>
Date:   Mon, 8 May 2023 13:58:41 +0200
Message-ID: <CAEoXQLwmtmDJVb4FUtP80JtDdHHMYx3b=EBvzC_9z5QCwi2BGw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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
