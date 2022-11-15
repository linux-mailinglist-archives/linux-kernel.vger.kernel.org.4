Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40780629E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiKOPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiKOPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:52:19 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A42E9E3;
        Tue, 15 Nov 2022 07:51:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u7so10016684qvn.13;
        Tue, 15 Nov 2022 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6dn5ExXEEUUjc/yMx7cgGs2EkgDVeq481oTf2xsoZY=;
        b=lS/wuXpA06L4GbnyUyGuiUHNT+J69FO2Qq4E9GMBMC/FHaanO/dVhs2NP8WYlOp7hd
         OWZh0AwzClg4E47AHWNupIIIRK1oQJdAJKa4bkx7WU17cdvTPsueHf0lIRt3jyFmpwJ1
         K707FTgLPQF0iNspM1k0pvZaN7bOneGMcGEEptaQ6I3u+JqN8NrPPKefzIMU4c9IQW1C
         VZKy3BeGXg2dulHNclzzLdM39zVhrx40vvSGt9kGSxen6NdkmaC6qYF1BVjfUamXAJwH
         jT4LDgTka72jPsROXuN3dGT55YfLgi0LcKO5Vjm0Zek20rjwAoe32EhvYwx1SfMaw0es
         9Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6dn5ExXEEUUjc/yMx7cgGs2EkgDVeq481oTf2xsoZY=;
        b=53uZEPHwTFvHFVpcV80imtr2ilD+fpUrAmAE4u3wUKJ5H22jrnajEVLyoEQrPN6/KZ
         X9Hu/isVsQTDyzKpXVyoYkgg+PPiMgJCAFU6YkpGB3tIJpZ/ciRZTVs/oX+Ap68yyXHe
         Ho/+BaF1U61SJvg8yA4AN6quU6CAwWRWPHWIwwZ+x9REVWIDdluBF5ULeP4KVWT5L4hH
         J5lPlgcWvYuS67rzkgx9Q+VAgaIxSJwJWQE7ht6W6X3uCCQ2jcm8+4BplqfOmgSLvAa8
         sSqJdW7rluHq1vFVW167/UCmsaWVVag0FINODBuAQ0M3WMRuNryvzdtffdXh250uIjsF
         LiEw==
X-Gm-Message-State: ANoB5pkiq3kErmTaKGh3FqjAYkwt5lW0Mv39Aj/j3oPlzokeLB76WdfT
        Jtbw8KRFCgbAWU6d/txqCPHB5bwghvi9/Q==
X-Google-Smtp-Source: AA0mqf5cW6YHCmRTW+FmlbM7ggnLpTfbNnNrmiqLtbGR6gAjEcB93+aujvOQG0KmlCP4m3zPwHJ/RQ==
X-Received: by 2002:ad4:4434:0:b0:4bb:6bbd:8c1b with SMTP id e20-20020ad44434000000b004bb6bbd8c1bmr17595669qvt.111.1668527505699;
        Tue, 15 Nov 2022 07:51:45 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006fb7f94a65bsm3655784qkp.44.2022.11.15.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:51:45 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:51:43 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 02/14] serial: liteuart: use bit number macros
Message-ID: <Y3O1jyO+9iCGS5Rx@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-3-gsomlo@gmail.com>
 <40b5679c-5316-9c5c-7e4-5c8c74ba1acf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40b5679c-5316-9c5c-7e4-5c8c74ba1acf@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:33:47PM +0200, Ilpo Järvinen wrote:
> On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> 
> > Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 32b81bd03d0c..1497d4cdc221 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -38,8 +38,8 @@
> >  #define OFF_EV_ENABLE	0x14
> >  
> >  /* events */
> > -#define EV_TX		0x1
> > -#define EV_RX		0x2
> > +#define EV_TX		BIT(0)
> > +#define EV_RX		BIT(1)
> >  
> >  struct liteuart_port {
> >  	struct uart_port port;
> > 
> 
> This seems to assume some random header provides BIT() for you?

OK: version 4 of the series will have this commit explicitly
#include <linux/bits.h>, which right now is most likely brought
in implicitly by one or more of the existing headers.

Thanks,
--Gabriel
