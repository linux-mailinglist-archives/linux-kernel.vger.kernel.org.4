Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554985B680E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiIMGlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIMGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:41:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC352FDE;
        Mon, 12 Sep 2022 23:41:18 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12b542cb1d3so19820731fac.13;
        Mon, 12 Sep 2022 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=6OFVncho9CWE/7b6Ak6mA3hXTMv6MBI1r90JjAcxY3U=;
        b=ZSMbJTrgUXaM3OPACB7qDY21W74tCNW+uTxAPFlof/2gE86A2+jsfVv3HHdo0WwQeE
         Uv4dHRAdm8sxBcsu4rzvuUCYwR//L0CqK4AtNG6+12d+sr5oVQNQzAgHwsqoi483lXAe
         HnAS4FRKDlEfCd78fcWOx1w1L9F+RwBFdbREqcZwxtNsH2N1X2T21lpUPhjMbHV6LzXT
         DQxuCsoKuvly1MHS8DbEtKpNTI2IiAkKExgE4JQOt5hF6ZniAA+iECJJO8lT6AlnJJvG
         ra+SLUm0hxJSCSdgtaa6mLJBwkp0FCotfMDzMYG67sgFaNs4VaxvX6VsagDqbdBeXdFN
         Fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6OFVncho9CWE/7b6Ak6mA3hXTMv6MBI1r90JjAcxY3U=;
        b=7BGy/4tcxLwW4Tm9rRotTUjLdhD/CokGSDugOycHehLkVw6vKKOJ+FDAsH0jgtfJSa
         Snv243xTHd2s9QbWazbZtkzDqf9iST1Cf/1pi4VehNPwIiSMNBF9cg3UIYGbDpxcl1Zb
         Gah3Ny6C/tJCymKVNhNdYtBFj4JpZmkx466wreRdeMhblHiAnYdiowIyx6PQxC8YWV/U
         oXNtaIWHgUock/A/sPFOmXmgThgByXg0ZSqMVol66F9Z8IOyHQ1z8ukD+2HTDwDaG5+M
         +jxrUdRbzZXaPAOVYPgJcOTokwg/C0fsJa3yD0IM5+opOMsiZ0IhAQKf5z3FfdbbRbM3
         tQLw==
X-Gm-Message-State: ACgBeo3rSamMsR8gXJu2alfX5pC54m+wcGqa3R+NgKKZ8RJ33sJubIkI
        rcLYxW4cWXkBNcT/ekYTP6pSir5FdCxqbzmK4UjAFuy+u/0=
X-Google-Smtp-Source: AA6agR7mvRq+QoTvT/Ynf9AJXfGXosxtGuG7DrU7dxVEwBaLcSV0gVemC53VszT1hP10zmX0R8MwW2OU6ipZCkxVluM=
X-Received: by 2002:a05:6808:1412:b0:342:ff44:6e5d with SMTP id
 w18-20020a056808141200b00342ff446e5dmr937736oiv.160.1663051277691; Mon, 12
 Sep 2022 23:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220910083835.2219239-1-niklas.soderlund@corigine.com> <7b2159922e989b1a5d5a3662fddb3c5ee2a97761.camel@toradex.com>
In-Reply-To: <7b2159922e989b1a5d5a3662fddb3c5ee2a97761.camel@toradex.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 13 Sep 2022 12:11:06 +0530
Message-ID: <CABJPP5CjgkOf9=uv4cqjaiOgN6iiXAy7k_RZkhTXPT_vs+Ke4g@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch: warn for non-standard fixes tag style
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 9:08 PM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> On Sat, 2022-09-10 at 10:38 +0200, Niklas S=C3=B6derlund wrote:
> > Add a warning for fixes tags that does not fall in line with the
> > standards specified by the community.
> >
> > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Reviewed-by: Louis Peens <louis.peens@corigine.com>
>
> Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
>

For the documentation part,
Acked-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Thanks.

