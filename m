Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51EF6DF4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDLMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:22:05 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEDA30EE;
        Wed, 12 Apr 2023 05:22:03 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee17a659bso216626037b3.4;
        Wed, 12 Apr 2023 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302123; x=1683894123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLEMcRFTyUAXgsUesoN6Zq5nWJj2e3OHS8pE8Im9o7E=;
        b=g+c0nMl+4jFEqOfCwWdCwrjCBStI4eeuBk7kN9bRdc71fO/jhyx5I+37F+MqFLEi76
         WAaoc2ecmuh0gSld+2xvj9FA1V2rHIDHxMMxKspk0HP36O9OgE0sm+MnyP07+Ke40Dgo
         1ddB1Y8eyWyL+TovZbXanwwzEu7Rk5oxTX1fanfXJ4snNzxYwmlmDx9gqiaGV0gs4vMD
         y+UIbvoZXdiE3N3iXR/VqwRR1e2ELYfML9lNJXiVp6RRAY3TlKlo/l6bQEpCiHRJgAK/
         CKVSO0r/d8bsX0aIX2XKzfH1bC7ZfA9mm7klOI4EQJ8+KO+bSPmsC7ucVz9Wb49vpYk9
         RDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302123; x=1683894123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLEMcRFTyUAXgsUesoN6Zq5nWJj2e3OHS8pE8Im9o7E=;
        b=1wA28uLntCQJRl4gaRTrpk8OlxA1c5PWTUt0wWI7hrvGwmP++O3BDFMWzIIFlA5N6/
         u6QBvoHaU5wQmJnrjMTNinU9ebDLAe5DQHxr5Q9x8Asb+DBdAqhrSN9OdyknfN/d2K9Q
         vgAH6eOZ5txFPe+lH/UZN3DupAlOOb/WPDz+pod5g8fKb+/2BE5Z4F20JdklLBnlm2RN
         SFS2yd2pjNmfWMSc8c6LpSrPs1NOdTwvliGE2coop6c69OCWyUa0Y4ydoW/m1CmRHv7q
         m9qCueKrNzOWD9CiuklxkmYW6xciMqzcnux/Vj0et3nDrSO26X1wLF3S2J3dOQCjhxi9
         0RTw==
X-Gm-Message-State: AAQBX9fWpyUgcCUXOakF8eDkgv9Q9qegf+E5Iqh+2QDLsvuhM2bsjS+d
        ZOM0CiXqF2l/mtlGFOqZiWhPpTp2URUkzhanJko=
X-Google-Smtp-Source: AKy350YNcqK5qJODUZEAf5Uj7XPszr1ypdJwZxTSNID1I2FOApV03k2Jh4KyBmrJ+yF2KknUZUI8IWce3ajOsFENu3o=
X-Received: by 2002:a81:eb08:0:b0:54f:97dd:633 with SMTP id
 n8-20020a81eb08000000b0054f97dd0633mr981566ywm.4.1681302123094; Wed, 12 Apr
 2023 05:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <ZDSRSWhWsN34MghQ@xps> <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
 <20230412025834.GA301301@mit.edu>
In-Reply-To: <20230412025834.GA301301@mit.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Apr 2023 14:21:51 +0200
Message-ID: <CANiq72mT3bVDKdHgaea-6WiZazd8Mvurqmqegbe5JZxVyLR8Yg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com, jistone@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 4:58=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> Something that would perhaps be useful is to document (a) what
> versions of Rust is available for various distributions, or pointers
> to how to get that information for various distributions.  For
> example, you can get that information from Debian using [1].  It
> appears that Fedora isn't distributing rustc at *all*, at least
> according to [2], so apparently for Fedora people will need to install
> it from source.

As far as I understand, Fedora is actually one of the distributions
that provide a very up-to-date Rust toolchain (the latest) and can be
installed via `dnf` [1][2].

Cc'ing Josh Stone who maintains the toolchain in Fedora, just in case
there is something I am missing that the webpage may be referring to.

