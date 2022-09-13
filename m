Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89965B6841
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIMG60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIMG6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:58:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400961C91C;
        Mon, 12 Sep 2022 23:58:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 198so11206746ybc.1;
        Mon, 12 Sep 2022 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LnmTmf+fuhPnF4eBYNnq2sxPqPnDopgZi1nGrmjVkXE=;
        b=RpxTl9YAxT0hmdQQ/88LOuX0P8NDm5fDvdsTNZ8Ph8Me/rFAu+zrBp4rZDmMiso09q
         eXcEQdIV6OuQzspB5Iul4Df8/+HzYCiVJ2DUHLIFEi87z/vLQ8liACLIHPL3tgJKEGu1
         al2+k7gGEhjXqEOWrpdq/L4G67Hs4SeKkjoFGo0Hur9PQ+XSFtzW73nDBZHMFfy6c7oi
         mMHRgeUUZ99V1N5qnIl9v9d4UOKH7JSFMDZ+BzTadazSrZcgXp7DQoQprZt/P2dEIMaK
         xpEMp/5P8GTcas9brGLRMHpUcz49oKbDN1jvGOhvWRy05GySh+OZghDvg3jvBAtjyWlG
         +OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LnmTmf+fuhPnF4eBYNnq2sxPqPnDopgZi1nGrmjVkXE=;
        b=t8jQsd1j/NUiw69ECOGWdLwOpExReZJuEi2Txrr/CiabZGVC6xKiG/7H/SFVGIljly
         BIuLzjhP4Bnw8OS12wGGPssbtLKjlJzZc0KQZeRbpqSpwbaRJ/sttObTcDmDEzzWvJ+T
         IaMg4cqBs4HcGaF8q2Ux8HSVrXEFzfHy0+uG9PosxEAjk1riMTxqmZdAMBNmBpXMd5iI
         +7SlZwUYIsN0Pq+o5bAkELrpxX+WCSFcmo9JgerOb8b0RmwY2XeRC5ZRj6DFd/B9R7RV
         p8TJf+ZiGqRjWYEA7towWCVbsL6mxFdinHQfhvAYK9l4gc/bRTbSqfB0fErTmelgCmHq
         DsSw==
X-Gm-Message-State: ACgBeo2OrYuDq8+S16hKRs/QVmmwgxDNJxQub1MwfdFkWU5uK942rCgE
        lIv58ggHdcEEHcRADhbmid9J70sMCT9FEitnAS0=
X-Google-Smtp-Source: AA6agR7NVdwxrFoKGJ1c2pNSCZsntIDW4rRvtp04Yoh0vZfjUJJ1RYWshtDEmXYoBn7PCSRZppqiH0viY8GCZsvaYi8=
X-Received: by 2002:a05:6902:89:b0:695:7ed0:d8cb with SMTP id
 h9-20020a056902008900b006957ed0d8cbmr24844042ybs.77.1663052301393; Mon, 12
 Sep 2022 23:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220910083835.2219239-1-niklas.soderlund@corigine.com>
In-Reply-To: <20220910083835.2219239-1-niklas.soderlund@corigine.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 13 Sep 2022 08:58:10 +0200
Message-ID: <CAKXUXMxbd9C832uq955tf1GoXO9+ckvpV84MB5=veQFzywen9Q@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch: warn for non-standard fixes tag style
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 10:38 AM Niklas S=C3=B6derlund
<niklas.soderlund@corigine.com> wrote:
>
> Add a warning for fixes tags that does not fall in line with the
> standards specified by the community.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Louis Peens <louis.peens@corigine.com>
> ---
> * Changes since v5
> - Add support for --fix option for checkpatch.pl.
>
> * Changes since v4
> - Extend test to cover lines with whitespace before the fixes: tag, e.g.
>   match check on /^\s*fixes:?/i.
>
> * Changes since v3
> - Add test that title in tag match title of commit referenced by sha1.
>
> * Changes since v2
> - Change the pattern to match on 'fixes:?' to catch more malformed
>   tags.
>
> * Changes since v1
> - Update the documentation wording and add mention one cause of the
>   message can be that email program splits the tag over multiple lines.
> ---
>  Documentation/dev-tools/checkpatch.rst |  8 +++++
>  scripts/checkpatch.pl                  | 43 ++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index b52452bc2963..8c8456a3bd18 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -612,6 +612,14 @@ Commit message
>
>      See: https://www.kernel.org/doc/html/latest/process/submitting-patch=
es.html#describe-your-changes
>
> +  **BAD_FIXES_TAG**
> +    The Fixes: tag is malformed or does not fall in line with the standa=
rds
> +    specified by the community. This can occur if the tag have been spli=
t into
> +    multiple lines (e.g., when pasted in email program with word wrappin=
g
> +    enabled).
> +
> +    See: https://www.kernel.org/doc/html/latest/process/submitting-patch=
es.html#describe-your-changes
> +

