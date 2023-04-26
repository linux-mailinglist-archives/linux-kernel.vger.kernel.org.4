Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C679D6EF09D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbjDZJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289340F4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:12:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK/E7n7nAX/4ZRojQQzb7HbpiDrWFTu4YVwrpr6eYLc=;
        b=tOrJLaX/33NYU0pkpLF21EV4zQ849QQhW1DBN9DntGjnXjIdlNVk8ish7Zfakv0rlnUHuK
        6RYD64Ey80nAzO7Nro6NXlYz+uHwrBoahgNoFtkeMgSCvktPSI9D6q+/rQHD1lH6pkz2yx
        e1c/iX15OEGSEssYuT0TJjPW8NEJTHppQKAdANYZeaJ5E+xRweLKaZs3ZPDi2xpRh4iI+O
        Xd3+oOqzEl1zY7pmJflS80rLhQlqkS6RhvUaEttVZHK4asjlGrAWXm+BP3xTtd2pn3hPdB
        ZZ2RlLqn7SF0ah6NVgAXMQju/9bobtOR4Pw60dEAY8BGNOBMmUMvAiaFQQy1Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK/E7n7nAX/4ZRojQQzb7HbpiDrWFTu4YVwrpr6eYLc=;
        b=DfzbZO/roxU7UdD0uUqezn5fgegOJr0LfxNP4dpjz7E4bADDq2pkmTVKUlmul0HEL9kRhB
        lCVTeLf7TCK6htAg==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?Q?Kle?= =?utf-8?Q?ine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Qinrun Dai <flno@hust.edu.cn>
Subject: Re: [GIT PULL] timers material for v6.4-rc1
In-Reply-To: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
References: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
Date:   Wed, 26 Apr 2023 11:12:05 +0200
Message-ID: <87fs8nyplm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2023 at 13:45, Daniel Lezcano wrote:
> The following changes since commit f7abf14f0001a5a47539d9f60bbdca649e43536b:
>
>    posix-cpu-timers: Implement the missing timer_wait_running callback 
> (2023-04-21 15:34:33 +0200)
>
> are available in the Git repository at:
>
>    ssh://git@git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v6.4-rc1

git@git.linaro.org: Permission denied (publickey).

I used the https variant as usual ...

