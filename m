Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67065710875
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjEYJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEYJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:13:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5B197;
        Thu, 25 May 2023 02:13:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75b0f2ce4b7so36248185a.2;
        Thu, 25 May 2023 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685006027; x=1687598027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dXxRgpCYwYEvO8+viBKaOCvYsHdp+OLwEgKK5Zar84=;
        b=Ls554U3ah3KLc5ag0G4cR+GTuWgnowKVe2eWj/Eiys8rv5glhbXYEY9fV04gF59JLh
         9jZhc0Ua/7ZvWvL7R+KdNgXZaz9zqr84HBjHnlHbQMyRkjTCXSCBLGmMTYztMY1sdlbN
         K1NaU92EtWfRaVJFVNcqBsW64IOO2rKq4cYM/nBP2ybsXMM5B7APjNrY8f6p2fRElRwe
         U4Bu6JukPUZplBQgQkXsL1h544YfvgWWB3T/R5LGGFgwWaxinNdHRDAmE9/4T5tNPeaq
         Z+YwUeGwXdoEymEZw67hxXXg4RsGMG4mETL4X/y3aIUa1KYK1y9kZg15EKZZNoODA+PL
         Yaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006027; x=1687598027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dXxRgpCYwYEvO8+viBKaOCvYsHdp+OLwEgKK5Zar84=;
        b=dBMFEvzUuYis0BLwR1Pjd17pK7iTn3dgflnb7NgZ2m0acfQRZUXQySorzNvcTQHNXg
         YAGASUf1nhOUFl8Al1pS2P5wAkLtWDmsgeU57wOeZcdSrXdImclKII8IGFjmcPpUBfLB
         GLT9nmcHMGpopxrC+j1qZMYo43Dh7+1MAuEkxKs4LiLXjwxhaWfcrDVcgGlN6ORjFWBq
         Ub9jjJbTL/BS/KVum3aanCCWTrBhnn3my9kkS8VqoE21xV913VFWGLKadMaxT63QVYO4
         jFPIqt6PBCksgmY2RWzCkfamm5HwKXrz2shfmBYU1CWk8KUgbQ9a31EveE64KTA31zs7
         H+0w==
X-Gm-Message-State: AC+VfDyDxuMPyMay4nytiCArCgRLnPGOMjAtPrXPx8+z0LDCuesQfCN4
        VV1Odd4V7N7yZatyHWS8cR2K+KI6tIYh8Kcz09k=
X-Google-Smtp-Source: ACHHUZ5/PSruSG0Zg49jiTqWBTWANT+/yiun94pxgP+eSbT3w3NfkfztzOx4znxgMQFr25/t/KPxnzbFOMfO9tlaHIM=
X-Received: by 2002:ad4:5d48:0:b0:616:4c4b:c9b9 with SMTP id
 jk8-20020ad45d48000000b006164c4bc9b9mr734564qvb.37.1685006027396; Thu, 25 May
 2023 02:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZGzsD_HMbMGhGwcr@surfacebook> <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol> <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
In-Reply-To: <f9006a57-4c67-c8a0-badc-84b3292aa686@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 May 2023 12:13:11 +0300
Message-ID: <CAHp75VfVr0N4Fv=s_12vcTi8=pGWJgeWoXpxQvqSNWDcZauS=A@mail.gmail.com>
Subject: Re: using libgpiod to replace sysfs ABI (was Re: [PATCH] gpiolib:
 Avoid side effects in gpio_is_visible())
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, May 25, 2023 at 2:53=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 24/05/23 17:41, Kent Gibson wrote:

...

> It'd also be great if there was some way of ensuring that a line's state
> is kept after the application has released the request (i.e. the txdis
> case I mentioned). But that probably needs work on the kernel side to
> make such guarantees.

Won't happen. It will require too much of strictness to be added into
the kernel with likely breakage of the existing code and
documentation. What is being discussed is a D-Bus (like?) daemon +
Policy in user space that will allow user / process / cgroup / etc to
"own" the line and track its state.

--=20
With Best Regards,
Andy Shevchenko
