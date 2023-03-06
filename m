Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A76AC22B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCFOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCFOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:04:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5622311B;
        Mon,  6 Mar 2023 06:04:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kb15so9870639pjb.1;
        Mon, 06 Mar 2023 06:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmE0PBshmfZdu/E6MkNuaD7XgEHUima2MUEEDu+sc60=;
        b=QdmtuGzgXdvTtgfKPV2/ZNFL4O9IYpMVcVKmEvkUICrvQjA/RbRA1NSOn1jclWvcxb
         Hn2cIs2Gs+0B0V4OCsgS0RmWkJe9VPEXObW8zKGJ0p0E4sXCshO+SJS8GhtATyxz4AJL
         jEIsg5IJvbUXbPgspeo6+RASoRJv98M96ZdcGnoeNpPqro0+Fk1pO0lcKiWi/nNof7DA
         phVbPD6v8IEMbHCP3/i1i7ATFYfwC8t+ruu1R7uqbN96BU/lt/OivJh0UfIsLPUDUouq
         hjOOhUKSouZE787tkqi1aLMLtVcPfmp+uH6Te8sx7/VhzA6OdiKm9YSly9cPSUXhNYw5
         x6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmE0PBshmfZdu/E6MkNuaD7XgEHUima2MUEEDu+sc60=;
        b=ia/y8Z2gA0VDz8YAvA/MLF5c/AXKkb+d3NXwZyOjWnRoRx6DnwgY+etNqOrtUXte1k
         sxC6Q5Gy9AOjxe3tSlZDEHh0xe39bMR01oSL5sxy/0wey5z15mZO8f0hBgvczKV6vyuu
         uNt1tc9YDPsWXS/RrPwvMXXWwVtA+a7u3sjRE+kMcptNavubzllVSM/+8ibV6hFrCP/K
         zkWAOpd/NRlgQ6ZEYFmldv/XJYMhGSoK98SrR9s+n2Nni+MAKEH07DPTS634FImtIbDe
         akqHjZAzMAQrEYX2w1a320XzcMonDNWDEoWWT7Ym/RDMP/JNGX1k82ys2JM4tVM4ZE/X
         la+A==
X-Gm-Message-State: AO0yUKV+J8/TBA5k23e4nj8dlQ3S1V8NQB6RCPUbMFhGYR2/AtlYt+Lp
        TrKtGthxvSN/ArZpJGArqu8=
X-Google-Smtp-Source: AK7set978izdZiDNVD1mywDz/2TUzawpLYJofMsRvl8GGWeVUbcV8/fhK9H+48ftLQFIZmbA4P5sxw==
X-Received: by 2002:a17:902:c94b:b0:19d:553:746b with SMTP id i11-20020a170902c94b00b0019d0553746bmr13860088pla.66.1678111473755;
        Mon, 06 Mar 2023 06:04:33 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0019a60b7cc0esm6775914plg.248.2023.03.06.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:04:33 -0800 (PST)
Message-ID: <4e538f00-1337-d346-7df5-30081cb64c6f@gmail.com>
Date:   Mon, 6 Mar 2023 23:04:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/7] Documentation/security-bugs: move from
 admin-guide/ to process/
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        Minchan Kim <minchan@kernel.org>,
        Jeimi Lee <jamee.lee@samsung.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-2-vegard.nossum@oracle.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230305220010.20895-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Mar 2023 23:00:04 +0100, Vegard Nossum wrote:
> Jiri Kosina, Jonathan Corbet, and Willy Tarreau all expressed a desire
> to move this document under process/.
>=20
> Create a new section for security issues in the index and group it with=

> embargoed-hardware-issues.
>=20
> I'm doing this at the start of the series to make all the subsequent
> changes show up in 'git blame'.
>=20
> Existing references were updated using:
>=20
>   git grep -l security-bugs ':!Documentation/translations/' | xargs sed=
 -i 's|admin-guide/security-bugs|process/security-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i =
