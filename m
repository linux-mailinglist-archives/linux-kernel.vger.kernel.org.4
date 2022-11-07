Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5661E845
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKGB2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:28:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284E2AE2;
        Sun,  6 Nov 2022 17:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2631460D36;
        Mon,  7 Nov 2022 01:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7265CC433C1;
        Mon,  7 Nov 2022 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667784530;
        bh=uv9BxzrMbMoJsT9XSuF0Zo9qkSqJjZpPCibJdQHn2GA=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=OGpsJbuXf2NIVNRsut4xoXj6O38AjBNTQTKltCPMKVyWwMNqx9cfatWI7kezY1Mvk
         mK4ZjIuvQGiZTUFu6UDhVAE8ZyuyJm1Q15kMbuV1xs95yBa1bFIBSA0bFSS4mLJYKU
         UodG7j9awqP0312CDw3UpVL/5VLqHvAP1nIS9kC6QXT2Xj1iOn295ka1RbH7vRHBoh
         +cky+tzw6oMJfBpI2ay6vynsWU5lOwvA+xGRB3TPV5XkT3Ayj3pQjondiRbp/ah1oe
         KMUWmoRx18nGfKR2W+84qYadkXrD6wyg2GsVfPQtGq+n8+GDMe+bYPAjiMW3UtJP9C
         42ERBW+52tFUw==
Received: by mail-wr1-f53.google.com with SMTP id h9so14190790wrt.0;
        Sun, 06 Nov 2022 17:28:50 -0800 (PST)
X-Gm-Message-State: ACrzQf1oRachRLMqJ4adEn649sBYkQTL76/13UbWuUCyYnW/I3i0VDuL
        q59zthhPCaXkymhTJXhj85KO/cWgrBmzR1xw3zs=
X-Google-Smtp-Source: AMsMyM47zm4eYRd4zwKC+OiGt6MYUKcYbFOZsJmmkSCuV0FUS+utU+2roSHKMXmro7EyByfNjcqI9JDGCrIa1hui0PA=
X-Received: by 2002:a5d:4bcd:0:b0:236:6b67:a5be with SMTP id
 l13-20020a5d4bcd000000b002366b67a5bemr28924858wrt.81.1667784528712; Sun, 06
 Nov 2022 17:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20221106161443.4104-1-wens@kernel.org> <CAMdYzYomgwo3RiUr4pptOD=AUgUS4f6Aqtio3agQP2F-bm2WZQ@mail.gmail.com>
In-Reply-To: <CAMdYzYomgwo3RiUr4pptOD=AUgUS4f6Aqtio3agQP2F-bm2WZQ@mail.gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 7 Nov 2022 09:28:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vKbgZxZUyVSdTfzuukHeUdK-8ymxUVGYg=GGShY6O-g@mail.gmail.com>
Message-ID: <CAGb2v64vKbgZxZUyVSdTfzuukHeUdK-8ymxUVGYg=GGShY6O-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk356x: Add dma-names to UART
 device nodes
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 8:52 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Sun, Nov 6, 2022 at 11:15 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > At least one implementation, Linux, requires "dma-names" properties
> > be used together with "dmas" to describe DMA resources. These are
> > currently missing, causing DMA to not be used for UARTs.
> >
> > Add "dma-names" to the UART device nodes.
> >
> > Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568 SoC")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Enabling dma globally can cause some interesting issues, have you
> tested this fully?

It seems to work OK with the Bluetooth controller, though I'm not running
extensive transfers over it. Scanning both traditional and LE works, and
does exercise the DMA controller.

If your worried about the DMA controller running out of channels and
impacting other peripherals, the DMA controller for the UARTs is only
shared with other UARTs, SPI, and PWM (which the kernel doesn't support
DMAing to). The UART and SPI drivers can fall back to PIO if DMA isn't
available.

So this isn't like on the RK3399 and prior chips, where it was shared with
audio, and exhausting the DMA channels would cause audio to not probe.

Regards
ChenYu
