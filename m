Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEA6D310F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDANcC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:32:00 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF73AB5;
        Sat,  1 Apr 2023 06:31:56 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-545cb3c9898so392020167b3.7;
        Sat, 01 Apr 2023 06:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680355915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMLjaNTG/vxBEa8ZgHssFzA8vDTxXHgXd9BXN8Mlh3k=;
        b=UH4mdtg2MKJN1UQYhiTfItKkdiixMw0D3b+ZpbNeIJ0+jz/1YC5gAjma4Xb2BzDnyJ
         dNQnH+b8GoT/fbfYaExg+2xbvQlLexmqcjC86d5Ku9Pfk515tl5dh6EAkudkBHO7w7+p
         RGzIK6gmBdqyT7a1Fk43PCp69CEp8UDIF4aONW3pfrl/0lPu6T/2Beun3GE+aBz7fq56
         V76p647gzN/RanBwWfGTCyDWNRrwVOLKFgla5QdTL7fmmLZlVkSUbenKL9n3hoXS2v1N
         UULB/q34F/rB/eo+HfkMwUwxx/ssbmj/u12Dg4OXD6xXQKfqpY8ZLTGt2sXVHNguR0U9
         LRQQ==
X-Gm-Message-State: AAQBX9cKkQNRRdRiqM3/Mu9jJqmqW1JAlPKX/DYVB/oG0GVZCB3cN3J1
        e20pjdFkj6LXUbsYbew7+9lu9JzGM4UgbA==
X-Google-Smtp-Source: AKy350byAcCJtAhyJUI939AKGqQvsqx9XcxR95hxLMBNkMLCJAB/9uGcGB53VO7aVsvJasEeMzbSoA==
X-Received: by 2002:a81:fd12:0:b0:533:9fa7:bbe9 with SMTP id g18-20020a81fd12000000b005339fa7bbe9mr29547493ywn.8.1680355915568;
        Sat, 01 Apr 2023 06:31:55 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 142-20020a810e94000000b00545a08184c1sm1176823ywo.81.2023.04.01.06.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 06:31:55 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5456249756bso467162177b3.5;
        Sat, 01 Apr 2023 06:31:54 -0700 (PDT)
X-Received: by 2002:a81:b617:0:b0:544:4008:baa1 with SMTP id
 u23-20020a81b617000000b005444008baa1mr15177048ywh.4.1680355914630; Sat, 01
 Apr 2023 06:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680248888.git.geert+renesas@glider.be> <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
 <CAL_JsqJJoTGjTihcCiX8qOowb7tSjxg-rjLVskVPuWvSn=0ikA@mail.gmail.com>
In-Reply-To: <CAL_JsqJJoTGjTihcCiX8qOowb7tSjxg-rjLVskVPuWvSn=0ikA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 1 Apr 2023 15:31:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvFu2vFXXxCK02UD_Ls_KruYBmdB6b7LdzPkFVZ=qi+Q@mail.gmail.com>
Message-ID: <CAMuHMdXvFu2vFXXxCK02UD_Ls_KruYBmdB6b7LdzPkFVZ=qi+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: address: Reshuffle to remove forward declarations
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Mar 31, 2023 at 6:28 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Mar 31, 2023 at 2:52 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Reshuffle the code to get rid of the forward declarations, which
> > improves readability.
>
> Is git blame smart enough to ignore this move? If not, I'd rather keep
> the blame than save 3 lines.

Apparently (I didn't know before ;-), it is, when using the -M option:

$ git blame -- drivers/of/address.c | tail -3
1db096f9167bc267e (Geert Uytterhoeven        2023-03-30 13:42:05 +0200
1150) return mem;
1db096f9167bc267e (Geert Uytterhoeven        2023-03-30 13:42:05 +0200 1151) }
1db096f9167bc267e (Geert Uytterhoeven        2023-03-30 13:42:05 +0200
1152) EXPORT_SYMBOL(of_io_request_and_map);

$ git blame -M -- drivers/of/address.c | tail -3
efd342fb0031a1775 (Matthias Brugger          2014-07-18 11:36:39 +0200
1150) return mem;
efd342fb0031a1775 (Matthias Brugger          2014-07-18 11:36:39 +0200 1151) }
efd342fb0031a1775 (Matthias Brugger          2014-07-18 11:36:39 +0200
1152) EXPORT_SYMBOL(of_io_request_and_map);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