Thanks for all the work on checkpatch here!

Just three nits:

does not fall in line with ~~> how about "is not aligned with" or
"does not follow"?

"specified" and "standards" is a "big" word. Let us be more brief and
avoid "specification" and "standard".

"standards specified by the community" ~> "community standards", maybe
even "community conventions"?

"when pasted in email program" ~> "when pasted in an email program"

Maybe you also add a sentence on word wrapping of Fixes: tags, such as:

Note that the Fixes: tag line shall not be wrapped.

Nevertheless, for the documentation part:
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

>
>  Comparison style
>  ----------------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 79e759aac543..77f577535fc3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3140,6 +3140,49 @@ sub process {
>                         }
>                 }
>
> +# Check Fixes: styles is correct
> +               if (!$in_header_lines && $line =3D~ /^\s*fixes:?/i) {
> +                       my $orig_commit =3D "";
> +                       my $id =3D "0123456789ab";
> +                       my $title =3D "commit title";
> +                       my $tag_case =3D 1;
> +                       my $tag_space =3D 1;
> +                       my $id_length =3D 1;
> +                       my $id_case =3D 1;
> +                       my $title_has_quotes =3D 0;
> +
> +                       if ($line =3D~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+(=
$balanced_parens)/i) {
> +                               my $tag =3D $1;
> +                               $orig_commit =3D $2;
> +                               $title =3D $3;
> +
> +                               $tag_case =3D 0 if $tag eq "Fixes:";
> +                               $tag_space =3D 0 if ($line =3D~ /^fixes:?=
 [0-9a-f]{5,} ($balanced_parens)/i);
> +
> +                               $id_length =3D 0 if ($orig_commit =3D~ /^=
[0-9a-f]{12}$/i);
> +                               $id_case =3D 0 if ($orig_commit !~ /[A-F]=
/);
> +
> +                               # Always strip leading/trailing parens th=
en double quotes if existing
> +                               $title =3D substr($title, 1, -1);
> +                               if ($title =3D~ /^".*"$/) {
> +                                       $title =3D substr($title, 1, -1);
> +                                       $title_has_quotes =3D 1;
> +                               }
> +                       }
> +
> +                       my ($cid, $ctitle) =3D git_commit_info($orig_comm=
it, $id,
> +                                                            $title);
> +
> +                       if ($ctitle ne $title || $tag_case || $tag_space =
||
> +                           $id_length || $id_case || !$title_has_quotes)=
 {
> +                               if (WARN("BAD_FIXES_TAG",
> +                                    "Please use correct Fixes: style 'Fi=
xes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\"=
)'\n" . $herecurr) &&
> +                                   $fix) {
> +                                       $fixed[$fixlinenr] =3D "Fixes: $c=
id (\"$ctitle\")";
> +                               }
> +                       }
> +               }
> +
>  # Check email subject for common tools that don't need to be mentioned
>                 if ($in_header_lines &&
>                     $line =3D~ /^Subject:.*\b(?:checkpatch|sparse|smatch)=
\b[^:]/i) {
> --
> 2.37.3
>
