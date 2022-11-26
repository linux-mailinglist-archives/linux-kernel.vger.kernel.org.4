Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B06398E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKZXMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKZXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:12:05 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5517A94;
        Sat, 26 Nov 2022 15:12:03 -0800 (PST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2AQNBjAj024382;
        Sun, 27 Nov 2022 08:11:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2AQNBjAj024382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669504306;
        bh=J1aAnXscrvWFK80n1DQJD2O6z7NQ6gh1y6G3uDAZyIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eciRdrErQqvG+mOZQ5No8Zebq30kqIzILQsWSJ44uh5rl+OzyS9my2tSMzhVZY2Xt
         SnNqYdmNtYfgEH1QCmt6xRJ4DQDukeg/PzCqoapW0vXL6wzjoE6eLhItiPpuw6Seyg
         CSfUdCrZOEnyWkpj7BflGhy/xSq8ZrywYDagSHYE0i/20WaNt3g4VgJEmFCwOtGxPC
         8SNXRtIF9cZcrDfAK05eP/O0B958vuzMQebgufc0cyjvXGLYsDmQv2482dQFRspjUa
         B58zIMNOn3zv/Fy7wFHPVjIsWLfgjVboufxov38D/nt4uyq8TUgrB/zXNcQkNUQmKk
         EGBvKNz9YjSCg==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-14286d5ebc3so9103430fac.3;
        Sat, 26 Nov 2022 15:11:46 -0800 (PST)
X-Gm-Message-State: ANoB5plE1K1jTrDjHS9lR8puucjUZy6cEtN9438lvMHxawNZ0NYu05HI
        H2BI0oyvK93lYVyGORLRBEgbUKum6gbyye0pcLo=
X-Google-Smtp-Source: AA0mqf6Bgxuv5S0JItTGlteY7DsOjjGjEFt8EwOQxaE+G9SXjFUUCKxQWVrWluwTZ+5fWNU6oBgVPOwvN8q4VGb4YAQ=
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id
 gh6-20020a0568703b0600b0013b5d72d2c6mr13777762oab.287.1669504305063; Sat, 26
 Nov 2022 15:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20221125101249.24931-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221125101249.24931-1-andriy.shevchenko@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 08:11:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThgfr2p5G9eNViw48ha1+505xNAOeadiVp1_gqq9CABg@mail.gmail.com>
Message-ID: <CAK7LNAThgfr2p5G9eNViw48ha1+505xNAOeadiVp1_gqq9CABg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] modpost: Mark uuid_le type to be suitable only for MEI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 7:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The uuid_le type is used only in MEI ABI, do not advertise it for others.
> While at it, comment out that UUID types are not to be used in a new code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>

Applied to linux-kbuild.
Thanks.



> If you confused by acrn user of the uuid_le type, the patch to fix that
> is pending for v6.2 as well 1dbb4f0235a4 ("virt: acrn: Mark the uuid
> field as unused"). Nevertheless this patch doesn't break the things and
> hence can go independently to the respective tree.
>
>  scripts/mod/file2alias.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7df23905fdf1..91c2e7ba5e52 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -34,19 +34,23 @@ typedef Elf64_Addr  kernel_ulong_t;
>  typedef uint32_t       __u32;
>  typedef uint16_t       __u16;
>  typedef unsigned char  __u8;
> +
> +/* UUID types for backward compatibility, don't use in new code */
>  typedef struct {
>         __u8 b[16];
>  } guid_t;
>
> -/* backwards compatibility, don't use in new code */
> -typedef struct {
> -       __u8 b[16];
> -} uuid_le;
>  typedef struct {
>         __u8 b[16];
>  } uuid_t;
> +
>  #define        UUID_STRING_LEN         36
>
> +/* MEI UUID type, don't use anywhere else */
> +typedef struct {
> +       __u8 b[16];
> +} uuid_le;
> +
>  /* Big exception to the "don't include kernel headers into userspace, which
>   * even potentially has different endianness and word sizes, since
>   * we handle those differences explicitly below */
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
