Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A026EA5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjDUIbP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjDUIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:31:10 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76898A54;
        Fri, 21 Apr 2023 01:31:09 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-54f9e41dfa7so4562927b3.3;
        Fri, 21 Apr 2023 01:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065869; x=1684657869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJk3HTBeWzZb2MBrPdY3fa4qSP22CufNx4/oB5AHnas=;
        b=bsxp1q6Ed3cmYewioVSdXEZZ7wIXq5Mu00h8HZRZmNgavVYi3vEqpikeCEalDZFs2i
         hWfv0TM/MXzpcVJ9Q71uwp41HG1wY6tDkl32JLkDp6QzoixkY85hzW1NL5GJ5ReLR3PT
         0gCkt1euuPZliMopOmV8Vhr4kxSlW6aH9fQnlq4bovAxRe0OiS/o+afzDgcwVL81aj3m
         cpAYwv8nhj8bQJSJI6ZlMMJIMlqyB9I/LKNUT70G/ypRbDouGlVarvTmw7wg7nDXwfzv
         XWmZPPEgQGEv+hfmJsE+uix99Ih1nst63QKGpww0aEjDnSK12hU4PsSDlDdsguCVPpfq
         VHdw==
X-Gm-Message-State: AAQBX9eIcdYmfCMSOV20pf3QFPjIEpfr2/V3NpEzYVdvt2V2MTrMB33c
        192F/AHdGyu9GP8u//OCnN8DXk38UB71THWs
X-Google-Smtp-Source: AKy350bT7Fikl+l0vtTOYb6J9xjiW/Ls2ail2HfQVCcjbi34sSLCc4U6vvzPn9DgtxEC/sqIY/0z6g==
X-Received: by 2002:a81:4f81:0:b0:54f:9b17:c7db with SMTP id d123-20020a814f81000000b0054f9b17c7dbmr1124686ywb.10.1682065868988;
        Fri, 21 Apr 2023 01:31:08 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id y3-20020a0dd603000000b0054e82b6a95esm829855ywd.42.2023.04.21.01.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 01:31:08 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54f9e41dfa7so4562827b3.3;
        Fri, 21 Apr 2023 01:31:08 -0700 (PDT)
X-Received: by 2002:a0d:df8d:0:b0:545:637c:3ed7 with SMTP id
 i135-20020a0ddf8d000000b00545637c3ed7mr1500731ywe.1.1682065867983; Fri, 21
 Apr 2023 01:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUNfcu=opFMSTP2E_VkgWXHazHFL2_Z4B0gFvQ7k8z7ZA@mail.gmail.com>
In-Reply-To: <CAMuHMdUNfcu=opFMSTP2E_VkgWXHazHFL2_Z4B0gFvQ7k8z7ZA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 10:30:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVm=ahKaWZR2fK=T7GQwgBpnJ8xgYj_iBF0TxN3Ra5xcA@mail.gmail.com>
Message-ID: <CAMuHMdVm=ahKaWZR2fK=T7GQwgBpnJ8xgYj_iBF0TxN3Ra5xcA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rg2lc-smarc: Enable CRU, CSI support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 3:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Apr 13, 2023 at 1:40 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable CRU, CSI on RZ/G2LC SMARC EVK and tie the CSI to the OV5645 sensor
> > using Device Tree overlay.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.5.

With s/rg2lc-smarc/rzg2lc-smarc/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
