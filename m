Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA573D60A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjFZCug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFZCud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF7115;
        Sun, 25 Jun 2023 19:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E5B960C68;
        Mon, 26 Jun 2023 02:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27C7C433C8;
        Mon, 26 Jun 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687747828;
        bh=nELlQoOTkjP3LWXlu8vQM6HRztCcyTW55SVKYLv77+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqMjjq1HMrrdB9euO/FGPW976/sUCFfkUHgIlj12shqfbMnU2xVvrerkP09pE+LnJ
         fh3XTdewkEmJaudOESWj0Ljazt6dx/rD9VnuJVIPBIgN3W/S+vIbbM4JF9O5aaIWoK
         jnarAtFC4A6vWEGM9gd6LWhpAd6ZqJLHFz90rGrBzae2Z9RLPxxcQPOlrKur8KOfUy
         vy9dwhXTN8HrqPElvSEsE//zlItZNuc6aBXdh2/TJTxaQ4Vd+JXSn5jgLdREiNw09L
         uEvVQt1G5GLoeJvaDTghbY9Bx34q6ZLNix89UNSapCque8i4gK962vc2MkjdGMCcbh
         MCau7d6NV8bTA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1a9db19d663so2819585fac.3;
        Sun, 25 Jun 2023 19:50:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDzkT1+eCkvnUMzL96Dwd2vGd9gg9LiKUAETicDlxgJ8lGeOBdGe
        6sVjHHK63Fz6kK0786QAznrg+IeLETLenr82tRk=
X-Google-Smtp-Source: ACHHUZ64BoH0H2lITDuAHu8T7yKCEE8UlOKVHDyztK+8Z2dzH3Mm+GfSysrnQqCvGf8a5tK7J0rAzDKK1aKsjhO+CoE=
X-Received: by 2002:a05:6870:a415:b0:1b0:2c27:c958 with SMTP id
 m21-20020a056870a41500b001b02c27c958mr3283146oal.17.1687747827327; Sun, 25
 Jun 2023 19:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230625140630.2134298-1-masahiroy@kernel.org>
In-Reply-To: <20230625140630.2134298-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Jun 2023 11:49:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=Sy+cGphfrwOeaft7zPaQyzJopJ4MmLZ3pgQBd2QmzA@mail.gmail.com>
Message-ID: <CAK7LNAT=Sy+cGphfrwOeaft7zPaQyzJopJ4MmLZ3pgQBd2QmzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kbuild: unexport abs_srctree and abs_objtree
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 11:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> 'make rpm-pkg' builds the kernel in rpmbuild/BUILD, but $(abs_srctree)
> and $(abs_objtree) point to the directory path where make was started,
> not the kernel is actually being built. Fix it.
>
> In hindsight, there was no need to export abs_srctree and abs_objtree.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Tools Makefiles rely on abs_*.
I will keep them exported. Sigh.





--=20
Best Regards
Masahiro Yamada
