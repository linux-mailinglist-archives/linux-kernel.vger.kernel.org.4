Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCE623472
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKIUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiKIUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:22:29 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531B1D335
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:22:29 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso3279fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkZEBtgDxLwh8xU3neb1FAkv2BmAFLuGBlDLcfKRoW8=;
        b=vnj1SQDl8mqR3MmD7DqMUdNfi9EUJZvJILOHciyG+VNOp6U0W8rfmn1+Xt31N+DcQi
         vDOnwVOnau8LUSczoJ0WHV2krITQHPokBhbZJC4BIkUnl+t4Dat/K/WTsgm/5X4H7YWQ
         zFVnHpsYmAev6RqZbkyoPpbxfEtuuC5V3kacc7B9jDIVJ86H3JkUSioH5iFiZXPAsk9u
         +2/qR/DZ7H515xlu6tv/Rw8xxaQ8v68Mmf2Mn0Ren3VUaznJd1IL/5goc6xepZl65XJt
         fP0AgfYdfvqQpcEsC69in5ywcxiT3s9Q3QxNfKI3qY3mYeuTNkzps4sk3UzAOewW8GKp
         JWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkZEBtgDxLwh8xU3neb1FAkv2BmAFLuGBlDLcfKRoW8=;
        b=MWhopa3xeVdFvsTpRWd/V/A8mCEC/JEl9IoBdKbK1HxrAlg0fp7kEmYgalAL4HpvwY
         EV2YxYf4+3Hq0pBrvzaiFj1Z2bAtLJ5+7wo0wHCLMk4OLxGspg2ozpyEGryktYyTvqqI
         o6sknMSmPVF5sdL5ey0cKp/Ag/dGYg7ecUUtHpjdk8j8Oyd+gj+BI/54XBgr967L1OJE
         cnVN0pYDX8H/VKa7SD+iOFeFezCzsVocvZYYKFxS/+I/9hMGALmT1H2h2134ap6QfUCG
         IMx9HhzLG3pnpIsFmyOY9lgdvZ7RSB8Cotzf7UyOL/ZA0uJsROTrQ+SJhdqSsreMFK4J
         hyFQ==
X-Gm-Message-State: ACrzQf2SyuBIkuppnHy8Fmrsp4F3IZqKCR7Rx5LC8qO5OOR2USvhvUI4
        SBdYiA1N2KqTx6auyZcURQ3eYEvYdrM7otdMkVEQsmIGyBE9
X-Google-Smtp-Source: AMsMyM4PhU2aWuL/hCnXMmV01mOurB3yfd1swJ4U7viOAdtWTL7HzwxBLnJkoFMtxmc+5Qwsw+/v3/n+uTUZ8vvCy4s=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr36758992oap.172.1668025345426; Wed, 09
 Nov 2022 12:22:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
 <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
 <20221109143834.GB24561@mail.hallyn.com> <CAHC9VhQgEej_yKXRJFtLHUQkL8hGrBYqRPye5SwBz_SU+2eK2A@mail.gmail.com>
In-Reply-To: <CAHC9VhQgEej_yKXRJFtLHUQkL8hGrBYqRPye5SwBz_SU+2eK2A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 15:22:14 -0500
Message-ID: <CAHC9VhS9h2ZL=JZOoNK7Q+TDU7BSq3Jk2BqZ0nZExCfTvkuUuQ@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 3:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Nov 9, 2022 at 9:38 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Mon, Oct 31, 2022 at 12:22:29PM -0700, Linus Torvalds wrote:
> > > On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > A single patch to the capabilities code to fix a potential memory leak
> > > > in the xattr allocation error handling.  Please apply for v6.1-rcX.
> > >
> > > Pulled.
> > >
> > > However, I react to the strange test condition. Sure, it's
> > > pre-existing, but does it really make sense?
> > >
> > > It does
> > >
> > > +       if (ret < 0 || !tmpbuf) {
> > > +               size = ret;
> > > +               goto out_free;
> > > +       }
> > >
> > > and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?
> >
> > I had to go through the history a bit - the !tmpbuf check was added
> >
> > https://www.spinics.net/lists/stable/msg463010.html
> >
> > because of a gcc warning.  Perhaps there's a better way to tell gcc
> > that it can't remain NULL if ret was < 0 ?
>
> Ooof, that's ugly, but thanks for digging it up.  As it turns out I
> happen to be working on a patch for vfs_getxattr_alloc() to fix the
> return value type right now, but it looks like I'll leave that gcc
> hack in place ... although I might leave a comment about it so the
> next person doesn't have to wonder.

Actually, it looks like there are other similar conditions, e.g.
evm_is_immutable(), without such a check and my compiler (gcc v12.2.0)
seems okay with it; presumably they fixed the compiler bug?

I guess I'll leave the hack in place for commoncap.c but not propagate
it elsewhere.

-- 
paul-moore.com
