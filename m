Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFB72D368
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjFLVfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjFLVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10506B3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00CD62BBD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED0C433EF;
        Mon, 12 Jun 2023 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686605709;
        bh=oFtWTK68THXWr/Pzz2pWWq2230SZ2mbnhzwgjjtW0Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJ4WWk3OOxvWz0Ybr2ozSWAYzG74ey/RDXw31iZzyL39fDhmKdbVQwxQ0kDG1nPr8
         JRjV5mFIxY1X7nHk0YNMF9lNNyGUof/YArgJvY0fULhQiVqNylQALlNv+hFZxHCiHP
         x4XpLVDCZ6nF84grflLP+4/5+1JfF44ZIvr7xyf4=
Date:   Mon, 12 Jun 2023 23:35:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig add /proc/config.gz
Message-ID: <2023061257-robotics-dinginess-c30c@gregkh>
References: <20230612210208.109267-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210208.109267-1-david@ixit.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:02:07PM +0200, David Heidelberg wrote:
> While 32-bit ARM isn't that widespread, multi_v7_defconfig is used for
> building more generic images, where having access to config can be handy.
> 
> arm64 and x86_64 already bundle config.gz, so this is an effort to provide
> the same level of comfort with ARMv7 devices.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 084cc612ea23..f40b5936ccbf 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1,6 +1,8 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y

Why not make this a module?

thanks,

greg k-h
