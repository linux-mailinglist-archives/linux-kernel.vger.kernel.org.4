Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020D6464B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLGXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLGXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:03:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045713D3E;
        Wed,  7 Dec 2022 15:03:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h12so30280198wrv.10;
        Wed, 07 Dec 2022 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlRZXX5fi6uW5Xh2LMxBmgQ7B0VSc2snpywNu1tW4NI=;
        b=Dj7+8fB4fw+2QdujWiQxxIkZgbFUihxLnxAqCWqnmVuceiC+w7/oGLydRxSI7h1lxB
         0peNzyiiz8uSh+9+kRzGEx3zvrooMEIizeOgE9Flas/91C6+0QiUG9aR8Xeqp4IFVyop
         XTcm1uOr54A4qTUerg0bCDlZlGTWu3yJDT+RiJstPURbVDVqmtrRXr2I1L9grF/OMarv
         Ex1mp9qXeju8NSruHmXe1/pUwQZDWs4+GSNM8DHYTSwg+CyFCjBs9nFuBWy0g9ZJ1fp5
         xAiNNao7DWjsUizxjzc/3NbOaxUcAUIX0Mr3TZ4Umm7h6e9/p5jJogeEnFqgCnP4D+u/
         Q4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlRZXX5fi6uW5Xh2LMxBmgQ7B0VSc2snpywNu1tW4NI=;
        b=dAKwHbwKfQNTvINB2nPzJhg4VdDzWMzmIh8h5ovhjCkCzDGkT/FzZlSl6rwiNxvF9U
         ADR2d1UCXDmSu9yzWaNwnkPFUwYYmZMaiAaB9l+msHB/A7hucwDTB6B8Xzv8wmGq4XQ0
         FVVisudQfzdQkuXzDv5xB1jnAgDBTtIX+WZ8+gNGQVaUxcMU70eCj50A4UB8DKkgq0tI
         IoGXamc0MMlIRD3OtEDfJMhZM/rMkVT5SllTYjMkLR5t71e52jU/wssI0wMC/gF15kex
         l4SEpp/3bBRdTsziMPX9L/n23CfM+0bXMxJMfhMQSEKBXdlJyHVKVb6baSwb7fEeBQRI
         jh5g==
X-Gm-Message-State: ANoB5pkzJ8MERiaXnACRS7TLsUv2SQy6osKJwRSX5BCldRrUwqsfeiJp
        dvPqpd39ZlTfxFMbPDYFxaY=
X-Google-Smtp-Source: AA0mqf7yPyQJ2OMGmt1h3CHkgXUOQGZMRlLGjTpfZ4OLsXZ8b3/7Xixr/sKd6B9TeKRcQ1e9ZglxMg==
X-Received: by 2002:a05:6000:104a:b0:242:257f:56f8 with SMTP id c10-20020a056000104a00b00242257f56f8mr691030wrx.11.1670454212122;
        Wed, 07 Dec 2022 15:03:32 -0800 (PST)
Received: from suse.localnet (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id cl8-20020a5d5f08000000b00241fde8fe04sm20994245wrb.7.2022.12.07.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:03:30 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Thu, 08 Dec 2022 00:03:29 +0100
Message-ID: <2263204.ElGaqSPkdT@suse>
In-Reply-To: <Y5CaRLtwaYXXlGYS@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com> <2130641.irdbgypaU6@suse> <Y5CaRLtwaYXXlGYS@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 7 dicembre 2022 14:51:00 CET Sebastian Andrzej Siewior wr=
ote:
> On 2022-12-07 14:01:50 [+0100], Fabio M. De Francesco wrote:
> > > > If so, I understand and I again agree with you. If not, I'm missing
> > > > something; so please let me understand properly.
> > > >=20
> > > > Aside from the above, I'm not sure whether you deleted the last phr=
ase
> > > > before
> > > > your suggestion. What about making it to become "For the above-
mentioned
> > > > cases, conversions should also explicitly disable page-faults and/or
> > > > preemption"?
> > >=20
> > > They need to disable preemption or page-faults or both if it is needed
> > > (not unconditionally) and where it is needed. This means not
> > > unconditionally over the whole kmap-ed section.
> >=20
> > I never meant to suggest to _unconditionally_ disable page-faults
> > and/or preemption. I was only trying to say that developers must carefu=
lly
> > check whether or not the whole kmap-ed section depended on those side
> > effects.
> I know. That are the two condition that should be checked/ kept in mind
> while replacing the code. Maybe I read it wrongly=E2=80=A6
>=20
> > If so, they must _explicitly_ disable preemption or page-faults or both
> > together with the use of kmap_local_page().
>=20
> Right. The requirement for it should be probably documented in case it
> is not obvious. For PREEMPT_RT it will become a problem if the preempt
> disabled section additionally acquired a spinlock_t or allocated memory.
> So ideally it won't be used ;)
>=20
> >                                             Instead, if the section=20
doesn't
> >=20
> > depend on preemption and/or page-faults disabling, they must only repla=
ce
> > kmap_atomic() with kmap_local_page().
>=20
> Correct and I assumed that you know all this.
>=20
> > I had probably used a bad wording when trying to say the same things th=
at
> > you
> > wrote much more clearly.
>=20
> Write it as you wish I just made a recommendation. If the wording is
> crystal clear then there is less room for interpretations.

I just sent v2 of this patch.[1] I hope that now I left less room for=20
potential misinterpretation by merging your suggestion with the old text.

Again thanks for helping,

=46abio

[1] https://lore.kernel.org/lkml/20221207225308.8290-1-fmdefrancesco@gmail.=
com/T/



