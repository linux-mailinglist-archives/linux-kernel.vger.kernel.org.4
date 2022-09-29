Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D05EF85D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiI2PIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiI2PH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:07:59 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3713F70F;
        Thu, 29 Sep 2022 08:07:54 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id d17so995809qko.13;
        Thu, 29 Sep 2022 08:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rzp0lh/K2FX3N+ufpgYNPH83ze92e9mULF1gMbtZpQs=;
        b=1RlzDOhSRVJ5JNShA75XKxhg2kBoqwv9zsgi/9BDjwSyMPSQ8Mn4mFzH7eqRJd5LkX
         Pn91rMtXGJvhYEfAy9j1PPw9delLElhypErhHiEbOsknMIwag+EB/o/6yzLb8PnoawvM
         /NG9nlhRBjIW8hbwzSM8zA8KZTRhKK1n9k07A3zUkZGpLWooY32eGkn5ZdkIcERB3PEf
         uunw1BlHbCivWJlSSr2Snqr+6STdX9/0TqRit5GDq3xmzN08xfvy+cOI5chERAgZEG9u
         4iqL0DTluhHdPZ4SATySuhQMJgq3fBDZwsZdMlh7pIa4jtiPZ0Q+rXMSZmXo7/GHkQWm
         wV+w==
X-Gm-Message-State: ACrzQf020AGib2d/uGpS2wHYk0r8uautqHA8FZouk6uPvcNuIeL+Oei9
        XbDiWWHlaCmFMTDAu4ElSJxFEdiSYYH4ow==
X-Google-Smtp-Source: AMsMyM6M2S5mBsgRualO6cSP4fO+x34xG2qIP15XNStfFnOKTYBPk6Sg2ppuZYhZ3UU5cphCKOL+7w==
X-Received: by 2002:a37:8dc6:0:b0:6cf:33cd:2c4f with SMTP id p189-20020a378dc6000000b006cf33cd2c4fmr2512631qkd.372.1664464072865;
        Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cb20-20020a05622a1f9400b0035a7070e909sm5772184qtb.38.2022.09.29.08.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id c9so1889651ybf.5;
        Thu, 29 Sep 2022 08:07:52 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr3378572ybp.365.1664464072203; Thu, 29
 Sep 2022 08:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1> <YzWr+mmtLy2DRYEA@oscomms1>
In-Reply-To: <YzWr+mmtLy2DRYEA@oscomms1>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Sep 2022 17:07:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
Message-ID: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
Subject: Re: [PATCH] openrisc: update config files
To:     Stafford Horne <shorne@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Thu, Sep 29, 2022 at 4:30 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> > On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > > Clean up config files by:
> > >   - removing configs that were deleted in the past
> > >   - removing configs not in tree and without recently pending patches
> > >   - adding new configs that are replacements for old configs in the file

> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Thanks for the patch this looks fine to me.  Usually I just generate this
> > defcnfigs using make savedefconfig.  If there is some better way which
> > doesn't generate the file with the # comment's I haven't found it.
> >
> > I will queue this.
>
> Actually..
>
> About the subject 'openrisc: update config files' and description.  Can you be
> more specific about what updates you are making for this patch?
>
> For example: remove comments from config files.

These are not comments, but options that default to y or m, and
are overriden to n by "commenting them out".

This syntax dates back to the days Kconfig was a collection of
shell scripts. Nowadays, switching to "CONFIG_<FOO>=n" would
perhaps make sense, as Kconfig already recognizes that syntax.

> > > --- a/arch/openrisc/configs/or1ksim_defconfig
> > > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > > @@ -19,9 +19,6 @@ CONFIG_NET=y
> > >  CONFIG_PACKET=y
> > >  CONFIG_UNIX=y
> > >  CONFIG_INET=y
> > > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > > -# CONFIG_INET_XFRM_MODE_BEET is not set
> > >  # CONFIG_INET_DIAG is not set
> > >  CONFIG_TCP_CONG_ADVANCED=y
> > >  # CONFIG_TCP_CONG_BIC is not set

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
