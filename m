Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD567CE47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjAZOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:36:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF872529E;
        Thu, 26 Jan 2023 06:36:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 938D3B81D12;
        Thu, 26 Jan 2023 14:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CFAC433EF;
        Thu, 26 Jan 2023 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743813;
        bh=98SAiW8EasNhUbmpf7pK4esoZxbZJjAiXnvFOnNwpKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfCcCUKFz6Gf+RF5hWJAETkkcjsUp4jjQwmKHYRZl2R1mfNN5X7BZhl9yZeLCRiNg
         9qrLPNiuf8Bdz/n/ZRZc3JoJ3OvC14jm/WyHIvfBNX5i0V7NvEZnfeacpPSGjIaNIn
         AHCae3F/UGrV+7DYjtBQ5dkOIH88nYZlCTQvOPMu426rpviKIIWWeu4viLSbNukEeS
         iB6FU32UFkQ6b3sMR+H8g0jGJlwpjgHPjY867Sa3QyKwYkuBsKR1eY6eCoA/3LQSbk
         iS65fr8vXaIPamQpqApfmdpfVLqYbddK9asoMx3HlrsPURrGIzQNXZPce4al/VqT65
         gKI4Ve43pwssQ==
Date:   Thu, 26 Jan 2023 14:36:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v9 2/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y9KP/0cVKBp6d7qc@google.com>
References: <20230120155018.15376-1-lujianhua000@gmail.com>
 <20230120155018.15376-2-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120155018.15376-2-lujianhua000@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Jianhua Lu wrote:

> Add support for Kinetic KTZ8866 backlight, which is used in
> Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> downstream implementation [1].
> [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Add missing staitc modifier to ktz8866_write function.
> 
> Changes in v3:
>   - Add 2022 to Copyright line.
>   - Sort headers.
>   - Remove meaningless comment.
>   - Use definitions instead of hardcoding.
>   - Add missing maintainer info.
> 
> Changes in v4:
>   - Change 2022 to 2023.
>   - Remove useless macro and enum.
>   - Describe settings by devicetree.
>   - Move header file to C file.
> 
> Changes in v5:
>   - Change "2023" to "2022, 2023" in Copyright line.
>   - Set scale property for backlight.
> 
> Changes in v6:
>   - Correct devicetree property name.
> 
> Changes in v7:
>   - Remove unnecessary sleep statement.
>   - Fix code style.
>   - Add vddpos and vddneg supply devicetree parse.
>   - Add enabel-gpio devicetree parse.
> 
> Changes in v8:
>   - Modify devicetree parse according to dt bindings.
> 
> No changes in v9
> 
>  MAINTAINERS                       |   6 +
>  drivers/video/backlight/Kconfig   |   8 ++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/ktz8866.c | 209 ++++++++++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/video/backlight/ktz8866.c

Applied, thanks

-- 
Lee Jones [李琼斯]
