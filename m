Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065CA6ADA39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCGJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCGJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:22:51 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327F53713
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:22:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536be69eadfso234112727b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYW/40WXc1mZFSpERayfTf6+aBHoaVcoZeiR5Zlwa5k=;
        b=OD1tiV5gfwq1q30wOH/HZwVUKillOPvqvmg+zHS4gzKsQo2PAhv32wRMkqMwr0riXU
         M12yyfFTeiR7ipa5Jy6dagZNn1RUquURdzmlh8SjnfOIIBQv7/NbJj9R3UrL03xeX+ur
         z0oiiQqZjR7hsWuPFIplhJuPlJvmHjc6c3x/URIVHraoVPFPQJHFlaIuPUdyL98T5lyr
         lL2LLvmD8lXOr1S9sqsq65QBP8OdzyRXmCjzrZnJKx1JjW53xnp52Qy/Q8QfggNDozQC
         fMQtpdQzu4gOp5JnSP3rqjWqqIZOLU5Wb0H6UvB5t4dS+/bxklQv0kzEmFgAXLvY1kVF
         U8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYW/40WXc1mZFSpERayfTf6+aBHoaVcoZeiR5Zlwa5k=;
        b=gEX5+H5f4ivU8pJIoXDmLr82njIZCS2VvUQFUF6zC0K+0WWYsShApvFN1yhzomEZsx
         6YSy7EM+QjMda6pKzEKf0kAkwR29SVxmQPlz3J0stMtRxYcxkXNVpLPn/eLywE8Rm+9v
         CHSwJrXeKKQuqGLrLxBQe/JQGENb5/ngh6XWFOugVag45R86SPpKaKhiALkXi7iNAhq9
         cwHNizBvdu/QxyvptLB2ycv1E49sWrCqZQa+CJNJ9lgiX1I3PbXBlNRQO+RoRAbewlaZ
         MzIJW3WmD7iz5ubxoU7SOZZWE4xOrZtwtmC/V1T1XmTqwkyl9xFcliUxUU/gFSV89jFA
         8Mog==
X-Gm-Message-State: AO0yUKXf5Y6kRjkaXaJoIicXi4hm5amM/k0wa6ZYA6hGR9BhCknZWAGb
        IlZQT/rbgifIScGvMue9AEFvM7vQAz+7nmNY4u8sIQ==
X-Google-Smtp-Source: AK7set8aVuKJvLzBh+CzD4AGBJpKjDwrv/rCWM61y1Bvum+SRltrS9eFgNVY29/1Yu+ZTWWFG05LKOPXxp39Q0Hdhlw=
X-Received: by 2002:a81:ac4b:0:b0:533:9ffb:cb12 with SMTP id
 z11-20020a81ac4b000000b005339ffbcb12mr9037322ywj.10.1678180956477; Tue, 07
 Mar 2023 01:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220023320.3499-1-clin@suse.com> <CACRpkdYknZo3Q7_CeSkOL2XwwAmKERskx24o-toaVy=rs0Yf5Q@mail.gmail.com>
 <ZAZ3JZQ4Tuz5vyH1@surfacebook>
In-Reply-To: <ZAZ3JZQ4Tuz5vyH1@surfacebook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 10:22:25 +0100
Message-ID: <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
To:     andy.shevchenko@gmail.com
Cc:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 12:28 AM <andy.shevchenko@gmail.com> wrote:
> Mon, Mar 06, 2023 at 02:28:56PM +0100, Linus Walleij kirjoitti:
> > On Mon, Feb 20, 2023 at 3:33 AM Chester Lin <clin@suse.com> wrote:
> >
> > > Here I want to introduce a new patch series, which aims to support IOMUX
> > > functions provided by SIUL2 [System Integration Unit Lite2] on S32 SoCs,
> > > such as S32G2. This series is originally from NXP's implementation on
> > > nxp-auto-linux repo[1] and it will be required by upstream kernel for
> > > supporting a variety of devices on S32 SoCs which need to config PINMUXs,
> > > such as PHYs and MAC controllers.
> > >
> > > Thanks,
> > > Chester
> > >
> > > Changes in v5:
> > > - dt-bindings: No change
> > > - driver:
> > >   - Refactor register r/w access based on REGMAP_MMIO and regmap APIs.
> > >   - Tag PM functions with '__maybe_unused'.
> > >   - Add mask check while parsing pin ID from a pinmux value.
> > >   - Simplify s32_pinconf_mscr_* functions.
> >
> > This looks really good any no more comments arrived, so patches are applied
> > for v6.4!
> >
> > Thanks for your work on this so far Chester! (I suppose there will be
> > maintenance
> > for this family going forward.)
>
> Can you unpull this?

If need be.

Are there serious issues with the patch set such that they cannot be fixed
by add-on patches?

Yours,
Linus Walleij
