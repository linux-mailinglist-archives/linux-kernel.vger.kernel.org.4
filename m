Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB46FD63D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjEJFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:38:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55442719;
        Tue,  9 May 2023 22:38:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so12182560a12.1;
        Tue, 09 May 2023 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683697095; x=1686289095;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IRV+sBk5PSnkH2cvQJEurZPQMXkcZOja4gthBlnfdvw=;
        b=A1h54Fif7vGJHhX9m1f3Kshr1flFcjj5AzZ/ocnSu3BiLmXjzWi8eQZxj/rncY8miQ
         0v27z+lMPwGBmHopVHW2+2J14kjpyubV1MgJlX+pboaAr0MZToQgz/2v2g3expkwDpKe
         WZ3tAFfb7li10tp/88owAqkA0zPC+8hxwtaA6ff26GFvXDgrFw78JG7QQUH2LYdwFv5u
         vN1FyOhDc6JeOVeA1f6OWLEPfCBTQVmdWhzybqZa7gw0D+OsML6oniiMpxYs4T4nzHQ6
         JOlHgzkLxan/XMa7ezvhi7uRB3nazYJl74itRiBJ+qcoWns94wmL1BbIUw6l/93Qu5jR
         rODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697095; x=1686289095;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRV+sBk5PSnkH2cvQJEurZPQMXkcZOja4gthBlnfdvw=;
        b=TLkqNKUsFgJO9oCgg0szbMQ8U1WFEULHsEBtlFNcWB/1CEKp0Mgr+HTUsi2NKNB1Hj
         HyXhJIj7HpYUQl5g4boMbf8VkbsQNWvVu+SxOOJYk3zcQiVeCzP32ORWaGb4T1K56kdB
         9X1wktJ/fnxCxZ6knmP8MqAj3Syd+10oKq1POX845PNPmpxI+dGmASiz3sajzN6hw6vc
         tNPCZzLuLiGquMzfTIpMLdfhmPV4F7+aVR0jTt+4eKGTclGeUJHUQ0n6d0SxMV8/sA66
         irXP6qnrxcGilP1P3oSoPXm0FHDYfa0ftu4yNPnkcmMkkQiW3zPo9AD62BR3WQy0Pq+T
         TfTQ==
X-Gm-Message-State: AC+VfDzqlEAnAOe8rkp5XJ4kA8SixYPC+hkrvVDUBHcC4iwkH2rlcrhc
        JRwk9E7Kuu2FLo/OcDB5J29UONcxKqJKdpGRxE4=
X-Google-Smtp-Source: ACHHUZ4ogjZtGrQXMJMKwEGu0G0AbD0KpYVERcNwR4arcIxdi5S+ollKjEgImzB7I/MuJA0JZh7eBw+2jTW/8V51pB4=
X-Received: by 2002:a17:907:9808:b0:94f:4801:6d08 with SMTP id
 ji8-20020a170907980800b0094f48016d08mr15277609ejc.71.1683697095024; Tue, 09
 May 2023 22:38:15 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 May 2023 07:38:04 +0200
Message-ID: <CAKXUXMy3_krgwHMS6TaDZhBePkaHTHigntwBD0WFxMJ=DtgWYA@mail.gmail.com>
Subject: Situation of CONFIG_CLK_SUNXI_PRCM_SUN9I
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maxime,

with commit 49c726d55c1b ("clk: sunxi: Add Kconfig options"), you
introduce various build configurations for Legacy clock support for
Allwinner SoCs. Among them, you introduce the config
CLK_SUNXI_PRCM_SUN9I in drivers/clk/sunxi/Kconfig, but this config is
not used anywhere in the kernel tree.

Can we just delete this config CLK_SUNXI_PRCM_SUN9I again, as it is
not needed, or did you simply miss to adjust the Makefile for this
option to be effective?

I will gladly send a patch, once you could give me a quick pointer.


Best regards,

Lukas

Note: This is a resent email (see original email:
https://lore.kernel.org/all/CAKXUXMzqCktKz7vGN4_QAp4n1SeP0-YHL19evmVSfseZOemd5g@mail.gmail.com/);
now hopefully with an email address for Maxime that reaches Maxime.
