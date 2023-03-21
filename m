Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE566C3497
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjCUOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCUOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:43:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312A10CA;
        Tue, 21 Mar 2023 07:43:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so60643103edb.6;
        Tue, 21 Mar 2023 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ubpTBwCGfHItDX77/xDDLQ0Emp6svnzclBDAs6qyE=;
        b=T1s8Ngl+RkVIvxNZpvZnMH7cqodpqineB22YWtIv/fCGFj7joV/a1TjSRUm2pJJHHt
         MUKxqDn5xKWt1O5LBWVnUBgDu7rGLfa03O5Y9FcuEHowG/SlkK7LqP23ZwmrwM0e7Teq
         QIWIwFG8FsQIjgobJ5zpK1KmBtp960ybNTL2lY/5bEB4xvS7cnm3kjiyyk9z2xzet73f
         gBH4RPumKKnXgn8OfdTuNLjHTY1ctiMA2fIGN5fpsiI7phP1firJvEgcgRL6RMRFv9B6
         rxvXVlonIb+2hM/XbpELgBCHVQG3Fb65I6yc1FlE/etUE3C5BrDKrCvP1Dd5HFv5cDVd
         3S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ubpTBwCGfHItDX77/xDDLQ0Emp6svnzclBDAs6qyE=;
        b=r3q6DEz2yV4hDn8IYZKPxexbnrH/9JtKp0BLERREVGhrjc3icgIU/1/JQXcKkwmqvd
         yJG5L5xDQ/oCCQBMHCQg4Zv5fBrncgztfXS0Se5wkvvLdQ3NRUGw8vrM8Ubqm4IA+eg1
         aprKVEFSrqZueWnnrWZwJepo+WVgfg7EJphSGksJ5kz9B0SddH91aD4ctut+Dr1IYOkK
         YPLNqun9TchVtSfFH+IAC/idGqrK0Gya/r5K55z3U4aqEm7niU7LNGquQ3h+LzMgoTmu
         CRoFl4CNWnH7YaTPQ4jVkhQENVp7rquab4h95n6L6KBMu8+LwAFZFZh+boO4kVI8fLq9
         P/pg==
X-Gm-Message-State: AO0yUKVDcwfyVLBQ4ocxPaK78o7bFUjtKZdfG5wST1ES/yoFdKJP+48E
        qUTywqM1D2uEnpeALTxga58=
X-Google-Smtp-Source: AK7set96Is0TLe0fndXxjNYCDYYIIwKDzHB+KNPQfBa3bfvxoMA0iLVPglnQVrqgXhUacHz1wyNEXg==
X-Received: by 2002:a05:6402:1116:b0:4ac:b528:5727 with SMTP id u22-20020a056402111600b004acb5285727mr3772779edv.1.1679409802207;
        Tue, 21 Mar 2023 07:43:22 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation ([5.170.200.163])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b004fb556e905fsm6386755edc.49.2023.03.21.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:43:21 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:43:18 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
Message-ID: <ZBnChlWq5RTI8U8h@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Fri, Nov 18, 2022 at 06:39:17PM +0900, Paul Elder wrote:
> This series depends on v3 of "dt-bindings: media: Add macros for video
> interface bus types" [1].
> 
> This series extends the rkisp1 driver to support the ISP found in the
> NXP i.MX8MP SoC.
> 
> The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
> and in the NXP i.MX8MP have the same origin, and have slightly diverged
> over time as they are now independently developed (afaik) by Rockchip
> and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
> and is close enough to the RK3399 ISP that it can easily be supported by
> the same driver.
> 
> The last two patches add support for UYVY output format, which can be
> implemented on the ISP version in the i.MX8MP but not in the one in the
> RK3399.
> 
> This version of the series specifically has been tested on a Polyhex
> Debix model A with an imx219 (Raspberry Pi cam v2).
> 
> [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/

I tested your series on imx274 on imx8mp-evk csi0.
All looks good on my side.
Thanks for your work!

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

Regards,
Tommaso

> 
> Laurent Pinchart (3):
>   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
>   media: rkisp1: Add and use rkisp1_has_feature() macro
>   media: rkisp1: Configure gasket on i.MX8MP
> 
> Paul Elder (11):
>   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
>   media: rkisp1: Add match data for i.MX8MP ISP
>   media: rkisp1: Add and set registers for crop for i.MX8MP
>   media: rkisp1: Add and set registers for output size config on i.MX8MP
>   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
>   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
>   media: rkisp1: Add register definitions for the test pattern generator
>   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
>   media: rkisp1: Support devices without self path
>   media: rkisp1: Add YC swap capability
>   media: rkisp1: Add UYVY as an output format
> 
>  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
>  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
>  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
>  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
>  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
>  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
>  include/uapi/linux/rkisp1-config.h            |   2 +
>  9 files changed, 509 insertions(+), 40 deletions(-)
> 
> -- 
> 2.35.1
>
