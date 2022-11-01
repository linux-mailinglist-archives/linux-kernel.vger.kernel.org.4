Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784AD614E74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKAPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKAPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:36:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9D19285;
        Tue,  1 Nov 2022 08:36:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i9so7016279qki.10;
        Tue, 01 Nov 2022 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tyOFs8HMbPI+3QLAryCFA6h9mffJbuGR7qcAQvPo6U=;
        b=HD2F7usIAd7F8S8uMjiTVJ5X7S19RhIjJDEF6bhBE6PKB4r4Qv5416aWWBwTnpyp0b
         6u3lTQAqEgYqIiEC4Ur3tnmviCrLWklJuwUY2i6p/VgnJ4GF49XFg0idXlmUPLwLztgD
         XBHW1trEsP7xQqFr8JkdwqbVTK7g0kQHP1bKnxGUlb5ayEnD+Dn4X8y6jldU5ZfnzEyr
         vuZyeYNBkODaYu4zQ3mPkwqgQ5VJBZeBBqOL6JgPO8+kYEDn42M2VHr1Pb1aziP4eSFJ
         s6Pid7JP12kZ56M5RLnzEEuXsLbDgv7J/XfwYVVyVoQ6z4Q8QEydkTPLHcbgZaHGuUD0
         0oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tyOFs8HMbPI+3QLAryCFA6h9mffJbuGR7qcAQvPo6U=;
        b=MMiQuA4qaZ+X+4Ycg7uRDAr/2TJgzIvwUejWulBp/EZ/sK+0EI/C0C21QcBGiCe8R6
         ND3xVaN1T8PrkguA5EITLtJ4FNtOVQJgkiopXlzoNxfgYTnDKIyse69AMrY0IhKR8jHi
         UPz3TL2nmDzzAOyBvdTvEPvZl7PoyVeyGTYz3G7bquggXsjHuw0uxYShdwYVMGXKtvF4
         waVXLyudJunHECdYLwHX0xtQRpna0MlglA3e6K5TQGIiE9ZhTZQVo4Yxklt2W91gx3ft
         gYc0i+tRJB7ChFf8RH4m+WyBWxq4oFDemRymoNq/OPAecs/F1MicO0CtKUcj2xytXyI4
         qKuA==
X-Gm-Message-State: ACrzQf3XgKcmcw3ZUHZDxvT7YlQ8ojBBWUe6eDmFNdZ2eeL3U9sMC5qw
        xAK6PgbC7Qzb0qLmKPyy4T+xCPgsRpIbKiv+gYs=
X-Google-Smtp-Source: AMsMyM5qBbpvlvNhLoJPjX7ijO/W8S3R6x9hlC6iBDXs41tmeasn1CZpPTQ+vfmcyONP+08aPBBwyKhVuKClZEnNx6Q=
X-Received: by 2002:a37:8786:0:b0:6f9:6d0c:27b4 with SMTP id
 j128-20020a378786000000b006f96d0c27b4mr130158qkd.383.1667316971008; Tue, 01
 Nov 2022 08:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
 <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com> <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
 <adb2d184-a247-ec16-10f-dfc13831ffc9@linux.intel.com>
In-Reply-To: <adb2d184-a247-ec16-10f-dfc13831ffc9@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Nov 2022 17:35:35 +0200
Message-ID: <CAHp75VeuYDbjvShTTW5797opunO4DvGSLQG3Aiv0pTpx-6ZZXg@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Tharunkumar.Pasumarthi@microchip.com,
        Kumaravel.Thiagarajan@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
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

On Tue, Nov 1, 2022 at 5:25 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Tue, 1 Nov 2022, Tharunkumar.Pasumarthi@microchip.com wrote:

...

> > I went through the code and it seems like this is not taken care by the=
 core.
> > Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485=
_config' callback?
> > This has not been done since we do not need all the configurations done=
 inside 'serial8250_em485_config'.
>
> It has nothing to do with serial8250_em485_config.
>
> It is very hard to believe you couldn't find
> uart_sanitize_serial_rs485() and uart_set_rs485_config() yourself, the
> latter calls your driver specific rs485 handler.

Which version has this API? If it's v6.1-rc1 and patches are made
against v6.0, it's possible to miss something.

In any case, the patches to the serial subsystem should always be done
against the tty/tty-next branch.

--=20
With Best Regards,
Andy Shevchenko
