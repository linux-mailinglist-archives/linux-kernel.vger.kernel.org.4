Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C870B55D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjEVGvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjEVGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:50:38 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3753C1BC1;
        Sun, 21 May 2023 23:47:57 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-783e4666739so3605355241.0;
        Sun, 21 May 2023 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684738040; x=1687330040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGmi/jDl6N+ceVHPXb+IkYJ9LmU2GS/nBnndIEuJhr8=;
        b=R9pM/8HHhMXOiArHema5Co9HH3a3iYljfOA8ryhh0msg0rcjr3lhezG1PT07xQAule
         7atZA1/J8ZBPjhzI0CxOYOjssMBycVSRpthDPdouYRH84Pv1k/bWcvLqX//1jvyUxy05
         J813brbKmPyB8k1Ib8AxSMeeaNnP+bKrwpoVBEJksqyPuw0R3pXTmacuLmvt+IIVt4ao
         9AFmBC3nfRVdOfsPazIbyfuUgR7m+A0mHJztAkxpykWisT8f+GzWx7YJqfXYb4udnL1U
         UbfQIsVBWuS+k4rkLc4mR56Nw4SngKv+Nv2Mdh1hA4xFV7+CKrQFzIKGiiLbJK0fqTpj
         jtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738040; x=1687330040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGmi/jDl6N+ceVHPXb+IkYJ9LmU2GS/nBnndIEuJhr8=;
        b=ceLN7ao/vT+AiSCTBvHLpyd++IB3zCpHANjPLDoJ9K5FW7W6G4ABUgEeLZNYG8nRy1
         ZbrhdbXi1uuxOaePee/MW+PDterLfzkaOpj/hovlz5eP+Z/SAqImm1PnO1YfS+II7Gkz
         bVKhUe7XNeiXYlszLSVMVrkYTsIh4Ks9lsLXpMw6v5w5QT29XBkGZ0v/K4yXTtQe8vg1
         jFwlMDnlm9Fzd5mjhtLuRxM44eFuh6MDebGHtV/ZSBvgENu7c5BKt5yNWSMDav8qOZtM
         s4jlG4EjdIYvRerQGV9o9tgsx6uaQZ+aqekZEgsndTv7qAdoYeZSHS163z6F2NbNhQDk
         9d5A==
X-Gm-Message-State: AC+VfDw/DP9DXxqFquazau8PczxDLO5N5mq3mhzUG13UFu+bLTm5Z3fx
        rh/3lUnGIfNnThAsw3Q91pQPj8pcDYly9Z3jeeuxUnZH
X-Google-Smtp-Source: ACHHUZ47bOxq1yEC62nOtfWx784t+ss0xhsM5J8PcrJlP1n2xCKdS6mlaq2iy0++UQy2/ofFXDcxwzkomdOUcDlGdZM=
X-Received: by 2002:a67:fe4b:0:b0:437:dfec:c654 with SMTP id
 m11-20020a67fe4b000000b00437dfecc654mr2517435vsr.12.1684738039943; Sun, 21
 May 2023 23:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com> <20230517-undertone-revolver-26b42b888b12@spud>
In-Reply-To: <20230517-undertone-revolver-26b42b888b12@spud>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 22 May 2023 08:47:08 +0200
Message-ID: <CABgxDoJa_yPmAGt6myOWNjQ6eXQ9YgL1H2HjTjza3oD7j4H=RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
To:     Conor Dooley <conor@kernel.org>
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

Le mer. 17 mai 2023 =C3=A0 19:44, Conor Dooley <conor@kernel.org> a =C3=A9c=
rit :
>
> Hey Romain,
>
> On Wed, May 17, 2023 at 04:41:43PM +0200, Romain Perier wrote:
> > This adds the documentation for the devicetree bindings of the Mstar
> > SSD20xD RTC driver.
>
> Bindings describe hardware, not the driver ;)

Hi,

Yep, I just copied and pasted the message of a previous merged-commit,
I will fix it.

>
> >
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
> Is this x a wildcard?
> In general, having a specific compatible is preferred, and if there are
> other models that are compatible we can list several "fall back" to the
> most specific one implemented in a driver.


The first SoC being concerned is SSD202D, so  "mstar,ssd202d-rtc" ?

Thanks,
Romain
