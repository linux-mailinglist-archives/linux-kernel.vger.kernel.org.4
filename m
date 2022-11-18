Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0F62FE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiKRTg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiKRTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:36:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD685A3A;
        Fri, 18 Nov 2022 11:36:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9BB6275E;
        Fri, 18 Nov 2022 19:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BFFC433D6;
        Fri, 18 Nov 2022 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800213;
        bh=tehCaVCC8Hs5tjHCa5kocIARBzPlPu/f+CEu9EDfC+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQHhooj1m/DN7Xh6ISJQ2PkNlWxl7L6zFWwMjsf1nXd4JuiunETBy+65vQbbg8w8h
         pqArn4kQhC5+3iNBEORrEoE81EUieEp789qgnc1/jxViO6ppQwnkzeb9JMsYbkb+zN
         Bvbno9F0Pk2BjcGg2riH3y6SzRLYF6waqt1CMLt3PeMb4RBa3ZCoxCdCYRT0BWX05A
         jrInQcNHy0GALTRG0ggIkXK5KO3XfB+hLNRumXtaWYxz/UkCZ4aVLFGIIWXYkQ5g6o
         RsLv6zR6hmzYmVUjrqUS3NOIwVDOWvgO5iQfxNhaAewJNBzK8vQslE4gNgAtLb6Fby
         //j2t3QwBIXDw==
Date:   Fri, 18 Nov 2022 19:36:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Message-ID: <Y3fe0LbZlOX1Dcw5@spud>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118133216.17037-4-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Walker,

On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:
> Add generic power domain driver for the StarFive JH71XX SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  MAINTAINERS                       |   8 +

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70c1d0f303e..112f1e698723 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19623,6 +19623,14 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:	drivers/reset/starfive/
>  F:	include/dt-bindings/reset/starfive*
>  
> +STARFIVE JH71XX PMU CONTROLLER DRIVER
> +M:	Walker Chen <walker.chen@starfivetech.com>
> +S:	Maintained

Should this be supported? (ditto the other series that you guys have
sent out in the last few days)

> +F:	Documentation/devicetree/bindings/power/starfive*
> +F:	drivers/soc/starfive/jh71xx_pmu.c
> +F:	include/soc/starfive/pm_domains.h
> +F:	include/dt-bindings/power/jh7110-power.h

I noticed that you have not CCed Arnd on these patches, which makes me
wonder how do you intend getting these patches applied?
Until now, Palmer has mostly merged RISC-V drivers/soc patches, but in
the last few days I've taken over for drivers/soc/{sifive,microchip}.

Are you going to send PRs for this stuff to Arnd, or would you like me
to apply patches for drivers/soc/startech? I happy to do that for you if
you like.

If you're going to send pull requests, I am not sure if Arnd requires
GPG signed tags for them. Arnd?

Otherwise, if you want me to take them, please add something like the
following, in addition to the entry your series already adds for the
specific driver:
STARFIVE SOC DRIVERS
M:	Conor Dooley <conor@kernel.org>
S:	Maintained
T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
F:	drivers/soc/starfive/
F:	include/soc/starfive/

Thanks,
Conor.

