Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2865BE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjACKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:38:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F7D232
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:38:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0034B80E63
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454CAC433D2;
        Tue,  3 Jan 2023 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742331;
        bh=c3L9uY7EIC7vpSaHHn/bXVJdBylqPR5p2C8ZK3Etjuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgefgNF+4HirWsfutq/MzyV0ZMIyvwlwVnqaxoeHoMf6UtXs7WoAaAZGp9ER9dHtC
         XdzRqXeOeQRDI1bcM7CJkf66kDOfoWPUQgnOJLR1F/KaMQERZB4I2SCKtWIXqdqZjw
         4RizqXan3DrRFexxrVx6oiI7nfdfIS8B4fLuPA4uQYb+0xN8w7P3x0B4EyZq+/kEjs
         UHtGk92bkgerQbFbfqKCdAHjnkncykTAQyqXtlzKc1TEHvAA7a6RyWpLiKHqzp0J0j
         374oGqzoiGv/Dppzd+xsNC6KYJwefvuO/O3OU7SXC/b8D9Xj4YQhevqnOxfYgSVZlQ
         qJFHjhA20Jtew==
Date:   Tue, 3 Jan 2023 10:38:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Ondrej Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: rk808: re-add rk808-clkout to RK818
Message-ID: <Y7QFtQdGaG1h2Kq9@google.com>
References: <20230102111147.2580861-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230102111147.2580861-1-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023, Tom Fitzhenry wrote:

> Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
> dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.
> 
> This line was removed in commit 3633daacea2e
> ("mfd: rk808: Permit having multiple PMIC instances"), but only from RK818.
> 
> Changes in v2:
> - Add a Fixes tag (Javier Martinez Canillas).
> - Add Javier Martinez Canillas's Reviewed-by tag.
> - Add Neil Armstrong's Acked-by tag.

Change-logs should live under the "---" below.

I'll ship this out for you this time.

> Fixes: 3633daacea2e ("mfd: rk808: Permit having multiple PMIC instances")
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/mfd/rk808.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

--
Lee Jones [李琼斯]
