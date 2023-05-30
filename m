Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7A716157
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjE3NRS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjE3NRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:17:14 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9CA1;
        Tue, 30 May 2023 06:17:13 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so6482595276.0;
        Tue, 30 May 2023 06:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452632; x=1688044632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7qxp/ySKoxLHMOkesoOAeOFmYowNE4XZL0vbKLeMXs=;
        b=ZZrnE1G+TA8RvrReW/7An9Pw+VXrpp77uUKOf/Hb1Wm38GBmyo9JrLzXhNwZjiTsUa
         vblKqjMOdfYyBwPyhHVReO3H9hRGBbSwkNaWKNMKnt9AIvsZiWGGu2tBP1d2kRC4N1Q3
         bmc5Te/DQQgnwLxQjzeysxsFw3etXNcT7DuNw30qtMjx7BJf1+Di/IDn+//OBK5und7B
         uQVqotbOqIJpGIlOpUrIhAuHODYgFV3PNjDnxGhkfceQ89oAmCX6tQRy6VvylF8Lprr7
         pPoLMbrtm5Urnl0wCaVQgAkOb9V1PWI7MYO4Gj/ySJ9ESZqynaW92zmpyPrERRAq854h
         XvzQ==
X-Gm-Message-State: AC+VfDxHkYUIx0SQe94rUKIriiqhv6z1+8+MXl14rRg16kJGv7dGT1GP
        qjno1hivyq9lJhiJd1cecoLIB9Os5nJldQ==
X-Google-Smtp-Source: ACHHUZ60fPlnZp6LFfVWs3I4ZnunL96uGUakrT6iIi9sckCa20s5Tyrp/4lPHn5UoIzqVqZtfPcrIw==
X-Received: by 2002:a0d:e6d0:0:b0:561:be3f:ae2c with SMTP id p199-20020a0de6d0000000b00561be3fae2cmr2206526ywe.40.1685452631987;
        Tue, 30 May 2023 06:17:11 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id d1-20020a81d341000000b00552f7767803sm4397409ywl.58.2023.05.30.06.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:17:11 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so6482555276.0;
        Tue, 30 May 2023 06:17:11 -0700 (PDT)
X-Received: by 2002:a81:7788:0:b0:568:90a3:404b with SMTP id
 s130-20020a817788000000b0056890a3404bmr2507911ywc.24.1685452631174; Tue, 30
 May 2023 06:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com> <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230529085656.GL25984@pendragon.ideasonboard.com> <86a5xncxhc.wl-maz@kernel.org>
 <OS0PR01MB59227AF1F83A73620179CDF8864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59227AF1F83A73620179CDF8864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 May 2023 15:16:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXnF87BqcxESzOjB9hSMZ0HSnqzRNXEvCXGczDj+4yPjw@mail.gmail.com>
Message-ID: <CAMuHMdXnF87BqcxESzOjB9hSMZ0HSnqzRNXEvCXGczDj+4yPjw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Tue, May 30, 2023 at 2:37 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > {modprobe,bind} error
> >
> > On Mon, 29 May 2023 09:56:56 +0100,
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > The name is just informative so I suppose it's ok. It makes me wonder,
> > > though, if the usb3drd driver shouldn't register the interrupt handler
> > > itself.
> >
> > Well, it registers it itself, but pretending to be another device.
> > Which is wrong on many levels.
>
> OK, Will register the handler in usb3drd driver and expose register/unregister handler API
> with cb function to avoid duplication of the code with renesas_usb3 driver.
>
> Basically, there will be 2 exported functions + 1 spinlock introduced in usb3drd driver
>
> USB3DRD driver register the IRQ handler
>
> Probe/remove from renesas_usb3 driver register/unregister the cb function. Whenever there is drd irq
> cb function will be called.

Please don't make it more complicated: if the parent device does not
use that interrupt, there is no need to move its handling to the parent
device driver.

Your patch looks fine to me, just replace the second ddata->dev, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
