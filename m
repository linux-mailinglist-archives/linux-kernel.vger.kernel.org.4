Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851956A7988
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCBCdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCBCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:33:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E91ACE3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:33:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a2so5671162plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677724410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0lZNoVt9lJ6J8uwaJdMmpDSpbdScMq/0KTuhIjVkUQ=;
        b=LBK+rKiKoXKZ/dbsn6xOP1h/1DdhUKpftUh9e+mkGx24Ct1QSUdx91ynl9oxmsdOmu
         AY8rWlxThr7PyU90SvB4UXjE6M5VHvjWx4KfK9GsYGkN3hLA/9NX+ZGRYO521cn5HoV/
         L4jLAkDTaJkUj2nKsaBy/Az+XIjOhnJpuKJKZ477nIPry0z8rgcjlZ2QsKxicDEtQVKp
         qFpzchl85bH4lVPP54ms7k/a61sS9zFQWXTwWJRVD0naVRlEs9F3Hyi4XBBHf5kj6brb
         ssow4TEkTpN1pS5sL1n+r5CheMH8kPZkPSRkwSE7afnWqqvApSlU63NoKvUKbd68prZj
         EoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677724410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0lZNoVt9lJ6J8uwaJdMmpDSpbdScMq/0KTuhIjVkUQ=;
        b=oqtcDEk3Jr6kEuJR9h06j7st+Ma6LstgyDrdaNiveN3bsDbL/fdqeVnEaGWOGNlbAn
         ESDL8I9iOnXOCRGUaxSZEHdFFcNPBzw8RsWHnY+5Dzfq0N2qjX4A48m7YMviPHnM7PPz
         E6G3jbnMc3h+n1uJosVcpPgGSQu8nWOm7TW8/e0NbbJwRjrZb+KRUTvF5H1ia7I6DTVS
         lSNxu6iiSpsk3dhxWy+eHQnUYR0VSvzqxOiuFxRBDTmzri+aVfxgf9bfzkCLrwx1pRGe
         NgkEvfCHOQ3uePQVbJvEyJ/iVUJ0lQIm1am0/aEM/Bxbn5x/1lwJGhOMKkq6QRp/1Y/S
         BosA==
X-Gm-Message-State: AO0yUKUdxv76m8tBecw57tDjqKleYWQzL6eC4nsabvs0GI0b0a+eeSU1
        +YBh1t0ld0JTz8WRK1zMl0pQKVtMRgzopz2DvwrR
X-Google-Smtp-Source: AK7set+xzLCM6twBgJCibMqi0G3TLp91UnzEQU5FoUMwEXykcRoWlNU/HbsG/K6w+XprDCA87nJQJ5CJfxasDk2ZryU=
X-Received: by 2002:a17:903:2782:b0:19b:373:94ad with SMTP id
 jw2-20020a170903278200b0019b037394admr3206594plb.3.1677724410550; Wed, 01 Mar
 2023 18:33:30 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com>
 <1675119451-23180-4-git-send-email-wufan@linux.microsoft.com>
 <061df661004a06ef1e8790d48157c7ba4ecfc009.camel@huaweicloud.com> <20230210232154.GA17962@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230210232154.GA17962@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Mar 2023 21:33:19 -0500
Message-ID: <CAHC9VhShcgFtdxxoFX9x+QOM3Qb7xWa-AJuJGrHgaK_N8nKtzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/16] ipe: add evaluation loop and introduce
 'boot_verified' as a trust provider
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 6:21=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On Tue, Jan 31, 2023 at 04:49:44PM +0100, Roberto Sassu wrote:
> > On Mon, 2023-01-30 at 14:57 -0800, Fan Wu wrote:
> > > From: Deven Bowers <deven.desai@linux.microsoft.com>
> > >
> > > IPE must have a centralized function to evaluate incoming callers
> > > against IPE's policy. This iteration of the policy against the rules
> > > for that specific caller is known as the evaluation loop.
> >
> > Not sure if you check the properties at every access.
> >
> > >From my previous comments (also for previous versions of the patches)
> > you could evaluate the property once, by calling the respective
> > functions in the other subsystems.
> >
> > Then, you reserve space in the security blob for inodes and superblocks
> > to cache the decision. The format could be a policy sequence number, to
> > ensure that the cache is valid only for the current policy, and a bit
> > for every hook you enforce.
>
> Thanks for raising this idea. I agree that if the property evaluation
> leads to a performance issue, it will be better to cache the evaluation
> result. But for this version, all the property evaluations are simple,
> so it is just as fast as accessing a cache. Also, for the initial
> version we prefer to keep the patch as minimal as possible.

FWIW, I think that is the right decision.  Keeping the initial
submission relatively small and focused has a lot of advantages when
it comes both to review and prematurely optimizing things that might
not need optimization.

--=20
paul-moore.com