's|Documentation/admin-guide/security-bugs|Documentation/process/security=
-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i =
'/Original:/s|\.\./admin-guide/security-bugs|\.\./process/security-bugs|g=
'
>=20
> Notably, the page is not moved in the translations (due to my lack of
> knowledge of these languages), but the translations have been updated
> to point to the new location of the original document where these
> references exist.
>=20
> Link: https://lore.kernel.org/all/nycvar.YFH.7.76.2206062326230.10851@c=
bobk.fhfr.pm/
> Suggested-by: Jiri Kosina <jikos@kernel.org>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Jeimi Lee <jamee.lee@samsung.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/admin-guide/index.rst                      | 1 -
>  Documentation/admin-guide/reporting-issues.rst           | 4 ++--
>  Documentation/process/howto.rst                          | 2 +-
>  Documentation/process/index.rst                          | 9 ++++++++-=

>  Documentation/process/researcher-guidelines.rst          | 2 +-
>  Documentation/{admin-guide =3D> process}/security-bugs.rst | 0
>  Documentation/process/stable-kernel-rules.rst            | 2 +-
>  Documentation/process/submitting-patches.rst             | 2 +-
>  .../translations/it_IT/admin-guide/security-bugs.rst     | 2 +-
>  .../translations/it_IT/process/submitting-patches.rst    | 2 +-
>  Documentation/translations/ja_JP/howto.rst               | 2 +-

For ja_JP part:
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>  Documentation/translations/ko_KR/howto.rst               | 2 +-
>  Documentation/translations/sp_SP/howto.rst               | 2 +-
>  .../translations/sp_SP/process/submitting-patches.rst    | 2 +-
>  .../translations/zh_CN/admin-guide/security-bugs.rst     | 2 +-
>  Documentation/translations/zh_CN/process/howto.rst       | 2 +-
>  .../translations/zh_TW/admin-guide/security-bugs.rst     | 2 +-
>  Documentation/translations/zh_TW/process/howto.rst       | 2 +-
>  MAINTAINERS                                              | 4 ++--
>  19 files changed, 26 insertions(+), 20 deletions(-)
>  rename Documentation/{admin-guide =3D> process}/security-bugs.rst (100=
%)
>=20
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-=
guide/index.rst
> index 0ad7e7ec0d27..09a563bbe3e7 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -36,7 +36,6 @@ problems and bugs in particular.
> =20
>     reporting-issues
>     reporting-regressions
> -   security-bugs
>     bug-hunting
>     bug-bisect
>     tainted-kernels
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documenta=
tion/admin-guide/reporting-issues.rst
> index ec62151fe672..2fd5a030235a 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -395,7 +395,7 @@ might want to be aware of; it for example explains =
how to add your issue to the
>  list of tracked regressions, to ensure it won't fall through the crack=
s.
> =20
>  What qualifies as security issue is left to your judgment. Consider re=
ading
> -Documentation/admin-guide/security-bugs.rst before proceeding, as it
> +Documentation/process/security-bugs.rst before proceeding, as it
>  provides additional details how to best handle security issues.
> =20
>  An issue is a 'really severe problem' when something totally unaccepta=
bly bad
> @@ -1269,7 +1269,7 @@ them when sending the report by mail. If you file=
d it in a bug tracker, forward
>  the report's text to these addresses; but on top of it put a small not=
e where
>  you mention that you filed it with a link to the ticket.
> =20
> -See Documentation/admin-guide/security-bugs.rst for more information.
> +See Documentation/process/security-bugs.rst for more information.
> =20
> =20
>  Duties after the report went out
> diff --git a/Documentation/process/howto.rst b/Documentation/process/ho=
wto.rst
> index cb6abcb2b6d0..deb8235e20ff 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -138,7 +138,7 @@ required reading:
>      philosophy and is very important for people moving to Linux from
>      development on other Operating Systems.
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      If you feel you have found a security problem in the Linux kernel,=

>      please follow the steps in this document to help notify the kernel=

