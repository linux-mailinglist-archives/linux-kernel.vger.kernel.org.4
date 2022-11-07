Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290661E86E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKGBvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGBvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:51:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CACD2F9;
        Sun,  6 Nov 2022 17:50:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w14so14155496wru.8;
        Sun, 06 Nov 2022 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hLQ+MSxsBnw7XpWeeY2S6hYOnV9ftFLKK+K/LhDt1dU=;
        b=RXWiw2eSSIuzc6idBVzMOC/idv9/uIfeZHQDBRYKqP70Z7KH+Yz63/1gvf2sZeH3KR
         WhR8FH8b6Kvu7l/F1/o2xnmesOpjbNK8u8D1+3sprsrVD6n6nzmet0ijSONfpZjXPUIZ
         DNa+LTuXdjjAgEGkfYM+dmhIp25jGwDMi1cb6qaq9s3XdJ36O3bypJE8UM++tLtP8MA+
         EcnaCFgZJ4mRG8pYxVZrQwU+CJX3VqXhOKioIpkgsvcfbKrtlsp1vpfRSwi+xCLvf8l1
         fJkPgFzk2LE1Dt8K01VUZaBQ3nrWjgCGZNHsfwIokXoIhUlkARiyv6PbUvtpdby9l/WF
         59fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLQ+MSxsBnw7XpWeeY2S6hYOnV9ftFLKK+K/LhDt1dU=;
        b=SiXWThq5IFvTAex2sxxJv/k8JCz95Gcec5m1cy6Xy+W+zKdP19VjnJjhA6kuZGx+0V
         9VfhQ/7I8aXCwOcecZtXnroFmRJ+BEyqoVXP6QKbXiaLv8O9oCn5XZUKWm9hOka9gQsF
         SKHtvL6wTTuE0oP7IhL33463F5jepD5rdJeemXqhLeY6UhhhLes8rzlAH34/FSNEarZH
         5Z0sPeRO8l3jaeDD/I9+O4JpPF8TZG+cCXyNLB+BwQ5PBz5e14dryBITBa+o/weKiVtX
         NwokCGLABkQSTYMUn8PFw3fcE597qs0Dx4Qi0IM6tnwZXKGD9yUMaw5DiklN+zzidV0K
         xlCA==
X-Gm-Message-State: ACrzQf3OWd3wnt9+u5ubKNrZC2W6Bzusc/1sCSJnPrz1HzLu4e3Uq4fh
        mc7C7raJDKdk2gfzLA9781rZhh9gK5e030eLjn4=
X-Google-Smtp-Source: AMsMyM7lndnfGy7HnQizAwkwrMMckj8N0io+DwmqCVfdk/ODiHzlqacKTKBDRZbnGcb+3Nyx/bxp4gzrPBgQDs4Q+tk=
X-Received: by 2002:a5d:604c:0:b0:236:6deb:6d31 with SMTP id
 j12-20020a5d604c000000b002366deb6d31mr29413383wrt.282.1667785856332; Sun, 06
 Nov 2022 17:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20221106161443.4104-1-wens@kernel.org> <CAMdYzYomgwo3RiUr4pptOD=AUgUS4f6Aqtio3agQP2F-bm2WZQ@mail.gmail.com>
 <CAGb2v64vKbgZxZUyVSdTfzuukHeUdK-8ymxUVGYg=GGShY6O-g@mail.gmail.com>
In-Reply-To: <CAGb2v64vKbgZxZUyVSdTfzuukHeUdK-8ymxUVGYg=GGShY6O-g@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 6 Nov 2022 20:50:43 -0500
Message-ID: <CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk356x: Add dma-names to UART
 device nodes
To:     wens@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 8:28 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Mon, Nov 7, 2022 at 8:52 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Sun, Nov 6, 2022 at 11:15 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > At least one implementation, Linux, requires "dma-names" properties
> > > be used together with "dmas" to describe DMA resources. These are
> > > currently missing, causing DMA to not be used for UARTs.
> > >
> > > Add "dma-names" to the UART device nodes.
> > >
> > > Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568 SoC")
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Enabling dma globally can cause some interesting issues, have you
> > tested this fully?
>
> It seems to work OK with the Bluetooth controller, though I'm not running
> extensive transfers over it. Scanning both traditional and LE works, and
> does exercise the DMA controller.
>
> If your worried about the DMA controller running out of channels and
> impacting other peripherals, the DMA controller for the UARTs is only
> shared with other UARTs, SPI, and PWM (which the kernel doesn't support
> DMAing to). The UART and SPI drivers can fall back to PIO if DMA isn't
> available.

Nah, enabling it for bluetooth is fine because you have flow control.
My issues have been on channels without flow control. Without DMA it
simply drops messages or the channel hangs until you close and reopen
it. With DMA, when an overflow locks up the channel it is usually
unavailable until the board is rebooted.

It's the main reason I've stopped daisy chaining boards to each other,
when the board powers off the pinmux pulls go crazy just long enough
to lock up the other end. It sometimes happens with reboots and large
data bursts as well.

I'd only enable them on bluetooth channels for the time being because of this.

>
> So this isn't like on the RK3399 and prior chips, where it was shared with
> audio, and exhausting the DMA channels would cause audio to not probe.
>
> Regards
> ChenYu
