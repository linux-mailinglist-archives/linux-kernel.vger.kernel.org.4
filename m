Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D616D2DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjDACvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 22:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjDACvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 22:51:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924511E82;
        Fri, 31 Mar 2023 19:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F08B9B832B2;
        Sat,  1 Apr 2023 02:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D99CC433EF;
        Sat,  1 Apr 2023 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680317507;
        bh=ZJGSXjvvnz5W52E3CrV9StYn5zk+nNKPLbd9LzSV5kQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OEdgHiHGSYrvK78dI33PrrjoiBdkSdqy9d8v76n1X+jJzRRXZaRGih2g7otw1SBqm
         qYcTIstp5C405BsXkXGZzcE6hbSnWAFlezWP+wke+3BZrBqnhhb5JY8WN2dIAQEtUf
         9z0KdXBFHeYoY+l9jPqYis/e0VisTd1GIyvApmbgc61ZLpOicYmM+BpJaiA6kLP0I5
         OQFgqnYqaxF+h0KITCM9COzAwbFeyZx1kmQo3KO3fn4JieSmROECRgb8Wac0cwAO6r
         ZzzoCyFFd1mNQ5wAeTNNqKARdAf6mOuTWNduOlHUT767K9TjztMnljZgANYh/8B+md
         0tidlbTEz414Q==
Received: by mail-ed1-f42.google.com with SMTP id ew6so96933815edb.7;
        Fri, 31 Mar 2023 19:51:46 -0700 (PDT)
X-Gm-Message-State: AAQBX9c99BQYvtZwA0KlgW4+vTI3fM7aA7sZjzwiJX84buUCfakkaBtC
        wlcfPAzL6mbIiy6xq+mTRkDlQCdMb6ZSjLlmDEw=
X-Google-Smtp-Source: AKy350ZJfD8TE3sQxeFgTGPTpSByp8FZdipz5S9Q4l/zmHf3Kg16Xy5RgG1cDJLdtWRBifM9WIi4bkR9hcJkOA3FfNk=
X-Received: by 2002:a50:8d57:0:b0:502:4a93:9c51 with SMTP id
 t23-20020a508d57000000b005024a939c51mr8890460edt.5.1680317504640; Fri, 31 Mar
 2023 19:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230330110710.20784-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230330110710.20784-1-lukas.bulwahn@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 31 Mar 2023 22:51:33 -0400
X-Gmail-Original-Message-ID: <CAJF2gTSYJAK5X1=4HfjhL25P2cp-_jOMtW4h3=1GWJVDvZeh8w@mail.gmail.com>
Message-ID: <CAJF2gTSYJAK5X1=4HfjhL25P2cp-_jOMtW4h3=1GWJVDvZeh8w@mail.gmail.com>
Subject: Re: [PATCH] csky: remove obsolete config CPU_TLB_SIZE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-csky@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, got it.

On Thu, Mar 30, 2023 at 7:07=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> Commit 9d35dc3006a9 ("csky: Revert mmu ASID mechanism") removes the only
> use of CONFIG_CPU_TLB_SIZE. Since then, this config has no effect and can
> be deleted.
>
> Remove the obsolete config CPU_TLB_SIZE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/csky/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index dba02da6fa34..1fb5f066a885 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -166,11 +166,6 @@ config STACKTRACE_SUPPORT
>  config TIME_LOW_RES
>         def_bool y
>
> -config CPU_TLB_SIZE
> -       int
> -       default "128"   if (CPU_CK610 || CPU_CK807 || CPU_CK810)
> -       default "1024"  if (CPU_CK860)
> -
>  config CPU_ASID_BITS
>         int
>         default "8"     if (CPU_CK610 || CPU_CK807 || CPU_CK810)
> --
> 2.17.1
>


--=20
Best Regards
 Guo Ren
