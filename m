Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92E626F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiKMKwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiKMKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:52:33 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB82DF1;
        Sun, 13 Nov 2022 02:52:31 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2ADAps8a013455;
        Sun, 13 Nov 2022 19:51:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2ADAps8a013455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668336715;
        bh=wfxW3yU/ozIG11zKkibtvaD5a6s4xhpnnsFtfT5h3Jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RVy/UtEk/YT8aDP3/lpuTCUjHEivk9LTFGZSLGct+uj0hlfeaVYF4V8pmULJI2VJV
         8np8zCZJzI7bhlT5GIt3UdCdTiRUN+YQw4DKxsxvge5PAM4fYqkaEkbZnDVruLhlDo
         8/dSXgALKURa2rERjDxr79mKIvPz8ThzzgTeeC2mk0ek4s9ykioz7wPCw5CYXGr95G
         poj6Usg6fO1lQ/E3A5qYtI9BBu3zBQyhu7uf3XzKYnBY9dG6ywlRlM48+iYKaXH26f
         /hMkRCk9SCn40lbf6erY6o8qwF5JtSnXR3pcPV8hBHdTKo2km45BEdiFY723N0zUAB
         U4Ao20lrHeCKw==
X-Nifty-SrcIP: [209.85.167.180]
Received: by mail-oi1-f180.google.com with SMTP id m204so8914490oib.6;
        Sun, 13 Nov 2022 02:51:54 -0800 (PST)
X-Gm-Message-State: ANoB5pkiqyMg4hV9R9BexuXer7kJQYl2iQQ2XS99y6Jf40BBDHoW36bR
        NlFlhy5QF2cUVxKDa3dC9Pe5qP+mNVZeyjE/Jrk=
X-Google-Smtp-Source: AA0mqf6dWx9fWoXXuufGuuhjBfCAoibDQe7+c2MdNoPwacSkcPpgEYcJj/Geh1GH0yVcnBg6AIjZbj4+HvIf6K2zqMU=
X-Received: by 2002:aca:3b82:0:b0:354:28ae:23b3 with SMTP id
 i124-20020aca3b82000000b0035428ae23b3mr3872355oia.287.1668336713663; Sun, 13
 Nov 2022 02:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20221112080717.17914-1-nicolas@fjasle.eu>
In-Reply-To: <20221112080717.17914-1-nicolas@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Nov 2022 19:51:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2j9sDhMOsQ42tAZhypWjE9JhuVe017p3FAPzeuYLi-Q@mail.gmail.com>
Message-ID: <CAK7LNAR2j9sDhMOsQ42tAZhypWjE9JhuVe017p3FAPzeuYLi-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] MAINTAINERS: Update Kbuild and Kconfig entries
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 5:10 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> Update MAINTAINERS by adding Nathan and myself to Kbuild reviewers and moving
> emeritus maintainer Marek to CREDITS.  Further, add the missing patchwork URLs
> for Kconfig and Kbuild.


All applied. Thanks!



> Nicolas Schier (3):
>   MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
>   MAINTAINERS: Remove Michal Marek from Kbuild maintainers
>   MAINTAINERS: Add linux-kbuild's patchwork
>
>  CREDITS     | 4 ++++
>  MAINTAINERS | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> Changes v1 -> v2:
>   * patch1: Also add Nathan to Kbuild reviewers (Nick, Nathan), and update commit msg
>   * patch2: Add missing 'no' to commit msg (Randy)
>   * patch2: Add CREDITS entry for Michal (Nick)
>
>
> Range-diff against v1:
> 1:  e827247c902b ! 1:  efd3cbed0d42 MAINTAINERS: Add Nicolas Schier to Kbuild reviewers
>     @@ Metadata
>      Author: Nicolas Schier <nicolas@fjasle.eu>
>
>       ## Commit message ##
>     -    MAINTAINERS: Add Nicolas Schier to Kbuild reviewers
>     +    MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
>
>     -    As suggested by Nick, add myself to Kbuild reviewers since I have been
>     -    reviewing patches for some time.  Citing from Nick's commit 36f1386d34120:
>     -    "I still have a long way to go in terms of mastery of GNU make, but at the
>     -    least I can help with more code review."
>     +    As suggested by Nick, add Nathan and myself to Kbuild reviewers to share more
>     +    review responsibilities.
>
>          Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
>     +    Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>     +    Acked-by: Nathan Chancellor <nathan@kernel.org>
>
>       ## MAINTAINERS ##
>     -@@ MAINTAINERS: KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>     +@@ MAINTAINERS: F: fs/autofs/
>     + KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>       M:        Masahiro Yamada <masahiroy@kernel.org>
>       M:        Michal Marek <michal.lkml@markovi.net>
>     ++R:        Nathan Chancellor <nathan@kernel.org>
>       R:        Nick Desaulniers <ndesaulniers@google.com>
>      +R:        Nicolas Schier <nicolas@fjasle.eu>
>       L:        linux-kbuild@vger.kernel.org
> 2:  88524e0789c3 ! 2:  c31750a47b44 MAINTAINERS: Remove Michal Marek from Kbuild maintainers
>     @@ Metadata
>       ## Commit message ##
>          MAINTAINERS: Remove Michal Marek from Kbuild maintainers
>
>     -    Remove Michal Marek from Kbuild maintainers as there is response since
>     -    October 2017.
>     +    Remove Michal Marek from Kbuild maintainers as there is no response from him
>     +    since October 2017.  Add an entry for Michal in CREDITS.
>     +
>     +    Michal, thanks for maintaining Kbuild for almost eight years!
>
>          Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>     +    Cc: Michal Marek <michal.lkml@markovi.net>
>          Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
>
>     + ## CREDITS ##
>     +@@ CREDITS: S: 482 Shadowgraph Dr.
>     + S: San Jose, CA  95110
>     + S: USA
>     +
>     ++N: Michal Marek
>     ++E: michal.lkml@markovi.net
>     ++D: Kbuild Maintainer 2009-2017
>     ++
>     + N: Martin Mares
>     + E: mj@ucw.cz
>     + W: http://www.ucw.cz/~mj/
>     +
>       ## MAINTAINERS ##
>      @@ MAINTAINERS: F: fs/autofs/
>
>       KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>       M:        Masahiro Yamada <masahiroy@kernel.org>
>      -M:        Michal Marek <michal.lkml@markovi.net>
>     + R:        Nathan Chancellor <nathan@kernel.org>
>       R:        Nick Desaulniers <ndesaulniers@google.com>
>       R:        Nicolas Schier <nicolas@fjasle.eu>
>     - L:        linux-kbuild@vger.kernel.org
> 3:  0e05c2d815d2 ! 3:  59eeba8ee2b7 MAINTAINERS: Add linux-kbuild's patchwork
>     @@ Commit message
>          Add patchwork URL for Kconfig and Kbuild.
>
>          Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
>     +    Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>       ## MAINTAINERS ##
>      @@ MAINTAINERS: KCONFIG
> --
> 2.37.2
>


-- 
Best Regards
Masahiro Yamada
