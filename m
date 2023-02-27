Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5A6A4AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjB0TUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjB0TUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:20:30 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156D21A1F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:20:28 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a3so13012328vsi.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYMeFcf+ypkoKVjHIY4FQjpDRLkN6rEsHF8Ba8hLVQ4=;
        b=qfY3/reSbwcucHvysUcDXHXPNI9KASsWErkAft/Z5bCB/1V8adMJi2vMae6TkEfBge
         pCQL+1x3FnMM41CY6yJbvzoC2O6+eeFw8w7a/ZIn/KdkLHZ0lOA9d0wXF98EU51IRgBV
         huuUDrmLCEMzmDDoAijiWBrsmLArg/bY3e6/ZUO4IQ/XaiC7Wb4PgY+uhW2ntqV+fkIv
         yOxE5bYu8zpBZooJDOayMVmI9UAVFsuOYaP2pBJ1h7NvUtTt8MV4KnZ/gmVDqaX9LKvN
         swXmieNTIpGaaWCD3ce1mcGaVlPDhUy1NfPti9OH1JRvjskvVzJI8sHhUIkXcnztKSK5
         jdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYMeFcf+ypkoKVjHIY4FQjpDRLkN6rEsHF8Ba8hLVQ4=;
        b=hc2BhH0Vn7YDiTaH7v0EC7NRr+ZFodNDdVOAYaTvDQUczxoH9oqL/Q0u98G+YhJ9Ks
         BTVH11RJjVJ4hjP/s0Kp3fCpq6PpPQJZs51XhHjdezaov93q7Mjuzax/9lT5+LE4oSqK
         Srp51fmpnUtUKLE/4MV8NKnfISZOEq/kpDNg7e9QTzDofsDSDmx/x6sKS9NQvoq6iWmo
         itkQn3WCNsAP8tF9oR+x4JGxArlmsDl0BtOBd3AidHlP451XW3Y8hBjZxLQLyMKHfVnv
         weADhwVZlrO4kRmZjiNuoKoXlZdrAehivDXoPpW3q+5ET6mXFicx3s38Tf5OuzH1VgcF
         sYug==
X-Gm-Message-State: AO0yUKWpcOvwc8m/tF4kUP/pFy2WCbSJGX2vIw8m605GnrFNvEyRPq08
        EOviC0syH70Q1TvXiTH5pILsa/2JTtDNQyDnVepGuA==
X-Google-Smtp-Source: AK7set/wsnNNPFwQQ/RsRwlCje/UJMUMUCx7iUqOEKRuIuUCbv35q+AU+uykmAULwh0jnNOaxljpk+5Gof7fGIVCRfg=
X-Received: by 2002:a05:6102:7c4:b0:402:9bf1:289f with SMTP id
 y4-20020a05610207c400b004029bf1289fmr406097vsg.5.1677525627393; Mon, 27 Feb
 2023 11:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20230224113837.874264-1-jneanne@baylibre.com> <20230224113837.874264-2-jneanne@baylibre.com>
 <Y/iqhsEIvHgnZ+5l@surfacebook>
In-Reply-To: <Y/iqhsEIvHgnZ+5l@surfacebook>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Mon, 27 Feb 2023 14:20:15 -0500
Message-ID: <CADL8D3bm82+=LwYnve04FB2zsSJ6ceKQHycV9oNWoYFiOQnVCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     andy.shevchenko@gmail.com
Cc:     Jerome Neanne <jneanne@baylibre.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, tony@atomide.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 7:16 AM <andy.shevchenko@gmail.com> wrote:
>
> Fri, Feb 24, 2023 at 12:38:36PM +0100, Jerome Neanne kirjoitti:
> > Add support for TPS65219 PMICs GPIO interface.
> >
> > 3 GPIO pins:
> > - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
> > - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
> >
> > GPIO0 is statically configured as input or output prior to linux boot.
>
> Linux
>
> > it is used for MULTI_DEVICE_ENABLE function.
> > This setting is statically configured by NVM.
> > GPIO0 can't be used as a generic GPIO (specification Table 8-34).
> > It's either a GPO when MULTI_DEVICE_EN=0
> > or a GPI when MULTI_DEVICE_EN=1.
>
> Something wrong with the indentation.
>
> > Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
>
> Can it be Datasheet tag?
>
> > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> > Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>
> Not sure how to interpet this along with the From line.
Are two sign-offs not allowed/expected?  I wrote the initial
implementation of this driver and Jerome updated it and is handling
submitting it since he did the rest of the TPS65219 drivers.
>
> ...
>
> > +config GPIO_TPS65219
> > +     tristate "TPS65219 GPIO"
> > +     depends on MFD_TPS65219
> > +     help
> > +       Select this option to enable GPIO driver for the TPS65219
> > +       chip family.
> > +       GPIO0 is statically configured as input or output prior to linux boot.
> > +       it is used for MULTI_DEVICE_ENABLE function.
> > +       This setting is statically configured by NVM.
> > +       GPIO0 can't be used as a generic GPIO.
> > +       It's either a GPO when MULTI_DEVICE_EN=0
> > +       or a GPI when MULTI_DEVICE_EN=1.
>
> Similar issues as with commit message. Also if chosen as M, how will it be
> called?
Based on INPUT_TPS65219_PWRBUTTON, this should have:

To compile this driver as a module, choose M here. The module will
be called tps65219-gpio.


--
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
