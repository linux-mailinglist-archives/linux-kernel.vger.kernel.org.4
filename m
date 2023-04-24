Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159D6ED23C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDXQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:12:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00775900B;
        Mon, 24 Apr 2023 09:12:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec86aeeb5cso4901031e87.3;
        Mon, 24 Apr 2023 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352726; x=1684944726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC/Qel4dCwHXjhR0tp2yNC9uLvVc9f136IJrlcVkO0E=;
        b=lDfqVwC1TF+P7hJinXxEwdB1awluHBjqP5vJ2IPpvyLT/4OwYKefzM6K8Xk5PkBBBn
         xYFO5NddFtUp3CxcU91y/60gGP3qQwbgm9aoQEyfHPlG156CiRcvOGN+pmZ37kVZq2ZB
         UKzuZDycEUWULlYfXTsjcylSTeyBQw6UeZZJprxR1F9BM3FZtJSWYH9IP0RkIrn1VsGq
         qn4bTytF4NZBRZwZVnulgVKzeo8nvUnGBCK21SeDbpJX5nprhaakYhdcpRM5VtBdRjys
         kXEIME0j507Dgk1s638lxOYJwFCFXGq67jZLK5otL0lgUJNPfkCDsyEvPSmU9c/v1d0F
         D8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352726; x=1684944726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC/Qel4dCwHXjhR0tp2yNC9uLvVc9f136IJrlcVkO0E=;
        b=O8Tsfrbsr/IuRxAUrZR5wuel/7LY4vAnOnzEK95S5JAD0OX23y71cjmN2vriIVnjYM
         Qwpxpwb6OcWwl3iJ31R3NMAZ9cKrudPU7hYKCYnes8tqHj/wJl3IsozGroAohlrYU10O
         VVPzqOwHjJhhWNRbJau2uK9uC6iVUTb+LV/+L3Be/xyaPy0BYv4IG3Eu+Z4FZzVPrpzW
         SOWNAyoJcQHVDT6rFmP9oJla96gQRc9oQZnDf6cHqLYAi5eTEvXXWab5OkwlPTIPTzLG
         mPU4OSIJ4Br9atqTB3SNcw4feQJijTpwrSUsBFFesciRQ3nLyrVZS4vpV9W/b3Cw6Kpm
         D/cQ==
X-Gm-Message-State: AAQBX9ehFUNUHvxjacVM9SiWrWzagU68SyCJeX6P3Z0UhBUq+gr/jmvf
        XddVs3Sa1yHUKi6UBGefVZIMhPoaP+WA3efwOfk=
X-Google-Smtp-Source: AKy350YJj/kPMAT/CV755guCAzI7JF4ebsAdwfic/K1Dc1PwpYcrncliIdYKET5PULhJh7W05L7gW+NshKm4na9q4n8=
X-Received: by 2002:ac2:4c8e:0:b0:4ea:f526:5bef with SMTP id
 d14-20020ac24c8e000000b004eaf5265befmr3869974lfl.28.1682352725746; Mon, 24
 Apr 2023 09:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-2-jorge.lopez2@hp.com>
 <dc902d52-7186-4095-9be9-60c728a24f05@t-8ch.de>
In-Reply-To: <dc902d52-7186-4095-9be9-60c728a24f05@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 24 Apr 2023 11:11:41 -0500
Message-ID: <CAOOmCE-N9yMn7Cvr9bK5TpAwpv7_Lam1huWRrYaFzXVtf4v_aA@mail.gmail.com>
Subject: Re: [PATCH v11 01/14] HP BIOSCFG driver - Documentation
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Thomas,


On Sat, Apr 22, 2023 at 3:51=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-20 11:54:41-0500, Jorge Lopez wrote:
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../testing/sysfs-class-firmware-attributes   | 98 ++++++++++++++++++-
> >  1 file changed, 96 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes =
b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > index 4cdba3477176..73d7b8fbc0b2 100644
> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > @@ -22,6 +22,12 @@ Description:
> >                       - integer: a range of numerical values
> >                       - string
> >
> > +             HP specific types
> > +             -----------------
> > +                     - ordered-list - a set of ordered list valid valu=
es
> > +                     - sure-start - report audit logs read from BIOS
>
> In the treevie you sent the Sure_Start attribute does not have
> a "current_value".
> This indicated that it's not actually a firmware attribute but just some
> standalone sysfs attribute.
>
> In this case it should not be documented here, but handled the same way
> as the SPM stuff.

I will update the documentation as indicated.

Regards,

Jorge
