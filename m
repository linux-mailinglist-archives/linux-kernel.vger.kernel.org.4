Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115DF6ECB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDXLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjDXLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:34:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516543C0D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:34:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f3df30043so653563966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682336093; x=1684928093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=phKEvcHVMTqACdLjm8eVzbdGFSMWrSbFNy5E+a4doOw=;
        b=Vm792uz2b2oSf64pgOvp209eDnItUKJHNuqdOAkWmvbHCzNp9EaPeYpV1IMynY3+if
         ZXPlaoQNBnm4Mdhc7UxFnq1w5R4QwW9MS3sqcIBzxyUQLTrdBX0131mhPj/i/w5LHwl8
         ppMAiKCbxQEBGkksXSJ3WH4QWVVsXsedUNBHjbkukOcZPor35mj3wJZBS8HZwfYIumvx
         RJDgeNZABMjNu3KZjfkH1EiTXisXzDUNjGxL5SpwjE65mgf+m19sellC+YE5kCACZW6g
         0ZyX/HXNaf4/mTX1aWrZfkoob5yBaQ4zn4OqEvJNeJL0dJdR+vi2V6N5MAsJGBP2cO6X
         SBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336093; x=1684928093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phKEvcHVMTqACdLjm8eVzbdGFSMWrSbFNy5E+a4doOw=;
        b=d9F4fhwWawMyoC91AzwspWuPGXIQclGgx/gx2ir8nbej8HfonMKl4TCz0NyM7HVwFA
         UoNEeafbPvvMTJML6TetZDp0FA4TtVYmQl+15eZ5sqvn3zyNML7gNc84AKwlzS/mmio8
         uy6S8w8OZU99eTfvU1pq5m5NewkTseWFCREmcJOCWcgiGLsZLylVsSLTHtkEFfSVN+q3
         lP+mxvb9BqWvSUEf1C9N0hNLC81yAFoA8Z9GeHMSbEJ8wn/nlmKFa7d5kwQoItb8tMzZ
         ar8kK+x6szGyrxV1tQrz/qu/VToKd6gnpiUvz2Pmw9W6Q5jcYQeuKZyNUm6bBU6txXqK
         3lKw==
X-Gm-Message-State: AAQBX9dFb2R1Pg/ZPcDspUW8DLRgusxGDUHbZKRUg+gAEwDzd1/H/30w
        MEd+puIpNgyunKmHMhdnt90=
X-Google-Smtp-Source: AKy350ZfpLXvxAHScAzsLdVaJMtRYwDvvKDiDLQBBQ6f7gaeTRgRDPrFGjsbi8FLyHQv9bhB352t6Q==
X-Received: by 2002:a17:906:151b:b0:94f:562b:2979 with SMTP id b27-20020a170906151b00b0094f562b2979mr9886541ejd.31.1682336092411;
        Mon, 24 Apr 2023 04:34:52 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id jt11-20020a170906ca0b00b00958434d4ecesm2808086ejb.13.2023.04.24.04.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:34:52 -0700 (PDT)
Message-ID: <ea8992e1be827883a78b4729fed55d70c5b33e2e.camel@gmail.com>
Subject: Re: [PATCH 06/43] clocksource: ep93xx: Add driver for Cirrus Logic
 EP93xx
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Apr 2023 13:34:51 +0200
In-Reply-To: <20230424123522.18302-7-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-7-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-24 at 15:34 +0300, Nikita Shubin wrote:
> This us a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> the device tree way:
>=20
> - Make every IO-access relative to a base address and dynamic
> =C2=A0 so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/clocksource/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 11 ++
> =C2=A0drivers/clocksource/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0drivers/clocksource/timer-ep93xx.c | 191 ++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 203 insertions(+)

--=20
Alexander Sverdlin.

