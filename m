Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046256ADB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCGJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCGJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:56:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DA50738;
        Tue,  7 Mar 2023 01:56:05 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n8so4190753qkp.5;
        Tue, 07 Mar 2023 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678182965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruKcO5BQUbqCHfP7qxmKsrkLuBDDAAab0Ba2+KPmTdo=;
        b=gksbuVVL/cEZlEwS4NKWJDFQcS1IMDs3psKhZcThkA1Gscp5utOk/7mx+7oCFQh6oV
         7vyJQE1XzdQ4S2gWi/V8dT9zzWFZyqmPfIEyOYyxRG40sRMS40tL0Rm4jqnf+GkiQkW4
         0+e3kX1aw64tqrlvwgkjCWUxSHIHUa4BznOXcRxAV8ntMoycGxE5d0UdDYQh+QmjkV2w
         QURRbZENqt/zn6fzG4a/GXIdEJVYn2U2nQ1lTQa4ZWAdQ1RLiFQWOP0bQVj3D/iilZBV
         mqYYQxPEs7EPn5YTGNjO8Jq6GHt2uPkui4ldzDZ09dGdXk+wdnPP1lbKWpNTssNEb2PC
         ZIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruKcO5BQUbqCHfP7qxmKsrkLuBDDAAab0Ba2+KPmTdo=;
        b=bmQZldigMU8Yg0CG53NC9hw3E78gryOxNqy+CuLj2tZKci9xAZdOhcvbGwVw0Eza6s
         7G1AolpAjn+/M57cEHWKLPQtOCAuEAaen92ltRWfNmu7VVrqwYTO7uISxBxFF46D6DGY
         cSGunr6ddX1MW8hZ9bR5+O6+K6Wzakqsp1jZdOGBKXPc4IcuqUhnnME5/yiAVilU80sY
         ecxqcNB34uK3Qd3FRv80bRlO4/HGbqjTZWqPRLsKHMgZsTgulZ4evZKBOtZFUaKP4QUK
         JASlZ3fy+wM+DjVO+qGLNEiiNpldd/Pr4wJUf0ZDbrDNcN6VAEv94CRzwBjir8r5KLBq
         0Frg==
X-Gm-Message-State: AO0yUKVPYpCD99cJsVd1CasXE3AEGbMwfjbI6enI/Z1u+nOzbrgmvJQs
        pQ5lh7ORD2H3sktqHJ2XXTHb5X4kPqO+UEDPBJw=
X-Google-Smtp-Source: AK7set+zoY3TRxMTc1+1o6uSEYS3hDaOyqC1l34cQwmav2RdSpNP+qJVL9kOdViUPzuPotx/GNgWY9Uk3/KVM/Wrwnw=
X-Received: by 2002:a05:620a:713:b0:742:7e5a:4cee with SMTP id
 19-20020a05620a071300b007427e5a4ceemr3893704qkc.10.1678182965007; Tue, 07 Mar
 2023 01:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20230220023320.3499-1-clin@suse.com> <CACRpkdYknZo3Q7_CeSkOL2XwwAmKERskx24o-toaVy=rs0Yf5Q@mail.gmail.com>
 <ZAZ3JZQ4Tuz5vyH1@surfacebook> <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
In-Reply-To: <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Mar 2023 11:55:29 +0200
Message-ID: <CAHp75Vf3ve-NdMG6iti-KSs=tGGgGf9tNj=aK7Jofk9233WocQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 11:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Tue, Mar 7, 2023 at 12:28 AM <andy.shevchenko@gmail.com> wrote:

...

> > Can you unpull this?

> If need be.
>
> Are there serious issues with the patch set such that they cannot be fixe=
d
> by add-on patches?

There are a few absent error checks, some error code shadowing, etc.
I can't tell if these all are serious, but the amount of them is like a doz=
en.

I reviewed the patch, so you can look into that yourself and decide.

--=20
With Best Regards,
Andy Shevchenko
