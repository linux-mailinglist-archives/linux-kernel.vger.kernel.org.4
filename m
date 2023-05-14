Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F369E701FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjENVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjENVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:07:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9E10D7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:07:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965e93f915aso2111843866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684098469; x=1686690469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGRlqZZ1fUgmAfqPUnrcmB1La/Dbz4hpapBH34ufLEM=;
        b=j9SB7JZ4fcPtUzc0hGWnK9o7DYoFK6+KkGYxxIIG8Q+CFJOm/wqTDMG1ZFAN2brK62
         hZl9axOllW02wTzPUeEFDT1/mKCEvM/71EG+Glnt1YrHu2RvVOKHtqikAipNiXTgQesT
         jOpFHL+j0Ij1+8URCXCd27zPk94msY7WZ/ogCnr3KKWHhnDgQ+Rw91VKtjAyJ4ir3uHH
         gwQFokiusma1KVMfFMRyD9j2AoOHMhXkqsaxg6/2Q8WlFwCucFA2KmMrY7RxNHe4AQoK
         DO5PEppU/Sko+kKF2Bpf1flLBOUKCWTILsinrjpdHKSC7aNnbYzGOBkHv7ftB5lxSFAD
         ySog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684098469; x=1686690469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGRlqZZ1fUgmAfqPUnrcmB1La/Dbz4hpapBH34ufLEM=;
        b=Ct8ckFVlmTZ4JjNe1ZOZOmbwKOzy7BOx/OxXK9uqQS0oZY9EG3gaf49VN4ICz3NAby
         IKpyeLEGFQE4mGBYaCMbUcd+o4qLYKE4VhZaUOKli0pGLJdmt3ed91pouwbIPScj9DJ/
         IFOwJX/v1yOZFo6nzTqL07KMQhX/j6ywJvtSRuDwvgwLmzsrbQlF7hiU2KdtjPhWUxq1
         jmsfu4xoNapV7lYhc5v8/IljSEdUanPxRICCqcjVtn8mjL6oCTPdu/hIx61SOjUjJDHv
         vE166WVJZUExOvgbOzhirg+S7jTXCFV7WlVSpW1pK86JdFNGw60B6+G4Atx3O/Cthrup
         bYBw==
X-Gm-Message-State: AC+VfDz8g8TPKehu1qFo9b3PaVRAsLuNv/OLE7W3oP4rcoqZ7yXvNv1H
        /1c9nseVu7Vg3C5UPgp6YlDjzwDhy3ieeFhxomo=
X-Google-Smtp-Source: ACHHUZ7uv9Nd45l1BKb9/qxM98WUnTOrEHYjmqjslOuPiaQ/DTjCTrcrh+nQfauFH/uP9FjF03hOLE1+0eK8wCzGyJ8=
X-Received: by 2002:a17:907:3e1b:b0:967:3963:dab8 with SMTP id
 hp27-20020a1709073e1b00b009673963dab8mr23009913ejc.7.1684098469409; Sun, 14
 May 2023 14:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230514201909.506090-1-martin.blumenstingl@googlemail.com> <2558ba71-4f51-e186-b51b-554a72f19e19@gmx.net>
In-Reply-To: <2558ba71-4f51-e186-b51b-554a72f19e19@gmx.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 14 May 2023 23:07:38 +0200
Message-ID: <CAFBinCApNjwgJ9vSjYqvZj5xn6vQzynFqB7KAvcT7KgB4fX+ig@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: meson8: correct uart_B and uart_C clock references
To:     Hans-Frieder Vogt <hfdevel@gmx.net>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:01=E2=80=AFPM Hans-Frieder Vogt <hfdevel@gmx.net=
> wrote:
[...]
> >   &uart_B {
> >       compatible =3D "amlogic,meson8-uart";
> > -     clocks =3D <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
> > +     clocks =3D <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
> Shouldn't the second clock reference for uart_B rather be CLKID_UART1,
> similar to meson8b?
> Sorry, didn't spot this earlier.
You're totally right - thank you for spotting this!
I'll send a fixed v3 soon.
