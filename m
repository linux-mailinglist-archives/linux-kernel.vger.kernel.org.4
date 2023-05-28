Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5B713848
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjE1HPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1HPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82BBE;
        Sun, 28 May 2023 00:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717E260B80;
        Sun, 28 May 2023 07:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BF1C433EF;
        Sun, 28 May 2023 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685258139;
        bh=5qI998XzfgTHQuwlw+Bc+sZsqM645GVdIQVNWS3s+Kg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MOt7u3n7lct+f1RJfh7qpbhvPBvjFRDo+6jfXv9SIdVi2+pQCE0XQyz7CQD9/qUmu
         RQDpflFT6xVmavMIws7MoU/L3tB48eXBbrmIf1Ow2vTlaiI4ysNhP+ukGySfpPKVUj
         3yURSNrtJesgZPKgop5GiuONmerzb4d3z4nvsDVjKuuISG1N1pPNINd052rIt8I4jT
         oMRdgn+8YwzBwvH1fR6/2p1jWQevyCZFX+opFfWRodas4kKamvfsNjL+i17Ae7VgpV
         aKDp/wWLh+p5Nt/JJ1e9wA2WKDyPEjz6ZVfGwvbqFI25tkMlNAGJg3vj2KgyVhRSYQ
         SHgOCjO76b8Eg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-546ee6030e5so1172775eaf.3;
        Sun, 28 May 2023 00:15:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDz8allxTYD3s5CWGSSXh/2HxHCedNHuHmQ8UfLIMT726/p258sK
        cCerzPPNx1+5myjf+DPVDs2UqnfqM/VMFtSz8hU=
X-Google-Smtp-Source: ACHHUZ5KtZXJGwpV3hx7dCR9Pb9YWmLd7EEyuntC+aXh5sdiNWNkE/AgxVa/c4QG+BYI6uDh/5yoMfe9w3h43qGpaBE=
X-Received: by 2002:a4a:3342:0:b0:54c:723b:36a8 with SMTP id
 q63-20020a4a3342000000b0054c723b36a8mr1785502ooq.4.1685258139095; Sun, 28 May
 2023 00:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230521132336.1279523-1-masahiroy@kernel.org>
 <20230521132336.1279523-2-masahiroy@kernel.org> <ZG5vvdlO8sTbqP4U@bergen.fjasle.eu>
In-Reply-To: <ZG5vvdlO8sTbqP4U@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 May 2023 16:15:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmJrWnV3+z-RE4W57M9tVrd6EwsyA2T07CF8jT3ePS5w@mail.gmail.com>
Message-ID: <CAK7LNASmJrWnV3+z-RE4W57M9tVrd6EwsyA2T07CF8jT3ePS5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Add tar requirement to changes.rst
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Thu, May 25, 2023 at 5:13=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sun 21 May 2023 22:23:36 GMT, Masahiro Yamada wrote:
> > tar is used to build the kernel with CONFIG_IKHEADERS.
> >
> > GNU tar 1.28 or later is required.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Documentation/process/changes.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/=
changes.rst
> > index a9ef00509c9b..3c0074214d75 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl versi=
on
> >  bc                     1.06.95          bc --version
> >  Sphinx\ [#f1]_         1.7              sphinx-build --version
> >  cpio                   any              cpio --version
> > +GNU tar                1.28             tar --version
> >  gtags (optional)       6.6.5            gtags --version
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > @@ -175,6 +176,12 @@ You will need openssl to build kernels 3.7 and hig=
her if module signing is
> >  enabled.  You will also need openssl development packages to build ker=
nels 4.3
> >  and higher.
> >
> > +Tar
> > +---
> > +
> > +GNU tar is needed if you want to enable access to the kernel headers v=
ia sysfs
> > +(CONFIG_IKHEADERS).
>
> CONFIG_IKHEADERS does also require 'xz' (cp. kernel/gen_kheaders.sh),
> should it be mentioned in changes.rst as well?


It is true, bue 'xz' is required in other situations too.

For example,
CONFIG_KERNEL_XZ
CONFIG_MODULE_COMPRESS_XZ
CONFIG_INITRAMFS_COMPRESSION_XZ


If we document the requirement for 'xz',
we need to document the requirement for
'gzip', 'zstd', 'lzma', etc. for the same reason.

So, I want to go only with 'tar' in this series.






> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
>
> > +
> >  gtags / GNU GLOBAL (optional)
> >  -----------------------------
> >
> > --
> > 2.39.2
>
> --
> Nicolas Schier
>
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
