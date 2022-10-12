Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1555FCE83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJLWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJLWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:35:30 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9562CAE48
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:35:28 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id v81so8834vkv.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVl9Q/r5lCZWk/7cWvLfMeck0NdTFk7vNCP9bjoQkU4=;
        b=KGdjtlUFOreMWjSF7qO4Y5WUGV+KB84Vj7pTlw2b/+3lDYLWB7rwqDlPtApx05axUz
         tCzsTJT7xv8RbhzeZ3vdUoEl3kFYY7DOQiE0R7tCcQu/LZjM7RjSSfJqUl93+aMgD4wI
         FsbL8jYaSwWXL5ZLDOt5L8l5cEJpfS2+MfOE9GfiFqN17vg/j1UVZuNJKZmM54WNVf5h
         rTnkKCSz2Eu0R49tSgDh1ePmlB56N4k/HVMVq1wGRvBlNFC5srMZ60sSi3rDPdBnN5Wm
         p+QSAIivk/qO9NJeh+rdZMIB/NCID+3aeW7wPDojOF5o7PNuVgS+pY2+d0TF7IQLa1+B
         yyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVl9Q/r5lCZWk/7cWvLfMeck0NdTFk7vNCP9bjoQkU4=;
        b=JN3CDG4mNVQj7wl5pDRGBxTZZ4ccO5Kb6o1jJ9YRG/mvt9W02kYUvlkinM9CX1eKV9
         2aD9ZqK474X9nrNBf7HS3rUuDwFvxszO3Kg1A2SuEjOLvOgx2OpYYEfG2ond0nuPH/B1
         d6pFzvmxbhYxSrOuiNh57+BFT0cf6+WclzodW6MSk3gXgI74nGtHSINTgjXhY5LPP/A6
         dSYkTnu5sgHAGTzSFxErO9DU/2B4+F+qVmJrFDM8qqOoVBmYpb8Tgl55Mjj/CBo9bImb
         1a+9GZCurkd5x8QA7FChragJjVqDXcqKRJcyixLHfiJCEtwrC6Hr29NEB3WW7Rk7Pjcf
         VIrA==
X-Gm-Message-State: ACrzQf0aNDPzwMGwYAwtfFEt6N1JpzAHPlRQCCpsidXElSz5YW4rHZ4f
        v4/GfVoYkYw1UJLJQYPaiSlF59iqEUVysGapvaw=
X-Google-Smtp-Source: AMsMyM6CrOZAcpiiYYvtNCGbZnHPKpbjuZ0G+sUpGufLS0HOePBX7E0eYw4qPsq7e4hSC2jPL3HqfjerUnEKHFMYMFo=
X-Received: by 2002:a1f:5c0a:0:b0:3ab:9b92:1185 with SMTP id
 q10-20020a1f5c0a000000b003ab9b921185mr10726509vkb.10.1665614127967; Wed, 12
 Oct 2022 15:35:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:c19:0:0:0:0:0 with HTTP; Wed, 12 Oct 2022 15:35:27 -0700 (PDT)
Reply-To: terryedwardbarwick@gmail.com
From:   Terry Edward Barwick <adamschrist180@gmail.com>
Date:   Wed, 12 Oct 2022 15:35:27 -0700
Message-ID: <CAE+hsa0HmdPY1pMcX=j8n0n=XMys7-+C69bqH=R+dO_He_pa4g@mail.gmail.com>
Subject: =?UTF-8?B?T2zDoSw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1,



     Meu nome =C3=A9 Terry Edward Barwick. Advogada Jur=C3=ADdica e Advogad=
a
Pessoal do Late Engr. Alessandro, que era um empreiteiro imobili=C3=A1rio
em Dubai, Emirados =C3=81rabes Unidos. Meu cliente antes de sua morte,
tinha um saldo de conta no valor de ($ 5,7 milh=C3=B5es) depositado em um
banco aqui nos Emirados =C3=81rabes Unidos. Estou entrando em contato com
voc=C3=AA para ser um benefici=C3=A1rio legal para que os fundos possam ser
pagos a voc=C3=AA e sejam compartilhados entre n=C3=B3s dois.



     Agradeceria sua pronta resposta. Volte para mim para que eu possa
explicar mais sobre esse problema e como proceder.



     Cumprimentos

     Sr. Terry Edward Barwick.
E-mail: www.terryedwardbarwick@gmail.com
