Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA39672E89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjASB5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjASB4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:56:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348636D363;
        Wed, 18 Jan 2023 17:54:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so1974065ejc.4;
        Wed, 18 Jan 2023 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LSz9bvo3BZ3yzR2LZdddWGu50g7D481ggXK11d8M0=;
        b=k0PPWVKhCWmYp+/4o8oguC5R37MopUd//IyT1BMNYlmFuqOfC+PXEqR4ju6ET6EHPj
         UMETuVxZJ7cjl47cvVjMIcJzgFi7PdATI6UypFahVC/NzuqT8pMg4hwu2Y+jNHdr51f7
         rYTf0pCFhgx8Eids2p5agC7kJgzMXgEFPTZb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5LSz9bvo3BZ3yzR2LZdddWGu50g7D481ggXK11d8M0=;
        b=PjQgsXmWXWhkCBvL06eEe0xvoycs5lA3ziPbS8Ijm44sgInL9CiIUPfDlbzj8CXqvK
         2OXKTi/INFzH7iLlvAOzCtFZThRWGHjM98No+UOHFgQEGHymw+8NqlmAvVh5Nd0BieX0
         j6ZU7S9E1NAzbWjHciFisOnVURnwd0w7HAx25/A4dFNtgHLmxWczUl3k2O5XfO6QYYc4
         dmeaJmy1t/o23tioy0DwRohzIRxx3J7HOOdO+ukpcisodXf8oSAeZhAXoomjcGEIzGrd
         MkHVeHmG7MCeCv82qkuELajff6CZFUe94wpmQ9yQ5sVWERHC13fG1Y0sSyPqeQfcw46H
         pemg==
X-Gm-Message-State: AFqh2krVBs3q2lCqTW1dFYPQAPnpjEDBDQWal9IpE0Ab0mty5bNeXYjV
        8tfbLy8K81EwJlVEi3EW7dpm5KQD6Hm4ZeYsYCJxhvXI8R9ORA==
X-Google-Smtp-Source: AMrXdXu+ox64PdWPYUzYVyZ0V9eEMhNYJBdrtYqnVqBurU84ellrmAEXv1jl+qoNNn06JcsWkIRO245bljA8fWYGORE=
X-Received: by 2002:a17:906:3b85:b0:7c1:4665:9684 with SMTP id
 u5-20020a1709063b8500b007c146659684mr1204502ejf.23.1674093274564; Wed, 18 Jan
 2023 17:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com> <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
In-Reply-To: <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Jan 2023 01:54:22 +0000
Message-ID: <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 22:48, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
> > On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> >> When the driver want to disable the signal of the function, it doesn't
> >> need to query the state of the mux function's signal on a pin. The
> >> condition below will miss the disable of the signal:

> > I can't see the verdict for this patch? Will there be a new
> > version, or are we in the middle of a discussion?
> > I'd really like Andrew's ACK on the result before merging.
>
> Apologies, it's been a bit of A Week :)
>
> Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.

As foreseen by Andrew, this caused a regression. On the Romulus
machine the device tree contains a gpio hog for GPIO S7. With the
patch applied:

[    0.384796] aspeed-g5-pinctrl 1e6e2080.pinctrl: request pin 151
(AA20) for 1e780000.gpio:943
[    0.385009] Muxing pin 151 for GPIO
[    0.385081] Disabling signal VPOB9 for VPO
[    0.402291] aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to acquire
regmap for IP block 1
[    0.402521] aspeed-g5-pinctrl 1e6e2080.pinctrl: request() failed for pin 151

The code path is aspeed-gpio -> pinmux-g5 -> regmap -> clk, and the
of_clock code returns an error as it doesn't have a valid struct
clk_hw pointer. The regmap call happens because pinmux wants to check
the GFX node (IP block 1) to query bits there.

For reference, reverting the patch gives us this trace:

[    0.393160] Muxing pin 151 for GPIO
[    0.393267] Disabling signal VPOB9 for VPO
[    0.393383] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.393552] Disabling signal VPOB9 for VPOOFF1
[    0.393681] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.393835] Disabling signal VPOB9 for VPOOFF2
[    0.393965] Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
[    0.394097] Enabling signal GPIOS7 for GPIOS7
[    0.394217] Muxed pin 151 as GPIOS7
[    0.394411] gpio-943 (seq_cont): hogged as output/low

This can be reproduced in qemu without userspace:

qemu-system-arm -M romulus-bmc -nographic -kernel arch/arm/boot/zImage
-dtb arch/arm/boot/dts/aspeed-bmc-opp-romulus.dtb -no-reboot

Billy, do you have any suggestions?

Cheers,

Joel
