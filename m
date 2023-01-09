Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C769A662FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjAITGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjAITGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:06:50 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C651DF33
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:06:49 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so804413vsk.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t8exJoBvTt1P5Ibi4ffT0OZZL8/6VG/7d+FIG5bJyws=;
        b=hCg80Z6dcWf/j5KoT6Kc5O4vq3+Fd5vxmJkTuUVCBWaTzWgewPzOptLZEwuws6vZDt
         zdshtoO1TqppUITvdDyMmT1plqoW8W/YuEw7NmfDoHQG3zFwBRRfFs7YK9eFH/c0IclD
         v9MrS6NIm/enDInGpNANWJB69fPeNcK7AzL6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8exJoBvTt1P5Ibi4ffT0OZZL8/6VG/7d+FIG5bJyws=;
        b=p4Hse180EdsmgT4gS1S5Xw/P6XA2NFfd4ZC3Vp5Yv7q8MXPV55r6vS7IT5ugvX9VNX
         GRYBd2LwvyHu0uXF+qnpWfpykfjqpVoFHuPYqdF2RDfw+41TtIHtnWnEB6/t9LLB3G0e
         +kNSL7C7rvtdy7C+B+APBg+cP8SDk0MePsgTcMDWVTk+Y8dpwUqPB/j7k0rbznJu/Wd7
         BXKdzv02/XzcZd/Pokx1l0D+9XZoBHV0tPniCj8ASIJDBoN8gT7H/QPfgj9ZlX3H5oDz
         E6lafStNupPXA9TU7QcdlVcCo9SzwpZwl79TWdtOKX9ZRpw28U2TwfYbzG3wFgQT+gDq
         GgYQ==
X-Gm-Message-State: AFqh2kou/DSYC/W3ZtiRPCxTMgG0PdoB7geQ3EbVx4rQHhLZwZSsaHr+
        RA3I4errMJQ6M4KxKAtlL8QgJQk4KpvoIPNUI8xtOg==
X-Google-Smtp-Source: AMrXdXt+GyECPwXEpKoOsk3GjRvID0FnUWGBJaqFdPPdhTixqf7vsBWhIGl/8QLFBEXaU3i68it2oTjiaB/J2mZ8x+Q=
X-Received: by 2002:a05:6102:1179:b0:3bb:425f:75ea with SMTP id
 k25-20020a056102117900b003bb425f75eamr10333107vsg.80.1673291208860; Mon, 09
 Jan 2023 11:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y7WkeCi7/x/t37JM@google.com> <Y7YjmtwByTR+8tbZ@google.com>
 <Y7bdmiZ9lqKZXCfq@google.com> <Y7buUdgLfnQqnG+x@google.com>
 <Y7b6dC6dDNO2bVjr@google.com> <Y7cSKFIakdGKKokE@google.com>
In-Reply-To: <Y7cSKFIakdGKKokE@google.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Mon, 9 Jan 2023 12:06:38 -0700
Message-ID: <CANg-bXDrSJCGk27YKheupm9YND1fSaBaYfQ1Bd-4C-PnH67ioQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] dt-bindings: mfd: Add compatible string for UART support
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 9:08 AM Lee Jones <lee@kernel.org> wrote:
> I changed the subject line and applied the patch, thanks.

Hey Lee, a couple comments/questions:
1. The subject line of this patch was updated in v11 of the series.
2. What tree was the patch applied to? I don't see the changes in linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

On Thu, Jan 5, 2023 at 11:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Thu, Jan 05, 2023 at 04:27:32PM +0000, Lee Jones wrote:
> > > > You should gain permission from the maintainer before you apply patches.
> > > >
> > > >   % scripts/get_maintainer.pl -f Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > >      Lee Jones <lee@kernel.org> (supporter:MULTIFUNCTION DEVICES (MFD))
> > > >      Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> > > >      Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> > > >      Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
> > >
> > > I see.  I guess for the case, I should get both MFD and DT bindings
> > > maintainers' Acks before applying the patch.
> >
> > Yes.  The situation isn't overly clear and differs from subsystem to
> > subsystem and maintainer to maintainer.  In the MFD case, Rob and
> > Krzysztof conduct the first reviews.  99 times out of 100, if they're
> > happy, I'm happy and I merge the changes via the MFD tree.  Same goes
> > for Backlight and more recently, LEDs.
>
> I see.  Apologize for that and I will pay more attention next time when
> handling cross-subsystem patches.
