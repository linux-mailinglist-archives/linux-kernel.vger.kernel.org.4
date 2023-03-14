Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44CD6BA03F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCNUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCNUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:00:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4521B9;
        Tue, 14 Mar 2023 13:00:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so10913367edb.11;
        Tue, 14 Mar 2023 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jud7IfhPHnbiyASn/wGtL+P6Zu5IjTWaT91NPp+KBg4=;
        b=YjfW3qsRh2lDVopihGnL9OBIV/KoLXiy2unWq+FTm1BMFrEvW/Kxr/IayeNfrTrVWa
         QJp1r2ZCFHPtdbvXqGmoaic5LdWTAE7PEZnkACgboWoW2WW0cgcB21vSIxSbroNxafMH
         jt2shn+0c3AoKE+Wy7qJNYht9ftmyzORhPzKXCjzlymJnm9cT/sVvFtL1WnX40iLBbqc
         WQ0BjlcjNIGctNGkr4RjgaIp180tuYSQyYCj1T2T4IRFALyEb0DuUvzrjVIM7vfs20Qz
         lkOsQO6lyMVODHHKm98R1Mo0Ea2YiPfHDX0qg08k3LDz0sXdZuKNSIIBeq/pX5bP+Fx+
         hxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jud7IfhPHnbiyASn/wGtL+P6Zu5IjTWaT91NPp+KBg4=;
        b=RwOHyN8wnq5/kFlc+VHtXwn3CJSApZocJYKcYcCxw3d/b8iQQeO5JzDloRg4iI6S4X
         FpFe8fQMnAkJ4dzG/S4O7yg1beZWAC8zPzx0RiwJmTNOtywU6xxk076lA0W5YRlT4BbO
         eCoZ4YzsCpDcAIe9QJNUpxYJWG/XxaGeZ8aduJ1QEzCogvfT2vLTxpUksbSqWz3Z4wZz
         SugHH84GtbIf8RUsAYmprvWyrzUKbrDBCH518QI/skmu/sCu6TNlexOVT+mbJATNBm3X
         AHcxneUWbhN7Ed9wVcsRwtyftzZZIC92OT8pHUiBiRslvkLZAJsoH+bWKRWs6teJu8AY
         8LEQ==
X-Gm-Message-State: AO0yUKVX5rqEDi3BC1GXruR7GWY0YX10VE1dxtXc2YU9JPaIlk7riuhF
        G4LRznjVW1aPq203ouyut7c=
X-Google-Smtp-Source: AK7set8M3sO1PiJs8c2knz3ceIkbAINsUNHeIyiesvCEzaMZW01qmPTAadH7OxAQIlvaDexMXWdwgQ==
X-Received: by 2002:a17:906:5dad:b0:8b1:3a18:9daf with SMTP id n13-20020a1709065dad00b008b13a189dafmr5128538ejv.74.1678824040344;
        Tue, 14 Mar 2023 13:00:40 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id dx25-20020a170906a85900b00927976a5562sm1525617ejb.181.2023.03.14.13.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:00:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: Use of_property_present() for testing DT property
 presence
Date:   Tue, 14 Mar 2023 21:00:38 +0100
Message-ID: <13221354.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20230310144724.1545223-1-robh@kernel.org>
References: <20230310144724.1545223-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 10. marec 2023 ob 15:47:24 CET je Rob Herring napisal(a):
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/sunxi/sunxi_mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> diff --git a/drivers/soc/sunxi/sunxi_mbus.c b/drivers/soc/sunxi/sunxi_mbus.c
> index d90e4a264b6f..1734da357ca2 100644
> --- a/drivers/soc/sunxi/sunxi_mbus.c
> +++ b/drivers/soc/sunxi/sunxi_mbus.c
> @@ -82,7 +82,7 @@ static int sunxi_mbus_notifier(struct notifier_block *nb,
>  	 * Older DTs or SoCs who are not clearly understood need to set
>  	 * that DMA offset though.
>  	 */
> -	if (of_find_property(dev->of_node, "interconnects", NULL))
> +	if (of_property_present(dev->of_node, "interconnects"))
>  		return NOTIFY_DONE;
> 
>  	ret = dma_direct_set_offset(dev, PHYS_OFFSET, 0, SZ_4G);




