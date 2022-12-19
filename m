Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66AF650BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiLSMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:35:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D83A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:35:30 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jo4so12182711ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rCYG7t1izN/gOyqR3UaPefTWs3YwGVtAE/HZuYn9Rfc=;
        b=ZKtkG+FX5U20S1M6EMAO9s5DcYzxSPb3NQCBOLLNZKUq1ijR3Q2uoYri0UIzTgvgB0
         BuFxphDmBbwcllU3Gq/LcNYSqtuoFmVbWfxHoWpZbb485QqVZreK8NBdka6pJ9kqxEfi
         b6g2VtgxtP/YluAJZKnBbJAR0WCcpqKp7HjTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCYG7t1izN/gOyqR3UaPefTWs3YwGVtAE/HZuYn9Rfc=;
        b=6h341Xz0Omgjiwh3+S1A3yafWrPsp/QTjJnVJwqDQH1ZXFVWFjLZl82C92oDPUYYuE
         K81MB6M7m2LHNKcfjn6y4Pqs+0i0xTQljM61Zjv6STj6amnfIreB7kQamCFdqjAGWq8s
         41687W/BaDO9UUwEpkqk1z6WwGdX4UhqcrnLMQlr4l5XZOZ6X1pLRPubV9q8Vor1NwCL
         bpXmE2l1qQgZEQZvx9wjsnb/801VX213NsmDkypRj+OjELOsbLiwRWYsjnghSRXwYKdF
         NL5uf5v05cKFm0ciTtbKaAiuVaSSjVlED9lKV8QQm4p7QjM9Aon9+O1OZlnjCGsIb8ZW
         G9rw==
X-Gm-Message-State: ANoB5pnZLXeprthjPRZT3PYQbYM/xwuY5WgzDV/S7u357I2ke0qrCcmM
        y2me5DtFkdYUQ5mB41X7LSL3BW0KhkmUKPleujBtXg==
X-Google-Smtp-Source: AA0mqf7MRvG+Qj2JseT+Qj2IY04GU3ehuu2j+6yoRs/z0TWbsGNO6utzwcWxYija4unhyYJGQ57ZKqf8K83fjcrrTnQ=
X-Received: by 2002:a17:906:8383:b0:7c1:19ea:dda with SMTP id
 p3-20020a170906838300b007c119ea0ddamr8979778ejx.31.1671453314287; Mon, 19 Dec
 2022 04:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20221002064540.2500257-1-michael@amarulasolutions.com>
In-Reply-To: <20221002064540.2500257-1-michael@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 19 Dec 2022 13:35:02 +0100
Message-ID: <CAOf5uw=2zjki8DEkgvDTKrj6V=FS44Z1WN3AvFZvzuN-MU_y4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add RGB ttl connection on rockchip phy
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

On Sun, Oct 2, 2022 at 8:45 AM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The rockchip phy can be convigured in ttl mode. The phy is shared
> between lvds, dsi, ttl. The configuration that now I'm able to support
> has the display output on some set of pins on standard vop output
> and a set of pins using the ttl phy. The solution is not clean as I
> would like to have because some register that are used to enable
> the TTL, are in the same register area of the dsi controller.
> In order to test I must add the following
>
> dsi_dphy: phy@ff2e0000 {
>
>         reg = <0x0 0xff2e0000 0x0 0x10000>,
>                 <0x0 0xff450000 0x0 0x10000>;
>         ...
> }
>
> The problem here is the second region I have added is the same of
> dsi logic. Only one register is needed by the the phy driver
>

Is there anyone who has time to review it?

Michael

> Michael Trimarchi (4):
>   phy: add PHY_MODE_TTL
>   phy: rockchip: Add inno_is_valid_phy_mode
>   phy: rockchip: Implement TTY phy mode
>   drm/rockchip: rgb: Add dphy connection to rgb output
>
>  drivers/gpu/drm/rockchip/rockchip_rgb.c       | 18 +++++
>  .../phy/rockchip/phy-rockchip-inno-dsidphy.c  | 72 +++++++++++++++++++
>  include/linux/phy/phy.h                       |  3 +-
>  3 files changed, 92 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
