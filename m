Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0B65FE24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjAFJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjAFJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:39:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C243E6A;
        Fri,  6 Jan 2023 01:31:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk16so733011wrb.11;
        Fri, 06 Jan 2023 01:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th0WEGaeBwuDgYUOSMw9cNMnaXqVuZ+hnr9Z3HPgsnM=;
        b=P4h1nCH0pNXiBh97+05WMCCCnvwVd+8Qh+qHWdt1XOsIvPsTIN0gDOv2ElSVJbpQtZ
         iTdW/+Nq9eQl0f42F355euMRrZjwsE8nmdAQRXaVRsEdeqE2DAOa0Knnbe9xH0fHG3nJ
         p9jp3CGQYctIYOjq/CprJVeVqL7M8iLfNh4W34JBFu64O7yH0FzAW0dXdSLCAl2CGoLS
         xqcn5wBkgx/Cms+7GNI7mwmjSCMtuC6mtc69nZkB8J+Drfu3ru7eew11rx2M+vVjtZks
         jQXATSqYyaYguuYnDDSjWaLSklo/pdCK1RdJkZHOvBx9FlXqvYIM1+03RaQp32sco2pU
         h6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=th0WEGaeBwuDgYUOSMw9cNMnaXqVuZ+hnr9Z3HPgsnM=;
        b=Utyiwl/aBq1cbnir5oTbyw0jHlNu17lwg29DMxCYr47WJWrE3nmMXN/Vn4l6MuwMhh
         21TFuAHeHozzFAD9xOrCRadl++wVnrEXNJ/TRw5wN03HNoVkIpKLAZOB4rSDBmFeQP8D
         IF1o5v5CBMw8Zp7C7FpeJJejIik1eMc34MjLi2K3BPYWJkayqNsTafBGs9ECDK5xgnN8
         Vki9bKsI6O7VwvcqrSjVnXke+4t8BXV6Wq/wG9qBT3h+O9AE9CTQ2BNqpRsBE3MhOqzd
         tjCxGZSnEOJFLUAQuh5OmcdVe/L10OVGgkXqW7YKcPjojaIIIBN/WQhY2zoZQyd6fSfX
         atAg==
X-Gm-Message-State: AFqh2krNIoZKmhrekrm/bZ+E6Yqj/Qe5Vx6+mW9BynLMAC3yBV9LUynu
        8qZHY02K2sNr9uPslZRSzy8=
X-Google-Smtp-Source: AMrXdXtXQ/FBBWfKI4DSehNmTv8LCHGOsZk2Do1P/FMzAL8FrZnsXAj3VoTqLGE6YNTj+kSS9U7kVg==
X-Received: by 2002:a5d:4950:0:b0:26e:7604:6575 with SMTP id r16-20020a5d4950000000b0026e76046575mr31432386wrs.65.1672997512513;
        Fri, 06 Jan 2023 01:31:52 -0800 (PST)
Received: from localhost ([217.138.219.182])
        by smtp.gmail.com with ESMTPSA id bj27-20020a0560001e1b00b0023659925b2asm659623wrb.51.2023.01.06.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:31:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 06 Jan 2023 10:31:49 +0100
Message-Id: <CPL04DQZPZ6P.1XLQFWLE9CISR@vincent>
Cc:     <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 5/6] fixdep: avoid parsing the same file over again
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20221231064203.1623793-1-masahiroy@kernel.org>
 <20221231064203.1623793-6-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-6-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

On Sat Dec 31, 2022 at 7:42 AM CET, Masahiro Yamada wrote:
> The dep files (*.d files) emitted by C compilers usually contain the
> deduplicated list of included files.
>
> There is an exceptional case; if a header is included by the -include
> command line option, and also by #include directive, it appears twice
> in the *.d file.
>
> For example, the top Makefile specifies the command line option,
> -include $(srctree)/include/linux/kconfig.h. You do not need to
> add #include <linux/kconfig.h> in every source file.
>
> In fact, include/linux/kconfig.h is listed twice in many .*.cmd files
> due to include/linux/xarray.h including <linux/kconfig.h>.
> I did not fix that since it is a small redundancy.
>
> However, this is more annoying for rustc. rustc emits the dependency
> for each emission type.
>
> For example, cmd_rustc_library emits dep-info, obj, and metadata.
> So, the emitted *.d file contains the dependency for those 3 targets,
> which makes fixdep parse the same file 3 times.
>
>   $ grep rust/alloc/raw_vec.rs rust/.alloc.o.cmd
>     rust/alloc/raw_vec.rs \
>     rust/alloc/raw_vec.rs \
>     rust/alloc/raw_vec.rs \
>
> To skip the second parsing, this commit adds a hash table for parsed
> files, just like we did for CONFIG options.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/basic/fixdep.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> index b20777b888d7..cc8f6d34c2ca 100644
> --- a/scripts/basic/fixdep.c
> +++ b/scripts/basic/fixdep.c
> @@ -113,7 +113,7 @@ struct item {
>  };
> =20
>  #define HASHSZ 256
> -static struct item *config_hashtab[HASHSZ];
> +static struct item *config_hashtab[HASHSZ], *file_hashtab[HASHSZ];
> =20
>  static unsigned int strhash(const char *str, unsigned int sz)
>  {
> @@ -361,6 +361,10 @@ static void parse_dep_file(char *p, const char *targ=
et)
>  			 * name, which will be the original one, and ignore any
>  			 * other source names, which will be intermediate
>  			 * temporary files.
> +			 *
> +			 * rustc emits the same dependency list for each
> +			 * emission type. It is enough to list the source name
> +			 * just once.
>  			 */
>  			if (!saw_any_target) {
>  				saw_any_target =3D true;
> @@ -368,7 +372,8 @@ static void parse_dep_file(char *p, const char *targe=
t)
>  				printf("deps_%s :=3D \\\n", target);
>  				need_parse =3D true;
>  			}
> -		} else if (!is_ignored_file(p, q - p)) {
> +		} else if (!is_ignored_file(p, q - p) &&
> +			   !in_hashtable(p, q - p, file_hashtab)) {
>  			printf("  %s \\\n", p);
>  			need_parse =3D true;
>  		}
> --=20
> 2.34.1