> > ---
> > * Changes since v5
> > - Add support for --fix option for checkpatch.pl.
> >
> > * Changes since v4
> > - Extend test to cover lines with whitespace before the fixes: tag,
> > e.g.
> >   match check on /^\s*fixes:?/i.
> >
> > * Changes since v3
> > - Add test that title in tag match title of commit referenced by sha1.
> >
> > * Changes since v2
> > - Change the pattern to match on 'fixes:?' to catch more malformed
> >   tags.
> >
> > * Changes since v1
> > - Update the documentation wording and add mention one cause of the
> >   message can be that email program splits the tag over multiple
> > lines.
> > ---
> >  Documentation/dev-tools/checkpatch.rst |  8 +++++
> >  scripts/checkpatch.pl                  | 43
> > ++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/checkpatch.rst
> > b/Documentation/dev-tools/checkpatch.rst
> > index b52452bc2963..8c8456a3bd18 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -612,6 +612,14 @@ Commit message
> >
> >      See:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes
> >
> > +  **BAD_FIXES_TAG**
> > +    The Fixes: tag is malformed or does not fall in line with the
> > standards
> > +    specified by the community. This can occur if the tag have been
> > split into
> > +    multiple lines (e.g., when pasted in email program with word
> > wrapping
> > +    enabled).
> > +
> > +    See:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes
> > +
> >
> >  Comparison style
> >  ----------------
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 79e759aac543..77f577535fc3 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3140,6 +3140,49 @@ sub process {
> >                         }
> >                 }
> >
> > +# Check Fixes: styles is correct
> > +               if (!$in_header_lines && $line =3D~ /^\s*fixes:?/i) {
> > +                       my $orig_commit =3D "";
> > +                       my $id =3D "0123456789ab";
> > +                       my $title =3D "commit title";
> > +                       my $tag_case =3D 1;
> > +                       my $tag_space =3D 1;
> > +                       my $id_length =3D 1;
> > +                       my $id_case =3D 1;
> > +                       my $title_has_quotes =3D 0;
> > +
> > +                       if ($line =3D~ /(\s*fixes:?)\s+([0-9a-
> > f]{5,})\s+($balanced_parens)/i) {
> > +                               my $tag =3D $1;
> > +                               $orig_commit =3D $2;
> > +                               $title =3D $3;
> > +
> > +                               $tag_case =3D 0 if $tag eq "Fixes:";
> > +                               $tag_space =3D 0 if ($line =3D~ /^fixes=
:?
> > [0-9a-f]{5,} ($balanced_parens)/i);
> > +
> > +                               $id_length =3D 0 if ($orig_commit =3D~
> > /^[0-9a-f]{12}$/i);
> > +                               $id_case =3D 0 if ($orig_commit !~ /[A-
> > F]/);
> > +
> > +                               # Always strip leading/trailing parens
> > then double quotes if existing
> > +                               $title =3D substr($title, 1, -1);
> > +                               if ($title =3D~ /^".*"$/) {
> > +                                       $title =3D substr($title, 1, -
> > 1);
> > +                                       $title_has_quotes =3D 1;
> > +                               }
> > +                       }
> > +
> > +                       my ($cid, $ctitle) =3D
> > git_commit_info($orig_commit, $id,
> > +                                                            $title);
> > +
> > +                       if ($ctitle ne $title || $tag_case ||
> > $tag_space ||
> > +                           $id_length || $id_case ||
> > !$title_has_quotes) {
> > +                               if (WARN("BAD_FIXES_TAG",
> > +                                    "Please use correct Fixes: style
> > 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid
> > (\"$ctitle\")'\n" . $herecurr) &&
> > +                                   $fix) {
> > +                                       $fixed[$fixlinenr] =3D "Fixes:
> > $cid (\"$ctitle\")";
> > +                               }
> > +                       }
> > +               }
> > +
> >  # Check email subject for common tools that don't need to be
> > mentioned
> >                 if ($in_header_lines &&
> >                     $line =3D~
> > /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
>
