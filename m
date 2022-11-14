Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F44628165
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiKNNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiKNNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:34:12 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A5193F4;
        Mon, 14 Nov 2022 05:34:11 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id cg5so6699759qtb.12;
        Mon, 14 Nov 2022 05:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0enCl3aA3oSehDqOarw87aM8R6LctgbZ471ws/S8kmA=;
        b=IiJXQRlYJNA+c1htr+QvDVftp/julRl8ORMkAYgCNh1oeTszNvexwKDJsEWc/91rCL
         kLwX5XHtT2O6P31Ur+1Vp+yVbLFnqnfbHv0vA6nTacYnkkspJMFUfGZTcJQrhZ0js/Y6
         7mVd6DLS8DIQgzLk3LcKn8oorFrF3Y9RmPSfIl6DTHkw3+UBU9S4u8F76Frl06jK0T2I
         z3wkjoqD9AkQimKbtw0WlQpNj7Yw3S9Yd08v/WGkdiDicxPtRdqVFeAC/HEupDvpi/8M
         i6k/e44hr/xwGCYZF+0fYbQGu+1omE5MHB5Zzj6sfRLCRdU9oEwS9CWjRZBMnwvtShOL
         pWaw==
X-Gm-Message-State: ANoB5pkrsyEXLXGnljjJBX+zuyGw+d2E0+5KIi0vp5ntOFdTcMSvSDm3
        is4T+loJsKuwlaWFJtH1AZZ85zy46J8GSg==
X-Google-Smtp-Source: AA0mqf7nS7nPiTEBoRNcCLh3vSlXK2loevcYGefNVeNypOeDiRV1ZyjihrKfxF8JkmF9BQe0i1CvCA==
X-Received: by 2002:ac8:474b:0:b0:3a5:177d:d9cb with SMTP id k11-20020ac8474b000000b003a5177dd9cbmr12196423qtp.64.1668432849301;
        Mon, 14 Nov 2022 05:34:09 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v11-20020ac8728b000000b003a526675c07sm5598118qto.52.2022.11.14.05.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 05:34:08 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id j2so13412870ybb.6;
        Mon, 14 Nov 2022 05:34:08 -0800 (PST)
X-Received: by 2002:a25:844b:0:b0:6de:6c43:3991 with SMTP id
 r11-20020a25844b000000b006de6c433991mr11541758ybm.604.1668432848711; Mon, 14
 Nov 2022 05:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com> <20221114111513.1436165-3-herve.codina@bootlin.com>
In-Reply-To: <20221114111513.1436165-3-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 14:33:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy8mG-=NXP_+kC-QWyy06E=epVQd6kYQRyRauf87jO0w@mail.gmail.com>
Message-ID: <CAMuHMdUy8mG-=NXP_+kC-QWyy06E=epVQd6kYQRyRauf87jO0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
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

On Mon, Nov 14, 2022 at 12:15 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the h2mode property to force the USBs mode ie:
>  - 2 hosts
> or
>  - 1 host and 1 device
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
