Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90760AF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiJXPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJXPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:38:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40981D4428;
        Mon, 24 Oct 2022 07:26:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g129so7177009pgc.7;
        Mon, 24 Oct 2022 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ6iF6T0zIUXPA/iUJjlbeVV5R7S7nny4K0HA6GOdU4=;
        b=aBt95Awussn3Wm9r/7PTxZWOl2PYOTP2QP85zW2nDHTj6f0Z4ydtLbWgZP+DizE+WZ
         3RrO3kAVi5tEUW2z922K+9+VBVIiAmy4certMrulkqwPFLW2QUEPeIPhfKt5YX6xgC2X
         hT0wlr4oFClhrk1S6jPKQ1aGgvGR8rEur++3wxN35ylNqKHOpzwPhsi6i5rmg1Pj39vW
         8KqwhF5XlyaoczOuLNvLbUVXiLOmRRIjK4W6VBMNst8CsSS8QPq6jMLaPuTtJyMV5t0G
         TGK1La8qEpPCx3OPzQqieGFUARQIAQhZ6XW6unCf29WwOFBbguF9OI1fnOYuSWXJsbes
         Mt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ6iF6T0zIUXPA/iUJjlbeVV5R7S7nny4K0HA6GOdU4=;
        b=7Fr7iZV7+oTUNt8FeL0TP9dX+OjwqztAbneVIkBYI1lGwE+CYqt7jvhlz1JxyNxoqX
         2Ugrmw24v04h/xASv8LGUicN5uQjOksTBaVJwWwNRhuv4/DVoUPg3K9zxJ3zTOvBjavE
         ihm1awz1m6AfF54diyfIulqe1CiP867TKTKzi+o0nWbzzL2MPctVYW07/KtvlQpk3qy9
         DtxseSqbzKTlC0MbgtC6UqN+T6TUvg9uR1n+MSuAOIJ4fe17YQD/v/NpzpJTgZvdlxUb
         CTQFGlBswcnO+qr8pTeGqkAbUSLubHyfxhVaf3X0QAWsnxE9xJYcjx0jqY8LvZ2DSfAc
         7wcA==
X-Gm-Message-State: ACrzQf0312J25BLi+m0qxw5U7skK9Qz72tSDcYEyy/qADdT9VQ25lCaU
        IlFXryzIGzPjGCfCGn0gnDYW8hY8PzBFe7ZYPAaU4uWs
X-Google-Smtp-Source: AMsMyM6sSiIpLatv76v+ujr0bWsW3B2wikZU8HsGumExxEGBwIcNwvwahd77TVvlPjWHjMiTM3YrQ9QlZn5WzGuzj8o=
X-Received: by 2002:a17:902:b190:b0:186:b9b2:9268 with SMTP id
 s16-20020a170902b19000b00186b9b29268mr754073plr.32.1666616889648; Mon, 24 Oct
 2022 06:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221024115429.1343257-1-heiko.thiery@gmail.com>
 <20221024122659.2krt2hh2sdvxuurn@pengutronix.de> <CAEyMn7Y9uxeFLM7-6jR=bonusdwjX=ukRotZm=7x_3QyxVW-DQ@mail.gmail.com>
 <20221024125630.frrbq4hy2bfxhjtq@pengutronix.de>
In-Reply-To: <20221024125630.frrbq4hy2bfxhjtq@pengutronix.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 24 Oct 2022 15:07:57 +0200
Message-ID: <CAEyMn7ZVT+jR1sH6-RB8C6GnLF4bYvnd8f154AGKKZiPzmGbDA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
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

Hi Marco,

Am Mo., 24. Okt. 2022 um 14:58 Uhr schrieb Marco Felsch
<m.felsch@pengutronix.de>:
>
> On 22-10-24, Heiko Thiery wrote:
> > Hi Marco,
> >
> > Am Mo., 24. Okt. 2022 um 14:34 Uhr schrieb Marco Felsch
> > <m.felsch@pengutronix.de>:
> > >
> > > Hi Heiko,
> > >
> > > On 22-10-24, Heiko Thiery wrote:
> > > > With that delay U-Boot is not able to store the environment variables in
> > > > the SD card. Since the delay is not required it can be remove.
> > >
> > > Now I'm curious, since this doesn't tell us the why, it just tell us
> > > about the end result. I'm asking because the NXP EVKs have an issue with
> > > the sd-card power line capacity and we need this delay to reach a level
> > > which is marked as low within the sd-spec.
> >
> > I must admit that I do not know at all why this entry was made. I have
> > now looked at the dtbs of the imx8 EVKs and except for imx8dxl-evk.dts
> > I see no delay here.
>
> Please see <20221024031351.4135651-10-peng.fan@oss.nxp.com>, they will
> be added.

I think I have to re-check that and especially why U-Boot is not able
with that setting to access the SD card for writing the environment.

Thanks!

>
> Regards,
>   Marco