>      developers, and help solve the issue.
> diff --git a/Documentation/process/index.rst b/Documentation/process/in=
dex.rst
> index d4b6217472b0..565df595152e 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -35,6 +35,14 @@ Below are the essential guides that every developer =
should read.
>     kernel-enforcement-statement
>     kernel-driver-statement
> =20
> +For security issues, see:
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   security-bugs
> +   embargoed-hardware-issues
> +
>  Other guides to the community that are of interest to most developers =
are:
> =20
>  .. toctree::
> @@ -47,7 +55,6 @@ Other guides to the community that are of interest to=
 most developers are:
>     submit-checklist
>     kernel-docs
>     deprecated
> -   embargoed-hardware-issues
>     maintainers
>     researcher-guidelines
> =20
> diff --git a/Documentation/process/researcher-guidelines.rst b/Document=
ation/process/researcher-guidelines.rst
> index afc944e0e898..9fcfed3c350b 100644
> --- a/Documentation/process/researcher-guidelines.rst
> +++ b/Documentation/process/researcher-guidelines.rst
> @@ -68,7 +68,7 @@ Before contributing, carefully read the appropriate d=
ocumentation:
>  * Documentation/process/development-process.rst
>  * Documentation/process/submitting-patches.rst
>  * Documentation/admin-guide/reporting-issues.rst
> -* Documentation/admin-guide/security-bugs.rst
> +* Documentation/process/security-bugs.rst
> =20
>  Then send a patch (including a commit log with all the details listed
>  below) and follow up on any feedback from other developers.
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentatio=
n/process/security-bugs.rst
> similarity index 100%
> rename from Documentation/admin-guide/security-bugs.rst
> rename to Documentation/process/security-bugs.rst
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentat=
ion/process/stable-kernel-rules.rst
> index 2fd8aa593a28..51df1197d5ab 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -39,7 +39,7 @@ Procedure for submitting patches to the -stable tree
> =20
>     Security patches should not be handled (solely) by the -stable revi=
ew
>     process but should follow the procedures in
> -   :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
> +   :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
> =20
>  For all other submissions, choose one of the following procedures
>  -----------------------------------------------------------------
> diff --git a/Documentation/process/submitting-patches.rst b/Documentati=
on/process/submitting-patches.rst
> index eac7167dce83..7b223f306efa 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -254,7 +254,7 @@ If you have a patch that fixes an exploitable secur=
ity bug, send that patch
>  to security@kernel.org.  For severe bugs, a short embargo may be consi=
dered
>  to allow distributors to get the patch out to users; in such cases,
>  obviously, the patch should not be sent to any public lists. See also
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
> =20
>  Patches that fix a severe bug in a released kernel should be directed
>  toward the stable maintainers by putting a line like this::
> diff --git a/Documentation/translations/it_IT/admin-guide/security-bugs=
=2Erst b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> index 18a5822c7d9a..20994f4bfa31 100644
> --- a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> =20
> -:Original: :ref:`Documentation/admin-guide/security-bugs.rst <security=
bugs>`
> +:Original: :ref:`Documentation/process/security-bugs.rst <securitybugs=
>`
> =20
>  .. _it_securitybugs:
> =20
> diff --git a/Documentation/translations/it_IT/process/submitting-patche=
s.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
> index c2cfa0948b2b..167fce813032 100644
> --- a/Documentation/translations/it_IT/process/submitting-patches.rst
> +++ b/Documentation/translations/it_IT/process/submitting-patches.rst
> @@ -272,7 +272,7 @@ embargo potrebbe essere preso in considerazione per=
 dare il tempo alle
