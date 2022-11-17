Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7162D78E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiKQJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiKQJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:56:31 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887E5A6F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:29 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-382f0906929so13593937b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLbkiW0vPorHmmgJbgBch+xEZ9yiRf67KgHepriqBCw=;
        b=4ZVBA3QqrKfG0WAiIIuAs+A6YdnSicW5uUr4Ll2i+nDySUDJVO1Vb9q1y4ZMsy5RSj
         DwtvQFGcAw1L6gyAmxlrMD5ksdViJsaDT87Cl1TJcd/qi76GAmhLW4W+H68StuuWFLN2
         sCbVpxzgd3mlg12PjA3fzLcyt2ci42NoWl6UAHOEwJWm30Ku4WKmCmeJadGy/siYhucy
         1AUlvRrtI0LnPOBUOFLdUkl6yk8FTyt1yXA6/c6wZE2QUM6aSECkuKIdLCTnlY5ftgoH
         CK0TEy34pkGVg1y995sggpdXsPqfWgGEJ13mJZJh3/UHd3eODM9CqKaHuIWhXfA4ef7F
         hxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLbkiW0vPorHmmgJbgBch+xEZ9yiRf67KgHepriqBCw=;
        b=yYakVrc//ehAbEclDhHQWYf9GHmHH17BamRHsNA5VfQK9+I0t1jaz0fCDqs2rC9ikJ
         zyygdwaS0BeTMXvjFnjYwAAecMibpcGGbDds988GTq+y0cMFPLUimLEPhUDwjPLZJEfj
         SwVQUtRg+ZQnha/vXUDXDx8oMpGOwCwJTYy0Z5pG5oev7tB5xBuP2wFZct3uJb0iD90q
         j1+iAV9sH2PdWvO8NW5XbbGIhyen5horJWgx33c3bPMEd9T4FQNJxUg4k5ISB4ALQROT
         z6po9r68fZR0CMZ4p5sMZneY3hjBlm4LBngXER2zOB3dTiZWbvpGiTo5xrmRemOPTsOJ
         J1MA==
X-Gm-Message-State: ANoB5pn/jlAVkKfHEN0SsIMyu84VVXg4yXhYqJGrdii5saYXpMwkEoRW
        bX7H8EoCp+dDV9YtY46KMnyDe7IWpqj90GhafPiJMw==
X-Google-Smtp-Source: AA0mqf5QYysC8WpIfevPj1rNmTkMVIyaXDEMKqTQcu10KCrq2T7jBoBBu1qGnUErMMRC2LJgf9CUTeVWUQMQuQNhi98=
X-Received: by 2002:a0d:df81:0:b0:369:b8d8:5b6b with SMTP id
 i123-20020a0ddf81000000b00369b8d85b6bmr1334819ywe.44.1668678928865; Thu, 17
 Nov 2022 01:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20221116145103.26744-1-nfrayer@baylibre.com> <20221117072812.ctrw54q2qqruxlts@dollhouse>
In-Reply-To: <20221117072812.ctrw54q2qqruxlts@dollhouse>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Thu, 17 Nov 2022 10:55:18 +0100
Message-ID: <CANyCTtQEm7DmeWELehn+6YmQnnBxWTyDydD6CLvrx62UcMzAzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] soc: ti: Add module build support to the k3
 socinfo driver
To:     Nishanth Menon <nm@ti.com>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 17 nov. 2022 =C3=A0 08:28, Nishanth Menon <nm@ti.com> a =C3=A9crit =
:
>
> On 15:51-20221116, Nicolas Frayer wrote:
> > In order for the TI K3 SoC info driver to be built as a module, the
> > following changes have been made:
> > - Converted memory allocations to devm and added the remove callback
> > - Added necessary code to build the driver as a module
> >
> > v2->v3:
> > dropped module conversion part of this series while other driver
> > dependencies on socinfo are worked out.
> > A dependency issue is introduced by changing subsys_initcall()
> > to module_platform_driver(). Some drivers using the socinfo information
> > probe before the socinfo driver itself and it makes their probe fail.
> >
> > v3->v4:
> > reintegrated the module build support and added patches for udma and md=
io
> > drivers to allow for deferred probe if socinfo hasn't probed yet.
> >
> > v4->v5:
> > Remove the k3 udma and mdio patches from this series and sent them
> > individually
> >
> > Nicolas Frayer (2):
> >   soc: ti: Convert allocations to devm
> >   soc: ti: Add module build support
> >
> >  arch/arm64/Kconfig.platforms |  1 -
> >  drivers/soc/ti/Kconfig       |  3 ++-
> >  drivers/soc/ti/k3-socinfo.c  | 47 +++++++++++++++++++++++-------------
> >  3 files changed, 32 insertions(+), 19 deletions(-)
>
> Sorry about another respin, but could you fix up $subject as per
> git log --oneline drivers/soc/ti/k3-socinfo.c
>
> I think you might want to use "soc: ti: k3-socinfo:"
> >
>
I'll send a v6 with the modified subject.

Thanks.
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
