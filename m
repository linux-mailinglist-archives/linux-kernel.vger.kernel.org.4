Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A895E6398EF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiKZXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKZXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:33:53 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549EBE0B7;
        Sat, 26 Nov 2022 15:33:52 -0800 (PST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2AQNXZST025618;
        Sun, 27 Nov 2022 08:33:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2AQNXZST025618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669505616;
        bh=J/LYe5JYlns9ACSZVuFdEa6f9SvtDU8tqbOLIhZ4S/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K6VmspVkxtxQJI/S1GPmBygjPjegA8jPHKlJwCuZK07NQW6kuTfW/AbUJJ8HakrwS
         Q2AAwMuoFNk4GVJtgUP6cZOKXbrD58o/rVn4enczXfaq24qImWlWbFmoPz5dS/h7qv
         +KLgdH7MLTqsvHd1gxWTsuxIszR7w3tQojnVp2BntK9VhFAoIT3WksfmqZlBei4c8m
         KuRHN9/qzSmsFFHcIePXD1unwBMrfOov8zLi9u4JqFf24IOjXeTERfQePRpetU/ezB
         /huavA+AUCY3sK2ywx8ayLg9MrsEqIHug3wMQ/WBtPuM8McqVGGSfdFMnUZKGtsTMC
         VI1Wmo64At1WA==
X-Nifty-SrcIP: [209.85.160.51]
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13bd2aea61bso9187071fac.0;
        Sat, 26 Nov 2022 15:33:35 -0800 (PST)
X-Gm-Message-State: ANoB5pkR3nemhbA/0aFabM7znnIXWxruWM7ydWjnoMtmmKqV0hWCYV9o
        UV4p4895oukPHnUJFwS/iefs37iAS299FSlJ+DA=
X-Google-Smtp-Source: AA0mqf7VYu6rJnCgqfD3zNa0ZU3XjLgkRFXxTy+sWhXKDwk5tclcHujVmNLXHFYAO5WZcBcbKZn9WwGOF3ud400h9Dw=
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id
 gh6-20020a0568703b0600b0013b5d72d2c6mr13800995oab.287.1669505614793; Sat, 26
 Nov 2022 15:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20221124032053.10627-1-rdunlap@infradead.org> <CAK7LNARfULFwt9RGq34dXSwchCWMrwauh_PfMKPCSBAqhCOHzg@mail.gmail.com>
In-Reply-To: <CAK7LNARfULFwt9RGq34dXSwchCWMrwauh_PfMKPCSBAqhCOHzg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 08:32:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzybtgWVcmE-Wk-3Vp-bx0qAJTjy3nWvdazQpfkFov-g@mail.gmail.com>
Message-ID: <CAK7LNAQzybtgWVcmE-Wk-3Vp-bx0qAJTjy3nWvdazQpfkFov-g@mail.gmail.com>
Subject: Re: [PATCH] nios2: add FORCE for vmlinuz.gz
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:55 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 12:21 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Add FORCE to placate a warning from make:
> >
> > arch/nios2/boot/Makefile:24: FORCE prerequisite is missing
> >
> > Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
>
>
> Assuming this will go to the NIOS2 tree,
>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
>
> Please let me know if I should apply this to kbuild tree.
>


I changed my mind and applied this to linux-kbuild/fixes.

I have another chance to send a pull request soon.


Thanks.









-- 
Best Regards
Masahiro Yamada
