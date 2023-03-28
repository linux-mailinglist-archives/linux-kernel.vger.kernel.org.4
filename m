Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3E6CB66E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC1F70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1F7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:59:24 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [IPv6:2001:41d0:1004:224b::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B561BF9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:59:22 -0700 (PDT)
Date:   Tue, 28 Mar 2023 07:59:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679983160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzZHCypCrHihtxhtaOoFXTCVEh91xd2+CUX2GOi1++0=;
        b=MOROOZPW8anQRQe6dJL28yQLXRTbsMu4nRBqsDgdw0XZlQ7Ux/s1xmjIHzfB/CcwEGM/+Y
        LirFAZn/tCHtxb+UDPn/xz0nkeqpw35pbWXCX8v0OHPheqczMmpNqfK7zMFVsrFXwkf8PU
        hco1BpLAKT0cZmCxyR559eGK0k8z6j8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 0/3] Add "mclk" support for maxim,max9867
Message-ID: <20230328055916.GA11037@g0hl1n.net>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
 <167810953075.75807.14829875612499629879.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167810953075.75807.14829875612499629879.b4-ty@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Hi Krzysztof,

sorry for coming back to you on this series, but I have a question on
the "workflow"...

On Mon, Mar 06, 2023 at 01:32:10PM +0000, Mark Brown wrote:
> On Fri, 03 Mar 2023 11:04:00 +0100, richard.leitner@linux.dev wrote:
> > This series adds support for the clocks properties in the
> > maxim,max9867 bindings. Furthermore the binding definitions are
> > converted from txt to yaml.
> > 
> > The clock property is needed to define the mclk for one of our
> > boards which uses the the i.MX8MP SAI MCLK as clock for the
> > maxim,max9867.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/3] ASoC: dt-bindings: maxim,max9867: convert txt bindings to yaml
>       commit: 6668f70abeea30f4674b2fdbc4232d5c3611b272
> [2/3] ASoC: dt-bindings: maxim,max9867: add clocks property
>       commit: d63e55b3e8ec90da69107f32038f3059d7317cc5
> [3/3] ASoC: maxim,max9867: add "mclk" support
>       commit: 448b06ba107d925d59d02781acdd2e4ad12dda0b
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.

As Krzysztof requested some changes on the clocks property dt-bindings
patch (#2) commit message... How should I handle this?

The changes requested on the patch content (dts example) should be sent
as incremental patch to the original series, I guess?

see https://lore.kernel.org/lkml/45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org/

> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

Thanks & regards;rl
