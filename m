Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FB70BBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjEVL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEVL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:28:10 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA110E2;
        Mon, 22 May 2023 04:27:33 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4394a8f26d5so201710137.0;
        Mon, 22 May 2023 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684754853; x=1687346853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzQoV7Wn/u+jSz7wS4+l8UNnhbuTTevU/GeKVF6hC4w=;
        b=h7hUkfRkIT8d1TL8VKcpL2xEoZtrzD3E7/5higkXyOtTPMqXCNN4fsw12MpHn3+pII
         wTvcGOW3TgzJPTWgFxDbosDQO803p7POb0VHGQF3B9WpPHB2rE/Ym6OQsURR/z71Gg2v
         kRdxwTC7rVH7kAsrh733d+GD8a8uRYIx6QgWiOJYbmKKVOSj7+KzuT6sl0AYuXtke6iz
         0BcpImAQiUWzsCG24/zRQy+7d+OiJcfSo5flb7mlllOBKZOoJaYOtG9kwDc7mHOaLqs3
         cWvr2GK3zuTqKRRz3O58kKzBQsQIUBF2nLIm5uXnilHkmdYRq0avSBiSziyHxp5cyik3
         kF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754853; x=1687346853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzQoV7Wn/u+jSz7wS4+l8UNnhbuTTevU/GeKVF6hC4w=;
        b=AynkQq0OEG8TnvC8RHGNUIxFts3hYrehvWUt0tLDll0pl2eAG80YQaIB5e8qt33Ss8
         tFbxXqmdYCfueSAVNDiY3hXQyIDhHD6/j9itXcn1QEvQstRxtroGC9I7YlfC4alDRs+z
         R9f7Hc/Zf3NeVHwEIYzHN2ooGsofdfhIyEHnuBg09pHH2mISuSqMUS0dMh1eVmANeQTy
         xB5yzO6d78DKoGs8ts4AfLuNdkt4BtHKqUzgYBdWnxrFJouRCBtT/A+2cfBdViWKJoIs
         VLANtrJ1aCwE5P528kr4w52+A0O0Ab+jYOW/intMuhVvWrdKlVVu8lgAv7QaYjXvtYXh
         fAow==
X-Gm-Message-State: AC+VfDykE+O5P7gb3xOZxOQJ7VaSjnlNYjvHQzZ66Fp2PzIDiuPCDF8p
        IlmSluigBdd8tH2zp3xhalLpiqUvd4pqVTXhMDY0/lFG
X-Google-Smtp-Source: ACHHUZ4TPDqwfF/yCxuDCTXZZCpG6InrjMEmVffSb/3qOxXl5IC+8Z7O85xhEWQCLGY5ogtoZVqfOgacvB6qu5SgiTA=
X-Received: by 2002:a05:6102:3c1:b0:430:3aec:efb8 with SMTP id
 n1-20020a05610203c100b004303aecefb8mr2093110vsq.28.1684754852768; Mon, 22 May
 2023 04:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com> <669d7b79-71a6-e1f9-8d7a-71c4b64de28d@kernel.org>
In-Reply-To: <669d7b79-71a6-e1f9-8d7a-71c4b64de28d@kernel.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 22 May 2023 13:27:21 +0200
Message-ID: <CABgxDoKaVip=T5=s2Gd8qpX15cLD=_0TZtQoNodK1CCf+GTYZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 18 mai 2023 =C3=A0 10:24, Krzysztof Kozlowski <krzk@kernel.org> a =
=C3=A9crit :
>
> On 17/05/2023 16:41, Romain Perier wrote:
> > This adds the documentation for the devicetree bindings of the Mstar
> > SSD20xD RTC driver.
> >
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

Hi,

This is usually what I do for all patches series, but possible I have
missed some person

>
> A nit, subject: drop second/last, redundant "devicetree bindings
> documentation". The "dt-bindings" prefix is already stating that these
> are bindings. You actually repeated everything...

Originally, it was just to write a simple sentence with words... it
gives context, you know...

Like here:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git/commit/?id=3D7647204c2e81b28b4a7c4eec7d539f998d48eaf0
or here:  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/commit/?id=3Ddd49cbedde8a0f1e0d09698f9cad791d37a8e03e

But honestly, I don't want to debate about this, yes I can remove
redundant "devicetree bindings documentation" ^^


>
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  .../bindings/rtc/mstar,ssd20xd-rtc.yaml       | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd20xd=
-rtc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.ya=
ml b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> > new file mode 100644
> > index 000000000000..2acd86cce69f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/mstar,ssd20xd-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mstar SSD20xD RTC
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
>
> This goes just above properties:
>

ack

> > +
> > +maintainers:
> > +  - Daniel Palmer <daniel@0x0f.com>
> > +  - Romain Perier <romain.perier@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mstar,ssd20xd-rtc
>
> Why rtc suffix? Can it be anything else?

Well, it is the dt-bindings for an RTC block ? suppose tomorrow we
have an ethernet block specific to the SoC SSD202D, it should be
"mstar,ssd202d-ethernet" , how do you make
the difference if you just put "mstar,sd202d" ? Plus a lot of rtc
dt-bindings have this suffix (when it is not an IP name). This is
exactly the case for rtc-msc313e and it was not an issue.

>
> Missing blank line

ack

>
> > +  reg:
> > +    maxItems: 1
> > +
> > +  start-year: true
>
> Drop
>
> What about interrupt line?

There is currently no interrupt right now, we have not yet the irqchip
code for handling the alarm irq of this rtc block.


>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> instead
> unevaluatedProperties: false

ack

Thanks,
Romain
