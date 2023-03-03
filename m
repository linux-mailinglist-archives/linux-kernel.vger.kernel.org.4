Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A383B6A91F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCCHwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 02:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCCHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:52:44 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48155511;
        Thu,  2 Mar 2023 23:52:43 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id nv15so1227030qvb.7;
        Thu, 02 Mar 2023 23:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swIYUUiwEVljh3zvvJtD0QY2HuHSKEbKGNleKmwU12g=;
        b=3vEsHs5IyMPmaeK/q2TXYykq/QeB9mc0BPvEFJuAl8TLmfp+uChNYQg/NPDadxqBV6
         4Il26ewnq09lMMnoyvLZjhXFTK/1GEOVF2WufSt5EeriDK1yw5/863Fn7hXF5FpBo7Pr
         ewFY7zhmfHOq4e1kv/5p7aH3sbDFTQzXl4buxEVjx+TVGxmA6LA67gGIkkgkbL0OW6zP
         2A4XUVIoUo5eBmvW4/yN8N6NJaMAHg08aEZmYaY2wLPmifnwHHx4m3nsLo6btwbAIWjc
         LO57/sSr39E97cbLEBxuTRFgOdt4WE9XOnyXtBUuhfXP/Vl8SrsA0yaKepcmrj6d1j5p
         Szmg==
X-Gm-Message-State: AO0yUKXIZRYNCh4vyEUdi/7HyO46CoyOa0BfDfk7hN0gqBBftq7QYfw3
        qjMV9ZGTauVKVwCeEzevShAz+CoF7WUlmw==
X-Google-Smtp-Source: AK7set+7g0wulw85k9CLOZqYAN0gFV9TS5ftFIpT3DSAgN4lxM90Az0reELwnv3MKsRcjnJmntVecg==
X-Received: by 2002:a05:6214:b66:b0:56e:fbd5:8dda with SMTP id ey6-20020a0562140b6600b0056efbd58ddamr1708316qvb.44.1677829962577;
        Thu, 02 Mar 2023 23:52:42 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 74-20020a370a4d000000b0073b878e3f30sm1238948qkk.59.2023.03.02.23.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:52:42 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id v101so1175837ybi.2;
        Thu, 02 Mar 2023 23:52:42 -0800 (PST)
X-Received: by 2002:a05:6902:d2:b0:a8f:a6cc:9657 with SMTP id
 i18-20020a05690200d200b00a8fa6cc9657mr356391ybs.7.1677829961948; Thu, 02 Mar
 2023 23:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20230302211759.30135-1-nick.alcock@oracle.com> <20230302211759.30135-6-nick.alcock@oracle.com>
In-Reply-To: <20230302211759.30135-6-nick.alcock@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Mar 2023 08:52:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
Message-ID: <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
Subject: Re: [PATCH 05/17] drivers: bus: simple-pm-bus: remove MODULE_LICENSE
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Mar 2, 2023 at 11:25 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for your patch!

> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -92,4 +92,3 @@ module_platform_driver(simple_pm_bus_driver);
>
>  MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
>  MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
> -MODULE_LICENSE("GPL v2");

Please do not remove this line as long as the file has no SPDX-License
tag.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
