Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846D863DAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiK3QmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiK3Qlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:41:55 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DFF880F8;
        Wed, 30 Nov 2022 08:41:54 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id d8so12671523qki.13;
        Wed, 30 Nov 2022 08:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpxFM3mDElOJp68yFjINxCWO/tvZWQI70qNzsqToQOg=;
        b=gRPDsLGKEzNyaiuobPyUOKq96O2NkP17ghRUxl9cN2aKyoX7ACcaIgANtJ922WLVaD
         gR5qJez7c2yP1urV5kqWJJZ8XsZWVWThd730b3b7wmkXeB1Pnx+8N2zMqWo4znQ174wD
         zy6tYw30uhEyj07nZdZhHVnKee+hYOCEgD1O8hSk8BKbrx/1A0jWzdwjdPgIq3m4IL4a
         zXyaEfXbn1pdX4ztWwvbHTKQZpAwRfm4lBkj9ERNdRjXm6epFf5WSFK4SpznR1PuVD1p
         qD6RDBG+ZHodOm1pJbJU8YBqCZisJvL2zNbFDapkLzlMyG2qVrvYt7Aq+2YAaqkUU7qB
         Js2g==
X-Gm-Message-State: ANoB5pkkdiHJQoX68aZ5fPRm/D/qCPAGt2ZCpE4e6HNqjL8Ls3NIumbq
        4HC2YoYGeoZftuydGPTbnNGoL7H/rTJwyA==
X-Google-Smtp-Source: AA0mqf43lMMb+KZfOFFWCbAWNQxV45SzGLFEl/b3Su8PbTVpfrl6zrRx53KHPLJrp4D4yJ9xqP9E3g==
X-Received: by 2002:ae9:e110:0:b0:6e0:2272:22ff with SMTP id g16-20020ae9e110000000b006e0227222ffmr37609223qkm.448.1669826513219;
        Wed, 30 Nov 2022 08:41:53 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a244d00b006fba44843a5sm1548757qkn.52.2022.11.30.08.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:41:52 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 189so21629647ybe.8;
        Wed, 30 Nov 2022 08:41:52 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr33358504ybc.543.1669826512202; Wed, 30
 Nov 2022 08:41:52 -0800 (PST)
MIME-Version: 1.0
References: <a14e9ec0af23eb349372fdcdb534d83652b5a449.1669826117.git.michal.simek@amd.com>
In-Reply-To: <a14e9ec0af23eb349372fdcdb534d83652b5a449.1669826117.git.michal.simek@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Nov 2022 17:41:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcJc-5aqy1u6=DYrb4fPiLSJw26Gw2m6gegOqnTwCQQA@mail.gmail.com>
Message-ID: <CAMuHMdVcJc-5aqy1u6=DYrb4fPiLSJw26Gw2m6gegOqnTwCQQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Rename overlay source files from .dts to .dtso
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, frank.rowand@sony.com,
        geert+renesas@glider.be, afd@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Nov 30, 2022 at 5:35 PM Michal Simek <michal.simek@amd.com> wrote:
> Based on commit e87cacadebaf ("of: overlay: rename overlay source files
> from .dts to .dtso") and also Kbuild changes done by commit 363547d2191c
> ("kbuild: Allow DTB overlays to built from .dtso named source files") and
> commit 941214a512d8 ("kbuild: Allow DTB overlays to built into .dtbo.S
> files") DT overlay source files should be renamed to .dtso.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Someone forgot to CC you on
https://lore.kernel.org/all/20221024173434.32518-7-afd@ti.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
