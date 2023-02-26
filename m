Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0396A2ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 09:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBZIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 03:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBZICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 03:02:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E577558C;
        Sun, 26 Feb 2023 00:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD026B80B6B;
        Sun, 26 Feb 2023 08:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AC4C433D2;
        Sun, 26 Feb 2023 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677398571;
        bh=OrzqlWOQcfQnlqFbe3GMPRvRARjlyE9lBCtiY1b4Zxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+gUhwjMepAn6I/5BW0BbqQg9HGh4rZjQS+ogOsJRwxq/Zg5Z+JxTh/BN3c9hB/od
         XMfgFaaOXgDABQF5KPVDWCYhh4EmfftzWLPH+UhoLmZnfPNkcsj1sik++9KNyu1VmA
         GuvQiask+OL7m/oVySCV5qjY6WJ4W4MT6emBBrh8vQUP5Afk49PeD6zsonnAF0gwVt
         JU/9hCB4Jaq+eiS/KrFsNke3CnDtoDw6j1do3huwpDfuFyseUD7AXGANyLTcu9TiVy
         NhP4vzFR7BLFd4tezkstfmTQcVmHoIj8BS6VoOyuSzYexU1R55M+Phtv/PUAd44n/7
         nR0Ol7TqDi8YA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-172334d5c8aso4482046fac.8;
        Sun, 26 Feb 2023 00:02:51 -0800 (PST)
X-Gm-Message-State: AO0yUKWFpVOvyTDdr0gdudDHPY9r3KymvovNLcFRj17ArpSqCkFZCRGJ
        8Tmzi1SY5D/JndV+v68/HnpLilJQvFraIaZbEdU=
X-Google-Smtp-Source: AK7set9X+iE7Z8FCwtROlejJhdk9qupobf0BdRTu6l0ae11qbiY+ZF7MOdKkzqpqYMN1lhjsmw1B/n/fEPjbr/xknR0=
X-Received: by 2002:a05:6871:6b97:b0:16e:2f74:e5c1 with SMTP id
 zh23-20020a0568716b9700b0016e2f74e5c1mr1828465oab.8.1677398570942; Sun, 26
 Feb 2023 00:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20230219142327.2309518-1-masahiroy@kernel.org>
In-Reply-To: <20230219142327.2309518-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Feb 2023 17:02:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPE6KWA-g0t3gD1vfFYqZL0pcy=e_tFa09Ns5j5pkqkg@mail.gmail.com>
Message-ID: <CAK7LNASPE6KWA-g0t3gD1vfFYqZL0pcy=e_tFa09Ns5j5pkqkg@mail.gmail.com>
Subject: Re: [PATCH v3] .gitattributes: use 'dts' diff driver for *.dtso files
To:     linux-kbuild@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 11:23=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Now we have the third extension for DT source files (overlay).
> Give the diff=3Ddts attribute to *.dtso as well.
>
> While I was here, I merged *.c and *.o into *.[ch] and added the
> SPDX-License-Identifier.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v3:
>   - Add SPDX-License-Identifier
>
> Changes in v2:
>   - Slightly shorten the code
>
>  .gitattributes | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index 4b32eaa9571e..c9ba5bfc4036 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,4 +1,4 @@
> -*.c   diff=3Dcpp
> -*.h   diff=3Dcpp
> -*.dtsi diff=3Ddts
> -*.dts  diff=3Ddts
> +# SPDX-License-Identifier: GPL-2.0-only
> +*.[ch] diff=3Dcpp
> +*.dts diff=3Ddts
> +*.dts[io] diff=3Ddts
> --
> 2.34.1
>

Applied to linux-kbuild.


--=20
Best Regards
Masahiro Yamada
