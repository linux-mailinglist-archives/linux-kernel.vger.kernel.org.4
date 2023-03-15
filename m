Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4765F6BB449
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCONRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCONRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:17:12 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6D1EFE7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:16:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-544787916d9so40151297b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ3eXjwbttuSy1jojETL4F0LELQttESdV4EJu8Cz1Rs=;
        b=Wi7YKk4pInAi0NM33rIZ+cs/wlDJ4brXMuNSXi9LhXRPdUnLsc18k2UOiZ+EOvUo55
         AEtFR4ncMJ26HgraZNXwTIMlen5NLQHbCA8BcCgyVPgBrMjgfG+3w3btZ5KUpPu58OzP
         qCuGFtkn3ixV7ZMZ7hjhXLsvF1w+xlP1noJsxTkJV1X1MZm+f9QX/NsYrO+ewPx7MH2E
         tWXX/pPwu/NbeSpRMW2Uq1Kat+oyn6rE9V/GWGJBNVITOCVzQDhRTu99gT5yMuWZowxg
         KZwFPOj4I8JMnKvnelONwiGULEHXASWjtwNgi8U6ZBdzUmDfObK2rRSl6CBCES/foh51
         iv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ3eXjwbttuSy1jojETL4F0LELQttESdV4EJu8Cz1Rs=;
        b=DaOGWzrMeAOS+Y0uRsKTiXWQsXg9+1B3xM6pogAhWFOpQBiWXrfojR4U4Pn7BJIbwr
         mP6iZsku5z1WcLCteG7WKttYMG4AJv48hX2hic3XgePk1tOt1Iuy1oZygMoPb5RP1tey
         ICeOYfnAuXgzpTG2BhQClL34JIb4BnNbwIC/M16DLHGgxw5hyuKiL0erHC4MrbCoFrMT
         5X5kNmZouJsL7kKPvOflRTdvMf1UySBQaqaofBf/r9YWCO77iM/wAko5fjIztVfJEQcn
         te/Z4OkxiR5iB1G8/rMHvl0VKruy4IwZisrQvazFFfwShzCruNzBn1nAaoT+aHjVngvM
         4e1Q==
X-Gm-Message-State: AO0yUKWZRtdM5YYLwJd12yPFPTM4T0BYh2qRbql2nPuUaVCikFn0QJAh
        BEpRyDKwYNGXunhmparPQS6hxpjJI8dHLvvakEohjA==
X-Google-Smtp-Source: AK7set/7kcSIdBeBjQgDrxxsGgjDVizVzEQVvblH0H30lKgrgsFXvSmSoKoksW2pLmIlOEK5H4EX0UAorAFxnD7sTj4=
X-Received: by 2002:a81:ac67:0:b0:541:753d:32f9 with SMTP id
 z39-20020a81ac67000000b00541753d32f9mr9565761ywj.9.1678886203678; Wed, 15 Mar
 2023 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230315130917.3633491-1-a.fatoum@pengutronix.de> <20230315130917.3633491-2-a.fatoum@pengutronix.de>
In-Reply-To: <20230315130917.3633491-2-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2023 14:16:32 +0100
Message-ID: <CACRpkdYUnM5CgBAz8kCni89Uq9Hahk2h5GU-LN0x2-HYEiyR-w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: dsa: realtek: fix missing new lines in error messages
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        kernel@pengutronix.de, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 2:09=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:

> Some error messages lack a new line, add them.
>
> Fixes: d40f607c181f ("net: dsa: realtek: rtl8365mb: add RTL8367S support"=
)
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
