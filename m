Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E506FF856
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbjEKRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEKRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:23:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E0A8;
        Thu, 11 May 2023 10:23:39 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-619be7d7211so41430306d6.3;
        Thu, 11 May 2023 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683825818; x=1686417818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM6TFiDQhgWQropng+AeJTYlJzn+bEC9f9zpp2BwMP0=;
        b=qpwCPqa4hqsdoIwTVUeTtOZ4pWT9CxBB/YaRF8axxSDjFwFTN0R848WaH8dfguKxlA
         RcKtzXQFZlv8VYa5DjhQSVEVFQesBXPKQHChDE84Qt9SIiu+eViQlvAq3dLuzN7ENDsM
         MMrNGHBLvOUywThafQbjbcOYFQ3v/+MSnln5N916ph2UyPoRh4DlTj80N7HPxe0rKRrP
         7pA6iV+7h1DG/jgsLQtT9QJxsM58vtwMcScgaNFUUi0Y5VssstNTe77sh+Umfuj9etYW
         aHrZv8N1wZfXjoaxMa1ndn2wwt8gUojXniUhdQVixp29oi+ijqakudpeYxKONy41wgW1
         0dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825818; x=1686417818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM6TFiDQhgWQropng+AeJTYlJzn+bEC9f9zpp2BwMP0=;
        b=JbYlf+0t5O9VJgYTT1bMFYhehMUJuH3DS4vEHc6z8YfYltVqK5p70Lwi3d56hmaMYO
         ln0LLw++7u2QM3L1ki7EMBJ1lpfNUtG9Q+z5M9PGvTIs+p41xBinWzIGK6rCF5Qc03KO
         rYTsYOv6eZP22OcCeEbBcvGzBGkpa+7yAuVoHz/FERB/rLeKsUGNfJIQt9XIgWrFyE5h
         M6ZvWbGJ0+kbNU2q4kkTyy/mFzQAyMSX58Nlrq2nvGz2nNnJ+kVUishY4YFzGjeYb7Pi
         1u/QuHTjflKfLm50aSVjuH3ZIcu2MnZrn3RRyHi7siT2GwhX1Ru/0kJkzDI9EgKqn0Kp
         qI0g==
X-Gm-Message-State: AC+VfDyBf7hOXR9gf7zRYLv46CwEIoh368UPDuBj8xmwlupljkjbp5j9
        WTxFwfoHtX/tl6KKlMpRWx0KK2F/+mgh2VSjAXM=
X-Google-Smtp-Source: ACHHUZ4Zvb/5yAMtSdGtdjyV4RQywVu4Ra/sFnP5BEB6FUzbAP4eGKnSZFjRbgqKWLDgMYqUxya2jOby5MhLP8YvTO8=
X-Received: by 2002:a05:6214:e48:b0:621:363c:ea9f with SMTP id
 o8-20020a0562140e4800b00621363cea9fmr15938098qvc.19.1683825817959; Thu, 11
 May 2023 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
 <ZFvTi3tQGUq2OCHi@surfacebook> <32ecb9f3-1443-210c-0fc9-40891629e25a@yoseli.org>
 <CAHp75Vcsieiab8ks7yLwJvhjHTPv2qeCBJYjMOVYBJXmNhbTYQ@mail.gmail.com> <1ab280c2-2536-f507-8e12-2e4d3f3eb37e@yoseli.org>
In-Reply-To: <1ab280c2-2536-f507-8e12-2e4d3f3eb37e@yoseli.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 May 2023 20:23:01 +0300
Message-ID: <CAHp75VeGMMOk0_C3E6hmg3Z06ARbN0tRLVFo5151bngFLDLSpw@mail.gmail.com>
Subject: Re: pca953x issue when driving a DSI bridge
To:     Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
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

On Thu, May 11, 2023 at 7:07=E2=80=AFPM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> On 11/05/2023 09:49, Andy Shevchenko wrote:
> > On Wed, May 10, 2023 at 11:18=E2=80=AFPM Jean-Michel Hautbois
> > <jeanmichel.hautbois@yoseli.org> wrote:
...

> > In your case I would try the easiest way (taking into account that
> > hardware connection is not preventing us from sleeping context), i.e.
> > check if the function that has GPIO call may sleep on its own and
> > simply replace gpiod_set_value() by gpiod_set_value_cansleep().
>
> And I found a patch, which is merged in v6.4-rc1 which does exactly this =
!
> https://lore.kernel.org/all/20230405135127.769665-1-alexander.stein@ew.tq=
-group.com/

Ah, cool!

> Thanks as it is your advice which made me find it :-p

You are welcome!

--=20
With Best Regards,
Andy Shevchenko
