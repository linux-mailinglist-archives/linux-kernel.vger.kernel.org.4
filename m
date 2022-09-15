Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096ED5B9B48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIOMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIOMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8593211;
        Thu, 15 Sep 2022 05:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77741623AF;
        Thu, 15 Sep 2022 12:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF092C43141;
        Thu, 15 Sep 2022 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663246105;
        bh=vYPH7fx1ureHC33v6mpOR/ZwVsXqh5v8XdoMYLJYITA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bmtTYnl887if/Y0PWs0Xbs/vZfSB5mW18ArMYw7ewAyImXhFphVNnQFBg1XBV2gvL
         PGHrgrm1goParP2chNY18YPBXEfZ/qkFhXfEZvdcN9xfBkF9qTCGNced5Te6DUgCpm
         JjExm0wKOJNu3tSJsyyCKFp7kLW2nMo3mDAxxBTrIHmrPCicWpYsgg3sV+Yq2OnWuR
         oAn+pGRXBZo9Z4kh6wEWM+D+3N0z18h9XzthMruxg3rzEk272624f7UfBKtSOEQ/Bd
         eYSt8u96/MoWI3i6y+JdEhPEJT2LQwfz6Vup8KKWg+S7FDtKmTfEVgZNlYwO2pmIHT
         6omV+kTcrri9g==
Received: by mail-vs1-f41.google.com with SMTP id q26so13678535vsr.7;
        Thu, 15 Sep 2022 05:48:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo3nKSComtmY9k5wQNFMqmLhUxzB/Av4YVbhBLWjQmpCo2iMQRto
        c28dYhZZ3ARxz9k0s20n4Vlh3cdzRS97VPu1Eg==
X-Google-Smtp-Source: AA6agR6cWMD0DU2Xd5g/oUc1mkJQuwd2KsOUyJJshpK/eKp9yVKE22ZbQHQDM85SEx87Sd6nqnD3BhvwMhkBxmAkNQY=
X-Received: by 2002:a67:c18a:0:b0:398:4c72:cafb with SMTP id
 h10-20020a67c18a000000b003984c72cafbmr10648043vsj.53.1663246104815; Thu, 15
 Sep 2022 05:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220909135103.98179-1-j@jannau.net> <20220909135103.98179-7-j@jannau.net>
 <20220913133207.GA3500192-robh@kernel.org> <20220914110448.GF4024@jannau.net>
In-Reply-To: <20220914110448.GF4024@jannau.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Sep 2022 07:48:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxU4W1yTRWuxbVAtQJPx_4+jqF7p29R9TW5MNsrLoTCQ@mail.gmail.com>
Message-ID: <CAL_JsqKxU4W1yTRWuxbVAtQJPx_4+jqF7p29R9TW5MNsrLoTCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] arm64: dts: apple: Add initial
 t6000/t6001/t6002 DTs
To:     Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 6:04 AM Janne Grunau <j@jannau.net> wrote:
>
> On 2022-09-13 08:32:07 -0500, Rob Herring wrote:
> > On Fri, Sep 09, 2022 at 03:50:59PM +0200, Janne Grunau wrote:
> > > From: Hector Martin <marcan@marcan.st>
> > >
> > > These SoCs are found in Apple devices with M1 Pro (t6000), M1 Max
> > > (t6001) and M1 Ultra (t6002).
> > >
> > > t6000 is a cut-down version of t6001, so the former just includes the
> > > latter and disables the missing bits (This is currently just one PMGR
> > > node and all of its domains.
> > >
> > > t6002 is two connected t6001 dies. The implementation seems to use
> > > t6001 with blocks disabled (mostly on the second die). MMIO addresses on
> > > the second die have a constant offset. The interrupt controller is
> > > multi-die aware. This setup can be represented in the device tree with
> > > two top level "soc" nodes. The MMIO offset is applied via "ranges" and
> > > devices are included with preproceesor macros to make the node labels
> > > unique and to specify the die number for the interrupt definition.
> > >
> > > Device nodes are distributed over dtsi files based on whether they are
> > > present on both dies or just on the first die. The only execption is the
> > > NVMe controller which resides on the second die. Its nodes are in a
> > > separate file.
> > >
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > Co-developed-by: Janne Grunau <j@jannau.net>
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > >
> > > ---
> > >
> > >
> > > ---
> > >  arch/arm64/boot/dts/apple/multi-die-cpp.h     |   23 +
> > >  arch/arm64/boot/dts/apple/t6000.dtsi          |   18 +
> > >  arch/arm64/boot/dts/apple/t6001.dtsi          |   63 +
> > >  arch/arm64/boot/dts/apple/t6002.dtsi          |  173 ++
> > >  arch/arm64/boot/dts/apple/t600x-common.dtsi   |  128 ++
> > >  arch/arm64/boot/dts/apple/t600x-die0.dtsi     |  298 +++
> > >  arch/arm64/boot/dts/apple/t600x-dieX.dtsi     |  103 +
> > >  .../arm64/boot/dts/apple/t600x-gpio-pins.dtsi |   45 +
> > >  arch/arm64/boot/dts/apple/t600x-nvme.dtsi     |   42 +
> > >  arch/arm64/boot/dts/apple/t600x-pmgr.dtsi     | 2012 +++++++++++++++++
> > >  10 files changed, 2905 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
> > >  create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> > >
> > > diff --git a/arch/arm64/boot/dts/apple/multi-die-cpp.h b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> > > new file mode 100644
> > > index 000000000000..153d89dd0ae1
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> > > @@ -0,0 +1,23 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ OR MIT
> > > + *
> > > + * C preprocessor macros for t600x multi die support.
> > > + */
> > > +
> > > +#ifndef __DTS_APPLE_MULTI_DIE_CPP_H
> > > +#define __DTS_APPLE_MULTI_DIE_CPP_H
> > > +
> > > +#ifndef __stringify
> > > +/* copied from include/linux/stringify.h */
> >
> > Which is dual licensed? Arguably, not big enough to matter.
>
> include/linux/stringify.h has no license header at all. If that's
> acceptable I will drop it from this file as well.
> I started from scratch with the SPDX header from other apple dts files.
> I should have paid more attention after replacing it with kernel
> __stringify (I probably would have updated it if stringify.h had a SPDX
> header).

I'd leave the license and just drop the comment. The construct is not
copyrightable IMO.

> > > +#define __stringify_1(x...)     #x
> > > +#define __stringify(x...)       __stringify_1(x)
> > > +#endif
> > > +
> > > +#ifndef __concat
> > > +#define __concat_1(x, y...)     x ## y
> > > +#define __concat(x, y...)       __concat_1(x, y)
> > > +#endif
> > > +
> > > +#define DIE_NODE(a) __concat(a, DIE)
> > > +#define DIE_LABEL(a) __stringify(__concat(a, DIE))
> >
> > Not a pattern we encourage in DT, but seems necessary here.
>
> That is probably an arguments for keeping __concat/__stringify local
> instead of adding it to include/dt-bindings

Yes.

> > > +
> > > +#endif /* !__LINUX_STRINGIFY_H */

Stale comment.

Rob