>  distribuzioni di prendere la patch e renderla disponibile ai loro uten=
ti;
>  in questo caso, ovviamente, la patch non dovrebbe essere inviata su al=
cuna
>  lista di discussione pubblica. Leggete anche
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
> =20
>  Patch che correggono bachi importanti su un kernel gi=C3=A0 rilasciato=
, dovrebbero
>  essere inviate ai manutentori dei kernel stabili aggiungendo la seguen=
te riga::
> diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation=
/translations/ja_JP/howto.rst
> index 9b0b3436dfcf..8d856ebe873c 100644
> --- a/Documentation/translations/ja_JP/howto.rst
> +++ b/Documentation/translations/ja_JP/howto.rst
> @@ -167,7 +167,7 @@ linux-api@vger.kernel.org =E3=81=AB=E9=80=81=E3=82=8B=
=E3=81=93=E3=81=A8=E3=82=92=E5=8B=A7=E3=82=81=E3=81=BE=E3=81=99=E3=80=82
>      =E3=81=93=E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=
=83=88=E3=81=AF Linux =E9=96=8B=E7=99=BA=E3=81=AE=E6=80=9D=E6=83=B3=E3=82=
=92=E7=90=86=E8=A7=A3=E3=81=99=E3=82=8B=E3=81=AE=E3=81=AB=E9=9D=9E=E5=B8=B8=
=E3=81=AB=E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82
>      =E3=81=9D=E3=81=97=E3=81=A6=E3=80=81=E4=BB=96=E3=81=AEOS=E3=81=A7=E3=
=81=AE=E9=96=8B=E7=99=BA=E8=80=85=E3=81=8C Linux =E3=81=AB=E7=A7=BB=E3=82=
=8B=E6=99=82=E3=81=AB=E3=81=A8=E3=81=A6=E3=82=82=E9=87=8D=E8=A6=81=E3=81=A7=
=E3=81=99=E3=80=82
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      =E3=82=82=E3=81=97 Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=
=A7=E3=82=BB=E3=82=AD=E3=83=A5=E3=83=AA=E3=83=86=E3=82=A3=E5=95=8F=E9=A1=8C=
=E3=82=92=E7=99=BA=E8=A6=8B=E3=81=97=E3=81=9F=E3=82=88=E3=81=86=E3=81=AB=E6=
=80=9D=E3=81=A3=E3=81=9F=E3=82=89=E3=80=81=E3=81=93
>      =E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=
=81=AE=E3=82=B9=E3=83=86=E3=83=83=E3=83=97=E3=81=AB=E5=BE=93=E3=81=A3=E3=81=
=A6=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=BA=E8=80=85=E3=81=AB=
=E9=80=A3=E7=B5=A1=E3=81=97=E3=80=81=E5=95=8F=E9=A1=8C=E8=A7=A3=E6=B1=BA=E3=
=82=92
>      =E6=94=AF=E6=8F=B4=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=
=81=84=E3=80=82
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation=
/translations/ko_KR/howto.rst
> index 969e91a95bb0..34f14899c155 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -157,7 +157,7 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
>      =EB=A6=AC=EB=88=85=EC=8A=A4=EB=A1=9C =EC=A0=84=ED=96=A5=ED=95=98=EB=
=8A=94 =EC=82=AC=EB=9E=8C=EB=93=A4=EC=97=90=EA=B2=8C=EB=8A=94 =EB=A7=A4=EC=
=9A=B0 =EC=A4=91=EC=9A=94=ED=95=98=EB=8B=A4.
> =20
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      =EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =EB=A6=AC=EB=88=85=EC=
=8A=A4 =EC=BB=A4=EB=84=90=EC=9D=98 =EB=B3=B4=EC=95=88 =EB=AC=B8=EC=A0=9C=EB=
=A5=BC =EB=B0=9C=EA=B2=AC=ED=96=88=EB=8B=A4=EA=B3=A0 =EC=83=9D=EA=B0=81=ED=
=95=9C=EB=8B=A4=EB=A9=B4 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EC=97=90
>      =EB=82=98=EC=98=A8 =EB=8B=A8=EA=B3=84=EC=97=90 =EB=94=B0=EB=9D=BC=EC=
=84=9C =EC=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=9E=90=EB=93=A4=EC=97=90=EA=
=B2=8C =EC=95=8C=EB=A6=AC=EA=B3=A0 =EA=B7=B8 =EB=AC=B8=EC=A0=9C=EB=A5=BC =
=ED=95=B4=EA=B2=B0=ED=95=A0 =EC=88=98 =EC=9E=88=EB=8F=84=EB=A1=9D
>      =EB=8F=84=EC=99=80 =EB=8B=AC=EB=9D=BC.
> diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation=
/translations/sp_SP/howto.rst
> index f9818d687b54..f1629738b49d 100644
> --- a/Documentation/translations/sp_SP/howto.rst
> +++ b/Documentation/translations/sp_SP/howto.rst
> @@ -135,7 +135,7 @@ de obligada lectura:
>       de Linux y es muy importante para las personas que se mudan a Lin=
ux
>       tras desarrollar otros sistemas operativos.
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      Si cree que ha encontrado un problema de seguridad en el kernel de=

