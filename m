Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC7745F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGCOtr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:49:45 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD2B2;
        Mon,  3 Jul 2023 07:49:44 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5703cb4bcb4so48059217b3.3;
        Mon, 03 Jul 2023 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395783; x=1690987783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY1I4rwqDndCDmWpTkptLJRSj9+jun4KpqhzWpHlROg=;
        b=J5C3B1bptD1PtBht6YeK92I6OEZirpGTiCvq61y9iNzqgvQ7fRkj8Ny25TzR4xwSiE
         +HvERqurtfGq6Tg8RFtDIVoERu1BDwdA7SuPWuBi7XpuHzW0CWMmoyoAJdPum2GZjtkz
         XjpYwV/5rk58a40BV8G5kXW1BrG1jKKdEdTiqWWRY4VCmxNHopJMeY4IEuESfE6r8xn4
         j2nXCyyAW/Bld3v64nvis7/GFeRAFW5kXh346NCswJdMLpesBoLKrC2VSrSPArmK97ex
         vYLtegGBlz8GkVuFqnOw+/vWzxIvBwAXACB1XLBaiKWwPovWG09SPZhP86hRFDB8DfeX
         agqw==
X-Gm-Message-State: ABy/qLZtk87+zPcorKs7YQZYV3h/RcClJ5QD4y8WaMR5XZDyeu+OfytL
        CsGhArNH5KJHhDJ+if+VsbVyFFaffNAyXg==
X-Google-Smtp-Source: APBJJlF0M4Fikyc0Ul4SzDeqUAzNRZP96JEtVLCJdDdSn3+io+1b7eUxliLWPtfEYm2dY1uhhvcPkw==
X-Received: by 2002:a81:628a:0:b0:56d:4b17:7e9c with SMTP id w132-20020a81628a000000b0056d4b177e9cmr11763355ywb.32.1688395783112;
        Mon, 03 Jul 2023 07:49:43 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 132-20020a25168a000000b00bcc9793c3e6sm4398729ybw.65.2023.07.03.07.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:49:42 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5703cb4bcb4so48058897b3.3;
        Mon, 03 Jul 2023 07:49:42 -0700 (PDT)
X-Received: by 2002:a25:15c1:0:b0:bfe:77f1:f454 with SMTP id
 184-20020a2515c1000000b00bfe77f1f454mr8566617ybv.51.1688395782355; Mon, 03
 Jul 2023 07:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com> <CACRpkdavQ1X29LyZscvdkBOS53H5sdYhZbKhWL9fpdghiddCTw@mail.gmail.com>
In-Reply-To: <CACRpkdavQ1X29LyZscvdkBOS53H5sdYhZbKhWL9fpdghiddCTw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 16:49:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoHRBWy3JXosTu7N0HUYECC=7DaiQWhchJQ=Fn=72vGA@mail.gmail.com>
Message-ID: <CAMuHMdUoHRBWy3JXosTu7N0HUYECC=7DaiQWhchJQ=Fn=72vGA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl names
To:     Linus Walleij <linus.walleij@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Fabrizio,

On Sat, Jun 24, 2023 at 9:12 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 23, 2023 at 10:40 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jun 23, 2023 at 10:01 AM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 85000000.mmc; cannot claim for 85020000.mmc
> > > pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
> > > renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reverse things back

I managed to reproduce the issue[*], and devised a fix, which I will
send shortly.

> > To me, that sounds like a bug in the pinctrl core.
> > Or am I missing something?
>
> The pin control core tracks on a per-pin basis, it has no clue about
> the name of certain dt nodes.
>
> This bug would be in the DT parsing code for the different states
> I think, and rzv2m is not using the core helpers for this but
> rather rzv2m_dt_subnode_to_map() etc.

Indeed, there's an issue in rzv2m_dt_subnode_to_map(): it registers
groups and functions using just the subnode names, which may not
be unique.  When this happens, they are ignored silently.

      $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pingroups
      registered pin groups:
      group: data
      pin 130 (P8_2)
      pin 131 (P8_3)
      pin 132 (P8_4)
      pin 133 (P8_5)

      group: ctrl
      pin 128 (P8_0)
      pin 129 (P8_1)

      group: cd
      pin 135 (P8_7)

      $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pinmux-functions
      function 0: data, groups = [ data ]
      function 1: ctrl, groups = [ ctrl ]
      function 2: cd, groups = [ cd ]

You can see this by adding checks in the pin control core:

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -639,8 +639,10 @@ int pinctrl_generic_add_group(struct pinctrl_dev
*pctldev, const char *name,
                return -EINVAL;

        selector = pinctrl_generic_group_name_to_selector(pctldev, name);
-       if (selector >= 0)
+       if (selector >= 0) {
+               pr_err("Duplicate group name %s (selector %d)\n",
name, selector);
                return selector;
+       }

        selector = pctldev->num_groups;

--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -878,8 +878,10 @@ int pinmux_generic_add_function(struct
pinctrl_dev *pctldev,
                return -EINVAL;

        selector = pinmux_func_name_to_selector(pctldev, name);
-       if (selector >= 0)
+       if (selector >= 0) {
+pr_err("Duplicate function name %s (selector %d)\n", name, selector);
                return selector;
+       }

        selector = pctldev->num_functions;

Is there any special reason why such duplicates are just ignored,
and not flagged as an error?

The RZ/G2L and RZ/N1 pin control drivers have the same issue, but it
is not triggered on these platforms (yet), as their DTS files either
do not use subnodes, or use unique subnode names.

The RZ/A1 and RZ/A2 pin control drivers are not affected, as they do
not support subnodes.

The StarFive JH7100 pin control driver does it right, by constructing
group/function names from both the node and the subnode names.

[*] As I do not have an RZ/V2M board, I added pin control, eMMC, and
    SDHI snippets from RZ/V2M to the Koelsch DTS, and modified the
    drivers to not touch the non-existing hardware.




Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
