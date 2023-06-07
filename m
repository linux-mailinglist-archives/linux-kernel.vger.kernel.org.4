Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB54726639
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFGQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFGQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:44:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86131FCD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:43:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5440e98616cso601416a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686156237; x=1688748237;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZHvnpizlKFDS0Lo9+bc240PsUpi+JXeB2hXvYWVLLA=;
        b=Rovy1ozhtyMkG7oxsz89nYzRnGZKFrn2rad3GD/NnmOUBI8krsemXANir6dfnA7zyD
         XeOkXLVj6QRKJqVlgVMnJ4oxZ3FZkb99oLIj/UBWoXKO7U7at+PgbJohv67i9OjgzghI
         FCYQ+dNdTujx39Rfvol1M+mCqK2oX4F3zs0PulQ48LF8dk6MuCtEz/Xlv7kHQ2Gr4uyn
         C4+LZJGvy/X45f0TZ73YWAtzwImvxXhRLemO13Cfb/bH9ZYFikshwqIIs8Rxn0UAjHzV
         uxiChsDHZGuElzs4RZxWelq3f90xyrEwO79zI3XpLXIf64lhiRJRgMY5yunMqXnpc3fP
         KikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156237; x=1688748237;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZHvnpizlKFDS0Lo9+bc240PsUpi+JXeB2hXvYWVLLA=;
        b=U/hK4mVvv0NhREUl45HXci4nuobFYlS0hI5FXaqoK8E9cNBwpTUAkIaDV5vxh9CE4p
         n7JzqYb0OHp7IOZvUGMADM7Jn5rPUzjIri8dL4STsVjdrne1HZYPUq+CQgKvsZjAmrtN
         46L6cmddfpL0ltVEfqlGCnWw5ljytv3e1KYcg8RF57IAZVaEznJ5AesfJWkXO+lAOlQm
         jj6B1Xt0w3418wF5edfAJx/+q6/uVM3r/xCmYkxD0atUx9JO4d/Ts189L0xams2yzVyp
         1XaY92Z4Y6XBkQdDt+rIdqY7NrLEtD9Qfmw2aDM6XF85mikHuCLKCpHkRXcv7MI1re9g
         oN0w==
X-Gm-Message-State: AC+VfDztIDj5KXzcyg9D+PpU/TC2a9xjIw5nRaBZdYOicJSEBN8XtMrx
        2uYBz20yfKoeGmUFPbWkUsoXnVKyLHgiJTimurI=
X-Google-Smtp-Source: ACHHUZ5Zcg8bthYwLM3QfyTG4nkGFimHXx/wJXBQks31Upf5fxe0pHxfC6pbfmi/qxpT2rXK7UxlluJwTUFqOLW24XQ=
X-Received: by 2002:a17:90a:6409:b0:24d:e296:659b with SMTP id
 g9-20020a17090a640900b0024de296659bmr6784866pjj.22.1686156236955; Wed, 07 Jun
 2023 09:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:60c:b0:65:7331:8d57 with HTTP; Wed, 7 Jun 2023
 09:43:56 -0700 (PDT)
Reply-To: georgebrownhoward02@gmail.com
From:   georgebrownhoward <dueuceed46@gmail.com>
Date:   Wed, 7 Jun 2023 18:43:56 +0200
Message-ID: <CACyPrtUSmBOLdR27SJVV6yFLMXxqxQOgay-4CN1OEoe+tUvLEg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
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
detalii:georgebrownhoward02@gmail.com

Multe mul=C8=9Bumiri in avans,
Domnule George Brown Howard,
