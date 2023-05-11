Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AF6FF7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjEKQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjEKQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65E7DA2;
        Thu, 11 May 2023 09:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6861D64F66;
        Thu, 11 May 2023 16:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF92BC4339E;
        Thu, 11 May 2023 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683824174;
        bh=NZQLRkpXPjDrV/tefkxQb8D2zb/ave42qpwXAWM3fyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SN/saX5/pXzqvrg3+YjPBjv1P2clQC94+8bNzYzcVA874LRMeOqDxUFbvGkWF9lYV
         l8FB4HbhP9mGzUgQ1jnlrKzIZrOk2g4O51ENv+59DXyJF/npRKBH5oVuDS0GZCYnXL
         FAmlW15Ueh0QyWxsN3GjiVvliPFahkk8iYS83QRSftK5QY1nM4dq96h4NT3fKFevVJ
         P5fq8cqL4Tm9S36w6PAOy84/rrtStLsrKwweD8LGS3LWXfUXs0IZwM8Rhzw2DqWik5
         0/kekym8PuRO9rGEPCaV5zUzxGZNDPDxgoNTkLujtKKWuSz5AkrEnI80mnEl6303ic
         RbhaY6SQe9C5A==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-54f846d251fso2331491eaf.3;
        Thu, 11 May 2023 09:56:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDw+wscbmcggx2sZGx0tKPI+r1a3565lBxCy5SE71DtiE5VMIvw9
        vh6B6QF/MZJPgxI51BfsJr7qpx6KmiI2ZjhAq1I=
X-Google-Smtp-Source: ACHHUZ7IivoF9ANMjM/WWUxmVCzwp5Ug26/ne44DqjZkkhIM5GfmHPOgqkpE/ZfAc9yuUqBN0rzr6POviRlblz3w4EU=
X-Received: by 2002:a4a:3042:0:b0:541:f986:637f with SMTP id
 z2-20020a4a3042000000b00541f986637fmr4566821ooz.8.1683824174123; Thu, 11 May
 2023 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230511043852.25803-1-bagasdotme@gmail.com>
In-Reply-To: <20230511043852.25803-1-bagasdotme@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 12 May 2023 01:55:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
Message-ID: <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: module-signing: Mention
 default_x509.genkey template
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
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

On Thu, May 11, 2023 at 1:39=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
> adds default x509 keypair config file template, but forgets to mention
> it in kernel module signing documentation.

What did it forget?

The current documentation looks fine to me.







> Update the doc accordingly.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/module-signing.rst | 41 ++++++++------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation=
/admin-guide/module-signing.rst
> index 7d7c7c8a545ca6..365d60a6245f17 100644
> --- a/Documentation/admin-guide/module-signing.rst
> +++ b/Documentation/admin-guide/module-signing.rst
> @@ -133,46 +133,39 @@ kernel so that it can be used to check the signatur=
es as the modules are
>  loaded.
>
>  Under normal conditions, when ``CONFIG_MODULE_SIG_KEY`` is unchanged fro=
m its
> -default, the kernel build will automatically generate a new keypair usin=
g
> -openssl if one does not exist in the file::
> -
> -       certs/signing_key.pem
> -
> +default, the kernel build will automatically generate a new keypair in
> +``certs/signing_key.pem`` using openssl if it doesn't exist,
>  during the building of vmlinux (the public part of the key needs to be b=
uilt
> -into vmlinux) using parameters in the::
> -
> -       certs/x509.genkey
> -
> +into vmlinux) using parameters in the ``certs/x509.genkey`` configuratio=
n
>  file (which is also generated if it does not already exist).
>
> -It is strongly recommended that you provide your own x509.genkey file.
> -
> -Most notably, in the x509.genkey file, the req_distinguished_name sectio=
n
> -should be altered from the default::
> +If you'd like to provide alternative configuration, copy
> +``certs/default_x509.genkey`` to ``certs/x509.genkey`` and edit the copy
> +instead. Most likely, you will want to edit the ``req_distinguished_name=
``
> +section, which identifies the resulting keypair. For example::
>
>         [ req_distinguished_name ]
> -       #O =3D Unspecified company
> -       CN =3D Build time autogenerated kernel key
> -       #emailAddress =3D unspecified.user@unspecified.company
> +       O =3D Example company
> +       CN =3D Example kernel build
> +       emailAddress =3D user@example.com
>
>  The generated RSA key size can also be set with::
>
>         [ req ]
>         default_bits =3D 4096
>
> -
> -It is also possible to manually generate the key private/public files us=
ing the
> -x509.genkey key generation configuration file in the root node of the Li=
nux
> -kernel sources tree and the openssl command.  The following is an exampl=
e to
> -generate the public/private key files::
> +Optionally, you can also manually generate the keypair so that the same
> +keypair can be used in multiple builds. To generate it::
>
>         openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
>            -config x509.genkey -outform PEM -out kernel_key.pem \
>            -keyout kernel_key.pem
>
> -The full pathname for the resulting kernel_key.pem file can then be spec=
ified
> -in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key the=
rein will
> -be used instead of an autogenerated keypair.
> +See :manpage:`openssl-req(1)` for the explanation.
> +
> +The full pathname for the resulting ``kernel_key.pem`` file can then be
> +specified in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate a=
nd key
> +therein will be used instead of an autogenerated keypair.
>
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> base-commit: ac9a78681b921877518763ba0e89202254349d1b
> --
> An old man doll... just what I always wanted! - Clara
>


--
Best Regards
Masahiro Yamada
