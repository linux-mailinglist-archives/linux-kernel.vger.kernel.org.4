Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB075035E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGLJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGLJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:36:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF7C26B3;
        Wed, 12 Jul 2023 02:35:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3159d75606dso3039332f8f.1;
        Wed, 12 Jul 2023 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689154511; x=1691746511;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBqycqdNdKpz14Pbyqrq6OFOf+4Pct6fOpn39ZFo7ps=;
        b=e/BwJ7H+6lYRsarWatoXwjH2z6jSppmrB0Kd9gpWYbB398QX9je+5K44f+oJE+Ga0e
         jko5FJSrMikCULG5hqUyTiLNJwPuq7ua9f6bs2cJ7jFMCyPxVsgII3FRjwAbn5wyUVxT
         UcGyC42hJkyU4cPrdw6+r5xhO270c5tcLguSWw0Oipt+ynQq1mRgHVe8FaaabfOCMRi3
         K7sN3Uunjy2Qsr2JYT1CBCEnSqtSb9UZ3BxqaxYA86Jw4Jdw1yKDPFMlPqHY0efsfy8q
         2LnxIZ6cfKhueEb0q3doHIbdgzr3LdsseLY+rRNYr5ttPzYmVtEPdUWVi33mUPU+cqYl
         YC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154511; x=1691746511;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBqycqdNdKpz14Pbyqrq6OFOf+4Pct6fOpn39ZFo7ps=;
        b=O3VZdDOeeiEgCFqMG5WiGukkeGSKbEuvvKLewjQiUcSogE3bWJzI13TyR9h6aAR5ly
         ckP0LcHRyatq4Vuky7I/r8u/+5ppw28p8FnmgZbKE9YF2o8ffny9YQflLecnXweMx05K
         xElbaVYRScPJyzZVOrOef4x2lZO5xjg3pL4pmc4tPCrKfAOP8jpOhOEzZnHf0TrovDzP
         Q/WOkJSI5gAL4Jm3XNtFJQGsS8vodDKzDwGapkZo7svPOTzsO/TZM46BYPtPH0XRxaa3
         yIUVmjeeVqeA19TuuKIgoO6seviNn8UuWPammnvq1BvC7uV13cJe7HkyjT6mWTrMp2hE
         MBpw==
X-Gm-Message-State: ABy/qLaf/bp/coMK/YmUrgZOFfLi4cfZh5dw6pfz2DVUc6yaYQQCGIGi
        Fw/1oO42eARSaXE+rGaSwpU=
X-Google-Smtp-Source: APBJJlEx9oYNUwmPTQ7MzLLoCB7QFxl2/IctouLhRz+s1Xh6/Gry0pjzT5sJQzzPMOjfkp5Kv1K90A==
X-Received: by 2002:a5d:68c6:0:b0:315:a043:5e0a with SMTP id p6-20020a5d68c6000000b00315a0435e0amr7048870wrw.56.1689154510696;
        Wed, 12 Jul 2023 02:35:10 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003fc02219081sm4594539wmm.33.2023.07.12.02.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:35:10 -0700 (PDT)
Message-ID: <64ae73ce.050a0220.fe1a6.4b8a@mx.google.com>
X-Google-Original-Message-ID: <ZK4I7j3lWat/FaJa@Ansuel-xps.>
Date:   Wed, 12 Jul 2023 03:59:10 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 0/1] add blink and activity
 functions to SGPIO
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712022250.2319557-1-colin.foster@in-advantage.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:22:49PM -0700, Colin Foster wrote:
> Preface (new for resend):
> 
> This is a resend of a patch I'd sent a couple years back. At that time,
> I was told to wait for hardware-offloaded LEDS. It looks like that time
> has finally come, so I've changed this from PATCH down to an RFC to make
> sure this is the right approach for the framework.
> 
> Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) have support for
> hardware-offloaded LEDs based on network activity. This is currenty
> managed by way of pinctrl-microchip-sgpio (and this current patch).
> 
> The purpose of this resend is two-fold. First, to come up with an idea
> of how this pinctrl-microchip-sgpio module can fit in with the new
> hardware-offloaded netdev triggers Christian Marangi recently added. Is
> this something that should be in the pinctrl module itself? Or should
> there be a drivers/net/ethernet/mscc/ocelot_leds.c module that I should
> add?
>

I'm a bit out of the loop on what magic OEM did to make LED work on
ocelot but I feel an ocelot_leds submodule is needed.

To correctly supports the hw many API needs to be defined and for switch
I would stick with how things are done with qca8k, codewise and DT wise
(with how LEDs are defined in DT)

Ideally the feature for MAC will be generilized and added to the DSA ops
struct, so having things in the DSA driver would make the migration
easier.

> The second reason is maybe there's someone out there who might also be
> considering implementing this. This might be a good starting point if
> someone is eager to get coding. On my priority list, this is quite low
> so I'll get to it eventually, but maybe not even in this dev cycle.
> That's why I'm including the original patch.
> 
> 
> Any suggestions on how to approach this problem are welcome.
> 
> 
> 
> 
> (You can probably stop reading here)
> 
> 
> Original Header:
> 
> Expose a debugfs / devicetree interface for Microsemi SGPIO controllers.
> By writing values of 2-5, the SGPIO pins can be configured for either
> automatic blinking or activity.
> 
> The implementation is modeled after the code in
> /drivers/pinctrl/pinctrl-ocelot.c.
> 
> I have only tested this with currently out-of-tree patches for the
> VSC7512 that I hope to get in soon. They are not needed for VSC7513 /
> VSC7514, SPARX5, or LUTON - but I don't have any hardware to test.
> 
> Of note: the 7512 chip has a discrepancy between the datasheet and the
> registers. The datahseet claims 20Hz blink default frequency, the
> registers claim 5 Hz default frequency for BMODE_0. I override the
> OCELOT registers to correct for this. I don't know if that is needed for
> LUTON or SPARX, but having two blink modes at the same frequency isn't
> beneficial. As such, I make the blink modes match the 5Hz / 20Hz for the
> two modes.
> 
> Tested with VSC7512 by way of:
> echo SGPIO_O_p1b0 {blink0,blink1,activity0,activity1} > 
> /sys/kernel/debug/pinctrl/pinctrl-sgpio-pinctrl-sgpio-output/pinmux-select
> 
> LEDs blink!
> 
> 
> Colin Foster (1):
>   pinctrl: microchip-sgpio: add activity and blink functionality
> 
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 135 +++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
	Ansuel
