Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551526C4858
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCVK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCVK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:56:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78018A85;
        Wed, 22 Mar 2023 03:56:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i5so24138938eda.0;
        Wed, 22 Mar 2023 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679482578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eribAeLlAZpM0sozfmroYZLd0JWUDJYfvoB2UDqzTlc=;
        b=bDsGkBzybZ7XSWupknT9Ksnp8uRqhwlyXWzafjT0YGpQhD1CLATrzpugsITAAyk5GO
         ROv0j73u+KWJofgT8KuUHvCeaob/Qmh26wKRHdBMgkuTtAMKtI84g+dqSqxiGu852Aw7
         nhkaFQLhy3nylmWLPy2nkQ0ygs52Kuy5RQAValIP0GkeICWmxYljxy/S2SwO7C4kZ7jF
         Vy4UvmS6AwpuitEa366FIXROYEzOe9+j22xsVfEq0mBTTct/h38E3LRshEPf7IUpgJ0q
         141/IPr6haUvfTGIWqCYeu5pFX7oEPujtBaYTXXXqOd1zDZe/JehlEd7eBG245c6xGba
         MbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eribAeLlAZpM0sozfmroYZLd0JWUDJYfvoB2UDqzTlc=;
        b=bNgfIzdW3U1o8wU5BAWZFGPJKCXY/vJGAjdrfwCMjGR0EmFeFFF5bENCSL7yEX7A6k
         XIMOlFt5gMhkOyfX2/CkbFTJZXdd0DhyTDptwJh+Kgp8Axi2h5u8aKNe434vaEsGLSRQ
         1+MNYkwo375BhU8L5pF77MRDAmRw+o/ahOXiLD0URYTeR9ZzXprz5dKMgPe6nEYj5byu
         ZQqBmCvV+Uk6L32ymSTmQ9bgLMe6B70j5k/aQBUxLngv+Akrf5nEoJpXSfNrhZvYV8dA
         a6kv6JKk9DBncySEnof3HjbjiTuLvn4TlhiPn7qPi2kvUgrub7IrklWmyax4MQ8spXNL
         flmw==
X-Gm-Message-State: AO0yUKXDFu53gaXjy7EhaghxEZvoLhWqyruS2CuPubQ1T5P/vJdC8rap
        4hOuJn2YX0MhkkTHzgkwTknsRPluAGUfyrt9RSk=
X-Google-Smtp-Source: AK7set8bTdcte9x03OjkSvsMixpWbUh5BMuJ76sBNCDUZEGwGaxof5QMGQfH8r7GG6JyIUFucpR+j1QZN+WW3boVZz4=
X-Received: by 2002:a17:907:2c46:b0:92f:cf96:e1f6 with SMTP id
 hf6-20020a1709072c4600b0092fcf96e1f6mr3049751ejc.11.1679482577793; Wed, 22
 Mar 2023 03:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073502.5421-1-clamor95@gmail.com> <167933710348.198283.16107220354236772396.b4-ty@kernel.org>
In-Reply-To: <167933710348.198283.16107220354236772396.b4-ty@kernel.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Mar 2023 12:56:06 +0200
Message-ID: <CAPVz0n2AuCb7fmLkzdimiZvqneQw7gXCfMTRvhp1n1zwRckfaA@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 0/8] Fix sound on ASUS Transformers
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 20 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 20:31 Mark=
 Brown <broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 08 Mar 2023 09:34:54 +0200, Svyatoslav Ryhel wrote:
> > - add quirk for headset detection used by some T30 devices
> >   (ASUS Transformers, LG Optimus 4X HD and Vu);
> > - add RT5631 and MAX9808x machine drivers
> > - update bindings
> >
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>
> Thanks!
>
> [1/8] dt-bindings: sound: nvidia,tegra-audio-common: add coupled-mic-hp-d=
etect property
>       commit: 2a7a8ebe85e1fa7e929f6f986a61f10321093c43
> [2/8] ASoC: tegra: Support coupled mic-hp detection
>       commit: eb0b8481c2e03a5ae01f6bea60b42109bd12b6fe
> [4/8] dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC
>       commit: 2060c9b8ae2a1f6abec483709f4209b6e3602b89
> [5/8] ASoC: tegra: Support RT5631 by machine driver
>       commit: 44b2fc2edb61e956885b4305bddaaec7f05d93d2
> [7/8] dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
>       commit: 85a375fe8df906b2701346e03e71501e6861a75a
> [8/8] ASoC: tegra: Support MAX9808x by machine driver
>       commit: d007a87bd7d181854b53b3e7fcbcf66c4bef86b2
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
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>

Thank you, Mark Brown! You have asked me to update commit name for
codec machine dts schema commits (those, which contain CODEC in the
subject), should I still update and resend them or you will handle those?

I still need v3 to update existing device bindings to the currently working
scheme. Should I exclude commits you have picked?

I have DMIC fix for wm8903 codec driver required for tf101 and tf300t,
should I add it into v3 or I have to send it separately?

Thanks in advance,
Svyatoslav R.

> Thanks,
> Mark
>
