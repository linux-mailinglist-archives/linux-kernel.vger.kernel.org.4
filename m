Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67E67B397
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjAYNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAYNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:42:53 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCDB76D;
        Wed, 25 Jan 2023 05:42:51 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id j9so15924139qtv.4;
        Wed, 25 Jan 2023 05:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVLXLhrWZMxsS5LRw98rr15QqoCU46pEI19S0OxbMm4=;
        b=ZiTPoD8FEZ2Kw/SQ6hzgXuhGAmT4q8z7x5uU2krqL0HRgMIeVonmYLcglLHb8JNRgJ
         mENwX/UAoSTcNfI+fWWpDcwYXMkNT3muKJCK6UNXm8ibuNl29vGrwQslTifDXcFiyvwy
         1zQdCsrm2cCuY+jpU7jdNCNqaL7cGoQ9zX7AXuaopyCyngzZ02nVguZfltkbpxYaSP7y
         2hvOQDczUjERt/ZnbfqiCFGXVkdJwr3iEsYAep2VgoB2x3FgYmIZXA6k4Z4iARg88niO
         It5lfq61IrnuzSwhHiEFSaMIRUnWcY4QVR5G5zgzemixxt8048BTZzvVaf/WtfXifOzc
         QHrg==
X-Gm-Message-State: AFqh2koj5iVqAp+tLyVPWQGNaYCdeicb5HSquUn3uWtt19Gmi3AuPChW
        FDyTmTf7KJ4eGebd9YSMtJhc9iD/81yT/w==
X-Google-Smtp-Source: AMrXdXvRb+7PJe1ivjV8VqGbG94rxv6z1zS/8anDHjfdr5zJGXC38BDAyP3ohWoUVis0DTPSaCKzPg==
X-Received: by 2002:ac8:5c14:0:b0:3b6:33c6:c5ac with SMTP id i20-20020ac85c14000000b003b633c6c5acmr60877323qti.4.1674654170281;
        Wed, 25 Jan 2023 05:42:50 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a166a00b00706b299d014sm3388067qko.132.2023.01.25.05.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:42:49 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id u72so2334903ybi.7;
        Wed, 25 Jan 2023 05:42:49 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr2623220ybe.365.1674654169340; Wed, 25
 Jan 2023 05:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com> <20230118144747.24968-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230118144747.24968-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 14:42:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMxt93MxBuO60qWmwuKjfFAts=FyWt4VVP+5uO1Pwx0w@mail.gmail.com>
Message-ID: <CAMuHMdVMxt93MxBuO60qWmwuKjfFAts=FyWt4VVP+5uO1Pwx0w@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: v2mevk2: Add PWC support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:48 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M EVK uses the PWC IP to control external power supplies
> and the I/O voltage for the uSD card.
>
> This patch enables the PWC node, and it also enables the poweroff
> features since PWC is actually used to control the board power
> rails.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
