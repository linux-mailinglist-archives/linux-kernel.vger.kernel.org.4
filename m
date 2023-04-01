Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84866D2E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjDAGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjDAGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC310D3;
        Fri, 31 Mar 2023 23:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2938C603F7;
        Sat,  1 Apr 2023 06:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF9C433D2;
        Sat,  1 Apr 2023 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680330175;
        bh=C4wrTt4zKss+4MIQ4zd/7UCc8iEP633HVcG1T+mQhiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sci3SLV5e2aXT5PUIjsGGDa2+eckoillSpkBvvRdjZlRDGuGJ+Zpp9OXnRfbmQ3fY
         9VVezGsnMsZiznZa+bfAdurrfmAosQ9Gsdp0/r7BvPbJux5JcqwdBmyphmsP+RlEJi
         c4Up6nQnLjcarI/Jrw0v5JEsGuIW4rPk/q2rBaGFmu7nh/slpaFKS8FiLAbiKwSAid
         9VlTVg1BZYX1yeJNxGBCnwzhFZBA8P7zMfNH55KCtTV89pQjQuN5u1HHmYSehicHbd
         wKwC6IzCrXtNwWH3Tx/xyhiKDW6m17KIZbHpk+QKVK64qEzRYQkaJncSUiR2BchEdW
         OX9U3KgUztNzA==
Received: by mail-oi1-f180.google.com with SMTP id l18so18272411oic.13;
        Fri, 31 Mar 2023 23:22:55 -0700 (PDT)
X-Gm-Message-State: AO0yUKXq23bSMMHQW5caKcsjSkHGs39HVRxavlJjmvJoogzOVCMxFjMd
        9N5/cC70FmBYRdnVU7Yt+qBlZ1Q1LLrQstIdtI0=
X-Google-Smtp-Source: AK7set9kbagaDQWo3VqsPvdsr+y+o5EyTN7o/8YsD4bA8ctmP71eEtUcCFuhO327T4HZXkPMjVoIAr+gx3H0deluQCg=
X-Received: by 2002:a05:6808:14d5:b0:384:a13:952a with SMTP id
 f21-20020a05680814d500b003840a13952amr9469531oiw.11.1680330174630; Fri, 31
 Mar 2023 23:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <1de9eccd-8570-3b69-4be2-347e862bcc33@mailbox.org>
In-Reply-To: <1de9eccd-8570-3b69-4be2-347e862bcc33@mailbox.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Apr 2023 15:22:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY8PvkDesOBQxLw11t1-OT9EsrNHekjAeOjLDhwPcP8w@mail.gmail.com>
Message-ID: <CAK7LNATY8PvkDesOBQxLw11t1-OT9EsrNHekjAeOjLDhwPcP8w@mail.gmail.com>
Subject: Re: [Question] Restore previous "local tag" behaviour
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 2:44=E2=80=AFAM Tor Vic <torvic9@mailbox.org> wrote=
:
>
> Hi,
>
> When I'm building my kernels, I used to tag my personal releases with a
> similar annotated tag commit as with vanilla kernel, just appending
> "-tv" or similar to it, i.e. "v6.3-rc4" becomes "v6.3-rc4-tv".

I do not understand what you want to achieve.



Let's say you wanted to release "v6.0-rc4-tv",
which consists of v6.0-rc4 with 331 extra commits.


$ git checkout  v6.0-rc5^
HEAD is now at 4ed9c1e971b1 Merge tag 'kbuild-fixes-v6.0-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
$ git describe
v6.0-rc4-331-g4ed9c1e971b1
$ make kernelrelease
6.0.0-rc4-00331-g4ed9c1e971b1


Then, you released it as "v6.0-rc4-tv".

$ git tag -a v6.0-rc4-tv -m "Linux v6.0-rc4-tv"
$ make kernelrelease
6.0.0-rc4


Then, kernelrelease becomes clean '6.0.0-rc4'.
Is this what you want?

It is apparently wrong since there are
331 commits between v6.0-rc4 and v6.0-rc4-tv.

That is what 6ab7e1f95e96 _fixed_.


The behavior is now clearer and correct.

$ git describe
v6.3-rc4-174-g2bac7dc169af
$ git tag  -a v6.3-rc4-tv  -m "Linux v6.3-rc4-tv"
$ make kernelrelease
6.3.0-rc4-00174-g2bac7dc169af


If you wanted to make a "-tv" release,
you would want to change the version field in Makefile
before tagging.


 diff --git a/Makefile b/Makefile
 index da2586d4c728..8639036f5095 100644
 --- a/Makefile
 +++ b/Makefile
 @@ -2,7 +2,7 @@
  VERSION =3D 6
  PATCHLEVEL =3D 3
  SUBLEVEL =3D 0
 -EXTRAVERSION =3D -rc4
 +EXTRAVERSION =3D -rc4-tv
  NAME =3D Hurr durr I'ma ninja sloth

  # *DOCUMENTATION*



Then, kernelrelease shows it is a "-tv" release.

$ make kernelrelease
6.3.0-rc4-tv







> This has worked just fine so far, but...
>
> Since commit 6ab7e1f95e96f0c688ae132b0e9a16c0f206689d ("setlocalversion:
> use only the correct release tag for git-describe"), this is not taken
> into account anymore, it uses the "git describe" tag instead of using
> the actually tagged commit as "kernelrelease".
>
> Is there a way to restore the previous behaviour without having to
> revert this (and preceding) commits?
>
> I know that we can disable CONFIG_LOCALVERSION_AUTO=3Dy and append
> directly to CONFIG_LOCALVERSION, but maybe someone knows how to use the
> "old" way of using tags...?
>
> In other words, when I have a local tag, I want "kernelrelease" to use
> just that tag, and when I don't tag anything, it should just use the
> standard "git describe" tag.


Again, I do not understand.

git tag is not stable information.

If you call it "a release",
you would want to work in the same way with/without git
even if most kernel developers are working in a git tree.


The mainline kernel, stable-kernel, linux-next are
released in https://kernel.org/
(and GitHub allows users to download a tarball of
a tagged commit.)


A released tarball (of course, there is no tag there),
produces the same kernelrelease as the git tree does.

You are requiring the kernelrelease be different
with/without the *-tv tag.
That is not what the release would look like.

The mainline kernel and stable kernel increment
the version field in Makefile.
linux-next has "localversion-next" at the top of the tree.






> For the moment I have just reverted the related commits as they don't
> serve any purpose for my needs.
>
> Cheers,
>
> Tor Vic



--=20
Best Regards
Masahiro Yamada
