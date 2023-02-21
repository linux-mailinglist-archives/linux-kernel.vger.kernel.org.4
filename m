Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881269DC95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjBUJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjBUJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:11:18 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AA23858;
        Tue, 21 Feb 2023 01:11:16 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id k20so428601qtj.5;
        Tue, 21 Feb 2023 01:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JT/nxkLUPPvSyT1XAkGQT7iXH75kIoeZitZQ4pmGywk=;
        b=TYWQ5/3eY8ltI6iIel7iJ6Fh1xDGIQUZUkbIVkxzcoulo4BZTfsruH0nCzJjx/rPG2
         k1XsDDsKxO3RHpY9YExfXYF2P25Bkrk9S6lVWbPSHpqeXMZcokgCzdyn9o51+mF63MHb
         j2SLnPmeGfyxD3pcNJvgWHDf4H9yYHkCAwXw25k780Tm5Cp7k1xh6U2qt+J7ghBecWAZ
         pZpobwwagNyaab2euGC1HONPRPgaso+zt+YSIKIouuD+ZP3mIXlbHzrqMpkweFds14Xi
         m7yjgEsHLFNUDxoThoaTVCOBuLTOOTIKOYk2aePPyoF4POUipA1E64IQIwJTZ72+EPeQ
         Xjkw==
X-Gm-Message-State: AO0yUKUJaWoSkN3/ftTYuTfgZkjOA51r35a34enB1JUcerKVTH+HCYsL
        SWUBaMSn6mmU0v7xjFhkizeKN+2a5Jg7ew==
X-Google-Smtp-Source: AK7set/HIY58J0mczc0Kaeyq9M2m6fkGVtBFcOjNdRwbdOXwxI1/wiWc5rwHayj1TpXX0Yz1ZJQo/A==
X-Received: by 2002:a05:622a:d1:b0:3ba:1c07:e472 with SMTP id p17-20020a05622a00d100b003ba1c07e472mr22965931qtw.51.1676970676004;
        Tue, 21 Feb 2023 01:11:16 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id cn6-20020a05622a248600b003b85ed59fa2sm780333qtb.50.2023.02.21.01.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:11:15 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536bf92b55cso43588777b3.12;
        Tue, 21 Feb 2023 01:11:15 -0800 (PST)
X-Received: by 2002:a81:d351:0:b0:536:e16d:23ea with SMTP id
 d17-20020a81d351000000b00536e16d23eamr47472ywl.526.1676970674915; Tue, 21 Feb
 2023 01:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20230216113035.3050871a@canb.auug.org.au>
In-Reply-To: <20230216113035.3050871a@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 10:11:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuudSDrWguMJiHsZ3GJhs+muK566M5GqK2vfMyBeo2pQ@mail.gmail.com>
Message-ID: <CAMuHMdVuudSDrWguMJiHsZ3GJhs+muK566M5GqK2vfMyBeo2pQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Feb 16, 2023 at 1:37 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the spi tree got a conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   b3de755d6041 ("dt-bindings: i2c: i2c-st: convert to DT schema")
>
> from the i2c tree and commit:
>
>   7ec844a2c753 ("spi: spi-st-ssc: convert to DT schema")
>
> from the spi tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc MAINTAINERS
> index 71e92d3c51c6,daa33e7bb457..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -2791,7 -2925,8 +2791,8 @@@ M:      Patrice Chotard <patrice.chotard@fos
>   L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:    Maintained
>   W:    http://www.stlinux.com
> + F:    Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
>  -F:    Documentation/devicetree/bindings/i2c/i2c-st.txt
>  +F:    Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
>   F:    arch/arm/boot/dts/sti*
>   F:    arch/arm/mach-sti/
>   F:    drivers/ata/ahci_st.c

Thanks, but please preserve sort order.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
