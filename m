Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC35F83FB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJHHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJHHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:24:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A9E0F2;
        Sat,  8 Oct 2022 00:24:49 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-345528ceb87so61807297b3.11;
        Sat, 08 Oct 2022 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iWyKaMDISXeONSvEckpZKdFY0ruOeKzT3+3B4I6Kdl0=;
        b=hAntufvWWxh4y9Kq/xnf6e6DkuinIarFJBkCnuMRaRhyfUcUIlhFRG+hKtUd8XlOGj
         JEzmyfbG5geG6DOcIN3stenWNVbG1ueCi6YsjeyJuFCD2/vzZ50+Axumh6iQzFSlPGpv
         1Y5GeZozwriCqigZ1xs1kjXM9hEbqhVNbqYDopI8Fzkt5xCvZevSylqQhnR2083SeCPg
         Ji9dsLbs8lkyd1HewLhH7DgiAxl0++0W39zRpqJxVyfUjcMSDHrmjNdPFzogmPkW9xpZ
         356Tjt3wvFQwsPqbpI/eMCfxYMu7ApB/TtGDE3D/9hrQ75fz4Jz3fnGAIBMQZMqZXsS/
         qkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWyKaMDISXeONSvEckpZKdFY0ruOeKzT3+3B4I6Kdl0=;
        b=2Yp5Xqe7wFJE9OhgWDS2VSukvQHpb+VUbGe0LoBXK4XfSGIjV78f7nXgPPzYVn6rTo
         mGJ+vPcWaA6MjOIAK/4zkBEsXGRRAF1P4BsrWWNUdCvr/TNsJt7yE7qrRhCi5xFPi85v
         2JlObIxE/Mgial4Jve9sIvxMMP1C+DcsCK5M2tK4W6URgX9Rsiorc7aTfN2zlGoIrTi0
         +nelZ+fLvSSS+gyJ5ApvOGOtW035LhcwXMSeR9cFGOa5++xwtxW2oxVCufoGo5e+iNfY
         OgiW9ccpgZRvfs5ZJQhKRpGDbx/gqUBngx3V2UORcIJUIxh2PPbWloG+oX2R8uZsU/Nr
         +plw==
X-Gm-Message-State: ACrzQf2qGCBlVW+W2xWs88s4PbZ45SgK9lW8Z6xBbKYWOCGv3LGZFH3U
        fvWTimGkIjY/maZSLX8XxF1vidV1n6q0/TwpP2I=
X-Google-Smtp-Source: AMsMyM7pcLcPfOdPXDuXPTm1G/LluYlawMFLzdGgaUJBksW476ZEt5+VZwvwIWiFEdBWyUKsUxCQES8dELrh/av7cDg=
X-Received: by 2002:a0d:fdc1:0:b0:349:c82b:b142 with SMTP id
 n184-20020a0dfdc1000000b00349c82bb142mr7709579ywf.431.1665213889042; Sat, 08
 Oct 2022 00:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
 <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
 <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com>
 <CANXV_XzdTTYc2w7Ur8zY=ijOofg91yfF7RLhedbVH0rmi3c2yA@mail.gmail.com>
 <CAK7LNATeW+c5+Kxnj9M4N+yNSv+7ot7bLTHzO3Z0Xb_XEW_6Nw@mail.gmail.com> <CAK7LNATqfCxwvYMUtoQZkoTk5yqZ_q+HJgcf934ib3NEG91oiw@mail.gmail.com>
In-Reply-To: <CAK7LNATqfCxwvYMUtoQZkoTk5yqZ_q+HJgcf934ib3NEG91oiw@mail.gmail.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Sat, 8 Oct 2022 10:24:37 +0300
Message-ID: <CANXV_XzmRiU2AT5r4GO0pNXCPFnZx4PZ3qbN37_rPkp=H1iWcQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

> On top of that, it is easier to add CONFIG_DEBUG_INFO_FULL or whatever.
As per the prior discussion, Nick has convinced me that configuring an
additional choice for a full debug info might cause more problems that
it solves in general.

>And, -g1 for CONFIG_DEBUG_INFO_REDUCED if you think it is worthwhile.
This indeed would shrink the image size, but with this option enabled
there would be no information about local variables which might
surprise users of the option. So I don't really think it is
worthwhile.

Regards,
Dmitrii.
