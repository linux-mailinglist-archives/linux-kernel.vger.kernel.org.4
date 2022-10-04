Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218F15F404A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJDJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJDJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:50:12 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B525722A;
        Tue,  4 Oct 2022 02:47:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id df9so4716732qvb.9;
        Tue, 04 Oct 2022 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=cg+ic1dqefBboQUI3t8RLTnTt/zeTAWLuZiAOGzzklc=;
        b=BC0ZfqpGbTpSy43rLVl0DvH4aaF7G3bhB/Zb1bamlhy+ECgSUnTYuNrIrHKyx6wjbm
         ZoMGy942eI1oM0idFzpeDUnp1YHsCTbKIxxSlthIOPQNII4UemBCzdE6dHt6Q1xwO3Ad
         g1L4gyiAy8SnOtXHYRp4/aoYHtQMvipG9YlvQW4lH9DDBqc2dO85p9ZM+NK5ys4ViQZZ
         zC7VzpEnAAmFZ9yKiwpiU+1ZHdo9kaZXLI4wmrCPUZGI8EQ5TraqvnDGuypt5QqvpnT9
         VxTN0rYHyboLEfh0xTPXITSVDHDFWxSZ/s+Zq3fNQYe0Q+5IGW7nQ780mMjXw6Bhf32h
         YZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cg+ic1dqefBboQUI3t8RLTnTt/zeTAWLuZiAOGzzklc=;
        b=vdKeoysb5o9qVjFEvHNKTohfiME/IMqTNvZe9BgVdnUDo3kYd9IP/FYtBcSESo1Z85
         WtaGPm1p6J0CfEya73+cjoi/3ISLm1s07wNXMdI5sTdj7/NDBlweTCZwzpb+YciNfoE/
         cIZ3RFdA1C2WwrawSCn/B2t64pK51o71dkof2YVpnjF2UiG7Ib4ApLt7iVLrSi8itOBB
         AvSfVDMzvTSeJouultNrYPWAGUenfn8qwoyeGFcAF3a7lDgwVXMHnJngW5yfPsGf2fFt
         skdQzQQy2RGj/eA85G6191xZaOXNHx9fCQkg7Nu3kAY9Z8fdQI37Yn+Zz4vJUN6yxm8X
         fYoA==
X-Gm-Message-State: ACrzQf2aM/NBRyHNz1Vf6pbZ2Uh1WLZKs5qUL3TQBC4jHoFQO6rX+GRm
        6mlxrNQSU0rFggIde9QE9sS40kqGSq775ljYEYE=
X-Google-Smtp-Source: AMsMyM6PFSFHrXBkEhFdIbz41omtTcLa5ZjrlfYWDlHGRTIGF3OH3hvWU6pgKx/D+W32nCb1biGp/I1X5LOEn6XGZ2U=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr19167543qvc.64.1664876835575; Tue, 04
 Oct 2022 02:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com> <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
In-Reply-To: <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Oct 2022 12:46:39 +0300
Message-ID: <CAHp75VeS5oA6mOrmXGX2u=x1fL3ZqHZDURYHhA8J1hBpXm-KSQ@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
        johan@kernel.org, wander@redhat.com,
        etremblay@distech-controls.com, macro@orcam.me.uk,
        geert+renesas@glider.be, jk@ozlabs.org, phil.edworthy@renesas.com,
        lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, UNGLinuxDriver@microchip.com
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

On Mon, Oct 3, 2022 at 10:36 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 01/10/2022 =C3=A0 08:15, Kumaravel Thiagarajan a =C3=A9crit :

...

> > +     if (pci_resource_flags(dev, 0) & IORESOURCE_MEM) {
> > +             if (!pcim_iomap(dev, 0, 0) && !pcim_iomap_table(dev))
> > +                     return -ENOMEM;
> > +
> > +             port->port.iotype =3D UPIO_MEM;
> > +             port->port.iobase =3D 0;
> > +             port->port.mapbase =3D pci_resource_start(dev, 0) + offse=
t;
> > +             port->port.membase =3D pcim_iomap_table(dev)[0] + offset;

> Is it needed to call pcim_iomap_table(dev) twice? (here and a few lines
> above in the 'if')

Yes. But the main question I asked (if we really need IO ports
support) still remains.

> > +             port->port.regshift =3D 0;
> > +     } else {
> > +             port->port.iotype =3D UPIO_PORT;
> > +             port->port.iobase =3D pci_resource_start(dev, 0) + offset=
;
> > +             port->port.mapbase =3D 0;
> > +             port->port.membase =3D NULL;
> > +             port->port.regshift =3D 0;
> > +     }

--=20
With Best Regards,
Andy Shevchenko