[1] https://packages.fedoraproject.org/pkgs/rust/rust/
[2] https://developer.fedoraproject.org/tech/languages/rust/rust-installati=
on.html

> The other thing that would be worth documenting is (b) something about
> what versions of Rust people have actually tested.  The comments at
> [3] are quite scary, since per [4], the minimum version of Rustc
> supported is 1.62.0 --- and per [3], **only** Rust 1.62.0 is
> supported, since we use unstable Rust features.

The one that we test, for the moment, is the minimum one (since it is
the "only" one) -- I will make it more clear in the webpage.

> But for example, with Debian, Debian stable is shipping Rust 1.48.0,
> and Debian testing (which is currently in "hard freeze" so it can be
> released as Debian stable this summer) is shipping Rustc 1.63.0.
>
> Since I use Debian testing, the question which is foremost in my mind
> is whether I can expect to have things work if I use the
> distro-provided 1.63.0 rustc, or is this really a case of "it's not
> Rust 1.62.0, so good luck to you"?

Distro versions should be fine (as in: it is not an issue of "official
prebuilt images" vs. "distro binaries"). But short-term you likely
need to match the numbered version (or perform small changes in the
kernel side when needed). So, in practice, the easiest route is to use
the binaries provided by Rust itself (via `rustup` or standalone
installers). We could also provide them at kernel.org like for other
toolchains if that helps.

So if distributions want to start using Rust code in their kernels
right now (i.e. before we can declare a proper minimum) with their own
`rustc` package, then one approach they can use is to provide an extra
`rustc-kernel` package matching the version required by the kernel (or
to change the kernel side a bit to make it compile).

We could, in principle, attempt to support several versions in the
kernel side, but given the upstreaming of the first Rust modules is
still going on (and the abstractions they depend on), we still have
some time. Moreover, the first Rust modules may not be needed by most
distributions: what is being upstreamed is the Android Binder driver,
the Asahi GPU driver and the NVMe driver so far.

So it is up to distributions to decide whether they need to use one of
those modules early on, and if that is the case and they need to do so
before we can declare a minimum, then I think it is reasonable to ask
them to match the version. Some particular users, e.g. Android, as far
as I understand, they are OK with matching the version for the time
being.

In summary, the issue is that the minimum version we will eventually
support is "in the future".

> If the goal is accelerate adoption of Rustc, and calm people's fears
> vis-a-vis using Rust, it's not enough to say, "why don't you use the
> distribution-provided version or Rust"?  It would be helpful if those
> Rust pioneers can share what versions of Rust they have tested
> against, especially for those commonly used distributions, such as
> Debian, and give us a report whether we should expect things to work,
> so we can ignore the scary warning from the build system that we're
> using an unsupported version of Rust, and if it breaks, we get to keep
> both pieces.

Definitely -- we should be testing distro-versions in CI as soon as it
is (reasonably) possible. We could even do so already for those
distributions that track the latest version, but then it means we will
be upgrading more often (every 6 weeks) in the kernel side. There
would still be small windows where it may not work depending on how
the schedules match, though (but distros could keep a `rustc-old` for
some days until it matches again, for instance).

> Fedora, if someone could build their own unofficial packages, until we
> can convince Red Hat to start shipping -their own supported Rust
> compilers, that might be a great way of bridging that gap.

I think all major distributions already ship Rust. From a quick look:
Fedora (1.68.2), Gentoo (1.68.2), Arch (1.68.2), openSUSE (1.68.0 for
the rolling one), Ubuntu (1.67.1 for 23.04), Debian (1.63.0 this
summer), Red Hat (1.62.1 in 9.1)...

As mentioned above, if kernel maintainers are happy with more frequent
upgrades (i.e. tracking the latest release), it would at least be
easier for those in distributions that track the latest Rust release
-- I would like to do that, in fact, if nobody opposes, since our idea
is to anyhow upgrade the compiler required in the kernel until we hit
the minimum.

What do you think?

Cheers,
Miguel
