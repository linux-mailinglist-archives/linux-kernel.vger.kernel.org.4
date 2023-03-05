Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979BF6AAE69
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 07:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCEGUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 01:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 01:20:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B1168A3;
        Sat,  4 Mar 2023 22:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A0B60AB2;
        Sun,  5 Mar 2023 06:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7651AC433AE;
        Sun,  5 Mar 2023 06:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677997250;
        bh=NXUx35r8E2F5/ovSer3FHXGfQg1/8K2vxVgkKH2WPdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ul2SFKnxMh2EQbC251FQx40O1RZEJmSLMNVDAiC8CDYXTRemiQhFeFQwHk6R7BeL3
         d8VapBMez/6GsdrEHxtB0wZre5f4RjIBWPYUskQjf1B23/9H7C6CAwBycWNgvvCCeM
         fKifQUTceuir/A56T6ipQz/JaPwY3vVd4YtU3fej/ZVt5dlrLCCnjS0bK9ReMgixoZ
         bmHHp5uhYmYrbYYDEI/QLuqL78yUOVAoTzicnzwGXjLsK07AjI+yBCZePfq9/xZiGW
         DG69PW4M0IrID5XUoZcQnePJMfNzLw9Efw3/0ZnfP/YjvxLuRfQOGnHktFno6aZios
         y7zNsfSZ/7WCw==
Received: by mail-oi1-f173.google.com with SMTP id e21so4843777oie.1;
        Sat, 04 Mar 2023 22:20:50 -0800 (PST)
X-Gm-Message-State: AO0yUKUGJBxSXnVnBJktjWYN6UVf+/vtUO7FNPgTr6NwnaRV9phAr7M4
        aXERPtG2XT321ntGmwDxgwZwyGrG8lyrBx3RgPY=
X-Google-Smtp-Source: AK7set/p8ALnhWz6u0J/k9USI6xuZBnEzTTyCo33EYtP2sBmWcza7zH4UDMaAGyHPcqfn6v1LTrLRK+yqJ/w6l5lt7I=
X-Received: by 2002:a05:6808:8d7:b0:384:65af:e554 with SMTP id
 k23-20020a05680808d700b0038465afe554mr2166536oij.1.1677997249545; Sat, 04 Mar
 2023 22:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20230301075402.4578-1-quic_johmoo@quicinc.com> <20230301075402.4578-3-quic_johmoo@quicinc.com>
In-Reply-To: <20230301075402.4578-3-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Mar 2023 15:20:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUgr0rrJv8ZvPKfyC8zZ1XX-Wv2Npw4iJXDGor=HSKyQ@mail.gmail.com>
Message-ID: <CAK7LNAQUgr0rrJv8ZvPKfyC8zZ1XX-Wv2Npw4iJXDGor=HSKyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: dev-tools: Add UAPI checker documentation
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 4:54=E2=80=AFPM John Moon <quic_johmoo@quicinc.com> =
wrote:
>
> Add detailed documentation for scripts/check-uapi.sh.
> ---
>  Documentation/dev-tools/checkuapi.rst | 258 ++++++++++++++++++++++++++
>  Documentation/dev-tools/index.rst     |   1 +
>  2 files changed, 259 insertions(+)
>  create mode 100644 Documentation/dev-tools/checkuapi.rst
>
> diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-to=
ols/checkuapi.rst
> new file mode 100644
> index 000000000000..2255066658e3
> --- /dev/null
> +++ b/Documentation/dev-tools/checkuapi.rst
> @@ -0,0 +1,258 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +UAPI Checker
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The UAPI checker (scripts/check-uapi.sh) is a shell script which checks =
UAPI
> +header files for userspace backwards-compatibility across the git tree.
> +
> +The script can produce false positives in some cases, so developers are


and false negatives too.







--=20
Best Regards
Masahiro Yamada
