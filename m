Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4B6E95F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDTNia convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDTNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:38:26 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316855B5;
        Thu, 20 Apr 2023 06:38:19 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54f6a796bd0so40572537b3.12;
        Thu, 20 Apr 2023 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997898; x=1684589898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9SF7s7N8rxXE2x9SyfGpF8YzWancQe2O4/d9UmGOoU=;
        b=cbJZiZOix48sIZbm5iuifFQPdxCTBmtlDL9B0BoQJdt4iC3KVz1A+90xL+Pz7G806D
         IO8tdYMAV3rPFCfmMSJPylJdFtR15Xn/mEJnGA5AqECzQ9HRor9RUastPBy2/ak52WoU
         pTJp3jHefl+RTzAxXUI/nwypODWcV9le9itz1CxFKqpGHPNXaIRZWrTbpdgYXh6nP5P6
         5aGi8jp+GhcN1F+u1kRaR8MM3gYeu8vWBfhBz2FFYjLxRcIJsCSGWoW0iXHUiC3jShV8
         LqHXLSxBvooMYNXOUCY0yuFLhO6J68WQiR3Xd3LUI5y8jv2ofhC8cvl7Us9jrpAeUiRn
         aBAw==
X-Gm-Message-State: AAQBX9cie4wOAI9rTVeTakuGWg9P2lfcwc/lTLYV5qY8ATlqBKS0kBI3
        rPSQU2FrDbvNIYPAf4EwIC91wNrzFztuvbfI
X-Google-Smtp-Source: AKy350YUVw+LTeyEt06DZf+YwL79C/p7EUvtXvx9F6ul6rnUvxZNG5CtF0I6r2ItzEXyn4ov3q8OTg==
X-Received: by 2002:a81:d93:0:b0:552:b601:c814 with SMTP id 141-20020a810d93000000b00552b601c814mr5935803ywn.24.1681997898592;
        Thu, 20 Apr 2023 06:38:18 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id u142-20020a818494000000b0054f6f65f258sm351097ywf.16.2023.04.20.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:38:18 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-555bc7f6746so41573597b3.6;
        Thu, 20 Apr 2023 06:38:17 -0700 (PDT)
X-Received: by 2002:a81:34a:0:b0:52e:e90b:5e2 with SMTP id 71-20020a81034a000000b0052ee90b05e2mr6431495ywd.1.1681997897692;
 Thu, 20 Apr 2023 06:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230412185608.64628-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230412185608.64628-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:38:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcSTeZdDezLEzc6vuw+8YXbLTeRsbn2Ne4O7XUzaW6wQ@mail.gmail.com>
Message-ID: <CAMuHMdVcSTeZdDezLEzc6vuw+8YXbLTeRsbn2Ne4O7XUzaW6wQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
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

On Wed, Apr 12, 2023 at 8:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add CSI and CRU nodes to r9a07g054 (RZ/V2L) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
