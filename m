Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD508731AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbjFOOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbjFOOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079012110;
        Thu, 15 Jun 2023 07:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9817963BBE;
        Thu, 15 Jun 2023 14:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FDC433C0;
        Thu, 15 Jun 2023 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686838047;
        bh=4IkplSyse+fcqo0BxBbsFz6EOvoaJfDtU9CrjGZJGxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFICRMR4b8Y7gnvJJiNTX9TDUN5XroVn5v2inVtCEO5r5zQHiQ0LJZf1Oh+/+Ty9F
         sQ4dJ7MbVjm5rhAlzM0N4WQVmHfUaiXbzE+VBSyVcuKdCShxf3ih2EeKR9PuFUQ+dn
         7yMf7FuSsyQewbbhE25pw+Il4kA1F/mgMfYyKQkoyVApxITPN0gR58jXxi1+jL6HlP
         KyT5BOjzgJWwTiBxWWMzx495e6IBJSlMxd5TNjziQ4ji9hpFGaq/G3DBQlaRAGJSu4
         rBIOsGYyJg2d5/YGQWUgu75+vu0gyoiLmu2SH09V1dGi6lTiXqXOsmbF4SxvdNrhHp
         Xp91GzhaVP5gg==
Date:   Thu, 15 Jun 2023 15:07:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: fix config reference for AW200xx driver
Message-ID: <20230615140722.GH3635807@google.com>
References: <20230609100233.4111-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609100233.4111-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Lukas Bulwahn wrote:

> Commit 36a87f371b7a ("leds: Add AW20xx driver") adds config LEDS_AW200XX
> in drivers/leds/Kconfig, but then in drivers/leds/Makefile accidently
> refers to CONFIG_LEDS_W200XX; note the missing A!
> 
> This typo makes it impossible to add the driver to a kernel build.
> 
> Fix this wrong config reference.
> 
> Fixes: 36a87f371b7a ("leds: Add AW20xx driver")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/leds/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
