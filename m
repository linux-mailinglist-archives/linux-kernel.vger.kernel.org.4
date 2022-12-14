Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA864C258
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiLNCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiLNCnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:43:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287762C5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so5452322pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=0jeSheK30XGJEY2/8YVZb5H42sPDzyWChJv0LM5DXGQkr4Rp1tcJYsSYcwhaeHaws5
         13r/iVQG2//SX9o8YqZmdqMz4vnF7EVFbHuI2t0+noHned9FfCDXaMIHgHFFQthwDw6g
         nyzZqYHCrdaZW15mjKnhYr7BxncWpncnJ570HtD3Rn1euKPAxBUxeIHLhg+GpJAB8xxa
         G9wO/TWuK6fKHURvUyXokt/S1QAjKThkNqCxr/2nwd4eRKBNyBmU2o8mhpoOBi67ZThv
         tmekbr0XJowvGgDjDYyzPsqzAoKPHyxEvn2QAbV65V/QUBE9lUmrlThE1GlVS12k8R87
         1L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=fpLuTpJnitC2wfaiPuNDu2/DkTo5auLD/m5GYF4u1XEDpNZjcaJC/wf0szggBosATX
         /20qiZgMfFX9KXluLpWp6ipFspGQXT0FzQ1yif7M8F3gHKb3PqRApkCtC4QScqXmmNIH
         DHerW0FId1LtZp+a5Q8h4cE1Xo43VzBiMIoX8YuW/JSdNgGRgFSq58UgNtPcRthIDCJs
         PodYyD8vVcmaGat6oaS/t1xfuhK71WJtH08Ogs5NxjpmWioSou7RK/S4fhGA6kc4TACA
         dnLQ3bIjDAaHbvjCsbK4X5T85v0dEHsgxs+3vufMChYWGyciA01+Fr+THvncflIoIVRh
         Oajg==
X-Gm-Message-State: AFqh2koeudbXJHkkgqTMN77yBKHJX9KANuc9CUtAjXyHp6UtIlEyIBXO
        xqeurdh+Qy9f4TChglUdgH3GEjo4/cPO86ZfVLQ8
X-Google-Smtp-Source: AMrXdXsAFqasEGUKk60MS2TQ0dx9fzOfbpL9oe4Ce2NTauHwaDuuWdH3Aa3wRVZtRYkllfhLAVvVDdYUy6Xfi1rkrsI=
X-Received: by 2002:a17:90a:1912:b0:219:8ee5:8dc0 with SMTP id
 18-20020a17090a191200b002198ee58dc0mr98556pjg.72.1670985824675; Tue, 13 Dec
 2022 18:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com> <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
In-Reply-To: <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Dec 2022 21:43:33 -0500
Message-ID: <CAHC9VhSv66DPsJ+5ewmHQ68D3uFh76TpNC9kGXcns_rV-tbaig@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 8:08 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (master)
> by Paul Moore <paul@paul-moore.com>:
>
> On Fri,  9 Dec 2022 09:29:35 +0100 you wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > The fs_context_parse_param hook already has a description, which seems the
> > right one according to the code.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [1/2] lsm: Fix description of fs_context_parse_param
>     https://git.kernel.org/netdev/net/c/577cc1434e4c
>   - [2/2] doc: Fix fs_context_parse_param description in mount_api.rst
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

It looks like the bot has a few screws loose as this went up to Linus
via the LSM tree :)

-- 
paul-moore.com
