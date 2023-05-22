Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E670BB41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEVLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEVLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:11:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CC30ED;
        Mon, 22 May 2023 04:06:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-62381fe42b3so25770386d6.0;
        Mon, 22 May 2023 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753578; x=1687345578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCxmceFxaOu1idnfY2VfZs/REw/SEk7/UmlEMx9raLg=;
        b=mDOIzfl3POnlvpW7fR0L1vhdAyGYek1iyC/V62ZOA7U7Y2eIo0EkuZW9G43PyX+HtT
         WvsDp8bsb4XqrMv+ifaueMktR4ZousftZiBd4RR4NqhLPdBHK7KSWevXTvdn0TxT+/9S
         iscw/J607rXEoKUs+VVflRAUSrGxqllQVXChQzzrsckZE0Ng6UkpZ40zjXEFTxb5YGVb
         CsA2FH8fUfCD/5T53yIt2lI9/GeQ7hBadutg3uPMeuf0Psr4s9FJGv7tWZozktBAL1th
         tArfVZDwdsy5dqY8f2GKzMrmpqNi+zRFPGsdWvuLNeIpevGzmWXOJUy5eL2eCyyPvtAf
         gqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753578; x=1687345578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCxmceFxaOu1idnfY2VfZs/REw/SEk7/UmlEMx9raLg=;
        b=Sgx566vCmrvHZkeqxXtsZ9EJNYAj6exnFg6YDy3/pkhdyGHWpejHx8vZDMIsy/TBVE
         epVEnfCxvX0gdvRmKb27vQFlxkb1sb3JsQ8HE0HRmOviUIZnIoQra0GPZLwJalx5tdTP
         DjrWDv32Qz8OX6bHvB1t28ZrhfzLrWp7TSwBBbZEuTMXpD06G3WE+FdqS7VJ3rcCzI9W
         Ze/utrytonJmGgszsISDArXw4iq3JNfItISCvS3oxskTTnIA1Ihz9I0Uxm7cVcDVC1gl
         oYcvinKHBBYuMqyZPVtkOdj/9I1B8XPyAdRIk6t7/N0bRA3jgucXzwrzvKO1O/GMyonF
         Wp8w==
X-Gm-Message-State: AC+VfDwC9JE/i29UrnTLRIokhgPsxEoiVSiBKx/IShCq/EveMA35jtU0
        DFSHgOxrfzi0t6mcJjaRwBbhDHKdKFmfnavTxbE=
X-Google-Smtp-Source: ACHHUZ4za1Fk1pRjVTXSpuT50YNQaqoVS3396KaiL6WErAffhxbAYHVgGx3UFjBlpa3K6PD8w4Yf81yJl+5AK0/5DrA=
X-Received: by 2002:ad4:5c49:0:b0:621:6886:d4db with SMTP id
 a9-20020ad45c49000000b006216886d4dbmr18327778qva.38.1684753578280; Mon, 22
 May 2023 04:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu>
 <20230521225901.388455-2-contact@artur-rojek.eu> <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
 <9812499a8e017b8e01327069c8063e5f213bb1c8.camel@crapouillou.net>
In-Reply-To: <9812499a8e017b8e01327069c8063e5f213bb1c8.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 14:05:42 +0300
Message-ID: <CAHp75Vfhj0Unrv+fsy+j-xErqt-UVR6G-7if18LoKgBRZGfG7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
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

On Mon, May 22, 2023 at 1:20=E2=80=AFPM Paul Cercueil <paul@crapouillou.net=
> wrote:
> Le lundi 22 mai 2023 =C3=A0 13:15 +0300, Andy Shevchenko a =C3=A9crit :
> > On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek <contact@artur-roje=
k.eu>
> > wrote:

...

> > > +       memset(tdat, 0, ARRAY_SIZE(tdat));
> >
> > Yeah, as LKP tells us this should be sizeof() instead of
> > ARRAY_SIZE().
>
> Probably "u16 tdat[6] =3D { 0 };" would work too?

Without 0 also would work :-)

--=20
With Best Regards,
Andy Shevchenko
