Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98C67D340
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAZRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:33:47 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D50134;
        Thu, 26 Jan 2023 09:33:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 78so1521976pgb.8;
        Thu, 26 Jan 2023 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DYjQ6n7EzYx5Feg2QhHYMO/VOjLFRVbBQjDB4pTdf0w=;
        b=X+twqZtuFZyiGYoiYl69j8TNREuL2JLzAJBTdaz6rF1oufc3Xu+L3d4zO0wkMmeKbE
         4ezJ9+kA4qfmax5geiqFWNa5XH3XZrdyTJC5Fon8aaY1koxavJwi5XwoCSmYRHS5k5no
         pKpYtZKeIxxCWX1Lqu3c9459zz4qj8UeLgTIiAmv6pbG0uKwybmqokQZ7lMNqE6B9Hhy
         MyGcBrLgRxvy+joUKJOSA+2Tz/ga4uiX1Gg/k/YcSsOgkHzR3gohrc/kXAhR8NPR6n+M
         IhqL2M9czGQmYyKp/bHrpHpsbrrUEZEkzDD2p1KDcIvup44JkbDe24ZWekchxfrClbFc
         kZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYjQ6n7EzYx5Feg2QhHYMO/VOjLFRVbBQjDB4pTdf0w=;
        b=32rjvlYD7O4w9o4CR0dANAFvgWIJq5joh+lUl1RXFq7nxJPMkM7DtbmK/nzlWOZabN
         GdfMo7UEdIHRdLE6xkkIpZMRBE5t0oajGVL8yQPIj5ipTkuPvzP1aiHOPvQm/IMP+VPN
         zdEb1EZKEyq+gvuMUOFRN36zUTGla//wIYi8VGa+j0zt3CP2ZJMVZ+5XEXbli7J2YXGP
         7kZEap4zoObvAhSrhax0E9gSqth/GCqT5zahoxQrPpAxdz2Ra6V2ELTOteXgPubT0cDl
         LoWAK3ceNMAQP8feWN7RA5WYhSi3jEUWdXIoMW/e5dPfQs1T7X6XItD9nkBatw6XRWER
         R7dQ==
X-Gm-Message-State: AFqh2kqiOrmzEZWqf7aVDL9aNY6B2/dNaHubOS12VXe8AcGsqo2GEA78
        cCloiyWB5gxup53Yh759uGrTCU602KpU9+Xi2lOxhosRZFiFGQ==
X-Google-Smtp-Source: AMrXdXsf5v4sOOZsERmRZKgXWIfQLfKhlXvtmsnQdnfW/oY0KlsPDf8FBeXg11R1ejkbk0Do5Ao5a4NvKqREJ59UbBA=
X-Received: by 2002:a62:1989:0:b0:58d:ae61:c14b with SMTP id
 131-20020a621989000000b0058dae61c14bmr3821738pfz.51.1674754424507; Thu, 26
 Jan 2023 09:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-9-william.zhang@broadcom.com> <CAOiHx=mQJXAkSsXkgGzpJUCzwxD1nC-Hbw3WX3OfRmp7cfFiww@mail.gmail.com>
 <CAMm8Nh0Lh+oUXZGCTBC-zQPQeg9-1dPUyoq34BP2ZP_vJqWX-A@mail.gmail.com>
In-Reply-To: <CAMm8Nh0Lh+oUXZGCTBC-zQPQeg9-1dPUyoq34BP2ZP_vJqWX-A@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 26 Jan 2023 18:33:33 +0100
Message-ID: <CAOiHx=nZBot4xuZ4aG6-4Ch18wNOK0Ud2+z7B2W7+YEc+U3DHg@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
To:     Kursad Oney <kursad.oney@broadcom.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kursad,

On Thu, 26 Jan 2023 at 17:22, Kursad Oney <kursad.oney@broadcom.com> wrote:
> >
> > While there, you might also want to check the cs_off value(s) as well.
>
> Can you explain this please?

I'm talking about the transfer property cs_off:

" @cs_off: performs the transfer with chipselect off."

See how it is handled in the generic spi_transfer_one_message():

        spi_set_cs(msg->spi, !xfer->cs_off, false);
        ...
        list_for_each_entry(xfer, &msg->transfers, transfer_list) {
                ...
                if (xfer->cs_change) {
                        if (list_is_last(&xfer->transfer_list,
                                         &msg->transfers)) {
                                keep_cs = true;
                        } else {
                                if (!xfer->cs_off)
                                        spi_set_cs(msg->spi, false, false);
                                _spi_transfer_cs_change_delay(msg, xfer);
                                if (!list_next_entry(xfer,
transfer_list)->cs_off)
                                        spi_set_cs(msg->spi, true, false);
                        }
                } else if (!list_is_last(&xfer->transfer_list,
&msg->transfers) &&
                           xfer->cs_off != list_next_entry(xfer,
transfer_list)->cs_off) {
                        spi_set_cs(msg->spi, xfer->cs_off, false);
                }
                ...
      }

if we fix the cs_change handling, we might as well bring it up to state.

In theory I would suggest to switch to implementing the set_cs() /
transfer_one() so you could let the core take care of all of that, but
that wouldn't work with dynamically switching to prepend mode. Might
be something for v1.1 though.


Regards
Jonas