>      Linux, siga los pasos de este documento para ayudar a notificar a =
los
>      desarrolladores del kernel y ayudar a resolver el problema.
> diff --git a/Documentation/translations/sp_SP/process/submitting-patche=
s.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
> index bf95ceb5e865..c2757d9ab216 100644
> --- a/Documentation/translations/sp_SP/process/submitting-patches.rst
> +++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
> @@ -276,7 +276,7 @@ parche a security@kernel.org. Para errores graves, =
se debe mantener un
>  poco de discreci=C3=B3n y permitir que los distribuidores entreguen el=
 parche a
>  los usuarios; en esos casos, obviamente, el parche no debe enviarse a
>  ninguna lista p=C3=BAblica. Revise tambi=C3=A9n
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
> =20
>  Los parches que corrigen un error grave en un kernel en uso deben diri=
girse
>  hacia los maintainers estables poniendo una l=C3=ADnea como esta::
> diff --git a/Documentation/translations/zh_CN/admin-guide/security-bugs=
=2Erst b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> index b8120391755d..d6b8f8a4e7f6 100644
> --- a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-zh_CN.rst
> =20
> -:Original: :doc:`../../../admin-guide/security-bugs`
> +:Original: :doc:`../../../process/security-bugs`
> =20
>  :=E8=AF=91=E8=80=85:
> =20
> diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Docum=
entation/translations/zh_CN/process/howto.rst
> index 10254751df6a..cc47be356dd3 100644
> --- a/Documentation/translations/zh_CN/process/howto.rst
> +++ b/Documentation/translations/zh_CN/process/howto.rst
> @@ -125,7 +125,7 @@ Linux=E5=86=85=E6=A0=B8=E4=BB=A3=E7=A0=81=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=
=82=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E5=AD=A6=E4=B9=A0=
=E5=A6=82=E4=BD=95=E4=B8=8E
>      =E8=BF=99=E7=AF=87=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E7=90=86=E8=
=A7=A3Linux=E7=9A=84=E5=BC=80=E5=8F=91=E5=93=B2=E5=AD=A6=E8=87=B3=E5=85=B3=
=E9=87=8D=E8=A6=81=E3=80=82=E5=AF=B9=E4=BA=8E=E5=B0=86=E5=BC=80=E5=8F=91=E5=
=B9=B3=E5=8F=B0=E4=BB=8E=E5=85=B6=E4=BB=96=E6=93=8D=E4=BD=9C=E7=B3=BB
>      =E7=BB=9F=E8=BD=AC=E7=A7=BB=E5=88=B0Linux=E7=9A=84=E4=BA=BA=E6=9D=A5=
=E8=AF=B4=E4=B9=9F=E5=BE=88=E9=87=8D=E8=A6=81=E3=80=82
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      =E5=A6=82=E6=9E=9C=E4=BD=A0=E8=AE=A4=E4=B8=BA=E8=87=AA=E5=B7=B1=E5=
=8F=91=E7=8E=B0=E4=BA=86Linux=E5=86=85=E6=A0=B8=E7=9A=84=E5=AE=89=E5=85=A8=
=E6=80=A7=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=B7=E6=A0=B9=E6=8D=AE=E8=BF=99=E7=
=AF=87=E6=96=87=E6=A1=A3=E4=B8=AD=E7=9A=84=E6=AD=A5=E9=AA=A4=E6=9D=A5
>      =E6=8F=90=E9=86=92=E5=85=B6=E4=BB=96=E5=86=85=E6=A0=B8=E5=BC=80=E5=
=8F=91=E8=80=85=E5=B9=B6=E5=B8=AE=E5=8A=A9=E8=A7=A3=E5=86=B3=E8=BF=99=E4=B8=
=AA=E9=97=AE=E9=A2=98=E3=80=82
> =20
> diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs=
=2Erst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> index eed260ef0c37..15f8e9005071 100644
> --- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
> @@ -2,7 +2,7 @@
> =20
>  .. include:: ../disclaimer-zh_TW.rst
> =20
> -:Original: :doc:`../../../admin-guide/security-bugs`
> +:Original: :doc:`../../../process/security-bugs`
> =20
>  :=E8=AD=AF=E8=80=85:
> =20
> diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Docum=
entation/translations/zh_TW/process/howto.rst
> index 8fb8edcaee66..ea2f468d3e58 100644
> --- a/Documentation/translations/zh_TW/process/howto.rst
> +++ b/Documentation/translations/zh_TW/process/howto.rst
> @@ -128,7 +128,7 @@ Linux=E5=85=A7=E6=A0=B8=E4=BB=A3=E7=A2=BC=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=AA=94=E3=80=
=82=E9=80=99=E4=BA=9B=E6=96=87=E6=AA=94=E5=B0=8D=E6=96=BC=E5=AD=B8=E7=BF=92=
=E5=A6=82=E4=BD=95=E8=88=87
>      =E9=80=99=E7=AF=87=E6=96=87=E6=AA=94=E5=B0=8D=E6=96=BC=E7=90=86=E8=
=A7=A3Linux=E7=9A=84=E9=96=8B=E7=99=BC=E5=93=B2=E5=AD=B8=E8=87=B3=E9=97=9C=
=E9=87=8D=E8=A6=81=E3=80=82=E5=B0=8D=E6=96=BC=E5=B0=87=E9=96=8B=E7=99=BC=E5=
=B9=B3=E5=8F=B0=E5=BE=9E=E5=85=B6=E4=BB=96=E6=93=8D=E4=BD=9C=E7=B3=BB
>      =E7=B5=B1=E8=BD=89=E7=A7=BB=E5=88=B0Linux=E7=9A=84=E4=BA=BA=E4=BE=86=
=E8=AA=AA=E4=B9=9F=E5=BE=88=E9=87=8D=E8=A6=81=E3=80=82
> =20
> -  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
> +  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
>      =E5=A6=82=E6=9E=9C=E4=BD=A0=E8=AA=8D=E7=88=B2=E8=87=AA=E5=B7=B1=E7=
=99=BC=E7=8F=BE=E4=BA=86Linux=E5=85=A7=E6=A0=B8=E7=9A=84=E5=AE=89=E5=85=A8=
=E6=80=A7=E5=95=8F=E9=A1=8C=EF=BC=8C=E8=AB=8B=E6=A0=B9=E6=93=9A=E9=80=99=E7=
=AF=87=E6=96=87=E6=AA=94=E4=B8=AD=E7=9A=84=E6=AD=A5=E9=A9=9F=E4=BE=86
>      =E6=8F=90=E9=86=92=E5=85=B6=E4=BB=96=E5=85=A7=E6=A0=B8=E9=96=8B=E7=
=99=BC=E8=80=85=E4=B8=A6=E5=B9=AB=E5=8A=A9=E8=A7=A3=E6=B1=BA=E9=80=99=E5=80=
=8B=E5=95=8F=E9=A1=8C=E3=80=82
> =20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b0db911207ba..ed84d41353a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -73,7 +73,7 @@ Tips for patch submitters
>  	and ideally, should come with a patch proposal. Please do not send
>  	automated reports to this list either. Such bugs will be handled
>  	better and faster in the usual public places. See
> -	Documentation/admin-guide/security-bugs.rst for details.
> +	Documentation/process/security-bugs.rst for details.
> =20
>  8.	Happy hacking.
> =20
> @@ -18807,7 +18807,7 @@ F:	include/uapi/linux/sed*
>  SECURITY CONTACT
>  M:	Security Officers <security@kernel.org>
>  S:	Supported
> -F:	Documentation/admin-guide/security-bugs.rst
> +F:	Documentation/process/security-bugs.rst
> =20
>  SECURITY SUBSYSTEM
>  M:	Paul Moore <paul@paul-moore.com>
