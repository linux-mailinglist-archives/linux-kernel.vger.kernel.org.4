Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908315FB43B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJKOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJKOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:07:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972AA97EE6;
        Tue, 11 Oct 2022 07:06:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i9so9020763qvo.0;
        Tue, 11 Oct 2022 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HNmks9UCwWqSHnlQF/VVdsqmuEvvfPoRyptBcZQL9k=;
        b=msa4PNVS9ssC3unsAJLPN4JOFKLQnZ9nJ9j+hgYWqa1WhYjBC+QwGXiYJ3RoUZR8tP
         +5svgHV23iWwxKwBeCwvj1cZCmLQmUWOHKZxyC7KTcQbKkQzAY3XBv7X3SUCt37EasWv
         1fIkEclsAjhGKWUMP6B2ZJzMBDXaRpIzDayFbG7EuBYP/daJFFMYEila/eO6cWfrGfb7
         Cmt0jTmSQ3BcE03XlDBjwLSR72Ynu5+MeTr/72s8g6zvvG8SmF8XQSIMChsgR+9vNcyz
         QBqgvCFYTwNQXFhloJG6fu6twmg8Cx2kUUEh86vaVsaMNml6NqsqmUGM8oYehfmsWrk0
         DljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HNmks9UCwWqSHnlQF/VVdsqmuEvvfPoRyptBcZQL9k=;
        b=Gc0rySmtR1rRriErhE5p7Fo3aYsskBRhX9FpG2Z1h9Xq7/lKcIwmUe/XYr9VCMO/D7
         K0BkDu9WsObFoVOwhN5q/yyvfuxA9WQdOXTuLUoFlaAw5/TIzU/zZCef7FuOgey7cIIM
         G7WvFe/lWJeoOrTdHC561xVegfdrLlJfspvjV0XpTeQ8lTfDzu7j/nAnKsTJ5m8jN6Pl
         gDmaShjVVMXccqM/T8WMeAkty2tljZvcD52uhAkCsIGICOtu7+O91IGrpaAAfNGHbqQl
         HMPvVR9hO391sg/WW/bYOBRxrcNETr1wBm54ZgdSLl2T8mERJHoLFlHspYGIiuWB7Y3v
         gwgw==
X-Gm-Message-State: ACrzQf10/ShO0Wuv0OZCIAr8xSesJoX0zTGryLMEZk6fwXYoga36QDVo
        Bl00fjvDDmGJ4LSsOcpYkrZgH14TjUA=
X-Google-Smtp-Source: AMsMyM7rlMH3XCKtXyssekGp5zIMw6llth321QMJ/MedxUU3Cti/Cd4XretvhoDGKAdO59kuU7aXkQ==
X-Received: by 2002:a17:902:b48b:b0:182:42ce:5779 with SMTP id y11-20020a170902b48b00b0018242ce5779mr11547325plr.103.1665497203869;
        Tue, 11 Oct 2022 07:06:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bff:9bd3:c2da:5f42])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b00176d347e9a7sm8574045pld.233.2022.10.11.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:06:43 -0700 (PDT)
Date:   Tue, 11 Oct 2022 07:06:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0V4cLGbYe4j+ls6@google.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Oct 11, 2022 at 02:37:26PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> > > The LCD driver (panel-sony-acx565akm), when probing, starts with line
> > > driven low, and then toggles it to high and keeps it there. Also, the
> > > line is driven low when powering off the device, and ls released when
> > > powering it back on. This means that the reset line should be described
> > > as "active low" in DTS. This will be important when the driver is
> > > converted to gpiod API which respects the polarity declared in DTS.
> > 
> > We should ensure these patches get merged together with the driver
> > change to avoid breaking LCD for booting. Probably no need to have
> > the driver quirk handling for inverted polartity in this case.
> > 
> > It's probably easiest to have an immutable branch for the driver
> > changes I can base the dts changes on. Or I can ack the dts changes
> > if they get merged with the driver.
> 
> Both drivers are already using gpiod API:
> 
> drivers/gpu/drm/panel/panel-sony-acx565akm.c
> drivers/gpu/drm/panel/panel-dsi-cm.c

I was looking at

drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c

which are not using gpiod. Should they be retired?

> 
> So this just breaks things.

I missed the drivers in drivers/gpu/... and I see that they essentially
abuse gpiod API as gpiod_set_value() operates on logical level
(active/inactive) and not absolute (high/low). They should either use
the gpiod_*_raw() variants, or they should be adjusted to do the proper
thing together with the accompanying DTS change.

What are your preferences?

Thanks.

-- 
Dmitry
