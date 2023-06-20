Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA47371B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjFTQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjFTQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:33:35 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8B19B3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:33:03 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a98a7fde3eso4272340fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278781; x=1689870781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLP18OTLuSxDA7X3Px473B0FeVYKNM0xRJJ/SFynJwI=;
        b=o31p5LIvFiVKhZu9V6cVtnjVrKY6GtqHhXXiJxAwAcXl+SRT/9KeqtYlXQqoKYjv+5
         mTaYbOce7ZBZEIdu4NUUFnBnB0HihDw2NEeZtFoQ/jhTn4d2gM4ph71FewBzFbSKT5eC
         S8DeLziWqrpNhzXpstRJ3VA9bqSnmUbVI0KAe2LOOMJ6hvOCPZXFLNrZwLz4pv2G4MQg
         v1XmHETnRzm1D2iBH6GHLLUzjYRfEQ5tbNNc2JMJ6RoopEu1ylPwWHaLl2y/+j6iEOBD
         r1TYFjg+xolEPKC5J7+4rStAgRQgg1S8x+SxqFewfgD/eazy5vRwhCKcUGL2aIQSOeqz
         AH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278781; x=1689870781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLP18OTLuSxDA7X3Px473B0FeVYKNM0xRJJ/SFynJwI=;
        b=GJMBR9N6cmboyRpBbhhkxEW+mymXNeGergdgGm8Cu2KNwhL3SRoALFhDc6zM5PqHOC
         imDmDWal2M4g/ylJnTxWavHGhmMqutGiUUshUj7E6ztz7s2EXldrUnjYjJerLGqDHwaa
         RjcWo15ZBVt0XcPg9gGXyyvvU5S6wQsnzuQT8lU5vJA5IQTp94pZ3kGdYN3jCHf6fO8E
         UmhZ3zY/IpWgsF4yG3IUedU6++eyhAeshnTNp6lmJ2Od0jYI8nkD0hCfGrMbfJK81Wzz
         +lLXtqQN50PAyYbNTpbK0pPYJRDUvRPNyR34UrARWeXrvAsfPergjJD6KBZPPEd7xl/7
         fiWQ==
X-Gm-Message-State: AC+VfDwogQuZPWCWjcZdZL+jcCFhmYRGlg7f9yDpiUmeHsyjAfEnlSzQ
        VqEAnKZYknAePLD2U99MMYqJA+Mezkbrwq9Iqlu+OWsP
X-Google-Smtp-Source: ACHHUZ7DO6D2dQ0ZmQ8k/BVTqGqAshW7CrdZc4YG8/ye5TedtV+oQcGX+OmSVKut8CriOL9Z3w7J2vydjhVPBDteri0=
X-Received: by 2002:a05:6808:1b06:b0:39e:dbb3:5528 with SMTP id
 bx6-20020a0568081b0600b0039edbb35528mr7280934oib.47.1687278781003; Tue, 20
 Jun 2023 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230619101224.22978-1-chanho.min@lge.com> <CACT4Y+Zn49-6R00buq-y_H0qs=4gBh6PBsJDFBptL8=h6GPQYA@mail.gmail.com>
 <CANpmjNMSfVeDa-YC-RQcZ-V=wvHGi43xvXSvaR0GQkEP0OOmOQ@mail.gmail.com>
In-Reply-To: <CANpmjNMSfVeDa-YC-RQcZ-V=wvHGi43xvXSvaR0GQkEP0OOmOQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 18:32:50 +0200
Message-ID: <CA+fCnZfi_o6QbfDamUjsPXjtnEwKyBn8y+T8=zxV2mEpA=DUyQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix mention for KASAN_HW_TAGS
To:     Marco Elver <elver@google.com>, Chanho Min <chanho.min@lge.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gunho.lee@lge.com
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

On Mon, Jun 19, 2023 at 1:36=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Mon, 19 Jun 2023 at 12:15, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, 19 Jun 2023 at 12:12, Chanho Min <chanho.min@lge.com> wrote:
> > >
> > > This patch removes description of the KASAN_HW_TAGS's memory consumpt=
ion.
> > > KASAN_HW_TAGS does not set 1/32nd shadow memory.
> >
> > The hardware still allocates/uses shadow in MTE.
> > Though, it may be 1/16-th, not sure.

1/32 is correct: 4 bits for every 16 bytes.

> I think the point is that it depends on the hardware implementation of
> MTE. There are a range of possibilities, but enabling KASAN_HW_TAGS
> doesn't consume any extra memory for tags itself if the hardware has
> to enable MTE and provision tag space via firmware to begin with.

Yeah, saying that HW_TAGS consumes memory is wrong.

But it might reasonable to spell out what happens with memory in the
config options description. Something like:

"Does not consume memory by itself but relies on the 1/32nd of
available memory being reserved by the firmware when MTE is enabled."
