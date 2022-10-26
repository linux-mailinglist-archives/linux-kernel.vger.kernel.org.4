Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18960E2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiJZOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiJZOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B22A3AAD;
        Wed, 26 Oct 2022 07:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF95761EC1;
        Wed, 26 Oct 2022 14:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B4DC43142;
        Wed, 26 Oct 2022 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666793493;
        bh=YMIF5UCWISG2ob0vvfFQtpNcUPd+lX4YhYyWt0PFYPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dCCnkTS6zQYXpli9FHZ3e7+Dogw8PaXYNgjsWYWZcuPL0kREvUpGKJtP4qBggBodN
         2AMODGNDYnn4B7/vXd8sq4gdpeRhscDJp4UaGXRNI6dLkAm0M1nQoSnemavqR6+4QG
         c73C/TQ3Hn86w+Boor+bUecKVVhFzNbQ/EgtI85Skrhrt5/7ee69/w98i9SqgdGl3e
         ZTYZ88KE3ZHmD8BwhFwr5fDAJnjNVr9haOpBqvrko0bS1YFjFiepe+nz31iSFkSA3+
         jgMnKrdWPQzTBG1pUCicthhiwteujQHpqXOIhjUGVfrfJKwr+nOKQKcF7MlZ/KFOuL
         7hfJ51haA9kKw==
Received: by mail-lj1-f169.google.com with SMTP id o4so17267156ljp.8;
        Wed, 26 Oct 2022 07:11:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf3pDNHafGb3fNm4dnGpXq6wki8FvI5gB5lOW6UBLTEphwHB4x0g
        7PzvvbvIDAvGVJNodLXBPCpcGbT5PF8UK9sD3g==
X-Google-Smtp-Source: AMsMyM6i/jjuNFCIcusJ8ZdpQuFHkRapKnNvN0juosoob6Nyxuo+jLAbTwN/yM4+V2v4zQPVryPgNoBO+QR4ZVRpbGk=
X-Received: by 2002:a05:651c:114a:b0:25d:5ae6:42a4 with SMTP id
 h10-20020a05651c114a00b0025d5ae642a4mr16242008ljo.255.1666793491191; Wed, 26
 Oct 2022 07:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221024173434.32518-1-afd@ti.com>
In-Reply-To: <20221024173434.32518-1-afd@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Oct 2022 09:11:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
Message-ID: <CAL_JsqJxgVwsjKnkCEkZeoSsDgaRD+DVPkHRBc2SrcSq69PBNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Rename DTB overlay source files
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:34 PM Andrew Davis <afd@ti.com> wrote:
>
> Hello all,
>
> This is a series based on my patch here[0]. As suggested by Rob
> I've resurrected Frank's patch and appended it to mine as a series.
>
> First patch here is my original patch, 3rd is Frank's patch but with
> the unittest changes pulled out into the 2nd patch. That was re-worked
> moving the source building macro into scripts/Makefile.lib.
>
> Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
> overlays. Split out by platform so they could be taken by platform
> maintainers or if easier ACK'd here and taken all together.
>
> This should cover all the DTB overlays so we can remove the old .dts
> rule for overlays and make .dtso the only supported way, let me know
> if we want that this cycle and I can post that too.
>
> Thanks,
> Andrew
>
> Changes from v1[1]:
>  - Added patch to rename pi433 overlay.
>  - Cleaned wording on patch 4-6.
>  - Collected some ACKs
>
> [0] https://www.spinics.net/lists/kernel/msg4548509.html
> [1] https://www.spinics.net/lists/arm-kernel/msg1020165.html
>
> Andrew Davis (6):
>   kbuild: Allow DTB overlays to built from .dtso named source files
>   kbuild: Allow DTB overlays to built into .dtso.S files
>   arm64: dts: freescale: Rename DTB overlay source files from .dts to
>     .dtso
>   arm64: dts: renesas: Rename DTB overlay source files from .dts to
>     .dtso
>   arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
>   staging: pi433: overlay: Rename overlay source file from .dts to .dtso
>
> Frank Rowand (1):
>   of: overlay: rename overlay source files from .dts to .dtso

I've applied patches 1-3 and 7. I'll send a PR for the branch to the
platform maintainers after a few days in linux-next.

Rob
