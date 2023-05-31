Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D3717D55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjEaKqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEaKqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916ADBE;
        Wed, 31 May 2023 03:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218D4627FA;
        Wed, 31 May 2023 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD17C433D2;
        Wed, 31 May 2023 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685529978;
        bh=uvajCD/cT8XPDDXHL1P5zECvOH/G0AyyNrIES1Z6/Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/ok+6f1wkidXmCi52ay4cMHzhejtsHqtYwA+9gXXd/YWg72oZmtpsb/yN8YRvB43
         o5RzGUJb/8sR6kVKcY2eRyZwbmI6kndeBkEnOlGx5gb3NLeFd0LLO7f07SiJ5JQ2Rh
         WECGpklsOlOx02Qgxou8TlQ/Uvn1QNLIXWqBpBFYhO+dEQ4lJSCfuosihMxsfczjBH
         geOAjLRvqZjZZ+v3Vv3MaimBz+3nS6or/or6tKpV41D9S6TB5pm5IRM5/Q7q9WqMNh
         i2UeA5ThiOgn+U3nveHzTMjouMFyT0TJUJAv6X8am3AdK0YH6NX9C+0zTF13OLr1JN
         DF0NbRxCjtz5A==
Date:   Wed, 31 May 2023 11:46:11 +0100
From:   Lee Jones <lee@kernel.org>
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>, pavel@ucw.cz,
        corbet@lwn.net, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 00/13] leds: introduce new LED hw control APIs
Message-ID: <20230531104611.GC449117@google.com>
References: <20230529163243.9555-1-ansuelsmth@gmail.com>
 <168552422621.12579.18364898651664418572.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168552422621.12579.18364898651664418572.git-patchwork-notify@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:

*sigh*
 
> On Mon, 29 May 2023 18:32:30 +0200 you wrote:
> > Since this series is cross subsystem between LED and netdev,
> > a stable branch was created to facilitate merging process.
> > 
> > This is based on top of branch ib-leds-netdev-v6.5 present here [1]
> > and rebased on top of net-next since the LED stable branch got merged.
> > 
> > This is a continue of [2]. It was decided to take a more gradual
> > approach to implement LEDs support for switch and phy starting with
> > basic support and then implementing the hw control part when we have all
> > the prereq done.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,v4,01/13] leds: add APIs for LEDs hw control
>     https://git.kernel.org/netdev/net-next/c/ed554d3f9451
>   - [net-next,v4,02/13] leds: add API to get attached device for LED hw control
>     https://git.kernel.org/netdev/net-next/c/052c38eb17e8
>   - [net-next,v4,03/13] Documentation: leds: leds-class: Document new Hardware driven LEDs APIs
>     https://git.kernel.org/netdev/net-next/c/8aa2fd7b6698
>   - [net-next,v4,04/13] leds: trigger: netdev: refactor code setting device name
>     https://git.kernel.org/netdev/net-next/c/28a6a2ef18ad
>   - [net-next,v4,05/13] leds: trigger: netdev: introduce check for possible hw control
>     https://git.kernel.org/netdev/net-next/c/4fd1b6d47a7a
>   - [net-next,v4,06/13] leds: trigger: netdev: add basic check for hw control support
>     https://git.kernel.org/netdev/net-next/c/6352f25f9fad
>   - [net-next,v4,07/13] leds: trigger: netdev: reject interval store for hw_control
>     https://git.kernel.org/netdev/net-next/c/c84c80c7388f
>   - [net-next,v4,08/13] leds: trigger: netdev: add support for LED hw control
>     https://git.kernel.org/netdev/net-next/c/7c145a34ba6e
>   - [net-next,v4,09/13] leds: trigger: netdev: validate configured netdev
>     https://git.kernel.org/netdev/net-next/c/33ec0b53beff
>   - [net-next,v4,10/13] leds: trigger: netdev: init mode if hw control already active
>     https://git.kernel.org/netdev/net-next/c/0316cc5629d1
>   - [net-next,v4,11/13] leds: trigger: netdev: expose netdev trigger modes in linux include
>     https://git.kernel.org/netdev/net-next/c/947acacab5ea
>   - [net-next,v4,12/13] net: dsa: qca8k: implement hw_control ops
>     https://git.kernel.org/netdev/net-next/c/e0256648c831
>   - [net-next,v4,13/13] net: dsa: qca8k: add op to get ports netdev
>     https://git.kernel.org/netdev/net-next/c/4f53c27f772e
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

-- 
Lee Jones [李琼斯]
