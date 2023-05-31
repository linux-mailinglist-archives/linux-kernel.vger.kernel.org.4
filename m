Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF17180EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjEaNCZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjEaNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:02:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F6E49
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:01:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad102ce9eeso7606448276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685537966; x=1688129966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk0pPTGREGNtqqDFsY8KHF8G7JlW3Q+zzUWS3RUpyQU=;
        b=O3WezxWL3hbfzi78/aboVecEEXo0aZOclRIl2R6yOjvKGBL+nijrSNNEWMJ106F7ma
         uEkNFDvnoT+uihJVSe0Q5aKcN0/bjmvAjB7vXfrAY1FVS46qyN36kfA1Mr6HagElkvf6
         bHZimTV2ygT975Wb/MrOb+opr/XQS9Ro0eYa/8QFzBJIq3zRxXi71TkUWl0++c5JWuBE
         /XKpA0w6kXQjmt+4wWZsGOJXtcSYZe754Ntvn1p56PjDU24Ze2w9YHm2E4ngIZ0eaNsb
         BM4Z+aEfYEFuFK2BznyKgSLHau2gWk/F9ZwV1YIEyY9CiT+rgZjOMfuTUkuCHbtDiaaN
         g5Vg==
X-Gm-Message-State: AC+VfDzO+uPqeXGN2i1ebPzjQqUPF+qzWnK01Do5cYUkGmpbGZTEsdZp
        aZCTSEbP5+TgxbecFVCiJCYEqVxOMUjE/g==
X-Google-Smtp-Source: ACHHUZ7mthertCrQYPZZzohNy2bKARmSTDYnsWCbMYH6g3ri2Oe+1rNRYpugQt8qi4Co4SbI863wTA==
X-Received: by 2002:a25:1654:0:b0:ba8:74f1:503d with SMTP id 81-20020a251654000000b00ba874f1503dmr5486540ybw.31.1685537965955;
        Wed, 31 May 2023 05:59:25 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id ch30-20020a0569020b1e00b00bad1cf6eb8csm3392326ybb.0.2023.05.31.05.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:59:25 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-566586b180fso44909457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:59:25 -0700 (PDT)
X-Received: by 2002:a81:48cc:0:b0:55a:c51:9a15 with SMTP id
 v195-20020a8148cc000000b0055a0c519a15mr6087006ywa.22.1685537965151; Wed, 31
 May 2023 05:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531125023.1121060-1-mpe@ellerman.id.au>
In-Reply-To: <20230531125023.1121060-1-mpe@ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 May 2023 14:59:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
Message-ID: <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Exclude m68k-only drivers from powerpc entry
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

CC Finn

On Wed, May 31, 2023 at 2:50 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> The powerpc section has a "F:" entry for drivers/macintosh, matching all
> files in or below drivers/macintosh. That is correct for the most part,
> but there are a couple of m68k-only drivers in the directory, so exclude
> those.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for your patch!

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11916,6 +11916,8 @@ L:      linuxppc-dev@lists.ozlabs.org
>  S:     Odd Fixes
>  F:     arch/powerpc/platforms/powermac/
>  F:     drivers/macintosh/
> +X:     drivers/macintosh/adb-iop.c
> +X:     drivers/macintosh/via-macii.c
>
>  LINUX FOR POWERPC (32-BIT AND 64-BIT)
>  M:     Michael Ellerman <mpe@ellerman.id.au>

LGTM, as there are already entries for these two files under
"M68K ON APPLE MACINTOSH".
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Which leads us to a related topic: Is Joshua still around?  Should Finn
be added or replace Joshua in the "M68K ON APPLE MACINTOSH" entry?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
